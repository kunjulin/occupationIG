#!/usr/bin/env node
// 導覽列（sushi-config.yaml 之 menu）閘門。JOB-23 §5。
//
// 為什麼需要這支腳本：
// 本 repo 既有之 check-pagecontent-refs.js 只檢查 **pagecontent 內文**之引用，
// **完全不涵蓋 menu**。而 menu 有兩類問題不會被任何既有機制擋下：
//
//  (1) 位移型錨點。0.2.2 以前之 menu 有四條 `artifacts.html#1` ~ `#4`。那些數字是
//      IG Publisher 依「該次建置中實際存在的 artifact 類別」出現順序自動編號的，
//      並非固定語意。一旦新增或移除任一類別（例如補上 CapabilityStatement／
//      OperationDefinition），編號整體位移，四條導覽連結會**靜默指向錯誤區段**——
//      且 `err = 0` 依然成立，因為 Publisher 不檢查頁內錨點之語意。
//      TW Core IG 對同一問題之解法是建策展頁，本 IG 於 0.2.3 比照辦理。
//
//  (2) 孤兒頁。JOB-12 §1(1) 曾發現 conformance.html 有建置產出卻未列入 menu，
//      讀者只能經 toc.html 才可能找到。當時以人工修正，未留下防止復發之機制。
//
// 方向：**以 menu 為導覽之唯一事實來源**。凡 menu 指向之頁面必須存在；凡存在之
// pagecontent 頁面必須被 menu 指到，否則須具名列入孤兒白名單並附理由。
//
// Usage:
//   node scripts/check-menu.js              # R-1/R-2 失敗即 exit 1；R-3/R-4/R-5 僅警告
//   node scripts/check-menu.js --strict     # 警告亦視為失敗
//   node scripts/check-menu.js --self-test  # 負向測試：三組必失敗案例
'use strict';

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const CONFIG = path.join(ROOT, 'sushi-config.yaml');
const PAGEDIR = path.join(ROOT, 'input', 'pagecontent');

// IG Publisher 自動產生、無對應 pagecontent 來源檔之頁面。
// 列於此處者 R-1 予以放行；其餘一律要求有對應 .md。
const AUTO_PAGES = new Set([
  'toc',                              // 目錄（Publisher 依 IG 之 page 樹產生）
  'artifacts',                        // 資源總覽
  'searchparameters-and-operation',   // 查詢參數及操作定義（本 IG 尚未使用）
  'capabilitystatements',             // 能力聲明（本 IG 尚未使用，JOB-23 C-2）
]);

// 孤兒頁白名單：存在於 pagecontent 但**刻意不列入 menu** 者，須具名並附理由。
const ORPHAN_ALLOWLIST = new Map([
  ['history', '版本歷程頁。由 package-list.json 與 path-history 參數驅動，' +
              '經 publish box 之「Releases」連結進入，不佔導覽列版位。'],
  ['open-issues', '轉址／聲明殼頁。內容已於 v0.8.0 移出，本頁僅保留 27 個錨點以維持' +
                  '既發函文、委員回覆書與簡報所引之外部連結有效，刻意不佔導覽列版位。'],
]);

const TOP_LEVEL_SOFT_MAX = 9; // 超過即警告：頂層過多會讓導覽列折行且可尋性劣化

// SUSHI 由檔名推導頁面標題之規則（JOB-25）：去副檔名、'-' 轉空白、每字首字母大寫。
// 用於 R-6d——若 `pages:` 之 title 恰等於此推導值，代表該頁其實沒被真正命名。
function sushiDefaultTitle(mdFile) {
  return mdFile
    .replace(/\.md$/, '')
    .split('-')
    .map((w) => (w ? w[0].toUpperCase() + w.slice(1) : w))
    .join(' ');
}

