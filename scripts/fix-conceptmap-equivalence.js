#!/usr/bin/env node
// ConceptMap equivalence 方向修正（JOB-22 §3.1）＋ 一致性檢查（§3.4）。
//
// 根因（JOB-22 §1.1）：文件二 §5.4 以 **source 為主詞**定義 narrower／wider，
// 而 FHIR R4 之官方定義為 **target-relative**：
//   narrower — The **target** mapping is narrower in meaning than the source concept.
//   wider    — The **target** mapping is wider in meaning than the source concept.
// ConceptMap 完全依本專案文件執行、內部一致，故 16 組之值方向一致顛倒——
// 每一則 comment 都正確描述了語意關係，錯的只是所選代碼，因此可機械翻轉。
// （R5 已改名為 source-is-narrower-than-target，把主詞寫進代碼名稱以消除此歧義。）
//
// ⚠️ 五組（現為六組）comment 與 display 相互矛盾者**排除於自動翻轉**，依 §3.2 個別處理：
//    只翻轉 equivalence 會把矛盾的 comment 固定下來。清單見 MANUAL_ELEMENTS。
//
// Usage:
//   node scripts/fix-conceptmap-equivalence.js            # dry-run：印出變更清單供覆核
//   node scripts/fix-conceptmap-equivalence.js --apply    # 套用翻轉
//   node scripts/fix-conceptmap-equivalence.js --check    # 一致性檢查（CI 閘門用）
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const cmPath = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');
const argv = process.argv.slice(2);
const apply = argv.includes('--apply');
const checkMode = argv.includes('--check');
// 涵蓋率下限：規則命中數／總組數。防「規則全未命中卻一片綠」（JOB-20 §5 之教訓）。
const minCoverage = parseFloat((argv.indexOf('--min-coverage') !== -1 && argv[argv.indexOf('--min-coverage') + 1]) || '0.5');

// §3.2 個別處理者：comment 與 display 矛盾，不可機械翻轉。
const MANUAL_ELEMENTS = new Set([0, 1, 3, 11, 13, 18]);

// ---- 一致性規則（§3.4）------------------------------------------------------
// 設計原則（避免誤判）：
//  1. 方向**只在 comment 帶有完整方向簽章（兩半皆具）時**才主張；單邊出現不足以斷定。
//  2. `relatedto` **永不被要求含任何關鍵詞**——21 組之措辭高度多樣（有僅寫換算公式者），
//     故僅在其 comment 明確主張包含關係時才視為違反。
//  3. 無簽章者列「未涵蓋」，**不算違反**（否則 [6] 這類極短 comment 會被誤殺）。
//  4. 「指定」須排除「未指定」（負向前瞻）——[9]/[10] 之「target…且指定 Immunoassay」、
//     [27] 之「source 之檢體為未指定之 Blood」皆曾為誤判來源。
const NON_DIRECTIONAL = [
  '不可直接比較', '需換算', '換算', '不同具體方法', '無包含關係', '不同量測方式',
  '非包含關係', '互有寬窄', '性質不同', '非單純包含', 'Unit conversion required',
  '不同估算公式', '數值不可', '檢體不同',
];
const SRC_SPECIFIED = /source\s*(?:之\S*)?指定/;
const TGT_UNSPECIFIED = /target[^，。]*未指定/;
const SRC_UNSPECIFIED = /source[^，。]*未指定/;
const TGT_SPECIFIED = /target[^，。]*(?<!未)指定/;
const SRC_BROADER = /語意較\s*target[^，。]*廣|較\s*target\s*廣/;

function expectedEquivalence(comment) {
  const c = comment || '';
  if (NON_DIRECTIONAL.some((k) => c.includes(k))) return { eq: 'relatedto', rule: 'R1 非方向性語彙' };
  if (SRC_SPECIFIED.test(c) && TGT_UNSPECIFIED.test(c)) return { eq: 'wider', rule: 'R2 source 指定＋target 未指定' };
  if ((SRC_UNSPECIFIED.test(c) && TGT_SPECIFIED.test(c)) || SRC_BROADER.test(c)) return { eq: 'narrower', rule: 'R3 source 較廣／未指定＋target 指定' };
  return { eq: null, rule: '—（無判準可循）' };
}

