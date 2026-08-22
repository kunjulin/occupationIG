#!/usr/bin/env node
// 驗證衍生資產 input/assets/snomed-loinc-mappings.csv 之 **LOINC 兩欄**與 IG 本體一致。
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
// ⚠️ **v0.10.1 擴大檢查範圍——原因與教訓（A-2）**
// 本檔原僅檢查 `loinc_preferred` 一欄，`loinc_acceptable` 從未被看過。閘門每輪亮綠燈，
// 而該欄同時藏著 7 筆本專案**自己已判定為錯碼**者，例如：
//   14390-9  官方語意為 Amylase in Dialysis fluid（透析液澱粉酶），2026-07-26 已換為 1743-4
//   22326-3  官方語意為 Hepatitis C virus 5-1-1 Ab，《建議修訂案》稱其為「送審阻斷級之語意錯誤」
//   3048-6   實為 Triglyceride --fasting（非 HDL）；47365-2 為捐血者篩檢情境碼
// 這與 check-translations.js 只比對 stringsBase.json 是**同一型**的錯誤：
// **閘門有在跑，但看的範圍不對**——而這種錯誤比「沒接 CI」更難發現，因為它每輪都是綠的。
// 教訓已寫入 CLAUDE.md §4：訂範圍時要問「這一類東西有幾個」。
// 本檔有兩個 LOINC 欄，且兩欄之間還有**方向**關係，故三項一起檢查（AC-1／AC-2／AC-3）。
//
// 檢查項目：
//   AC-1  loinc_preferred  須存在於某 IG 值集
//   AC-2  loinc_acceptable 之每一碼須存在於某 IG 值集，**或**為 ConceptMap 之 source
//         （後者涵蓋「刻意保留於 ConceptMap 但不納入值集」之 protocol／變異碼，
//          如 56086-2 PhenX、56114-2 NHANES、56115-9 NCFS）
//   AC-3  loinc_acceptable 之碼若為 ConceptMap source，其 target 須等於**本列**之
//         loinc_preferred。此項攔截 preferred／acceptable **顛倒**——v0.10.1 實測命中兩筆：
//           LDL-C  CSV 記 pref 13457-7（計算法），IG 之 Preferred 為方法通用碼 2089-1
//           FVC    CSV 記 pref 19876-2（支氣管擴張劑前），IG 之 Preferred 為 19868-9
//         顛倒比缺碼更嚴重：它會叫實作端把變異碼當成主要交換碼送出，而 AC-1／AC-2
//         都攔不住（兩碼都在值集裡）。
//   層級標示一致性（JOB-21 §3.3）
//
// 哨符（sentinel）：欄位若為「(-…)」形式（如「(-確定無合適碼)」），表示該項目經查證於
// LOINC 無適用代碼（如腰臀比 WHR、HDL-C 之全血碼），屬有意之無碼標記，予以放行。
//
// Usage: node scripts/check-asset-consistency.js
//        node scripts/check-asset-consistency.js --self-test   負向自我測試（先跑這個）
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const vsDir = path.join(repoRoot, 'input', 'fsh', 'valuesets');
const csvPath = path.join(repoRoot, 'input', 'assets', 'snomed-loinc-mappings.csv');
const cmPath = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');

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

// acceptable 欄之格式為 `{a, b}` 或 `{a;b}`（歷史上兩種分隔符並存），逐碼取出。
function acceptableCodes(cell) {
  return [...String(cell || '').matchAll(/\b(\d{1,6}-\d)\b/g)].map((m) => m[1]);
}

