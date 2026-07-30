#!/usr/bin/env node
// UCUM 建議單位稽核（JOB-19 線 B ＋ 補充事項 §2／§3）。
//
// 為什麼需要這支腳本：
// input/assets/extended-ucum-reference.csv 之 ucum_suggested 已被交付文件採用為對外
// 「UCUM」建議。已實際出錯之案例：吸菸量 64218-1 標 {pack}/d（包/日），官方為 /d
// （支/日）——量綱不符（見 JOB-18）。本腳本以 tx.fhir.org 之 $lookup 取每碼官方
// EXAMPLE_UCUM_UNITS，逐碼比對，使 UCUM 錯誤如同 display 錯誤般於建置階段可被稽核。
//
// ⚠️ 稽核全集＝**由值集展開**，非讀取既有 CSV 之列（補充事項 §2 之根因修正）：
//   舊版以 CSV 之 271 列為全集，而該 CSV 凍結於 Extended 尚為 292 碼時期，其後
//   JOB-01／JOB-14 之換碼從未回寫，致 20 個量值碼不在 CSV、從未被 $lookup、閘門盲目。
//   「需覆核 0」僅對那 271 列成立，不代表值集全部量值項已驗證。
//   本版改以值集（VS-ExtendedDataset／VS-CoreDataset／VS-TWHAVitalSigns／社會史）之
//   Scale = Qn 代碼為全集：值集中之量值碼若不在 CSV，即「未列於對照檔」，閘門失敗。
//   此即 JOB-17 對 loinc-valuesets.xlsx 所採「由值集展開＋CI 攔阻」之同一模式，
//   使下一次換碼之缺漏被自動發現，而非靠人工回寫 CSV。
//
// ⚠️ 核心紀律（JOB-19 §3.1／§5）：「不符」一律列出供人工判定，本腳本**不自動覆寫 CSV**。
//    吸菸量案例顯示「不符」有時是「代碼選錯」而非「單位填錯」；自動改單位會固化錯誤。
//
// 稽核範圍判準（補充事項 §3——主動排除並註明，而非「不在 CSV 就跳過」）：
//   納入：$lookup 之 SCALE_TYP ∈ {Qn, OrdQn}（承載數值，UCUM 適用）
//   排除：其餘 Scale（Nom/Ord/Nar/Doc/Multi…，如 panel、定性、影像、鏡檢定性）
//        或 PROPERTY ∈ 明確不承載單位者（Type/Prid/ID/Imp/Find/Anat/-）
//   排除者標為「不適用」並記錄其 Scale／Property，非被動略過。
//
// 七態分類：
//   相符        值集中之量值碼在 CSV，且 ucum_suggested 之單位皆為官方 EXAMPLE_UCUM_UNITS 所列
//   不符        在 CSV 但有官方清單外之單位 → 人工判定係「選用差異」或「代碼/量綱錯誤」
//   LOINC 未提供 在 CSV，官方無 EXAMPLE_UCUM_UNITS
//   待人工判定   在 CSV，官方多值而 CSV 空白／擇一——需確認院內實際用者
//   未列於對照檔 值集中之量值碼**不在** CSV（涵蓋缺口，補充事項 §2 之核心）
//   不適用      非 Qn/OrdQn 或 Property 不承載單位（主動排除，記錄理由）
//   查詢失敗    $lookup 失敗
//
// Usage:
//   node scripts/audit-ucum.js [--tx <url>] [--delay <ms>] [--out <json>]
//   node scripts/audit-ucum.js --gate [--max <n>] [--max-missing <n>]
//       閘門模式：不符 > max、未列於對照檔 > max-missing、Scale 未知 > max-unknown 即 exit 1
'use strict';

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

