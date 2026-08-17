#!/usr/bin/env node
// 翻譯字串閘門（JOB-24）。
//
// 為什麼需要這支腳本：
// 模板之 `translations/stringsBase.json` **只含 `en` 一種語言**（其餘語言僅以 .po 形式
// 存在，未編入該 JSON）。而本 IG 宣告 `language: zh-TW`（JOB-02），頁面模板一律以
// `site.data.stringsBase[lang]['<Key>']` 取字——查無 `zh-TW` 時 Liquid 回傳空字串，
// 於是頁尾與各頁 chrome 之標籤**全部渲染為空白**（連結仍在、僅無文字）。
// 模板 `scripts/ant.xml` 之複製區塊自己留了 TODO：
//   "Replace this copy with something that will default missing translations to English"
// 亦即上游明知缺語系不會退回英文，尚未處理。
//
// 本 IG 之對策：於 `input/data/stringsBase.json` 自備一份含 `zh-TW` 的資料檔
// （IG Publisher 會將 input/data 併入 Jekyll 之 _data）。
//
// 但自備即代表**會與上游脫鉤**：模板日後新增字串鍵時，我方檔案不會自動跟上，
// 那些新鍵會在 zh-TW **與 en 兩邊都變成空白**，且不會有任何錯誤訊息——
// 與 JOB-23 之位移型錨點同型的「靜默失效」。本閘門即為此而設。
//
// 檢查項目：
//   T-1  模板 en 之每個鍵，我方 en 與 zh-TW 均須存在（缺一即失敗）
//   T-2  我方 en 之值須與模板 en **逐字相同**（避免無意間改動英文原文）
//   T-3  同一鍵之 %PLACEHOLDER% 集合，en 與 zh-TW 須一致（漏掉 %DATE% 會少印資料）
//   T-4  zh-TW 不得留有空字串（空字串正是本 JOB 要消滅的症狀）
//   T-5  我方多出、模板沒有的鍵 → 警告（可能是上游已移除之殘留）
//
// 模板來源檔於建置後才存在（IG Publisher 解壓至 ./template）。找不到時**跳過 T-1/T-2**
// 並明白告知——不可因為「沒東西可比」就靜默通過。
//
// Usage:
//   node scripts/check-translations.js              # T-1~T-4 失敗即 exit 1；T-5 警告
//   node scripts/check-translations.js --strict     # 警告亦視為失敗
//   node scripts/check-translations.js --self-test  # 負向測試：四組必失敗案例
'use strict';

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const OURS = path.join(ROOT, 'input', 'data', 'stringsBase.json');
const TEMPLATE = path.join(ROOT, 'template', 'translations', 'stringsBase.json');
const LANG = 'zh-TW';

const placeholders = (s) => [...String(s).matchAll(/%[A-Z]+%/g)].map((m) => m[0]).sort().join(',');

function check(ours, templateEn) {
  const errors = [];
  const warnings = [];

  const ourEn = ours.en;
  const ourZh = ours[LANG];

  if (!ourEn) errors.push('我方 stringsBase.json 缺少 `en` 區塊。');
  if (!ourZh) errors.push(`我方 stringsBase.json 缺少 \`${LANG}\` 區塊——這正是本檔存在的理由。`);
  if (!ourEn || !ourZh) return { errors, warnings };

  if (templateEn) {
    for (const k of Object.keys(templateEn)) {
      // T-1
      if (!(k in ourEn)) {
        errors.push(`T-1 模板新增了字串鍵「${k}」，我方 en 未收錄——該鍵會在所有語言渲染為空白。`);
        continue;
      }
      if (!(k in ourZh)) {
        errors.push(`T-1 字串鍵「${k}」缺 ${LANG} 翻譯——會渲染為空白。`);
      }
      // T-2
      if (ourEn[k] !== templateEn[k]) {
        errors.push(
          `T-2 字串鍵「${k}」之 en 與模板不一致。\n` +
          `      模板：${JSON.stringify(templateEn[k])}\n` +
          `      我方：${JSON.stringify(ourEn[k])}`
        );
      }
    }
    // T-5
    for (const k of Object.keys(ourEn)) {
      if (!(k in templateEn)) {
        warnings.push(`T-5 我方有鍵「${k}」但模板已無此鍵——可能為上游移除後之殘留，請確認。`);
      }
    }
  }

  for (const k of Object.keys(ourZh)) {
    // T-3
    if (k in ourEn && placeholders(ourEn[k]) !== placeholders(ourZh[k])) {
      errors.push(
        `T-3 字串鍵「${k}」之佔位符不一致——譯文會少印或多印資料。\n` +
        `      en   ：${placeholders(ourEn[k]) || '（無）'}\n` +
        `      ${LANG}：${placeholders(ourZh[k]) || '（無）'}`
      );
    }
    // T-4
    if (String(ourZh[k]).trim() === '') {
      errors.push(`T-4 字串鍵「${k}」之 ${LANG} 為空字串——空白標籤正是本 JOB 所要消滅的症狀。`);
    }
  }

  return { errors, warnings };
}