// ConceptMap 之 source → target 對映（僅取 target[0]；本檔各 element 皆為 1:1）。
function conceptMapPairs(text) {
  const src = [...text.matchAll(/element\[(\d+)\]\.code = #(\S+)/g)].map((m) => [m[1], m[2]]);
  const tgt = Object.fromEntries(
    [...text.matchAll(/element\[(\d+)\]\.target\[0\]\.code = #(\S+)/g)].map((m) => [m[1], m[2]])
  );
  return new Map(src.map(([i, s]) => [s, tgt[i]]));
}

// ---- AC-1 ------------------------------------------------------------------
function checkPreferred(rows, vsCodes) {
  const offenders = [];
  let sentinels = 0;
  for (const r of rows) {
    const code = (r.loinc_preferred || '').trim();
    if (!code) { offenders.push({ item: r.item_name_zh, code: '(空白)' }); continue; }
    if (SENTINEL.test(code)) { sentinels++; continue; }
    if (!vsCodes.has(code)) offenders.push({ item: r.item_name_zh, code });
  }
  return { offenders, sentinels };
}

// ---- AC-2／AC-3 ------------------------------------------------------------
function checkAcceptable(rows, vsCodes, cmPairs) {
  const orphans = [];   // AC-2：值集無、ConceptMap 亦無
  const reversed = [];  // AC-3：歸一目標不等於本列 preferred
  let cmOnly = 0, checked = 0;
  for (const r of rows) {
    const pref = (r.loinc_preferred || '').trim();
    for (const code of acceptableCodes(r.loinc_acceptable)) {
      checked++;
      const inVs = vsCodes.has(code);
      const target = cmPairs.get(code);
      if (!inVs && target === undefined) { orphans.push({ item: r.item_name_zh, code }); continue; }
      if (!inVs) cmOnly++;
      // 方向：本列 preferred 為哨符時無從比對，略過（該列本無主碼）。
      if (target !== undefined && !SENTINEL.test(pref) && target !== pref) {
        reversed.push({ item: r.item_name_zh, code, target, pref });
      }
    }
  }
  return { orphans, reversed, cmOnly, checked };
}

// ---- 層級標示一致性（JOB-21 §3.3）------------------------------------------
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

function checkTierConsistency(vsCodes, cmPairs) {
  const A = collectAcceptableAnnotated();
  const srcAll = new Set(cmPairs.keys());
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
  console.log('OK: 層級標示一致（對稱差 0）。');
  return true;
}

// ---- 負向自我測試 ----------------------------------------------------------
// 每一條規則都要能證明「它擋得住」——只證明現況通過等於沒有證明。
function selfTest() {
  const vs = new Set(['2089-1', '13457-7', '18262-6', '19868-9', '19876-2', '8280-0']);
  const cm = new Map([['13457-7', '2089-1'], ['18262-6', '2089-1'], ['19876-2', '19868-9'],
    ['56114-2', '8280-0'], ['14390-9', '9999-9']]);
  const cases = [];
  const row = (o) => ({ item_name_zh: 't', loinc_preferred: '', loinc_acceptable: '', ...o });

  // ① AC-1 未知 preferred 須擋下
  cases.push(['① AC-1 preferred 不在值集 → 失敗',
    checkPreferred([row({ loinc_preferred: '55284-4' })], vs).offenders.length === 1]);
  // ② AC-1 哨符須放行
  cases.push(['② AC-1 哨符放行',
    checkPreferred([row({ loinc_preferred: '(-確定無合適碼)' })], vs).offenders.length === 0]);
  // ③ AC-2 孤兒碼須擋下（本次真正漏掉的那一類：14390-9 之 target 不在值集且該碼自身亦不在）
  cases.push(['③ AC-2 acceptable 值集無、ConceptMap 無 → 失敗',
    checkAcceptable([row({ loinc_preferred: '2089-1', loinc_acceptable: '{22326-3}' })], vs, cm).orphans.length === 1]);
  // ④ AC-2 僅存在於 ConceptMap 之 protocol 碼須放行（56114-2）
  const c4 = checkAcceptable([row({ loinc_preferred: '8280-0', loinc_acceptable: '{56114-2}' })], vs, cm);
  cases.push(['④ AC-2 僅在 ConceptMap 之 protocol 碼放行', c4.orphans.length === 0 && c4.cmOnly === 1]);
  // ⑤ AC-3 方向顛倒須擋下（LDL-C 型：pref 誤記為變異碼）
  cases.push(['⑤ AC-3 preferred／acceptable 顛倒 → 失敗',
    checkAcceptable([row({ loinc_preferred: '13457-7', loinc_acceptable: '{18262-6}' })], vs, cm).reversed.length === 1]);
  // ⑥ AC-3 方向正確須放行
  cases.push(['⑥ AC-3 方向正確放行',
    checkAcceptable([row({ loinc_preferred: '2089-1', loinc_acceptable: '{13457-7;18262-6}' })], vs, cm).reversed.length === 0]);
  // ⑦ AC-3 preferred 為哨符時不誤判（該列本無主碼可比對）
  cases.push(['⑦ AC-3 哨符 preferred 不誤判',
    checkAcceptable([row({ loinc_preferred: '(-確定無合適碼)', loinc_acceptable: '{13457-7}' })], vs, cm).reversed.length === 0]);
  // ⑧ 兩種分隔符（逗號／分號）皆須解析出全部代碼——只認一種會靜默漏檢
  cases.push(['⑧ 逗號與分號分隔皆解析',
    acceptableCodes('{804-5, 26464-8}').length === 2 && acceptableCodes('{19876-2;19870-5}').length === 2]);
  // ⑨ 空白／哨符之 acceptable 欄不得產生偽陽性
  cases.push(['⑨ 空白與哨符 acceptable 不誤判',
    checkAcceptable([row({ loinc_preferred: '2089-1', loinc_acceptable: '' }),
      row({ loinc_preferred: '2089-1', loinc_acceptable: '(-確定無合適碼)' })], vs, cm).checked === 0]);

  let ok = true;
  for (const [name, pass] of cases) { console.log(`  ${pass ? '✔' : '✖'} ${name}`); if (!pass) ok = false; }
  if (!ok) { console.error('\n✖ 自我測試未通過：閘門無法證明它擋得住上列情形。'); process.exit(1); }
  console.log(`\n✔ 自我測試通過（${cases.length} 例）。`);
}

// ---- 主流程 ----------------------------------------------------------------
if (process.argv.includes('--self-test')) { selfTest(); process.exit(0); }

const vsCodes = collectValueSetLoincCodes();
const cmPairs = conceptMapPairs(fs.readFileSync(cmPath, 'utf8'));
const rows = parseCsv(fs.readFileSync(csvPath, 'utf8'));
const rel = path.relative(repoRoot, csvPath);

let failed = false;

const { offenders, sentinels } = checkPreferred(rows, vsCodes);
if (offenders.length) {
  console.error(`✖ ${rel}：下列 loinc_preferred 不存在於任何 IG 值集——請以值集為真更正 CSV：`);
  for (const o of offenders) console.error(`    ${o.code}  （${o.item}）`);
  console.error('  （若該項目於 LOINC 確無適用代碼，請標為「(-確定無合適碼)」等哨符。）');
  failed = true;
} else {
  console.log(`OK: ${rel} 之 ${rows.length} 筆 loinc_preferred 均存在於 IG 值集（含 ${sentinels} 筆無碼哨符）。`);
}

const { orphans, reversed, cmOnly, checked } = checkAcceptable(rows, vsCodes, cmPairs);
if (orphans.length) {
  console.error(`✖ ${rel}：下列 loinc_acceptable 之代碼既不在任何 IG 值集，亦非 ConceptMap 之 source：`);
  for (const o of orphans) console.error(`    ${o.code}  （${o.item}）`);
  console.error('  （這通常表示該碼已於本 IG 換碼或移除，而 CSV 未同步。請以值集與 ConceptMap 為真更正，');
  console.error('    確無適用變異碼者標為「(-確定無合適碼)」。）');
  failed = true;
}
if (reversed.length) {
  console.error(`✖ ${rel}：下列 loinc_acceptable 之歸一目標不等於本列 loinc_preferred——研判 preferred／acceptable 顛倒：`);
  for (const o of reversed) console.error(`    ${o.code} → ${o.target}，但本列 loinc_preferred = ${o.pref}  （${o.item}）`);
  console.error('  （ConceptMap 之 target 即本 IG 認定之 Preferred。請以 ConceptMap 為真更正 CSV 之兩欄。）');
  failed = true;
}
if (!orphans.length && !reversed.length) {
  console.log(`OK: ${checked} 筆 loinc_acceptable 代碼均可解析（其中 ${cmOnly} 筆僅存在於 ConceptMap，依設計不納入值集），且歸一方向與本列 preferred 一致。`);
}

if (!checkTierConsistency(vsCodes, cmPairs)) failed = true;

if (failed) process.exit(1);