const repoRoot = path.resolve(__dirname, '..');
const argv = process.argv.slice(2);
const arg = (k, d) => { const i = argv.indexOf(k); return i !== -1 && argv[i + 1] ? argv[i + 1] : d; };
const tx = arg('--tx', 'https://tx.fhir.org/r4').replace(/\/$/, '');
const delayMs = parseInt(arg('--delay', '120'), 10);
const gateMode = argv.includes('--gate');
const maxMismatch = parseInt(arg('--max', '0'), 10);
const maxMissing = parseInt(arg('--max-missing', '0'), 10);
const maxUnknown = parseInt(arg('--max-unknown', '0'), 10);
const csvPath = path.join(repoRoot, 'input', 'assets', 'extended-ucum-reference.csv');
const vsDir = path.join(repoRoot, 'input', 'fsh', 'valuesets');
const outJson = arg('--out', 'docs/optimization/evidence/ucum-audit.json');

// 納入稽核之值集（其 LNC 成員展開為全集）。社會史量化碼（吸菸量等）由 VS-CoreUploadSet
// 之裸 LNC# 行帶入。VS-CoreUploadSet 亦 include 其他值集，去重後不影響。
const AUDIT_VALUESETS = [
  'VS-ExtendedDataset.fsh',
  'VS-CoreDataset.fsh',
  'VS-TWHAVitalSigns.fsh',
  'VS-CoreUploadSet.fsh',
];

// Property 明確不承載 UCUM 單位者（即使 Scale 誤標亦排除）。
const EXCLUDE_PROPERTY = new Set(['Type', 'Prid', 'ID', 'Imp', 'Find', 'Anat', '-', '']);

// ---- HTTP（鏡像 lookup-loinc.js 之 getJson）--------------------------------
function getJson(url, tries = 3) {
  return new Promise((resolve, reject) => {
    const mod = url.startsWith('https:') ? https : http;
    const req = mod.get(url, { headers: { Accept: 'application/fhir+json' }, timeout: 30000 }, (res) => {
      let body = '';
      res.setEncoding('utf8');
      res.on('data', (d) => (body += d));
      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          try { resolve(JSON.parse(body)); } catch (e) { reject(new Error(`JSON 解析失敗：${e.message}`)); }
        } else if (res.statusCode >= 500 && tries > 1) {
          setTimeout(() => getJson(url, tries - 1).then(resolve, reject), 1500);
        } else {
          try { resolve({ __httpStatus: res.statusCode, ...JSON.parse(body) }); }
          catch { reject(new Error(`HTTP ${res.statusCode}`)); }
        }
      });
    });
    req.on('timeout', () => req.destroy(new Error('timeout')));
    req.on('error', (e) => (tries > 1 ? setTimeout(() => getJson(url, tries - 1).then(resolve, reject), 1500) : reject(e)));
  });
}

function pickProps(res) {
  const out = { display: '', example_ucum: '', property: '', scale: '', status: '', error: '' };
  if (!res || res.resourceType !== 'Parameters') {
    out.error = res && res.resourceType === 'OperationOutcome'
      ? (res.issue || []).map((i) => i.diagnostics || i.details?.text).filter(Boolean).join('; ')
      : `非預期回應（${res && res.resourceType}）`;
    return out;
  }
  const WANT = { EXAMPLE_UCUM_UNITS: 'example_ucum', PROPERTY: 'property', SCALE_TYP: 'scale', STATUS: 'status' };
  for (const p of res.parameter || []) {
    if (p.name === 'display') out.display = p.valueString || '';
    if (p.name === 'property') {
      const parts = Object.fromEntries((p.part || []).map((x) => [x.name, x]));
      const code = parts.code?.valueCode || parts.code?.valueString;
      const v = parts.value;
      // ⚠️ SCALE_TYP／PROPERTY 由 tx 以 valueCoding 回傳時，其 code 為 LOINC 答案清單碼
      // （如 Qn = LP7753-9），**非**字面 "Qn"。故一律優先取 display，code 僅作備援
      //（首版誤以 code 比對 'Qn'，導致 320 碼全判為「不適用」而閘門空過）。
      const val = v ? (v.valueString ?? v.valueCode ?? v.valueCoding?.display ?? v.valueCoding?.code ?? '') : '';
      if (code && WANT[code]) out[WANT[code]] = String(val);
      if (code === 'SCALE_TYP') out.scale_code = String(v?.valueCoding?.code ?? '');
    }
  }
  return out;
}

