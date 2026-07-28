#!/usr/bin/env node
// 檢查「宣告 Must Support 的欄位」是否真的在範例中被填過。
//
// 為什麼需要：MS 是對實作端的要求——宣告了卻沒有任何範例示範怎麼填，實作端無從照做，
// 而 IG Publisher 不會檢查這件事（它只檢查範例是否符合 profile，不檢查 profile 的
// MS 宣告是否被範例覆蓋）。本 IG 的 README 明確以 MS 支撐第 19 條之稽核追溯訴求，
// 「宣告了但範例不填」會使該訴求無法驗證。
//
// 判定方式：
//   1. 從 fsh-generated/resources/StructureDefinition-*.json 取出 snapshot 中
//      mustSupport = true 的元素（含繼承自上游 profile 者——這正是要用 snapshot
//      而非 FSH 原始碼的原因）。
//   2. 找出 meta.profile 指向該 profile 的所有範例資源。
//   3. 逐一判斷該路徑在任一範例中是否有值，或以 dataAbsentReason 標示缺值。
//
// **本腳本的判定有明確界線，不要當成比實際更強的保證：**
//   - 切片（`component:systolic`）以其基礎路徑近似判定，不驗證切片判別式是否真的命中。
//   - Extension 定義（type = Extension）不判定覆蓋——extension 的「範例」是指有宿主
//     資源用到它，需在宿主端檢查，與此處的路徑比對不是同一件事。輸出中另行列出。
//   - 「有值」只看存在性，不看值是否有意義。
//
// Usage:
//   node scripts/check-ms-coverage.js [--dir fsh-generated/resources] [--json out.json] [--strict]
//     --strict  有未覆蓋之 MS 欄位即以非 0 結束（供 CI 收緊時使用）
'use strict';

const fs = require('fs');
const path = require('path');

function arg(name, fallback = null) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] ? process.argv[i + 1] : fallback;
}

// 掃描目錄之選擇很關鍵：SUSHI 之 fsh-generated **只有 differential、沒有 snapshot**，
// 繼承自上游（TW Core）的 MS 宣告完全看不到。IG Publisher 的 output/ 才有完整
// snapshot。故未指定 --dir 時：優先取 output/（建置後執行），否則退回 fsh-generated
// 並明講其侷限。第一版未處理此事，在 CI 掃出「0 個 MS 欄位」卻回報 OK——假綠。
function autoDir() {
  const hasSD = (d) =>
    fs.existsSync(d) && fs.readdirSync(d).some((f) => f.startsWith('StructureDefinition-') && f.endsWith('.json'));
  if (hasSD('output')) return 'output';
  if (hasSD('fsh-generated/resources')) return 'fsh-generated/resources';
  return null;
}

const dir = arg('--dir', null) ?? autoDir();
const jsonOut = arg('--json');
const strict = process.argv.includes('--strict');

if (!dir || !fs.existsSync(dir)) {
  console.error(`✖ 找不到可掃描之目錄（output/ 或 fsh-generated/resources）——請先執行建置。`);
  console.error('  （本機若無法連上 packages.fhir.org，SUSHI 會在載入核心套件時中止，此檢查只能在 CI 執行。）');
  process.exit(1);
}

