#!/usr/bin/env node
// LOINC 顯示名不符之分流工具（JOB-01）
//
// 從 output/qa.txt 擷取 "Wrong Display Name" 訊息，取出本 IG 標示之 display 與
// **術語伺服器回報之官方 display**（該訊息本身即含官方值，故毋須另行 $lookup 即可分流），
// 依 LOINC 六軸做文字層級比對後分為四類：
//
//   A  COMPONENT 或 SYSTEM 不同  → 高度可疑「用錯碼」，須以 $lookup 逐碼確認並換碼
//   B  PROPERTY（量綱）不同      → 質量濃度 ↔ 莫耳濃度等，會導致數值誤讀，須決策
//   C  僅 METHOD 或用語差異      → 代碼正確、display 漂移，可覆寫為官方 display
//   D  無法自動判定              → 一律人工檢視
//
// ⚠️ 本工具**只做分流，不改任何檔案**。C 類看似可批次覆寫，但其中「檢體範圍不同」
// （如 Serum or Plasma vs Serum）之案例仍可能是選碼問題，故 C 類亦標註是否含
// SYSTEM 差異供人工過目。分流結果不得直接當作修改依據——
// 見 .claude/skills/fhir-tx-audit/SKILL.md 與 docs/optimization/JOB-01。
//
// Usage:
//   node scripts/triage-display-mismatches.js [--qa output/qa.txt] [--csv <輸出路徑>]
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
function arg(name, fallback) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] && !process.argv[i + 1].startsWith('--') ? process.argv[i + 1] : fallback;
}
const qaPath = path.resolve(repoRoot, arg('--qa', path.join('output', 'qa.txt')));
const csvPath = arg('--csv', null);

if (!fs.existsSync(qaPath)) {
  console.error(`找不到 qa.txt：${qaPath}`);
  process.exit(1);
}
const qa = fs.readFileSync(qaPath, 'utf8');

// ---------------------------------------------------------------- 擷取
// display 內含單引號（如 4,4'-Methylene…），故不能以最短匹配切分；
// 改以「' for http://loinc.org#」與「' (en-US)」等固定錨點界定。
const RE = /Wrong Display Name '(.+?)' for http:\/\/loinc\.org#([0-9]+-[0-9]+)\. Valid display is one of \d+ choices: (.+?) \(for the language/g;

function splitChoices(s) {
  // 形如：'A' (en-US), 'B' (en-US) or 'C' (en-US)
  const out = [];
  const re = /'(.*?)' \((?:en|en-US)\)/g;
  let m;
  while ((m = re.exec(s))) out.push(m[1]);
  return out;
}

const rows = [];
const seen = new Set();
let m;
while ((m = RE.exec(qa))) {
  const [, igDisplay, code, choicesRaw] = m;
  const key = `${code}|${igDisplay}`;
  if (seen.has(key)) continue;
  seen.add(key);
  rows.push({ code, igDisplay, official: splitChoices(choicesRaw) });
}

// ---------------------------------------------------------------- 六軸拆解
// LOINC 全名慣例：COMPONENT [PROPERTY] in SYSTEM by METHOD
function axes(name) {
  const propM = name.match(/\[([^\]]+)\]/);
  const property = propM ? propM[1] : '';
  let rest = name.replace(/\[[^\]]*\]/, ' ');
  const byM = rest.match(/\bby\s+(.+)$/i);
  const method = byM ? byM[1].trim() : '';
  if (byM) rest = rest.slice(0, byM.index);
  const inM = rest.match(/\bin\s+([^]+)$/i);
  const system = inM ? inM[1].trim() : '';
  if (inM) rest = rest.slice(0, inM.index);
  return { component: rest.replace(/\s+/g, ' ').trim(), property, system, method };
}