function selfTest() {
  const base = { A: 'Alpha %X%', B: 'Bravo' };
  const cases = [
    {
      name: 'T-1 模板新增之鍵未收錄',
      ours: { en: { A: 'Alpha %X%' }, [LANG]: { A: '甲 %X%' } },
      tpl: { A: 'Alpha %X%', B: 'Bravo' },
      expect: /^T-1 /,
    },
    {
      name: 'T-2 我方擅改英文原文',
      ours: { en: { A: 'Alpha %X% CHANGED', B: 'Bravo' }, [LANG]: { A: '甲 %X%', B: '乙' } },
      tpl: base,
      expect: /^T-2 /,
    },
    {
      name: 'T-3 譯文漏掉佔位符',
      ours: { en: { A: 'Alpha %X%', B: 'Bravo' }, [LANG]: { A: '甲', B: '乙' } },
      tpl: base,
      expect: /^T-3 /,
    },
    {
      name: 'T-4 譯文為空字串',
      ours: { en: { A: 'Alpha %X%', B: 'Bravo' }, [LANG]: { A: '甲 %X%', B: '' } },
      tpl: base,
      expect: /^T-4 /,
    },
  ];

  let failed = 0;
  for (const c of cases) {
    const res = check(c.ours, c.tpl);
    if (res.errors.some((m) => c.expect.test(m))) {
      console.log(`  ✓ ${c.name}`);
    } else {
      console.error(`  ✗ ${c.name}：預期被攔下，實際未攔（errors=${res.errors.length}）`);
      failed++;
    }
  }
  if (failed) {
    console.error(`\n負向測試失敗 ${failed} 組——閘門本身失效，修好前不得信任其結果。`);
    process.exit(1);
  }
  console.log('\n負向測試全數通過（閘門會攔下該攔的東西）。');
}

function main() {
  const args = process.argv.slice(2);
  if (args.includes('--self-test')) {
    console.log('check-translations 負向測試：');
    selfTest();
    return;
  }
  const strict = args.includes('--strict');

  if (!fs.existsSync(OURS)) {
    console.error(`✖ 找不到 ${path.relative(ROOT, OURS)}——本 IG 之 zh-TW 字串檔遺失。`);
    process.exit(1);
  }
  const ours = JSON.parse(fs.readFileSync(OURS, 'utf8'));

  let templateEn = null;
  if (fs.existsSync(TEMPLATE)) {
    templateEn = JSON.parse(fs.readFileSync(TEMPLATE, 'utf8')).en || null;
  }

  const { errors, warnings } = check(ours, templateEn);

  if (!templateEn) {
    console.log(
      `⚠ 找不到 ${path.relative(ROOT, TEMPLATE)}（模板尚未解壓，通常代表本機未建置過）。\n` +
      '  已跳過 T-1／T-2／T-5（與上游比對）；T-3／T-4 仍照常執行。\n' +
      '  與上游之比對以 CI 為準——CI 一律先建置再跑本閘門。'
    );
  }

  if (errors.length) {
    console.error('翻譯字串檢查失敗：');
    for (const e of errors) console.error(`  ${e}`);
    console.error('');
  }
  if (warnings.length) {
    console.log(`翻譯字串警告${strict ? '（--strict：視為失敗）' : ''}：`);
    for (const w of warnings) console.log(`  ${w}`);
    console.log('');
  }

  if (errors.length || (strict && warnings.length)) process.exit(1);

  const n = Object.keys(ours[LANG]).length;
  console.log(
    `OK: ${LANG} 共 ${n} 個字串，全數非空、佔位符與 en 一致` +
    (templateEn ? `，且與模板 en（${Object.keys(templateEn).length} 鍵）完全對齊` : '（未與模板比對）') +
    (warnings.length ? `（${warnings.length} 項警告）` : '') + '。'
  );
}

main();
