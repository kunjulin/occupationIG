#!/usr/bin/env node
'use strict';
// ============================================================================
// 下載資產連結閘門：頁面上的資產連結，解析後必須真的有檔案
// ============================================================================
//
// 緣起：`zh-TW/downloads.html` 之「附表十 → 危害類別對照表 (XLSX)」寫的是裸檔名
// `Appendix10-to-HazardType.xlsx`，自語言層解析為 `zh-TW/Appendix10-to-HazardType.xlsx`
// ——**該路徑不存在**，中文讀者點下去得到 404。
//
// ⚠️ 這一類缺陷有兩個特性，使它特別容易長期存活：
//   1. **只在其中一層壞**。根層有檔、語言層沒有，隨手點一次很可能點到好的那層。
//   2. **淹沒在 2321 筆 `cannot be resolved` 裡**。其中 2320 筆是 canonical 前綴問題
//      （全指向 history.html），這 1 筆才是真正的內容缺陷——靠總數看不出來。
//
// 故本閘門只做一件事，但做死：把每個頁面上的**資產連結**（副檔名非 .html 之相對連結）
// 依其所在目錄解析，逐一確認檔案存在。
//
// ⚠️ **本檢查需要建置產出，只能在 CI 執行**（比照 qa-gate.js：找不到 output/ 即失敗，
//    不得靜默略過——「沒檢查」與「檢查通過」不能長得一樣）。
//
// 用法：
//   node scripts/check-download-links.js              實檢（需 output/）
//   node scripts/check-download-links.js --self-test  負向自我測試（先跑這個）

const fs = require('fs');
const path = require('path');

// 只看資產：副檔名存在且不是 .html。頁面連結之斷鏈由 IG Publisher 自己的
// cannot-be-resolved 追蹤，此處不重複（也避免把 2320 筆 canonical 問題再數一次）。
const isAssetHref = (href) => {
  if (!href) return false;
  if (/^[a-z][a-z0-9+.-]*:/i.test(href)) return false; // http:／https:／mailto: 等絕對位址
  if (href.startsWith('#') || href.startsWith('//')) return false;
  const clean = href.split('#')[0].split('?')[0];
  if (!clean) return false;
  const ext = path.extname(clean).toLowerCase();
  return ext !== '' && ext !== '.html' && ext !== '.htm';
};

// 掃 output/ 之第 1、2 層 .html（根層頁面與語言層頁面）。
function htmlPages(outDir) {
  const out = [];
  const push = (dir) => {
    for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
      if (e.isFile() && e.name.endsWith('.html')) out.push(path.join(dir, e.name));
    }
  };
  push(outDir);
  for (const e of fs.readdirSync(outDir, { withFileTypes: true })) {
    if (!e.isDirectory()) continue;
    // 只進語言層；assets/、_includes/ 等模板目錄不含內容頁
    if (/^(assets|_.*|package|qa|tmp)$/.test(e.name)) continue;
    try {
      push(path.join(outDir, e.name));
    } catch {
      /* 不可讀之目錄略過 */
    }
  }
  return out;
}

function check(outDir) {
  const rows = [];
  for (const page of htmlPages(outDir)) {
    const html = fs.readFileSync(page, 'utf8');
    const dir = path.dirname(page);
    for (const m of html.matchAll(/href\s*=\s*"([^"]*)"/gi)) {
      const href = m[1];
      if (!isAssetHref(href)) continue;
      const clean = href.split('#')[0].split('?')[0];
      const target = path.resolve(dir, clean);
      rows.push({
        page: path.relative(outDir, page),
        href,
        target: path.relative(outDir, target),
        // 解析到 output/ 之外者一律視為壞連結（`../` 用過頭）
        escaped: !target.startsWith(path.resolve(outDir) + path.sep),
        exists: fs.existsSync(target) && fs.statSync(target).isFile(),
      });
    }
  }
  return rows;
}

