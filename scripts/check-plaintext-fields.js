#!/usr/bin/env node
'use strict';
// ============================================================================
// 純文字欄位閘門：markdown 記號不得出現在 FHIR 之 string 型欄位
// ============================================================================
//
// 為什麼需要這道：
//   FHIR 之 `CodeSystem.concept.definition` 與 `.display` 型別為 **string**，
//   不是 markdown。寫在裡面的 `**粗體**` 與反引號**不會被算繪**，會逐字顯示。
//
//   實測（v0.9.0 已發佈站台）：
//     CodeSystem-CS-BetelNutObservable.json 之 narrative 顯示
//       「受檢者目前之嚼檳榔狀態。本碼為**問題**（Observation.code），答案以 `value[x]` 承載」
//     ValueSet-VS-CoreUploadSet.json 之 narrative 同樣逐字顯示。
//   即讀者看到的就是那兩個星號與反引號本身。
//
//   這是一份會被主管機關與臨床專家審查的規範文件，敘述的呈現品質不是小事。
//   ⚠️ 且此缺陷**跨五個版次累積了 6 處**（5 處自 v0.4.0、1 處 v0.9.0），
//   從未有任何東西發出訊號——IG Publisher 不會警告，因為語法完全合法。
//   純靠人眼看產出頁面才會發現，那正是需要閘門的形態。
//
// **不在檢查範圍**（這些欄位確為 markdown 型，記號會正常算繪）：
//   CodeSystem.description／ValueSet.description／StructureDefinition.description、
//   ImplementationGuide 之敘述頁、以及 `^purpose`／`^copyright` 等。
//   ⚠️ 故本閘門**只掃 `* #代碼 "顯示名" "定義"` 這一種形式**，不做全檔掃描——
//   放寬成全檔會把合法的 markdown description 一併判成違規。
//
// 用法：
//   node scripts/check-plaintext-fields.js              實檢
//   node scripts/check-plaintext-fields.js --self-test  負向自我測試（先跑這個）

const fs = require('fs');
const path = require('path');
const os = require('os');

// FSH 之 concept 規則：`* #code "display" "definition"`
// display 與 definition 皆為 string 型，兩者都要檢查。
const CONCEPT_RE = /^\s*\*\s*#(\S+)\s+"((?:[^"\\]|\\.)*)"(?:\s+"((?:[^"\\]|\\.)*)")?/;

// 要抓的 markdown 記號。刻意只列這三種——它們是本 repo 實際出現過、
// 且在純文字下明顯突兀的形態。星號採**成對**判定，避免把
// 「每日 3-5 顆*」這類單獨星號或數學式誤判。
const MARKERS = [
  ['粗體記號 **…**', /\*\*[^*]+\*\*/],
  ['反引號 `…`', /`[^`]+`/],
  ['markdown 連結 [文字](網址)', /\[[^\]]+\]\([^)]+\)/],
];

const FSH_DIR = path.join('input', 'fsh');

function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.fsh')) out.push(p);
  }
  return out;
}

function checkTree(root) {
  const violations = [];
  let concepts = 0;
  for (const p of walk(path.join(root, FSH_DIR))) {
    const lines = fs.readFileSync(p, 'utf8').split(/\r?\n/);
    lines.forEach((line, i) => {
      const m = line.match(CONCEPT_RE);
      if (!m) return;
      concepts += 1;
      const [, code, display, definition] = m;
      for (const [field, text] of [['display', display], ['definition', definition]]) {
        if (!text) continue;
        for (const [label, re] of MARKERS) {
          const hit = text.match(re);
          if (!hit) continue;
          violations.push(
            `[P-1] ${path.relative(root, p)}:${i + 1} #${code} 之 ${field} 含${label}：` +
            `${hit[0].slice(0, 40)}` +
            `　→ 該欄位於 FHIR 為 string 而非 markdown，記號會逐字顯示給讀者。`);
        }
      }
    });
  }
  return { violations, concepts };
}