// ---- 解析 ------------------------------------------------------------------
function parse(text) {
  const el = {};
  for (const line of text.split(/\r?\n/)) {
    const m = line.match(/^\*\s*group\[0\]\.element\[(\d+)\](\.target\[0\])?\.(code|display|equivalence|comment)\s*=\s*(.+)$/);
    if (!m) continue;
    const i = Number(m[1]);
    const key = (m[2] ? 't_' : 's_') + m[3];
    el[i] = el[i] || {};
    el[i][key] = m[4].trim().replace(/^"|"$/g, '').replace(/^#/, '');
  }
  return el;
}

const original = fs.readFileSync(cmPath, 'utf8');
const el = parse(original);
const ids = Object.keys(el).map(Number).sort((a, b) => a - b);

// ---- --check：一致性檢查 ----------------------------------------------------
if (checkMode) {
  const violations = [];
  let covered = 0;
  const uncovered = [];
  for (const i of ids) {
    const eq = el[i].t_equivalence || '';
    const { eq: exp, rule } = expectedEquivalence(el[i].t_comment);
    if (exp === null) { uncovered.push(i); continue; }
    covered++;
    if (exp !== eq) violations.push({ i, eq, exp, rule, s: el[i].s_code, t: el[i].t_code, c: el[i].t_comment });
  }
  const ratio = ids.length ? covered / ids.length : 0;
  console.log(`ConceptMap equivalence 一致性檢查（${ids.length} 組）`);
  console.log(`  規則涵蓋 ${covered}／${ids.length} = ${(ratio * 100).toFixed(1)}%（下限 ${(minCoverage * 100).toFixed(0)}%）`);
  console.log(`  未涵蓋（無方向簽章，不算違反）：${uncovered.length ? uncovered.map((i) => `[${i}]`).join(' ') : '無'}`);
  const dist = {};
  for (const i of ids) dist[el[i].t_equivalence] = (dist[el[i].t_equivalence] || 0) + 1;
  console.log(`  equivalence 實測分佈：${Object.entries(dist).sort().map(([k, v]) => `${k} ${v}`).join('／')}`);
  if (violations.length) {
    console.error(`\n✖ comment 與 equivalence 不一致：${violations.length} 組`);
    for (const v of violations) {
      console.error(`  [${v.i}] ${v.s} → ${v.t}：現值 ${v.eq}，依 ${v.rule} 應為 ${v.exp}`);
      console.error(`        comment: ${v.c}`);
    }
    process.exit(1);
  }
  if (covered === 0) { console.error('\n✖ 規則涵蓋為 0——判準必然失效，非「全部無簽章」。'); process.exit(1); }
  if (ratio < minCoverage) { console.error(`\n✖ 規則涵蓋率 ${(ratio * 100).toFixed(1)}% < ${(minCoverage * 100).toFixed(0)}%，研判判準失效。`); process.exit(1); }
  console.log(`\n✔ 一致性檢查通過：0 違反，涵蓋率 ${(ratio * 100).toFixed(1)}% ≥ ${(minCoverage * 100).toFixed(0)}%。`);
  process.exit(0);
}

// ---- dry-run／--apply：方向翻轉 --------------------------------------------
const FLIP = { narrower: 'wider', wider: 'narrower' };
const changes = [];
for (const i of ids) {
  const eq = el[i].t_equivalence || '';
  if (MANUAL_ELEMENTS.has(i)) continue;         // §3.2 個別處理
  if (!(eq in FLIP)) continue;                  // relatedto／equivalent 不動
  changes.push({ i, from: eq, to: FLIP[eq], s: el[i].s_code, t: el[i].t_code, c: el[i].t_comment });
}

console.log(`自動翻轉候選：${changes.length} 組（排除 §3.2 個別處理之 ${[...MANUAL_ELEMENTS].sort((a, b) => a - b).map((i) => `[${i}]`).join(' ')}）\n`);
console.log(`${'el'.padEnd(5)}${'source → target'.padEnd(24)}${'現值'.padEnd(10)}→ 新值`);
for (const c of changes) {
  console.log(`[${String(c.i).padStart(2)}]  ${`${c.s} → ${c.t}`.padEnd(23)}${c.from.padEnd(11)}→ ${c.to}`);
  console.log(`      ${c.c}`);
}
const byDir = changes.reduce((a, c) => { const k = `${c.from}→${c.to}`; a[k] = (a[k] || 0) + 1; return a; }, {});
console.log(`\n小計：${Object.entries(byDir).map(([k, v]) => `${k} ${v} 組`).join('、')}`);

if (!apply) { console.log('\n（dry-run。覆核無誤後以 --apply 套用。）'); process.exit(0); }

let out = original;
for (const c of changes) {
  const re = new RegExp(`(\\*\\s*group\\[0\\]\\.element\\[${c.i}\\]\\.target\\[0\\]\\.equivalence\\s*=\\s*)#${c.from}\\b`);
  if (!re.test(out)) { console.error(`✖ [${c.i}] 未能定位 equivalence 行，中止以免部分套用。`); process.exit(1); }
  out = out.replace(re, `$1#${c.to}`);
}
fs.writeFileSync(cmPath, out);
console.log(`\n已套用 ${changes.length} 組翻轉至 ${path.relative(repoRoot, cmPath)}。`);
