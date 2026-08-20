#!/usr/bin/env node
// 外部相依閘門。JOB-28 §5。
//
// 為什麼需要這支腳本：
// 0.2.5 以前，TWCR_SF（臺灣癌症登記短表 IG）之 5 個 CodeSystem 與 4 個 ValueSet
// 以【本地 stub】承載（input/fsh/codesystems/TWCRSF-mocks.fsh），並在
// sushi-config.yaml 之 special-url 列 9 條例外，才能讓他方命名空間出現在本 IG 產出中。
// 0.3.0 改為正式 dependencies 後，stub 與例外均已刪除。
//
// 這個狀態很容易被無聲地推翻：
//   - CI 若沒抓到 TWCR_SF 套件，建置會失敗；有人為了「先讓 CI 綠」而把 stub 貼回來，
//     本 IG 就再次自行定義他方命名空間下的資源——而且不會有任何錯誤訊息。
//   - special-url 一旦被加回，未解析的 canonical 也會靜默通過。
// 兩者都屬「復原成舊的權宜作法」而非真正的修復，故以閘門固定。
//
// 方向：**他方命名空間之資源一律由上游套件提供，不得由本 IG 自行定義。**
//
// Usage:
//   node scripts/check-dependencies.js              # D-1~D-3 失敗即 exit 1
//   node scripts/check-dependencies.js --strict     # 警告亦視為失敗
//   node scripts/check-dependencies.js --self-test  # 負向測試
'use strict';

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const CONFIG = path.join(ROOT, 'sushi-config.yaml');
const FSH_DIR = path.join(ROOT, 'input', 'fsh');

// 必須以正式相依宣告、不得由本 IG 自行定義之外部命名空間。
const FOREIGN_NAMESPACES = [
  {
    prefix: 'https://hapi.fhir.tw/',
    owner: '臺灣癌症登記短表 IG（TWCR_SF）',
    packageId: 'fhir.TWCRSF',
    site: 'https://mitw.dicom.org.tw/IG/TWCR_SF/',
  },
];

// 已知曾以 stub 承載、不得復現之 artifact id（JOB-28 刪除者）。
const REMOVED_STUB_IDS = [
  'sf-BetNutChewAmount-codesystem',
  'sf-BetNutChewBeh-codesystem',
  'sf-BetNutChewQuit-codesystem',
  'sf-BetNutChewYear-codesystem',
  'sf-ObserBeh-codesystem',
  'sf-BetNutChewAmount-valueset',
  'sf-BetNutChewBeh-valueset',
  'sf-BetNutChewQuit-valueset',
  'sf-BetNutChewYear-valueset',
];

function listFshFiles(dir) {
  const out = [];
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) out.push(...listFshFiles(p));
    else if (e.name.endsWith('.fsh')) out.push(p);
  }
  return out;
}

// ---------------------------------------------------------------- 檢查規則
function check({ yamlText, fshSources }) {
  const errors = [];
  const warnings = [];

  const hasDependenciesBlock = /^dependencies:\s*$/m.test(yamlText);

  for (const ns of FOREIGN_NAMESPACES) {
    // D-1：相依須宣告
    const declared = new RegExp(`^\\s{2}${ns.packageId.replace('.', '\\.')}\\s*:`, 'm').test(yamlText);
    if (!declared) {
      errors.push(
        `D-1 sushi-config.yaml 之 dependencies 未宣告 ${ns.packageId}（${ns.owner}）。` +
        `本 IG 引用 ${ns.prefix} 命名空間，該命名空間非本專案所有，須以正式相依取得。`
      );
    }

    // D-2：不得由本 IG 自行定義該命名空間下的資源
    for (const { file, text } of fshSources) {
      const defines = /^\s*\*\s*\^url\s*=\s*"([^"]+)"/gm;
      let m;
      while ((m = defines.exec(text)) !== null) {
        if (m[1].startsWith(ns.prefix)) {
          errors.push(
            `D-2 ${path.relative(ROOT, file)} 以 ^url 自行定義了 ${ns.owner} 命名空間下的資源：${m[1]}。` +
            `該命名空間須由上游套件 ${ns.packageId} 提供（站台 ${ns.site}），不得於本 IG 內定義。`
          );
        }
      }
    }

    // D-3：special-url 不得列入該命名空間
    //
    // 以逐行掃描而非單一正則取出區塊：special-url 為 YAML 清單，其結束條件是
    // 「出現縮排更淺或同層的下一個鍵」。正則的 `\s` 會跨行吃掉換行而誤判區塊邊界，
    // 首版即因此靜默放行（負向測試抓到），故改為明確的行狀態機。
    const specialUrls = [];
    {
      const lines = yamlText.split(/\r?\n/);
      let inBlock = false;
      let blockIndent = 0;
      for (const line of lines) {
        if (!inBlock) {
          const m = line.match(/^(\s*)special-url:\s*$/);
          if (m) { inBlock = true; blockIndent = m[1].length; }
          continue;
        }
        if (/^\s*(#.*)?$/.test(line)) continue;          // 空行或註解：仍在區塊內
        const indent = line.match(/^(\s*)/)[1].length;
        if (indent <= blockIndent) { inBlock = false; continue; }  // 回到同層或更淺 → 離開
        const item = line.match(/^\s*-\s*(\S+)/);
        if (item) specialUrls.push(item[1]);
      }
    }
    if (specialUrls.some((u) => u.startsWith(ns.prefix))) {
      errors.push(
        `D-3 sushi-config.yaml 之 special-url 仍列有 ${ns.prefix} 之例外。` +
        `改為正式相依後不再需要例外宣告；保留例外會讓未解析之 canonical 靜默通過。`
      );
    }
  }

  // D-4：已刪除之 stub id 不得復現
  for (const { file, text } of fshSources) {
    for (const id of REMOVED_STUB_IDS) {
      const re = new RegExp(`^\\s*Id:\\s*${id}\\s*$`, 'm');
      if (re.test(text)) {
        errors.push(
          `D-4 ${path.relative(ROOT, file)} 重新定義了已於 0.3.0 刪除之 stub：${id}。` +
          `該定義應由上游套件提供。若 CI 抓不到套件，請修 CI 之取得步驟，不要把 stub 貼回來。`
        );
      }
    }
  }

  if (!hasDependenciesBlock) {
    warnings.push('D-0 sushi-config.yaml 未見 `dependencies:` 區塊——請確認檔案結構是否正確。');
  }

  return { errors, warnings };
}

