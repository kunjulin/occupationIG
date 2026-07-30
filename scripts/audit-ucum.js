#!/usr/bin/env node
// UCUM 建議單位稽核（JOB-19 線 B）。
//
// 為什麼需要這支腳本：
// input/assets/extended-ucum-reference.csv 之 271 列 verification 欄原本 100% 為「需覆核」，
// 其 ucum_suggested 已被交付文件採用為對外「UCUM」建議，卻無一經確認。已實際出錯之案例：
// 吸菸量 64218-1 標 {pack}/d（包/日），官方為 /d（支/日）——量綱不符（見 JOB-18）。
// 本腳本以 tx.fhir.org 之 $lookup 取每碼官方 EXAMPLE_UCUM_UNITS，與 CSV 逐筆比對，
// 產出四態分類，使 UCUM 錯誤如同 display 錯誤般於建置階段可被稽核。
//
// 沿用 scripts/lookup-loinc.js 之既有模式（$lookup?property=* + getJson 重試），非另立一套。
// tx.fhir.org 於本容器被 proxy 封鎖（403），故本腳本設計為於 CI（tx 可達）執行；
// 其輸出即為 CSV verification 欄之依據，並供 qa-gate 之「UCUM mismatch」具名類別。
//
// ⚠️ 核心紀律（JOB-19 §3.1／§5）：「不符」一律列出供人工判定，本腳本**不自動覆寫 CSV**。
//    吸菸量案例顯示「不符」有時是「代碼選錯」而非「單位填錯」——{pack}/d 要成立需要的是
//    另一個代碼，不是把 64218-1 的單位改掉。自動改單位會把錯誤固化下來。
//
// 判定原則：
//   相符        CSV 之 ucum_suggested 出現於官方 EXAMPLE_UCUM_UNITS 清單中
//   不符        CSV 有值但不在官方清單 → 須人工判定係「選用差異」或「量綱/代碼錯誤」
//   LOINC 未提供 官方無 EXAMPLE_UCUM_UNITS（多為定性／影像／鏡檢項目）
//   待人工判定   官方清單有多個單位而 CSV 擇一；或 CSV 空白而官方有值——需確認院內實際用者
//
// Usage:
//   node scripts/audit-ucum.js [--tx <url>] [--delay <ms>] [--out <json>]
//   node scripts/audit-ucum.js --gate [--max <n>]   # 閘門模式：不符數 > max 即 exit 1
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
const csvPath = path.join(repoRoot, 'input', 'assets', 'extended-ucum-reference.csv');
const outJson = arg('--out', 'docs/optimization/evidence/ucum-audit.json');

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

// 自 $lookup 之 Parameters 取所需 property（EXAMPLE_UCUM_UNITS 等）。
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
      const val = v ? (v.valueString ?? v.valueCode ?? v.valueCoding?.code ?? v.valueCoding?.display ?? '') : '';
      if (code && WANT[code]) out[WANT[code]] = String(val);
    }
  }
  return out;
}

// 官方 EXAMPLE_UCUM_UNITS 可能含多個單位（以 ; 或空白分隔）。切成集合。
function unitSet(s) {
  return (s || '').split(/[;,]/).map((u) => u.trim()).filter(Boolean);
}

// 最小 CSV 解析（保留欄位；本檔引號欄位不含換行）。
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

function classify(csvUnit, officialUnits) {
  // CSV 之 ucum_suggested 本身可能含多個單位（如 "[arb'U];[arb'U]/mL"，與官方多值格式一致），
  // 故 CSV 側亦須切成集合再逐一比對，不可拿整串去比對官方清單（否則多值列會誤判為不符）。
  const csv = unitSet(csvUnit);
  const off = new Set(officialUnits);
  if (!officialUnits.length) return csv.length ? '待人工判定' : 'LOINC 未提供'; // 官方無建議單位
  if (!csv.length) return '待人工判定';                                        // 官方有、CSV 空白
  const allIn = csv.every((u) => off.has(u));
  if (!allIn) return '不符';                                                   // CSV 有官方清單外之單位
  // CSV 之單位皆為官方所列：完全涵蓋即相符；官方多值而 CSV 只擇部分則進人工判定（§3.1）。
  return csv.length === officialUnits.length ? '相符' : (officialUnits.length > 1 ? '待人工判定' : '相符');
}

(async () => {
  const rows = parseCsv(fs.readFileSync(csvPath, 'utf8'));
  const loincKey = Object.keys(rows[0]).find((k) => k.toLowerCase().includes('loinc')) || 'loinc';
  console.log(`術語伺服器：${tx}`);
  console.log(`待稽核：${rows.length} 列（${csvPath.split('/').slice(-1)[0]}）\n`);

  const results = [];
  const tally = { 相符: 0, 不符: 0, 'LOINC 未提供': 0, 待人工判定: 0, 查詢失敗: 0 };
  const mismatches = [];

  for (let i = 0; i < rows.length; i++) {
    const r = rows[i];
    const code = (r[loincKey] || '').trim();
    if (!code) continue;
    const url = `${tx}/CodeSystem/$lookup?system=${encodeURIComponent('http://loinc.org')}&code=${encodeURIComponent(code)}&property=*`;
    let props;
    try { props = pickProps(await getJson(url)); }
    catch (e) { props = { error: e.message, example_ucum: '' }; }

    let state;
    if (props.error) { state = '查詢失敗'; }
    else { state = classify(r.ucum_suggested, unitSet(props.example_ucum)); }
    tally[state] = (tally[state] || 0) + 1;

    const rec = { code, csv_ucum: r.ucum_suggested || '', official_ucum: props.example_ucum || '', property: props.property || '', state, note: props.error || '' };
    results.push(rec);
    if (state === '不符') mismatches.push(rec);
    // 逐列印出，供 CI 日誌收割（無直連 tx 之環境以 CI 為 oracle）
    console.log(`[${String(i + 1).padStart(3)}/${rows.length}] ${code.padEnd(9)} ${state.padEnd(6)} csv=${(r.ucum_suggested || '∅').padEnd(14)} official=${props.example_ucum || '∅'}`);
    if (i < rows.length - 1) await new Promise((res) => setTimeout(res, delayMs));
  }

  console.log('\n=== 四態分類彙總 ===');
  for (const [k, v] of Object.entries(tally)) console.log(`  ${k.padEnd(10)} ${v}`);
  console.log(`\n不符（須人工判定，本腳本不自動覆寫）：${mismatches.length} 筆`);
  for (const m of mismatches) console.log(`  ✖ ${m.code}  csv=${m.csv_ucum}  官方=${m.official_ucum}`);

  const absJson = path.resolve(repoRoot, outJson);
  fs.mkdirSync(path.dirname(absJson), { recursive: true });
  fs.writeFileSync(absJson, JSON.stringify({ txServer: tx, total: results.length, tally, results }, null, 2) + '\n');
  console.log(`\n完整結果：${path.relative(repoRoot, absJson)}`);

  if (gateMode) {
    if (tally['查詢失敗'] > 0) { console.error(`\n✖ 有 ${tally['查詢失敗']} 筆 $lookup 查詢失敗，無法完成稽核（tx 連線問題？）。`); process.exit(2); }
    if (mismatches.length > maxMismatch) {
      console.error(`\n✖ UCUM mismatch：不符 ${mismatches.length} 筆 > 基準 ${maxMismatch} 筆。請人工判定（選用差異或代碼錯誤）後更正 CSV 或調整基準。`);
      process.exit(1);
    }
    console.log(`\n✔ UCUM 閘門通過：不符 ${mismatches.length} ≤ 基準 ${maxMismatch}。`);
  }
})();
