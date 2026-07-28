#!/usr/bin/env node
// 從一個已解壓之 FHIR 套件中，摘出指定 profile 的「要填什麼才會通過驗證」。
//
// 為什麼需要：JOB-05 要為 7 個 profile 補範例，其中 6 個繼承自 TW Core
// （TWCoreServiceRequest／TWCoreCarePlan／TWCoreDiagnosticReport／TWCoreOccupation／
// TWCoreECG／TWCoreImagingStudy）。上游的必填欄位、固定值與必要綁定不看是不會知道的，
// 而開發環境封鎖 packages.fhir.org，本機無從得知——盲寫範例只會換來好幾輪
// 「CI 報錯→猜→再報錯」。runner 連得到，故與 inspect-package.js 同樣設計為
// 「吃已解壓的資料夾」，下載交給 workflow，本檔不碰網路。
//
// 輸出三類資訊（這三類就是範例寫不對的全部來源）：
//   1. min > 0 之元素——不填就是 error；
//   2. fixed[x] / pattern[x]——填錯值就是 error；
//   3. binding.strength = required 之元素——值不在值集內就是 error。
// 另列出 mustSupport 元素供 JOB-05 之 MS 覆蓋檢核參照（那是 SHOULD，不是 error）。
//
// 差異化顯示：預設只列出「本 profile 相對於 FHIR 基礎資源額外收緊」的部分，
// 亦即略過 status/id 等基礎資源本來就必填者以外的雜訊——但**不做語意猜測**，
// 一律以 snapshot 實際數值為準。
//
// Usage:
//   node scripts/describe-profile.js --dir <解壓後之 package 目錄> --profile <id 或 url>
//   node scripts/describe-profile.js --dir ... --profile ... --all   （連 0..* 元素一併列出）
'use strict';

const fs = require('fs');
const path = require('path');

function arg(name, fallback = null) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] && !process.argv[i + 1].startsWith('--')
    ? process.argv[i + 1]
    : fallback;
}

const dir = arg('--dir');
const wanted = process.argv.reduce((acc, a, i) => {
  if (a === '--profile' && process.argv[i + 1]) acc.push(process.argv[i + 1]);
  return acc;
}, []);
const showAll = process.argv.includes('--all');

if (!dir || wanted.length === 0) {
  console.error('用法：node scripts/describe-profile.js --dir <package 目錄> --profile <id|url> [--profile ...] [--all]');
  process.exit(1);
}

const root = fs.existsSync(path.join(dir, 'package')) ? path.join(dir, 'package') : dir;
const sds = [];
for (const f of fs.readdirSync(root).filter((n) => n.endsWith('.json'))) {
  try {
    const j = JSON.parse(fs.readFileSync(path.join(root, f), 'utf8'));
    if (j.resourceType === 'StructureDefinition') sds.push(j);
  } catch {
    /* 套件內偶有非 FHIR 之 json（.index.json 等），略過 */
  }
}
console.log(`套件內共 ${sds.length} 個 StructureDefinition（來源 ${root}）\n`);

function find(key) {
  return sds.find((s) => s.id === key || s.url === key || s.name === key);
}

function fixedOf(e) {
  const k = Object.keys(e).find((x) => x.startsWith('fixed') || x.startsWith('pattern'));
  return k ? { key: k, value: e[k] } : null;
}

function short(v) {
  const s = typeof v === 'string' ? v : JSON.stringify(v);
  return s.length > 160 ? `${s.slice(0, 157)}…` : s;
}

let missing = 0;
for (const key of wanted) {
  const sd = find(key);
  if (!sd) {
    console.log(`✖ 找不到 profile：${key}`);
    missing++;
    continue;
  }
  const els = sd.snapshot?.element ?? [];
  console.log('='.repeat(78));
  console.log(`${sd.id}   ${sd.url}`);
  console.log(`  基礎型別 ${sd.type}｜父輪廓 ${sd.baseDefinition ?? '(無)'}｜元素 ${els.length} 個`);
  console.log('');

  const required = els.filter((e) => (e.min ?? 0) > 0 && e.path.split('.').length > 1);
  console.log(`-- 必填（min > 0）共 ${required.length} 個 --`);
  for (const e of required) {
    const f = fixedOf(e);
    console.log(
      `  ${e.id}  [${e.min}..${e.max}]` +
        (e.type ? `  型別 ${e.type.map((t) => t.code).join('|')}` : '') +
        (f ? `  ${f.key} = ${short(f.value)}` : '')
    );
  }

  const fixed = els.filter((e) => fixedOf(e) && (e.min ?? 0) === 0);
  if (fixed.length) {
    console.log(`\n-- 有固定值但非必填（填了就必須填這個值）共 ${fixed.length} 個 --`);
    for (const e of fixed) {
      const f = fixedOf(e);
      console.log(`  ${e.id}  ${f.key} = ${short(f.value)}`);
    }
  }

  const bound = els.filter((e) => e.binding && e.binding.strength === 'required');
  console.log(`\n-- required 綁定共 ${bound.length} 個 --`);
  for (const e of bound) {
    console.log(`  ${e.id}  → ${e.binding.valueSet}`);
  }

  const ms = els.filter((e) => e.mustSupport === true);
  console.log(`\n-- mustSupport 共 ${ms.length} 個 --`);
  console.log(ms.length ? `  ${ms.map((e) => e.id).join('\n  ')}` : '  （無）');

  if (showAll) {
    console.log(`\n-- 全部元素 --`);
    for (const e of els) {
      console.log(`  ${e.id}  [${e.min ?? 0}..${e.max ?? '*'}]`);
    }
  }
  console.log('');
}

if (missing) {
  console.error(`✖ 有 ${missing} 個 profile 在此套件中找不到。`);
  process.exit(1);
}
