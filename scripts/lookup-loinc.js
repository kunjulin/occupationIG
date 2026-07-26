#!/usr/bin/env node
// 以術語伺服器 $lookup 逐碼取回 LOINC 六軸，供 JOB-01 之 A／B 類換碼決策使用。
//
// 為何需要本工具：分流（scripts/triage-display-mismatches.js）可離線完成，因為
// qa.txt 已含官方 display；但「這個碼的六軸到底是什麼、該換成哪個碼」必須向
// 術語伺服器求證。本工具把這段機械性工作固定下來，避免逐碼手動查詢時的變異。
//
// ⚠️ 本工具**只取事實，不做判斷**。verdict 欄位一律留空，由人依 SKILL.md 之程序填寫。
//    「顯示名不符可能代表用錯碼」——判斷須由人為之。
//
// Usage:
//   node scripts/lookup-loinc.js --in docs/optimization/evidence/display-triage-2026-07-26.csv
//   node scripts/lookup-loinc.js --codes 14390-9,19199-9 --out /tmp/out.json
//
// 選項：
//   --in <csv>       分流 CSV（讀取 code 與 class 欄）
//   --classes A,B    只查這些類別（預設 A,B；用 ALL 查全部）
//   --codes a,b,c    直接指定代碼，忽略 --in
//   --out <json>     完整回應摘要（預設 docs/optimization/evidence/lookup-<date>.json）
//   --csv-out <csv>  在分流 CSV 上補入官方六軸欄位後另存
//   --tx <url>       術語伺服器（預設 https://tx.fhir.org/r4）
//   --delay <ms>     每次查詢間隔（預設 300ms，勿調太低）
'use strict';

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

const repoRoot = path.resolve(__dirname, '..');
const arg = (n, d) => {
  const i = process.argv.indexOf(n);
  return i !== -1 && process.argv[i + 1] && !process.argv[i + 1].startsWith('--') ? process.argv[i + 1] : d;
};

const tx = arg('--tx', 'https://tx.fhir.org/r4').replace(/\/$/, '');
const delayMs = Number(arg('--delay', '300'));
const inCsv = arg('--in', path.join('docs', 'optimization', 'evidence', 'display-triage-2026-07-26.csv'));
const classes = arg('--classes', 'A,B').split(',').map((s) => s.trim().toUpperCase());
const codesArg = arg('--codes', null);
const stamp = new Date().toISOString().slice(0, 10);
const outJson = arg('--out', path.join('docs', 'optimization', 'evidence', `lookup-${stamp}.json`));
const csvOut = arg('--csv-out', null);

// ---------------------------------------------------------------- 讀取代碼清單
function parseCsvLine(line) {
  const out = [];
  let cur = '';
  let q = false;
  for (let i = 0; i < line.length; i++) {
    const c = line[i];
    if (q) {
      if (c === '"' && line[i + 1] === '"') { cur += '"'; i++; }
      else if (c === '"') q = false;
      else cur += c;
    } else if (c === '"') q = true;
    else if (c === ',') { out.push(cur); cur = ''; }
    else cur += c;
  }
  out.push(cur);
  return out;
}

let targets = [];
let csvRows = null;
let csvHeader = null;

if (codesArg) {
  targets = codesArg.split(',').map((s) => s.trim()).filter(Boolean).map((code) => ({ code, cls: '?' }));
} else {
  const p = path.resolve(repoRoot, inCsv);
  if (!fs.existsSync(p)) {
    console.error(`找不到分流 CSV：${p}\n  請先執行 scripts/triage-display-mismatches.js`);
    process.exit(1);
  }
  const lines = fs.readFileSync(p, 'utf8').trim().split(/\r?\n/);
  csvHeader = parseCsvLine(lines[0]);
  csvRows = lines.slice(1).map(parseCsvLine);
  const iCode = csvHeader.indexOf('code');
  const iCls = csvHeader.indexOf('class');
  const seen = new Set();
  for (const r of csvRows) {
    const code = r[iCode];
    const cls = (r[iCls] || '').toUpperCase();
    if (!code || seen.has(code)) continue;
    if (!classes.includes('ALL') && !classes.includes(cls)) continue;
    seen.add(code);
    targets.push({ code, cls });
  }
}

if (!targets.length) {
  console.error('沒有要查詢的代碼。');
  process.exit(1);
}

// ---------------------------------------------------------------- HTTP
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
          // 4xx 多為「代碼不存在」，本身即是重要結論，故回傳而非拋錯
          try { resolve({ __httpStatus: res.statusCode, ...JSON.parse(body) }); }
          catch { reject(new Error(`HTTP ${res.statusCode}`)); }
        }
      });
    });
    req.on('timeout', () => { req.destroy(new Error('timeout')); });
    req.on('error', (e) => (tries > 1 ? setTimeout(() => getJson(url, tries - 1).then(resolve, reject), 1500) : reject(e)));
  });
}

