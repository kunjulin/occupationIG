#!/usr/bin/env node
// 盤點一個已解壓之 FHIR 套件：它定義了哪些識別碼命名空間、代碼系統，
// 以及 profile 對 identifier.system 下了什麼固定值。
//
// 為什麼需要這支工具：JOB-06 的第一步是「先查 TW Core 已定義什麼，能沿用的一律沿用」，
// 因為同一個識別碼有兩個 canonical 比現況更糟。但開發環境連不到
// packages.fhir.org／twcore.mohw.gov.tw，無從盤點；CI runner 連得到。
// 故本工具設計為「吃已解壓的資料夾」，下載與解壓交給 workflow（見
// .github/workflows/inspect-package.yml），本檔不碰網路，可在任何環境重跑。
//
// JOB-10（TWCR_SF mock 依賴治理）同樣需要盤點上游套件，故不寫死 tw.gov.mohw.twcore。
//
// Usage:
//   node scripts/inspect-package.js --dir <解壓後之 package 目錄>
//   node scripts/inspect-package.js --dir ... --json out.json
'use strict';

const fs = require('fs');
const path = require('path');

function arg(name, fallback) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] && !process.argv[i + 1].startsWith('--')
    ? process.argv[i + 1]
    : fallback;
}

const dir = arg('--dir', null);
const jsonOut = arg('--json', null);

if (!dir) {
  console.error('用法：node scripts/inspect-package.js --dir <解壓後之 package 目錄> [--json out.json]');
  process.exit(1);
}
if (!fs.existsSync(dir)) {
  console.error(`✖ 找不到目錄：${dir}`);
  process.exit(1);
}

// npm 風格之 FHIR 套件解壓後為 package/*.json
const root = fs.existsSync(path.join(dir, 'package')) ? path.join(dir, 'package') : dir;

const files = fs.readdirSync(root).filter((f) => f.endsWith('.json'));
if (!files.length) {
  console.error(`✖ ${root} 下沒有 .json——確認解壓路徑是否正確。`);
  process.exit(1);
}

const namingSystems = [];
const codeSystems = [];
const identifierBindings = []; // profile 中對 identifier.system 下的固定值
const resourceCounts = {};

// StructureDefinition 之 element 可能以 fixedUri / patternUri / fixedString 等形式
// 固定 identifier.system；逐一檢查，避免漏掉某種寫法。
const FIXED_KEYS = ['fixedUri', 'patternUri', 'fixedString', 'patternString'];

for (const f of files) {
  let r;
  try {
    r = JSON.parse(fs.readFileSync(path.join(root, f), 'utf8'));
  } catch {
    continue; // package.json、.index.json 等非資源檔
  }
  const type = r.resourceType;
  if (!type) continue;
  resourceCounts[type] = (resourceCounts[type] || 0) + 1;

  if (type === 'NamingSystem') {
    namingSystems.push({
      name: r.name,
      title: r.title,
      status: r.status,
      kind: r.kind,
      responsible: r.responsible,
      description: (r.description || '').slice(0, 200),
      uniqueIds: (r.uniqueId || []).map((u) => ({
        type: u.type,
        value: u.value,
        preferred: u.preferred === true,
      })),
    });
  }

  if (type === 'CodeSystem') {
    codeSystems.push({ id: r.id, url: r.url, name: r.name, status: r.status });
  }

  if (type === 'StructureDefinition') {
    const els = [...((r.snapshot && r.snapshot.element) || []), ...((r.differential && r.differential.element) || [])];
    for (const el of els) {
      if (!el.path || !/\bidentifier\b/i.test(el.path) || !/\.system$/.test(el.path)) continue;
      for (const k of FIXED_KEYS) {
        if (el[k]) {
          identifierBindings.push({ profile: r.id || r.name, path: el.path, key: k, value: el[k] });
        }
      }
      // patternIdentifier 掛在 .identifier 而非 .identifier.system，另行處理於下
    }
    for (const el of els) {
      if (!el.path || !/\bidentifier$/i.test(el.path)) continue;
      const pi = el.patternIdentifier || el.fixedIdentifier;
      if (pi && pi.system) {
        identifierBindings.push({
          profile: r.id || r.name,
          path: `${el.path} (patternIdentifier)`,
          key: 'patternIdentifier.system',
          value: pi.system,
        });
      }
    }
  }
}

// ---------------------------------------------------------------- 報表
const line = (s = '') => console.log(s);

line(`\n套件目錄：${root}`);
line(`資源檔數：${files.length}`);
line('\n資源型別分布：');
for (const [t, n] of Object.entries(resourceCounts).sort((a, b) => b[1] - a[1])) {
  line(`  ${String(n).padStart(4)} × ${t}`);
}

line(`\n${'='.repeat(70)}`);
line(`NamingSystem：${namingSystems.length} 個`);
line('='.repeat(70));
if (!namingSystems.length) {
  line('  （無）——此套件未以 NamingSystem 宣告任何識別碼命名空間。');
} else {
  for (const ns of namingSystems.sort((a, b) => (a.name || '').localeCompare(b.name || ''))) {
    line(`\n● ${ns.name}${ns.title ? `  「${ns.title}」` : ''}`);
    line(`  status=${ns.status}  kind=${ns.kind}${ns.responsible ? `  responsible=${ns.responsible}` : ''}`);
    for (const u of ns.uniqueIds) {
      line(`  ${u.preferred ? '★' : ' '} ${u.type.padEnd(6)} ${u.value}`);
    }
    if (ns.description) line(`    ${ns.description}`);
  }
}

line(`\n${'='.repeat(70)}`);
line(`Profile 中固定之 identifier.system：${identifierBindings.length} 筆`);
line('='.repeat(70));
if (!identifierBindings.length) {
  line('  （無）');
} else {
  const byValue = new Map();
  for (const b of identifierBindings) {
    if (!byValue.has(b.value)) byValue.set(b.value, []);
    byValue.get(b.value).push(b);
  }
  for (const [value, list] of [...byValue.entries()].sort()) {
    line(`\n● ${value}`);
    for (const b of list) line(`    ${b.profile}  ${b.path}`);
  }
}

line(`\n${'='.repeat(70)}`);
line(`CodeSystem：${codeSystems.length} 個`);
line('='.repeat(70));
for (const cs of codeSystems.sort((a, b) => (a.url || '').localeCompare(b.url || ''))) {
  line(`  ${cs.url}${cs.status && cs.status !== 'active' ? `  [${cs.status}]` : ''}`);
}

if (jsonOut) {
  fs.writeFileSync(
    jsonOut,
    `${JSON.stringify({ root, resourceCounts, namingSystems, identifierBindings, codeSystems }, null, 2)}\n`
  );
  line(`\n已寫出 ${jsonOut}`);
}