// ---------------------------------------------------------------- 負向自測
function selfTest() {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'plaintext-'));
  const dir = path.join(tmp, FSH_DIR, 'codesystems');
  const results = [];
  const run = (name, fn) => {
    let ok = false;
    try { ok = fn(); } catch { ok = false; }
    results.push([name, ok]);
  };
  const reset = () => {
    fs.rmSync(tmp, { recursive: true, force: true });
    fs.mkdirSync(dir, { recursive: true });
  };
  const mk = (body) => fs.writeFileSync(path.join(dir, 'a.fsh'), body);

  // ① 定義含粗體 → 必須被抓到（即實際發生過的形態）
  reset();
  mk('CodeSystem: X\nId: X\n* #a "顯示名" "本碼為**問題**，不是答案。"\n');
  run('① definition 含粗體記號',
      () => checkTree(tmp).violations.some((v) => v.includes('粗體') && v.includes('definition')));

  // ② 定義含反引號 → 必須被抓到
  reset();
  mk('CodeSystem: X\nId: X\n* #a "顯示名" "以 UCUM `a` 表達。"\n');
  run('② definition 含反引號',
      () => checkTree(tmp).violations.some((v) => v.includes('反引號')));

  // ③ **display 也要查**——display 同為 string 型。
  //    只查 definition 會漏掉一半，且 display 出現在每一張代碼表上，更顯眼。
  reset();
  mk('CodeSystem: X\nId: X\n* #a "每日嚼食量（`{quid}/d`）" "純文字定義。"\n');
  run('③ display 含反引號', () => checkTree(tmp).violations.some((v) => v.includes('display')));

  // ④ markdown 連結 → 必須被抓到
  reset();
  mk('CodeSystem: X\nId: X\n* #a "顯示名" "詳見 [術語頁](terminology.html)。"\n');
  run('④ definition 含 markdown 連結',
      () => checkTree(tmp).violations.some((v) => v.includes('連結')));

  // ⑤ 純文字定義 → 不得誤報（正向對照）
  reset();
  mk('CodeSystem: X\nId: X\n* #a "顯示名" "本碼是問題，用於 Observation.code；答案以 value[x] 承載。"\n');
  run('⑤ 純文字定義不誤報（正向對照）', () => {
    const r = checkTree(tmp);
    return r.violations.length === 0 && r.concepts === 1;
  });

  // ⑥ **Description: 之 markdown 不得被誤判（正向對照）**——那個欄位確為 markdown 型。
  //    若把本閘門放寬成全檔掃描，這一案會轉紅，正確的敘述會被逼著改壞。
  reset();
  mk('CodeSystem: X\nId: X\n' +
     'Description: "本代碼系統為**provisional**，用於 `Observation.code`。"\n' +
     '* #a "顯示名" "純文字定義。"\n');
  run('⑥ Description 之 markdown 不誤判（正向對照）',
      () => checkTree(tmp).violations.length === 0);

  // ⑦ 單獨星號不得被誤判為粗體（正向對照）
  reset();
  mk('CodeSystem: X\nId: X\n* #a "顯示名" "每日 3-5 顆*，星號為原始表單之註記符號。"\n');
  run('⑦ 單獨星號不誤判（正向對照）', () => checkTree(tmp).violations.length === 0);

  // ⑧ 只有 display、無 definition 之 concept 不得使解析崩潰（正向對照）
  reset();
  mk('CodeSystem: X\nId: X\n* #a "只有顯示名"\n');
  run('⑧ 無 definition 之 concept（正向對照）', () => {
    const r = checkTree(tmp);
    return r.violations.length === 0 && r.concepts === 1;
  });

  let bad = 0;
  console.log('純文字欄位閘門負向自我測試（標「正向對照」者必須不被判失敗，其餘必須被判失敗）：');
  for (const [name, ok] of results) {
    console.log(`  ${ok ? '✔' : '✖'} ${name}`);
    if (!ok) bad++;
  }
  fs.rmSync(tmp, { recursive: true, force: true });
  if (bad) {
    console.error(`\n✖ 自我測試失敗 ${bad} 項——閘門本身有問題，實檢結果不可信。`);
    process.exit(1);
  }
  console.log('✔ 自我測試全數通過。\n');
}

// ---------------------------------------------------------------- main
function main() {
  const root = path.resolve(__dirname, '..');
  if (process.argv.includes('--self-test')) { selfTest(); return; }

  const r = checkTree(root);
  console.log(`純文字欄位閘門：掃描 ${r.concepts} 個 concept 之 display 與 definition`);

  if (r.violations.length) {
    console.error(`\n✖ 純文字欄位閘門失敗，共 ${r.violations.length} 筆：`);
    r.violations.forEach((v) => console.error('  ' + v));
    console.error('\n  處置：改寫為純文字。強調改用語序或 ⚠️ 記號，代碼字面以「」框住。');
    console.error('  ⚠️ 不要改成別的 markdown 記號——問題不在用哪一種，在該欄位根本不算繪。');
    process.exit(1);
  }
  console.log('\n✔ 所有 concept 之 display 與 definition 均為純文字，無不會算繪之 markdown 記號。');
}

main();