// ---------------------------------------------------------------- 負向測試
function selfTest() {
  const okYaml =
    'dependencies:\n  tw.gov.mohw.twcore: 1.0.0\n  fhir.TWCRSF:\n    version: 0.1.1\nparameters:\n  foo: bar\n';
  const cases = [
    {
      name: 'D-1 未宣告 fhir.TWCRSF 相依',
      yamlText: 'dependencies:\n  tw.gov.mohw.twcore: 1.0.0\nparameters:\n  foo: bar\n',
      fshSources: [],
      expect: /^D-1 /,
    },
    {
      name: 'D-2 以 ^url 自行定義他方命名空間',
      yamlText: okYaml,
      fshSources: [{ file: '/x/mock.fsh', text: '* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/whatever"\n' }],
      expect: /^D-2 /,
    },
    {
      name: 'D-3 special-url 復現他方命名空間',
      yamlText:
        okYaml.replace('parameters:\n  foo: bar\n',
          'parameters:\n  special-url:\n    - https://hapi.fhir.tw/fhir/ValueSet/x\n'),
      fshSources: [],
      expect: /^D-3 /,
    },
    {
      name: 'D-4 已刪除之 stub 復現',
      yamlText: okYaml,
      fshSources: [{ file: '/x/mock.fsh', text: 'CodeSystem: X\nId: sf-ObserBeh-codesystem\n' }],
      expect: /^D-4 /,
    },
  ];

  let failed = 0;
  for (const c of cases) {
    const res = check(c);
    if (res.errors.some((e) => c.expect.test(e))) {
      console.log(`  ✓ ${c.name}`);
    } else {
      console.error(`  ✗ ${c.name}：預期被攔下，實際未攔（errors=${res.errors.length}）`);
      failed++;
    }
  }
  // 正向對照：乾淨狀態不得誤報
  const clean = check({ yamlText: okYaml, fshSources: [{ file: '/x/ok.fsh', text: '* ^url = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/x"\n' }] });
  if (clean.errors.length === 0) console.log('  ✓ 正向對照：乾淨狀態不誤報');
  else { console.error('  ✗ 正向對照誤報：', clean.errors); failed++; }

  if (failed) {
    console.error(`\n負向測試失敗 ${failed} 組——閘門本身失效，修好前不得信任其結果。`);
    process.exit(1);
  }
  console.log('\n負向測試全數通過（閘門會攔下該攔的東西）。');
}

// ---------------------------------------------------------------- 主程序
function main() {
  const args = process.argv.slice(2);
  if (args.includes('--self-test')) {
    console.log('check-dependencies 負向測試：');
    selfTest();
    return;
  }
  const strict = args.includes('--strict');

  const yamlText = fs.readFileSync(CONFIG, 'utf8');
  const fshSources = listFshFiles(FSH_DIR).map((f) => ({ file: f, text: fs.readFileSync(f, 'utf8') }));

  const { errors, warnings } = check({ yamlText, fshSources });

  if (errors.length) {
    console.error('外部相依檢查失敗：');
    for (const e of errors) console.error(`  ${e}`);
    console.error('');
  }
  if (warnings.length) {
    console.log(`外部相依警告${strict ? '（--strict：視為失敗）' : ''}：`);
    for (const w of warnings) console.log(`  ${w}`);
    console.log('');
  }
  if (errors.length || (strict && warnings.length)) process.exit(1);

  console.log(
    `OK: ${FOREIGN_NAMESPACES.length} 個外部命名空間均以正式相依宣告；` +
    `無自行定義之他方資源、無 special-url 例外、${REMOVED_STUB_IDS.length} 個已刪除 stub 未復現` +
    `（掃描 ${fshSources.length} 個 FSH 檔）。`
  );
}

main();
