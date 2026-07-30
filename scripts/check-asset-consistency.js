#!/usr/bin/env node
// 驗證衍生資產 input/assets/snomed-loinc-mappings.csv 之 loinc_preferred 欄，
// 逐筆均存在於某一 IG 值集（input/fsh/valuesets/*.fsh）。
//
// 為什麼需要這支腳本（JOB-19 §2.5）：
// 該 CSV 為對外下載資產，其 loinc_preferred 曾三度與 IG 本體脫節而未被察覺：
//   eGFR 88293-6（實為 98979-8）、血壓 55284-4（DISCOURAGED，實為 85354-9）、
//   視力 79880-1（單眼最佳矯正 Snellen，實為 98497-1 panel）。
// 其 snomed_status 欄卻一律標 VERIFIED。此腳本把「CSV 之 LOINC 側須與值集一致」
// 這條先前只靠人工的規則閘門化：改了值集卻沒同步 CSV（或反之）即擋下。
//
// 方向：**以值集為真**。CSV 追隨值集，不得反向回填。
//
// 哨符（sentinel）：loinc_preferred 若為「(-…)」形式（如「(-確定無合適碼)」），
// 表示該項目經查證於 LOINC 無適用代碼（如腰臀比 WHR），屬有意之無碼標記，予以放行。
//
// Usage: node scripts/check-asset-consistency.js
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const vsDir = path.join(repoRoot, 'input', 'fsh', 'valuesets');
const csvPath = path.join(repoRoot, 'input', 'assets', 'snomed-loinc-mappings.csv');

// 收集所有值集中出現之 LOINC 代碼。
function collectValueSetLoincCodes() {
  const codes = new Set();
  for (const name of fs.readdirSync(vsDir)) {
    if (!name.endsWith('.fsh')) continue;
    const text = fs.readFileSync(path.join(vsDir, name), 'utf8');
    for (const m of text.matchAll(/^\*\s+LNC#(\S+)/gm)) codes.add(m[1]);
  }
  return codes;
}

// 最小 CSV 解析（僅需第一列標頭與各列之欄位切割；本檔之引號欄位不含換行）。
function parseCsv(text) {
  const lines = text.replace(/^﻿/, '').split(/\r?\n/).filter((l) => l.length);
  const split = (line) => {
    const out = [];
    let f = '', q = false;
    for (let i = 0; i < line.length; i++) {
      const c = line[i];
      if (q) { if (c === '"') { if (line[i + 1] === '"') { f += '"'; i++; } else q = false; } else f += c; }
      else if (c === '"') q = true;
      else if (c === ',') { out.push(f); f = ''; }
      else f += c;
    }
    out.push(f);
    return out;
  };
  const header = split(lines[0]);
  return lines.slice(1).map((l) => {
    const cells = split(l);
    return Object.fromEntries(header.map((h, i) => [h, cells[i] ?? '']));
  });
}

const SENTINEL = /^\(-/; // 「(-確定無合適碼)」等有意之無碼標記

// ---- 層級標示一致性（JOB-21 §3.3）----------------------------------------
// A = 值集內以**標籤形式**標註 acceptable 之碼；B = ConceptMap source ∩ 值集內之碼。
// A △ B（對稱差）必須為空集合。
//
// ⚠️ 判定 A 必須用標籤形式 `Acceptable:`／`（Acceptable：`，**不可**用「comment 含 Acceptable」：
//    77307-7（血鉛 Preferred）之註解寫「5671-3／23749-5 為 Acceptable，經 ConceptMap 歸一」——
//    它在描述**其他碼**是 acceptable。以子字串比對會把它誤判為 acceptable，使 A 虛增。
//    （本檢查開發時即實測到此誤判：A 34→33、A 類 4→3。）
//
// 56086-2 等「刻意保留於 ConceptMap 但已移出值集」者，因 B 已 ∩ 值集內之碼而自然排除，
// 無須允許清單；日後若出現值集內之例外，須以具名允許清單處理並附理由。
const ACCEPTABLE_LABEL = /(?:^|[（(\s])Acceptable[:：]/;

function collectAcceptableAnnotated() {
  const set = new Set();
  for (const name of fs.readdirSync(vsDir)) {
    if (!name.endsWith('.fsh')) continue;
    for (const line of fs.readFileSync(path.join(vsDir, name), 'utf8').split(/\r?\n/)) {
      const m = line.match(/^\*\s+LNC#(\S+)/);
      if (!m) continue;
      const i = line.indexOf('//');
      if (i === -1) continue;
      if (ACCEPTABLE_LABEL.test(line.slice(i))) set.add(m[1]);
    }
  }
  return set;
}

function conceptMapSources() {
  const f = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');
  const set = new Set();
  for (const m of fs.readFileSync(f, 'utf8').matchAll(/element\[\d+\]\.code = #(\S+)/g)) set.add(m[1]);
  return set;
}

function checkTierConsistency(vsCodes) {
  const A = collectAcceptableAnnotated();
  const srcAll = conceptMapSources();
  const B = new Set([...srcAll].filter((c) => vsCodes.has(c)));
  const onlyA = [...A].filter((c) => !B.has(c)).sort();
  const onlyB = [...B].filter((c) => !A.has(c)).sort();
  const outOfVs = [...srcAll].filter((c) => !vsCodes.has(c)).sort();
  console.log(`層級標示一致性：FSH 標註 ${A.size} 碼、ConceptMap source ∩ 值集 ${B.size} 碼`
    + `（另 ${outOfVs.length} 碼在 ConceptMap 但已移出值集，依設計排除：${outOfVs.join(', ') || '無'}）`);
  if (onlyA.length || onlyB.length) {
    console.error(`✖ 層級標示不一致：${onlyA.length + onlyB.length} 筆`);
    if (onlyA.length) console.error(`  FSH 標 Acceptable 但 ConceptMap 無歸一（實作端送出時無法歸一）：${onlyA.join(', ')}`);
    if (onlyB.length) console.error(`  ConceptMap 有歸一但 FSH 未標 Acceptable（註解漏註）：${onlyB.join(', ')}`);
    return false;
  }
  console.log(`OK: 層級標示一致（對稱差 0）。`);
  return true;
}

const vsCodes = collectValueSetLoincCodes();
const rows = parseCsv(fs.readFileSync(csvPath, 'utf8'));

const offenders = [];
let sentinels = 0;
for (const r of rows) {
  const code = (r.loinc_preferred || '').trim();
  if (!code) { offenders.push({ item: r.item_name_zh, code: '(空白)' }); continue; }
  if (SENTINEL.test(code)) { sentinels++; continue; }
  if (!vsCodes.has(code)) offenders.push({ item: r.item_name_zh, code });
}

const rel = path.relative(repoRoot, csvPath);
if (offenders.length) {
  console.error(`✖ ${rel}：下列 loinc_preferred 不存在於任何 IG 值集——請以值集為真更正 CSV：`);
  for (const o of offenders) console.error(`    ${o.code}  （${o.item}）`);
  console.error('  （若該項目於 LOINC 確無適用代碼，請標為「(-確定無合適碼)」等哨符。）');
  process.exit(1);
}
console.log(`OK: ${rel} 之 ${rows.length} 筆 loinc_preferred 均存在於 IG 值集（含 ${sentinels} 筆無碼哨符）。`);

if (!checkTierConsistency(vsCodes)) process.exit(1);