// ================================================================== 自我測試
function selfTest() {
  const os = require('os');
  const results = [];
  const run = (name, fn) => {
    let ok = false;
    try {
      ok = fn();
    } catch {
      ok = false;
    }
    results.push([name, ok]);
  };
  const mk = (files) => {
    const root = fs.mkdtempSync(path.join(os.tmpdir(), 'dl-'));
    for (const [rel, body] of Object.entries(files)) {
      const p = path.join(root, rel);
      fs.mkdirSync(path.dirname(p), { recursive: true });
      fs.writeFileSync(p, body);
    }
    return root;
  };
  const page = (href) => `<html><body><a href="${href}">x</a></body></html>`;
  const bad = (rows) => rows.filter((r) => !r.exists || r.escaped);

  // ① 語言層之裸檔名、檔案只在根層 → 必須被抓到（本次缺陷之原形）
  run('① 語言層裸檔名指向根層檔案 → 失敗', () => {
    const root = mk({ 'a.xlsx': 'x', 'zh-TW/downloads.html': page('a.xlsx') });
    const b = bad(check(root));
    return b.length === 1 && b[0].href === 'a.xlsx';
  });

  // ② 語言層以 ../ 指向根層檔案 → 不得被抓到（正向對照，即本次之修法）
  run('② 語言層 ../ 指向根層檔案（正向對照）', () => {
    const root = mk({ 'a.xlsx': 'x', 'zh-TW/downloads.html': page('../a.xlsx') });
    return bad(check(root)).length === 0;
  });

  // ③ ../ 用過頭、解析到 output/ 之外 → 必須被抓到
  //    否則「改成 ../」會從一種壞連結變成另一種壞連結而不自知。
  run('③ 解析到 output/ 之外 → 失敗', () => {
    const root = mk({ 'zh-TW/downloads.html': page('../../a.xlsx') });
    const b = bad(check(root));
    return b.length === 1 && b[0].escaped === true;
  });

  // ④ 兩層都有檔案之裸檔名 → 不得被抓到（正向對照，其餘三個資產之情形）
  run('④ 兩層都有檔案（正向對照）', () => {
    const root = mk({
      'a.zip': 'x',
      'zh-TW/a.zip': 'x',
      'downloads.html': page('a.zip'),
      'zh-TW/downloads.html': page('a.zip'),
    });
    return bad(check(root)).length === 0;
  });

  // ⑤ 外部絕對網址與純錨點 → 不列入檢查（正向對照）
  run('⑤ 外部網址與錨點不誤報（正向對照）', () => {
    const root = mk({
      'zh-TW/p.html': `${page('https://example.org/a.xlsx')}${page('#sec')}`,
    });
    return check(root).length === 0;
  });

  // ⑥ .html 連結不列入檢查（正向對照）——那是 IG Publisher 自己的斷鏈範圍，
  //    納進來會把 2320 筆 canonical 問題再數一次。
  run('⑥ .html 連結不納入（正向對照）', () => {
    const root = mk({ 'zh-TW/p.html': page('other.html') });
    return check(root).length === 0;
  });

  // ⑦ 帶查詢字串／片段之資產連結 → 須正確剝除後解析
  run('⑦ 剝除 ?query 與 #frag 後解析', () => {
    const root = mk({ 'a.xlsx': 'x', 'zh-TW/p.html': page('../a.xlsx?v=2#top') });
    return bad(check(root)).length === 0;
  });

  console.log('下載資產連結閘門負向自我測試（標「正向對照」者必須不被判失敗）：');
  let nbad = 0;
  for (const [name, ok] of results) {
    console.log(`  ${ok ? '✔' : '✖'} ${name}`);
    if (!ok) nbad++;
  }
  if (nbad) {
    console.error(`✖ 自我測試失敗 ${nbad} 項——閘門本身有問題，實檢結果不可信。`);
    process.exit(1);
  }
  console.log('✔ 自我測試全數通過。');
}

if (process.argv.includes('--self-test')) {
  selfTest();
  process.exit(0);
}

// ==================================================================== 實檢
const outDir = path.resolve(process.cwd(), 'output');
if (!fs.existsSync(outDir)) {
  console.error('\n✖ 找不到 output/——本檢查需要建置產出，只能在建置後（CI）執行。');
  console.error('  刻意以失敗而非略過處理：「沒檢查」與「檢查通過」不能長得一樣。');
  process.exit(1);
}

const rows = check(outDir);
const broken = rows.filter((r) => !r.exists || r.escaped);

// 逐層列出資產分佈——本次缺陷正是「根層有、語言層沒有」，把它印出來比只報通過有用。
const layers = new Map();
for (const r of rows) {
  const layer = r.page.includes(path.sep) ? r.page.split(path.sep)[0] : '(根層)';
  if (!layers.has(layer)) layers.set(layer, { n: 0, bad: 0 });
  layers.get(layer).n++;
  if (!r.exists || r.escaped) layers.get(layer).bad++;
}
console.log(`下載資產連結閘門：檢查 ${rows.length} 個資產連結`);
for (const [layer, v] of [...layers].sort()) {
  console.log(`  ${layer.padEnd(10)} 連結 ${String(v.n).padStart(3)} 個，壞 ${v.bad} 個`);
}

if (broken.length) {
  console.error(`\n✖ 有 ${broken.length} 個資產連結解析後找不到檔案：`);
  for (const r of broken) {
    const why = r.escaped ? '解析到 output/ 之外' : '檔案不存在';
    console.error(`  ${r.page}`);
    console.error(`      href   ${r.href}`);
    console.error(`      解析為 ${r.target}   ——${why}`);
  }
  console.error('\n⚠️ 常見成因：資產只存在於根層（例如 IG Publisher 自 ConceptMap 產生者），');
  console.error('   而語言層頁面用裸檔名連結。修法為改用 `../<檔名>`，或把該資產納入');
  console.error('   input/assets/ 使其複製到兩層。**不得以 ignoreWarnings.txt 抑制**。');
  process.exit(1);
}
console.log('✔ 全部資產連結解析後均有實際檔案。');