const norm = (s) =>
  s
    .toLowerCase()
    .replace(/[.,''`\-‐-―]/g, '')
    .replace(/\s+/g, ' ')
    .trim();

// 已知同義詞：非拼寫差異，而是 LOINC 與院內慣用語之別，不視為 COMPONENT 不同
const SYNONYMS = [
  ['wbc', 'leukocytes'],
  ['rbc', 'erythrocytes'],
  ['uric acid', 'urate'],
  ['gamma glutamyltransferase', 'gamma glutamyl transferase'],
  ['cyfra 211', 'cytokeratin 19'],
];
function componentSame(a, b) {
  const x = norm(a);
  const y = norm(b);
  if (x === y) return true;
  // 「/100 leukocytes」為 LOINC 舊式命名，現行為「/Leukocytes」
  const strip = (s) => s.replace(/\/100 leukocytes/g, '/leukocytes');
  if (strip(x) === strip(y)) return true;
  for (const [p, q] of SYNONYMS) {
    if ((x.includes(p) && y.includes(q)) || (x.includes(q) && y.includes(p))) return true;
  }
  return false;
}

// ---------------------------------------------------------------- 分流
for (const r of rows) {
  const ig = axes(r.igDisplay);
  // 官方選項同時含長名與短名（如 'RBC # Bld Auto'、'Sp Gr Ur Refractometry'）。
  // 短名是縮寫，拿來比對六軸會產生大量假陽性，故以「與 IG 標示之詞彙重疊度」挑選
  // 最相近者，同分時取較長者（LOINC 長名）。
  const words = (s) => new Set(norm(s).split(' ').filter(Boolean));
  const igWords = words(r.igDisplay);
  const overlap = (o) => {
    const w = words(o);
    let hit = 0;
    for (const t of w) if (igWords.has(t)) hit++;
    return hit / Math.max(1, new Set([...w, ...igWords]).size);
  };
  const cand = r.official
    .map((o) => ({ o, a: axes(o), score: overlap(o) }))
    .sort((x, y) => x.score - y.score || x.o.length - y.o.length)
    .pop();
  const off = cand.a;
  r.officialPrimary = cand.o;

  // 注意：JS 的 && 回傳最後一個運算元而非布林值。此處必須以 Boolean() 強制轉型——
  // 否則 sysDiff 會變成 'Serum, Plasma or Blood' 這類字串，寫入 CSV 時其中的逗號
  // 會把該列撐出多餘欄位（2026-07-26 實際發生過）。分類邏輯用 truthy 判斷不受影響，
  // 但輸出必然損毀。
  const compDiff = !componentSame(ig.component, off.component);
  const sysDiff = Boolean(norm(ig.system) !== norm(off.system) && (ig.system || off.system));
  const propDiff = Boolean(norm(ig.property) !== norm(off.property) && (ig.property || off.property));
  const methDiff = Boolean(norm(ig.method) !== norm(off.method));

  r.axes = { compDiff, sysDiff, propDiff, methDiff };
  if (compDiff || sysDiff) r.cls = 'A';
  else if (propDiff) r.cls = 'B';
  else if (methDiff || norm(r.igDisplay) !== norm(r.officialPrimary)) r.cls = 'C';
  else r.cls = 'D';
}

// ---------------------------------------------------------------- 輸出
const byCls = { A: [], B: [], C: [], D: [] };
for (const r of rows) byCls[r.cls].push(r);

console.log(`\n來源：${path.relative(repoRoot, qaPath)}`);
console.log(`共擷取 ${rows.length} 筆 Wrong Display Name\n`);
console.log(`  A（COMPONENT／SYSTEM 不同，高度可疑用錯碼，須 $lookup 換碼）：${byCls.A.length}`);
console.log(`  B（PROPERTY 量綱不同，須決策）：                              ${byCls.B.length}`);
console.log(`  C（僅 METHOD／用語差異，可覆寫 display）：                    ${byCls.C.length}`);
console.log(`  D（無法自動判定，人工檢視）：                                 ${byCls.D.length}`);

for (const cls of ['A', 'B']) {
  if (!byCls[cls].length) continue;
  console.log(`\n===== ${cls} 類（需人工決策，不可批次處理）=====`);
  for (const r of byCls[cls]) {
    const d = Object.entries(r.axes).filter(([, v]) => v).map(([k]) => k.replace('Diff', '')).join('+');
    console.log(`  ${r.code}  [${d}]`);
    console.log(`      IG  : ${r.igDisplay}`);
    console.log(`      官方: ${r.officialPrimary}`);
  }
}

if (csvPath) {
  const esc = (s) => `"${String(s).replace(/"/g, '""')}"`;
  const out = [
    'code,class,ig_display,official_display,component_diff,system_diff,property_diff,method_diff,action,replacement_code,rationale,verified_by,verified_date',
  ];
  for (const r of rows) {
    const action = r.cls === 'C' ? 'rewrite-display' : 'REVIEW';
    // 每一欄都經 esc()——包含看似安全的布林與代碼欄。少 escape 一欄就足以毀掉整份 CSV。
    out.push(
      [
        r.code,
        r.cls,
        r.igDisplay,
        r.officialPrimary,
        r.axes.compDiff,
        r.axes.sysDiff,
        r.axes.propDiff,
        r.axes.methDiff,
        action,
        '',
        '',
        '',
        '',
      ]
        .map(esc)
        .join(',')
    );
  }
  const abs = path.resolve(repoRoot, csvPath);
  fs.writeFileSync(abs, out.join('\n') + '\n');
  console.log(`\n已輸出：${path.relative(repoRoot, abs)}`);
}