// ---------------------------------------------------------------- 解析 Parameters
const AXES = {
  COMPONENT: 'component',
  PROPERTY: 'property',
  TIME_ASPCT: 'time',
  SYSTEM: 'system',
  SCALE_TYP: 'scale',
  METHOD_TYP: 'method',
  CLASS: 'class',
  STATUS: 'status',
  ORDER_OBS: 'orderObs',
};

function parseLookup(res) {
  const out = { display: '', axes: {}, designations: [] };
  if (!res || res.resourceType !== 'Parameters') {
    out.error = res && res.resourceType === 'OperationOutcome'
      ? (res.issue || []).map((i) => i.diagnostics || i.details?.text).filter(Boolean).join('; ')
      : `非預期回應（${res && res.resourceType})`;
    return out;
  }
  for (const p of res.parameter || []) {
    if (p.name === 'display') out.display = p.valueString || '';
    if (p.name === 'property') {
      const parts = Object.fromEntries((p.part || []).map((x) => [x.name, x]));
      const code = parts.code?.valueCode || parts.code?.valueString;
      const v = parts.value;
      const val = v ? (v.valueString ?? v.valueCode ?? v.valueBoolean ?? v.valueCoding?.display ?? v.valueCoding?.code ?? '') : '';
      if (code && AXES[code]) out.axes[AXES[code]] = String(val);
    }
    if (p.name === 'designation') {
      const parts = Object.fromEntries((p.part || []).map((x) => [x.name, x]));
      const val = parts.value?.valueString;
      if (val) out.designations.push(val);
    }
  }
  return out;
}

// ---------------------------------------------------------------- 主流程
(async () => {
  console.log(`術語伺服器：${tx}`);
  console.log(`待查代碼：${targets.length} 筆（類別 ${classes.join('/')}）\n`);

  const results = [];
  let ok = 0;
  let fail = 0;

  for (let i = 0; i < targets.length; i++) {
    const { code, cls } = targets[i];
    const url = `${tx}/CodeSystem/$lookup?system=${encodeURIComponent('http://loinc.org')}&code=${encodeURIComponent(code)}&property=*`;
    process.stdout.write(`[${String(i + 1).padStart(3)}/${targets.length}] ${cls} ${code} … `);
    let parsed;
    try {
      parsed = parseLookup(await getJson(url));
    } catch (e) {
      parsed = { error: e.message, axes: {}, designations: [] };
    }
    if (parsed.error) { fail++; console.log(`✖ ${parsed.error}`); }
    else { ok++; console.log(`${parsed.display}`); }
    results.push({ code, class: cls, ...parsed });
    if (i < targets.length - 1) await new Promise((r) => setTimeout(r, delayMs));
  }

  const absJson = path.resolve(repoRoot, outJson);
  fs.mkdirSync(path.dirname(absJson), { recursive: true });
  fs.writeFileSync(
    absJson,
    JSON.stringify({ txServer: tx, queriedAt: new Date().toISOString(), total: targets.length, ok, fail, results }, null, 2) + '\n'
  );
  console.log(`\n成功 ${ok}／失敗 ${fail}`);
  console.log(`完整結果：${path.relative(repoRoot, absJson)}`);

  if (csvOut && csvRows) {
    const esc = (s) => `"${String(s ?? '').replace(/"/g, '""')}"`;
    const byCode = new Map(results.map((r) => [r.code, r]));
    const iCode = csvHeader.indexOf('code');
    const extra = ['lookup_display', 'lookup_component', 'lookup_property', 'lookup_system', 'lookup_scale', 'lookup_method', 'lookup_status', 'lookup_error'];
    const lines = [[...csvHeader, ...extra].join(',')];
    for (const r of csvRows) {
      const hit = byCode.get(r[iCode]);
      const add = hit
        ? [hit.display, hit.axes.component, hit.axes.property, hit.axes.system, hit.axes.scale, hit.axes.method, hit.axes.status, hit.error]
        : ['', '', '', '', '', '', '', ''];
      lines.push([...r.map(esc), ...add.map(esc)].join(','));
    }
    const absCsv = path.resolve(repoRoot, csvOut);
    fs.writeFileSync(absCsv, lines.join('\n') + '\n');
    console.log(`合併後 CSV：${path.relative(repoRoot, absCsv)}`);
  }

  if (fail) {
    console.log('\n⚠️ 有查詢失敗之代碼。失敗本身可能就是結論（例如代碼不存在），');
    console.log('   但也可能是網路或伺服器問題，請先確認 error 內容再判定。');
  }
  console.log('\n下一步：填寫 CSV 之 action／replacement_code／rationale／verified_by／verified_date，');
  console.log('        提交後回到主工作流套用變更（值集 ＋ ConceptMap ＋ terminology.md ＋ 範例）。');
})();