// Scale 正規化：display 若已為字面值（Qn／OrdQn…）直接用；否則以答案清單碼回推。
const SCALE_BY_LP = { 'LP7753-9': 'Qn', 'LP7752-1': 'OrdQn', 'LP7751-3': 'Ord', 'LP7750-5': 'Nom', 'LP7749-7': 'Nar' };
function normScale(scale, scaleCode) {
  const s = (scale || '').trim();
  if (s && !/^LP\d/.test(s)) return s;              // 已是字面值
  return SCALE_BY_LP[s] || SCALE_BY_LP[scaleCode || ''] || s || '';
}

function unitSet(s) {
  return (s || '').split(/[;,]/).map((u) => u.trim()).filter(Boolean);
}

// CSV 之 ucum_suggested 本身可能為多值（與官方格式一致），兩側均切成集合後以子集判定，
// 不可拿整串比對官方清單（否則多值列誤判為不符）。
function classify4(csvUnit, officialUnits) {
  const csv = unitSet(csvUnit);
  const off = new Set(officialUnits);
  if (!officialUnits.length) return csv.length ? '待人工判定' : 'LOINC 未提供';
  if (!csv.length) return '待人工判定';
  if (!csv.every((u) => off.has(u))) return '不符';
  return csv.length === officialUnits.length ? '相符' : (officialUnits.length > 1 ? '待人工判定' : '相符');
}

function inScope(scale, property) {
  return (scale === 'Qn' || scale === 'OrdQn') && !EXCLUDE_PROPERTY.has(property);
}