// ---------------------------------------------------------------- menu 解析
//
// 刻意不引入 YAML 套件（本 repo 無 runtime 相依，devDependencies 僅 fsh-sushi）。
// menu 之結構受限且固定（頂層 2 空格、子項 4 空格），故以嚴格剖析處理：
// 任何不符預期之縮排一律報錯而非猜測——猜錯會讓閘門靜默放行。
function parseMenu(yamlText) {
  const lines = yamlText.split(/\r?\n/);
  const start = lines.findIndex((l) => /^menu:\s*$/.test(l));
  if (start === -1) throw new Error('sushi-config.yaml 中找不到 `menu:` 區塊');

  const items = [];   // { top, label, target, line }
  let currentTop = null;

  for (let i = start + 1; i < lines.length; i++) {
    const raw = lines[i];
    const lineNo = i + 1;
    if (/^\s*$/.test(raw)) continue;
    if (/^\s*#/.test(raw)) continue;
    if (/^\S/.test(raw)) break; // 回到頂層縮排即離開 menu 區塊

    const m = raw.match(/^(\s+)(.+?):\s*(.*?)\s*$/);
    if (!m) throw new Error(`menu 第 ${lineNo} 行無法解析：${raw}`);
    const [, indent, label, value] = m;

    if (indent.length === 2) {
      currentTop = label;
      if (value) items.push({ top: label, label, target: value, line: lineNo, isTop: true });
      else items.push({ top: label, label, target: null, line: lineNo, isTop: true, isGroup: true });
    } else if (indent.length === 4) {
      if (currentTop === null) throw new Error(`menu 第 ${lineNo} 行：子項缺少所屬頂層項目`);
      if (!value) throw new Error(`menu 第 ${lineNo} 行：子項「${label}」缺少 target`);
      items.push({ top: currentTop, label, target: value, line: lineNo, isTop: false });
    } else {
      throw new Error(`menu 第 ${lineNo} 行：不支援的縮排深度 ${indent.length}（僅允許 2 或 4）`);
    }
  }
  return items;
}

// ---------------------------------------------------------------- pages 解析
//
// `pages:` 之結構為兩層：檔名（2 空格）→ title（4 空格）。同樣採嚴格剖析。
// 回傳 [{ file, title, line }]，順序即宣告順序（決定 toc.html 章節順序）。
function parsePages(yamlText) {
  const lines = yamlText.split(/\r?\n/);
  const start = lines.findIndex((l) => /^pages:\s*$/.test(l));
  if (start === -1) return null; // 未宣告 pages: —— SUSHI 自動收錄，R-6 不適用

  const entries = [];
  let current = null;

  for (let i = start + 1; i < lines.length; i++) {
    const raw = lines[i];
    const lineNo = i + 1;
    if (/^\s*$/.test(raw)) continue;
    if (/^\s*#/.test(raw)) continue;
    if (/^\S/.test(raw)) break;

    const m = raw.match(/^(\s+)(.+?):\s*(.*?)\s*$/);
    if (!m) throw new Error(`pages 第 ${lineNo} 行無法解析：${raw}`);
    const [, indent, key, value] = m;

    if (indent.length === 2) {
      current = { file: key, title: null, line: lineNo };
      entries.push(current);
    } else if (indent.length === 4) {
      if (!current) throw new Error(`pages 第 ${lineNo} 行：屬性缺少所屬頁面`);
      if (key === 'title') current.title = value.replace(/^["']|["']$/g, '');
    } else {
      throw new Error(`pages 第 ${lineNo} 行：不支援的縮排深度 ${indent.length}（僅允許 2 或 4）`);
    }
  }
  return entries;
}

// ---------------------------------------------------------------- 檢查規則
function checkMenu(yamlText, pageStems) {
  const errors = [];
  const warnings = [];
  const items = parseMenu(yamlText);

  const referenced = new Set();

  for (const it of items) {
    if (!it.target) continue;
    const [file, anchor] = it.target.split('#');

    // R-2：位移型錨點。artifacts.html 之數字錨點由 Publisher 自動編號，禁用。
    if (/^artifacts\.html$/.test(file) && /^\d+$/.test(anchor || '')) {
      errors.push(
        `R-2 [第 ${it.line} 行] 「${it.label}」使用位移型錨點 ${it.target}。` +
        `該編號依建置時實際存在之 artifact 類別產生，類別增減即整體位移且不會報錯。` +
        `請改指向策展頁（profiles-and-extensions.html／terminology.html）。`
      );
      continue;
    }

    // R-3：其他純數字錨點（同類風險，但非 artifacts.html，故僅警告）
    if (anchor && /^\d+$/.test(anchor)) {
      warnings.push(`R-3 [第 ${it.line} 行] 「${it.label}」之錨點 #${anchor} 為純數字，建議改用具名錨點。`);
    }

    // R-1：target 必須存在
    if (!/\.html$/.test(file)) {
      errors.push(`R-1 [第 ${it.line} 行] 「${it.label}」之 target「${it.target}」非 .html。`);
      continue;
    }
    const stem = file.slice(0, -'.html'.length);
    if (pageStems.has(stem)) {
      referenced.add(stem);
    } else if (AUTO_PAGES.has(stem)) {
      referenced.add(stem);
    } else {
      errors.push(
        `R-1 [第 ${it.line} 行] 「${it.label}」指向 ${file}，` +
        `但 input/pagecontent/${stem}.md 不存在，亦不在自動產生頁白名單中。`
      );
    }
  }

  // R-4：頂層項目數
  const topCount = new Set(items.map((i) => i.top)).size;
  if (topCount > TOP_LEVEL_SOFT_MAX) {
    warnings.push(`R-4 頂層項目 ${topCount} 項，超過建議上限 ${TOP_LEVEL_SOFT_MAX} 項（TW Core IG v1.0.0 為 8 項）。`);
  }

  // R-5：孤兒頁
  for (const stem of [...pageStems].sort()) {
    if (referenced.has(stem)) continue;
    if (ORPHAN_ALLOWLIST.has(stem)) continue;
    warnings.push(
      `R-5 input/pagecontent/${stem}.md 有建置產出但未被 menu 引用（孤兒頁）。` +
      `請納入 menu，或具名列入本腳本之 ORPHAN_ALLOWLIST 並附理由。`
    );
  }

  // R-6：pages: 與 pagecontent 之雙向對應（JOB-25）
  //
  // 宣告 pages: 後 SUSHI 停止自動收錄——漏列一個檔案，該頁即從產出中**靜默消失**，
  // 不會有任何錯誤訊息。與 R-2 之位移型錨點、JOB-24 之缺語系字串同屬靜默失效型缺陷。
  const pages = parsePages(yamlText);
  if (pages) {
    const declared = new Set(pages.map((p) => p.file));

    // R-6a：每個 pagecontent 檔案都要被宣告
    for (const stem of [...pageStems].sort()) {
      if (!declared.has(`${stem}.md`)) {
        errors.push(
          `R-6a input/pagecontent/${stem}.md 未列於 \`pages:\`。` +
          `宣告 pages: 後 SUSHI 不再自動收錄，該頁會從建置產出中靜默消失。`
        );
      }
    }

    for (const p of pages) {
      const stem = p.file.replace(/\.md$/, '');
      // R-6b：宣告的檔案要真的存在
      if (!pageStems.has(stem)) {
        errors.push(`R-6b [第 ${p.line} 行] \`pages:\` 宣告之 ${p.file} 不存在於 input/pagecontent/。`);
        continue;
      }
      // R-6c：title 不得缺漏或空白
      if (!p.title) {
        errors.push(`R-6c [第 ${p.line} 行] ${p.file} 缺少 title（或 title 為空）。`);
        continue;
      }
      // R-6d：title 不得等於 SUSHI 由檔名推導之預設值
      if (p.title === sushiDefaultTitle(p.file)) {
        warnings.push(
          `R-6d [第 ${p.line} 行] ${p.file} 之 title「${p.title}」等於 SUSHI 由檔名推導之預設值，` +
          `等同未命名（該頁 <title>／H1／麵包屑將顯示英文）。`
        );
      }
    }

    // R-6e：index.md 應為第一項
    if (pages.length && pages[0].file !== 'index.md') {
      warnings.push(`R-6e \`pages:\` 之第一項為 ${pages[0].file}，慣例應為 index.md（決定首頁與 toc 起始）。`);
    }
  }

  return { errors, warnings, topCount, items, pages };
}

// ---------------------------------------------------------------- 負向測試
//
// 閘門本身也可能失效（例如 parseMenu 提早 break 而漏檢），屆時會「全綠但沒檢查」。
// 比照 JOB-20／JOB-21／JOB-22 之作法，內建必失敗案例。
function selfTest() {
  const cases = [
    {
      name: 'R-1 指向不存在之頁面',
      yaml: 'menu:\n  首頁: index.html\n  不存在: no-such-page.html\n',
      pages: new Set(['index']),
      expect: /^R-1 /,
    },
    {
      name: 'R-2 使用 artifacts.html#2 位移型錨點',
      yaml: 'menu:\n  規範文件:\n    資源總覽: artifacts.html\n    Extensions: artifacts.html#2\n',
      pages: new Set([]),
      expect: /^R-2 /,
    },
    {
      name: 'R-5 孤兒頁未列入白名單',
      yaml: 'menu:\n  首頁: index.html\n',
      pages: new Set(['index', 'lonely']),
      expect: /^R-5 /,
      warningOnly: true,
    },
    {
      name: 'R-6a pages: 漏列一個 pagecontent 檔案（該頁會靜默消失）',
      yaml: 'pages:\n  index.md:\n    title: 應用說明\nmenu:\n  應用說明: index.html\n',
      pages: new Set(['index', 'forgotten']),
      expect: /^R-6a /,
    },
    {
      name: 'R-6b pages: 宣告了不存在的檔案',
      yaml: 'pages:\n  index.md:\n    title: 應用說明\n  ghost.md:\n    title: 幽靈頁\nmenu:\n  應用說明: index.html\n',
      pages: new Set(['index']),
      expect: /^R-6b /,
    },
    {
      name: 'R-6c pages: 條目缺 title',
      yaml: 'pages:\n  index.md:\n    title: 應用說明\n  bare.md:\n    title:\nmenu:\n  應用說明: index.html\n',
      pages: new Set(['index', 'bare']),
      expect: /^R-6c /,
    },
    {
      name: 'R-6d title 等於 SUSHI 由檔名推導之預設值',
      yaml: 'pages:\n  index.md:\n    title: 應用說明\n  general-exam.md:\n    title: General Exam\nmenu:\n  應用說明: index.html\n',
      pages: new Set(['index', 'general-exam']),
      expect: /^R-6d /,
      warningOnly: true,
    },
  ];

  let failed = 0;
  for (const c of cases) {
    let res;
    try {
      res = checkMenu(c.yaml, c.pages);
    } catch (e) {
      console.error(`  ✗ ${c.name}：剖析即拋錯（${e.message}）`);
      failed++;
      continue;
    }
    const pool = c.warningOnly ? res.warnings : res.errors;
    const hit = pool.some((m) => c.expect.test(m));
    if (hit) {
      console.log(`  ✓ ${c.name}`);
    } else {
      console.error(`  ✗ ${c.name}：預期被攔下，實際未攔（errors=${res.errors.length}, warnings=${res.warnings.length}）`);
      failed++;
    }
  }
  if (failed) {
    console.error(`\n負向測試失敗 ${failed} 組——閘門本身失效，修好前不得信任其結果。`);
    process.exit(1);
  }
  console.log('\n負向測試全數通過（閘門會攔下該攔的東西）。');
}

// ---------------------------------------------------------------- 主程序
function main() {
  const args = process.argv.slice(2);
  const strict = args.includes('--strict');

  if (args.includes('--self-test')) {
    console.log('check-menu 負向測試：');
    selfTest();
    return;
  }

  const yamlText = fs.readFileSync(CONFIG, 'utf8');
  const pageStems = new Set(
    fs.readdirSync(PAGEDIR).filter((f) => f.endsWith('.md')).map((f) => f.slice(0, -3))
  );

  let res;
  try {
    res = checkMenu(yamlText, pageStems);
  } catch (e) {
    console.error(`menu 剖析失敗：${e.message}`);
    process.exit(1);
  }

  if (res.errors.length) {
    console.error('導覽列檢查失敗：');
    for (const e of res.errors) console.error(`  ${e}`);
    console.error('');
  }
  if (res.warnings.length) {
    console.log(`導覽列警告${strict ? '（--strict：視為失敗）' : ''}：`);
    for (const w of res.warnings) console.log(`  ${w}`);
    console.log('');
  }

  if (res.errors.length || (strict && res.warnings.length)) process.exit(1);

  const targets = res.items.filter((i) => i.target).length;
  const pagesNote = res.pages
    ? `；pages: 已宣告 ${res.pages.length} 頁，與 pagecontent 雙向對應且均有中文標題`
    : '；(未宣告 pages:，頁面標題由 SUSHI 依檔名推導，R-6 未適用)';
  console.log(
    `OK: menu 頂層 ${res.topCount} 項、可點選入口 ${targets} 個，全數解析成功；` +
    `無位移型錨點，無未白名單之孤兒頁${pagesNote}` +
    (res.warnings.length ? `（${res.warnings.length} 項警告）` : '') + '。'
  );
}

main();