const files = fs.readdirSync(dir).filter((f) => f.endsWith('.json'));
const resources = [];
for (const f of files) {
  try {
    resources.push(JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8')));
  } catch {
    console.error(`  ⚠️ 略過無法解析之檔案：${f}`);
  }
}

const profiles = resources.filter(
  (r) => r.resourceType === 'StructureDefinition' && r.derivation === 'constraint'
);
const instances = resources.filter(
  (r) => r.resourceType !== 'StructureDefinition' &&
         r.resourceType !== 'ImplementationGuide' &&
         r.meta && Array.isArray(r.meta.profile)
);

// ---------------------------------------------------------------- 路徑求值
// element.id 形如 Observation.component:systolic.value[x]
// 切片標記在此被剝除（見檔頭之界線說明）；[x] 以前綴比對任一 value 型別。
function steps(elementId) {
  return elementId
    .split('.')
    .slice(1) // 去掉資源型別
    .map((s) => s.split(':')[0]);
}

function hasValue(node, rest) {
  if (node === undefined || node === null) return false;
  if (rest.length === 0) {
    if (Array.isArray(node)) return node.length > 0;
    if (typeof node === 'object') return Object.keys(node).length > 0;
    return node !== '';
  }
  if (Array.isArray(node)) return node.some((n) => hasValue(n, rest));
  if (typeof node !== 'object') return false;

  const [head, ...tail] = rest;
  if (head.endsWith('[x]')) {
    const prefix = head.slice(0, -3);
    for (const k of Object.keys(node)) {
      if (k.startsWith(prefix) && k.length > prefix.length && hasValue(node[k], tail)) return true;
    }
    return false;
  }
  if (head in node && hasValue(node[head], tail)) return true;

  // 缺值以 dataAbsentReason 標明者視為已覆蓋——那正是本 IG 的治理原則所要求的填法
  const shadow = node[`_${head}`];
  if (shadow && JSON.stringify(shadow).includes('data-absent-reason')) return true;
  if (tail.length === 0 && node[head] && node[head].dataAbsentReason) return true;
  return false;
}

// ---------------------------------------------------------------- 主判定
const rows = [];
const extensionProfiles = [];
let differentialOnly = 0;

for (const sd of profiles) {
  // snapshot 才含繼承自上游之 MS；SUSHI 產物只有 differential，此時僅能檢查
  // 本 IG 自行宣告的 MS，須向使用者明講（見結尾之提示與 0 筆防呆）。
  let elements = sd.snapshot?.element;
  if (!elements || elements.length === 0) {
    elements = sd.differential?.element ?? [];
    differentialOnly++;
  }
  const msIds = elements.filter((e) => e.mustSupport === true).map((e) => e.id);
  if (msIds.length === 0) continue;

  if (sd.type === 'Extension') {
    extensionProfiles.push({ id: sd.id, url: sd.url, msCount: msIds.length });
    continue;
  }

  const conforming = instances.filter((i) => i.meta.profile.some((p) => p.split('|')[0] === sd.url));
  for (const id of msIds) {
    const p = steps(id);
    if (p.length === 0) continue; // 資源根層標 MS，無意義
    const covered = conforming.filter((i) => hasValue(i, p));
    rows.push({
      profile: sd.id,
      path: id,
      examples: conforming.length,
      covered: covered.length,
      coveredBy: covered.slice(0, 3).map((i) => i.id),
    });
  }
}

rows.sort((a, b) => (a.profile === b.profile ? a.path.localeCompare(b.path) : a.profile.localeCompare(b.profile)));
const gaps = rows.filter((r) => r.covered === 0);
const noExample = [...new Set(rows.filter((r) => r.examples === 0).map((r) => r.profile))];

console.log('Must Support 覆蓋檢核');
console.log(`  掃描目錄：${dir}`);
console.log(`  掃描 ${profiles.length} 個 profile、${instances.length} 個範例實例`);
if (differentialOnly > 0) {
  console.log(
    `  ⚠️ ${differentialOnly} 個 profile 無 snapshot，僅以 differential 判定——` +
      '繼承自上游（TW Core 等）的 MS 宣告**不在檢查範圍**。完整檢查需以建置後之 output/ 為掃描目錄。'
  );
}
console.log(`  MS 欄位共 ${rows.length} 個，已被範例覆蓋 ${rows.length - gaps.length} 個，未覆蓋 ${gaps.length} 個\n`);

// 0 筆 MS 不可能是本 IG 的真實狀態（多個 profile 明確宣告 performer MS 等）。
// 出現 0 代表掃描基礎錯了（例如拿到無 snapshot 又無 MS differential 的目錄），
// 此時回報 OK 是假綠——第一版就這樣騙過了 CI。一律視為失敗。
if (rows.length === 0 && extensionProfiles.length === 0) {
  console.error('✖ 掃出 0 個 MS 欄位——掃描基礎有誤（snapshot 缺失？目錄錯誤？），不得視為通過。');
  process.exit(1);
}

if (noExample.length) {
  console.log(`⚠️ 下列 profile 有 MS 宣告但**沒有任何範例**（其 MS 欄位必然全部未覆蓋）：`);
  for (const p of noExample) console.log(`    ${p}`);
  console.log('');
}

if (gaps.length) {
  console.log('未覆蓋之 MS 欄位：');
  let cur = null;
  for (const g of gaps) {
    if (g.profile !== cur) {
      cur = g.profile;
      console.log(`  ${cur}（${g.examples} 個範例）`);
    }
    console.log(`    ✖ ${g.path}`);
  }
  console.log('');
}

if (extensionProfiles.length) {
  console.log('下列 Extension 定義含 MS 宣告，其覆蓋須在**宿主資源**端判斷，本腳本不判定：');
  for (const e of extensionProfiles) console.log(`    ${e.id}（${e.msCount} 個 MS 欄位）`);
  console.log('');
}

if (jsonOut) {
  fs.writeFileSync(jsonOut, `${JSON.stringify({ rows, gaps, extensionProfiles }, null, 2)}\n`);
  console.log(`已寫出 ${jsonOut}`);
}

if (gaps.length === 0) {
  console.log('OK：所有 MS 欄位皆有範例覆蓋。');
} else if (strict) {
  console.error(`✖ 有 ${gaps.length} 個 MS 欄位未被任何範例覆蓋（--strict）。`);
  process.exit(1);
} else {
  console.log('（未加 --strict，不以此使建置失敗。）');
}