// ---- 讀取來源 --------------------------------------------------------------
function collectValueSetCodes() {
  const codes = new Set();
  for (const name of AUDIT_VALUESETS) {
    const f = path.join(vsDir, name);
    if (!fs.existsSync(f)) continue;
    for (const m of fs.readFileSync(f, 'utf8').matchAll(/^\*\s+LNC#(\S+)/gm)) codes.add(m[1]);
  }
  return [...codes].sort();
}

function parseCsv(text) {
  const lines = text.replace(/^﻿/, '').split(/\r?\n/).filter((l) => l.length);
  const split = (line) => {
    const out = []; let f = '', q = false;
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
  return lines.slice(1).map((l) => { const c = split(l); return Object.fromEntries(header.map((h, i) => [h, c[i] ?? ''])); });
}

(async () => {
  const universe = collectValueSetCodes();
  const csvRows = parseCsv(fs.readFileSync(csvPath, 'utf8'));
  const csvKey = Object.keys(csvRows[0]).find((k) => k.toLowerCase().includes('loinc')) || 'loinc';
  const csvByCode = new Map(csvRows.map((r) => [(r[csvKey] || '').trim(), r]));

  console.log(`術語伺服器：${tx}`);
  console.log(`稽核全集：由值集展開共 ${universe.length} 碼（${AUDIT_VALUESETS.join('／')}）`);
  console.log(`對照檔：${path.basename(csvPath)} 現有 ${csvRows.length} 列\n`);

  const results = [];
  const tally = { 相符: 0, 不符: 0, 'LOINC 未提供': 0, 待人工判定: 0, 未列於對照檔: 0, 不適用: 0, 'Scale 未知': 0, 查詢失敗: 0 };
  const mismatches = [];
  const missing = [];
  const unknownScale = [];

  for (let i = 0; i < universe.length; i++) {
    const code = universe[i];
    let props;
    try { props = pickProps(await getJson(`${tx}/CodeSystem/$lookup?system=${encodeURIComponent('http://loinc.org')}&code=${encodeURIComponent(code)}&property=*`)); }
    catch (e) { props = { error: e.message, example_ucum: '', scale: '', property: '' }; }

    const scale = normScale(props.scale, props.scale_code);
    let state;
    if (props.error) state = '查詢失敗';
    // Scale 仍為未對映之答案清單碼：**不可**當作「不適用」默默排除——那正是補充事項 §3
    // 所禁止之被動排除（其中部分碼確有官方單位，如 5804-0 之 mg/dL）。列為獨立狀態並閘門追蹤。
    else if (/^LP\d/.test(scale)) state = 'Scale 未知';
    else if (!inScope(scale, props.property)) state = '不適用';
    else if (!csvByCode.has(code)) state = '未列於對照檔';
    else state = classify4(csvByCode.get(code).ucum_suggested, unitSet(props.example_ucum));
    tally[state] = (tally[state] || 0) + 1;

    const rec = { code, scale, scale_raw: props.scale, property: props.property, official_ucum: props.example_ucum || '',
      csv_ucum: csvByCode.get(code)?.ucum_suggested || '', state, note: props.error || '' };
    results.push(rec);
    if (state === '不符') mismatches.push(rec);
    if (state === '未列於對照檔') missing.push(rec);
    if (state === 'Scale 未知') unknownScale.push(rec);
    console.log(`[${String(i + 1).padStart(3)}/${universe.length}] ${code.padEnd(9)} ${state.padEnd(6)} scale=${(scale || '∅').padEnd(6)} prop=${(props.property || '∅').padEnd(6)} csv=${(rec.csv_ucum || '∅').padEnd(14)} official=${rec.official_ucum || '∅'}`);
    if (i < universe.length - 1) await new Promise((r) => setTimeout(r, delayMs));
  }

  // CSV 有、但不在值集全集之列（換碼後之冗列）。
  const stale = csvRows.map((r) => (r[csvKey] || '').trim()).filter((c) => c && !universe.includes(c));

  console.log('\n=== 七態分類彙總 ===');
  for (const [k, v] of Object.entries(tally)) console.log(`  ${k.padEnd(12)} ${v}`);
  console.log(`\n未列於對照檔（值集有量值碼、CSV 無——涵蓋缺口）：${missing.length} 筆`);
  for (const m of missing) console.log(`  ✖ ${m.code}  scale=${m.scale}  官方單位=${m.official_ucum || '(LOINC 未提供)'}`);
  console.log(`\n不符（須人工判定，不自動覆寫）：${mismatches.length} 筆`);
  for (const m of mismatches) console.log(`  ✖ ${m.code}  csv=${m.csv_ucum}  官方=${m.official_ucum}`);
  console.log(`\nScale 未知（tx 回傳未對映之答案清單碼，須人工判定是否納入）：${unknownScale.length} 筆`);
  for (const u of unknownScale) console.log(`  ? ${u.code}  scale_raw=${u.scale_raw}  csv=${u.csv_ucum || '∅'}  官方=${u.official_ucum || '(未提供)'}`);
  console.log(`\n對照檔冗列（CSV 有、值集無，換碼後之殘留）：${stale.length} 筆${stale.length ? '：' + stale.join(', ') : ''}`);

  const absJson = path.resolve(repoRoot, outJson);
  fs.mkdirSync(path.dirname(absJson), { recursive: true });
  fs.writeFileSync(absJson, JSON.stringify({ txServer: tx, universe: universe.length, tally, stale, results }, null, 2) + '\n');
  console.log(`\n完整結果：${path.relative(repoRoot, absJson)}`);

  if (gateMode) {
    if (tally['查詢失敗'] > 0) { console.error(`\n✖ 有 ${tally['查詢失敗']} 筆 $lookup 查詢失敗，無法完成稽核。`); process.exit(2); }
    let fail = false;
    if (missing.length > maxMissing) { console.error(`\n✖ 未列於對照檔：${missing.length} 筆 > 基準 ${maxMissing}。值集之量值碼須全數納入對照檔。`); fail = true; }
    if (mismatches.length > maxMismatch) { console.error(`\n✖ UCUM mismatch：不符 ${mismatches.length} 筆 > 基準 ${maxMismatch}。請人工判定後更正。`); fail = true; }
    if (unknownScale.length > maxUnknown) { console.error(`\n✖ Scale 未知：${unknownScale.length} 筆 > 基準 ${maxUnknown}。新增之未對映 Scale 碼須先判定是否納入稽核範圍。`); fail = true; }
    if (fail) process.exit(1);
    console.log(`\n✔ UCUM 閘門通過：不符 ${mismatches.length} ≤ ${maxMismatch}、未列於對照檔 ${missing.length} ≤ ${maxMissing}、Scale 未知 ${unknownScale.length} ≤ ${maxUnknown}。`);
  }
})();
