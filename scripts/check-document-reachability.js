#!/usr/bin/env node
'use strict';
// ============================================================================
// document Bundle 之前向可達性診斷（JOB-34 步驟 1）
// ============================================================================
//
// R4 §3.3.1：document Bundle 之每個 entry 都必須能自 Composition **前向走訪**抵達，
// 僅 Provenance 為明文豁免。走訪不到者，接收端依規範無從得知該資源屬於本文件哪一部分。
//
// ⚠️ **本檔為診斷工具，不是閘門**，未接入 `npm run verify`：
//    它以 FSH 建圖，是 IG Publisher 之近似而非等價——實測本檔算出 11 筆、
//    qa.txt 為 10 筆，差額尚未查明（JOB-34 §2.3）。在差額查明前，
//    **權威來源是 qa.txt**，本檔只用來定位是哪些 entry、落在哪個 Bundle。
//
// 用法：node scripts/check-document-reachability.js
// ============================================================================

const fs = require('fs');
const path = require('path');

// ⚠️ 剝除註解時必須「找不在引號內的 //」——fullUrl 是 https:// 開頭，
// 用 /\/\/.*$/ 會把整個 URL 當註解砍掉，entries 全空而「0 筆不可達」，
// 且不會有任何錯誤訊息。與 check-no-internal-refs.js 之 commentStart 同一作法。
function stripComment(line) {
  let inQuote = false;
  for (let i = 0; i < line.length - 1; i++) {
    const c = line[i];
    if (c === '"') inQuote = !inQuote;
    else if (c === '/' && line[i + 1] === '/' && !inQuote) return line.slice(0, i);
  }
  return line;
}

const dir = 'input/fsh/examples';
const files = fs.readdirSync(dir).filter((f) => f.endsWith('.fsh'));

// instance id -> { type, refs:Set, file }
const inst = new Map();
// bundle id -> { type, entries:[id], file }
const bundles = new Map();

for (const f of files) {
  const lines = fs.readFileSync(path.join(dir, f), 'utf8').split(/\r?\n/);
  let cur = null;
  for (const raw of lines) {
    const line = stripComment(raw);
    const mi = line.match(/^Instance:\s*(\S+)/);
    if (mi) {
      cur = { id: mi[1], type: null, refs: new Set(), entries: [], btype: null, file: f };
      inst.set(cur.id, cur);
      continue;
    }
    if (!cur) continue;
    const mt = line.match(/^InstanceOf:\s*(\S+)/);
    if (mt) cur.type = mt[1];
    const bt = line.match(/^\*\s*type\s*=\s*#(\S+)/);
    if (bt) cur.btype = bt[1];
    // Bundle entry：以 fullUrl 尾段作為被指向之資源 id
    const fu = line.match(/^\*\s*entry\[[^\]]*\]\.fullUrl\s*=\s*"[^"]*\/([^/"]+)"/);
    if (fu) cur.entries.push(fu[1]);
    // 參照：Reference(x) 與 reference = "Type/x"
    for (const m of line.matchAll(/Reference\(([^)]+)\)/g)) {
      cur.refs.add(m[1].trim().split('|')[0].split('/').pop());
    }
    for (const m of line.matchAll(/reference\s*=\s*"[^"]*?([A-Za-z0-9\-.]+)"/g)) {
      cur.refs.add(m[1]);
    }
  }
}

for (const [id, v] of inst) if (v.btype) bundles.set(id, v);

const RESOLVED = (id) => inst.get(id);

let grand = 0;
const rows = [];
for (const [bid, b] of bundles) {
  if (b.btype !== 'document') continue;
  const entrySet = new Set(b.entries);
  const comp = b.entries.find((e) => (RESOLVED(e) || {}).type && /Composition/i.test(RESOLVED(e).type));
  if (!comp) {
    console.log(`${bid}: 找不到 Composition entry`);
    continue;
  }
  // BFS，只走 bundle 內之 entry
  const seen = new Set([comp]);
  const queue = [comp];
  while (queue.length) {
    const cur = queue.shift();
    const node = RESOLVED(cur);
    if (!node) continue;
    for (const r of node.refs) {
      if (entrySet.has(r) && !seen.has(r)) {
        seen.add(r);
        queue.push(r);
      }
    }
  }
  const unreachable = b.entries.filter((e) => !seen.has(e));
  // Provenance 為 R4 明文豁免
  const real = unreachable.filter((e) => !/Provenance/i.test((RESOLVED(e) || {}).type || ''));
  grand += real.length;
  rows.push({ bid, total: b.entries.length, reach: seen.size, un: real });
}

console.log('document Bundle 之前向可達性（R4 §3.3.1）\n');
for (const r of rows) {
  console.log(`${r.bid}  entry ${r.total}  可達 ${r.reach}  不可達 ${r.un.length}`);
  for (const u of r.un) {
    const n = RESOLVED(u);
    console.log(`    ✗ ${(n && n.type) || '?'}/${u}`);
  }
}
console.log(`\n合計不可達 entry：${grand} 筆`);
