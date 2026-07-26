#!/usr/bin/env node
// QA 閘門：解析 IG Publisher 之 output/qa.txt，與 qa-baseline.json 比對，任一數值高於
// 基準線即失敗（只能降不能升）。目的是在既有 208 筆 warning 尚未清完的情況下，
// 仍能從第一天起防止退步。
//
// 另設一道獨立的術語伺服器連線檢查：input/ignoreWarnings.txt 目前以泛用字串抑制
// "No server available" 與 PKIX 錯誤（離線建置所需），這會讓送審用的 tx 建置
// 「連不上 tx」與「通過驗證」外觀相同。因此本檔另行掃描 publisher 執行日誌，
// 不依賴 qa.txt——抑制檔管不到日誌。詳見 docs/optimization/JOB-09。
//
// Usage:
//   node scripts/qa-gate.js                                  # 讀 output/qa.txt
//   node scripts/qa-gate.js --qa path/to/qa.txt
//   node scripts/qa-gate.js --log input-cache/publisher-run.log   # 加做連線檢查
//   node scripts/qa-gate.js --expect-tx                      # 要求日誌顯示確實使用了 tx server
//   node scripts/qa-gate.js --update                         # 下調基準線並寫回（改善後使用）
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');

function arg(name, fallback) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] && !process.argv[i + 1].startsWith('--')
    ? process.argv[i + 1]
    : fallback;
}
const hasFlag = (name) => process.argv.includes(name);

const qaPath = path.resolve(repoRoot, arg('--qa', path.join('output', 'qa.txt')));
const baselinePath = path.resolve(repoRoot, arg('--baseline', 'qa-baseline.json'));
const logPath = arg('--log', null);
const update = hasFlag('--update');
const expectTx = hasFlag('--expect-tx');

function die(msg) {
  console.error(`\n✖ ${msg}`);
  process.exit(1);
}

if (!fs.existsSync(qaPath)) {
  die(`找不到 qa.txt：${qaPath}\n  請先執行建置（npm run build 或 _genonce_tx.bat）。`);
}
if (!fs.existsSync(baselinePath)) die(`找不到基準線檔：${baselinePath}`);

const qa = fs.readFileSync(qaPath, 'utf8');
const baseline = JSON.parse(fs.readFileSync(baselinePath, 'utf8'));

// ---------------------------------------------------------------- 總數
const totalsMatch = qa.match(/err\s*=\s*(\d+),\s*warn\s*=\s*(\d+),\s*info\s*=\s*(\d+)/);
if (!totalsMatch) die('無法從 qa.txt 解析 "err = N, warn = N, info = N"。qa.txt 格式可能已變更。');
const totals = {
  err: Number(totalsMatch[1]),
  warn: Number(totalsMatch[2]),
  info: Number(totalsMatch[3]),
};

const versionMatch = qa.match(/IG Publisher Version:\s*([\d.]+)/);
const igVersion = versionMatch ? versionMatch[1] : 'unknown';

// ---------------------------------------------------------------- 分類計數
function countOccurrences(haystack, needle) {
  let n = 0;
  let i = 0;
  while ((i = haystack.indexOf(needle, i)) !== -1) {
    n++;
    i += needle.length;
  }
  return n;
}

const rows = [];
let failed = false;
let improved = false;

for (const [needle, limit] of Object.entries(baseline.categories)) {
  const actual = countOccurrences(qa, needle);
  const delta = actual - limit;
  const over = actual > limit;
  if (over) failed = true;
  if (delta < 0) improved = true;
  rows.push({ label: needle, limit, actual, delta, over });
}

for (const key of ['err', 'warn', 'info']) {
  const limit = baseline.totals[key];
  const actual = totals[key];
  const over = actual > limit;
  if (over) failed = true;
  if (actual < limit) improved = true;
  rows.unshift({ label: `TOTAL ${key}`, limit, actual, delta: actual - limit, over });
}

// ---------------------------------------------------------------- 報表
const width = Math.max(...rows.map((r) => r.label.length), 24);
console.log(`\nQA 閘門 — ${path.relative(repoRoot, qaPath)}`);
console.log(`IG Publisher ${igVersion}（基準線量測於 ${baseline.igPublisherVersion}）\n`);
console.log(`${'訊息類別'.padEnd(width)}  基準線   實際    差異  判定`);
console.log('-'.repeat(width + 30));
for (const r of rows) {
  const verdict = r.over ? 'FAIL 退步' : r.delta < 0 ? 'OK  改善' : 'OK';
  const sign = r.delta > 0 ? `+${r.delta}` : `${r.delta}`;
  console.log(
    `${r.label.padEnd(width)}  ${String(r.limit).padStart(6)} ${String(r.actual).padStart(6)} ${sign.padStart(7)}  ${verdict}`
  );
}

if (igVersion !== 'unknown' && igVersion !== baseline.igPublisherVersion) {
  console.log(
    `\n⚠ IG Publisher 版本與基準線不同（${baseline.igPublisherVersion} → ${igVersion}）。` +
      '\n  訊息數變動可能來自工具升級而非本 IG 之變更，請人工確認後再下調基準線。'
  );
}

// ---------------------------------------------------------------- 術語伺服器連線檢查
const OFFLINE_MARKERS = [
  'No server available',
  'PKIX path building failed',
  'Unable to resolve the terminology server',
  'Terminology server not available',
];

function scanForOffline(text, label) {
  const hits = OFFLINE_MARKERS.filter((m) => text.includes(m));
  if (hits.length) {
    console.error(`\n✖ ${label} 出現術語伺服器連線失敗跡象：`);
    for (const h of hits) console.error(`    - ${h}`);
    console.error(
      '  「連不上術語伺服器」不等於「通過驗證」。送審建置必須確實連上 tx server；\n' +
        '  離線建置（-tx n/a）不得作為送審依據（README §建置與編譯步驟）。'
    );
    return true;
  }
  return false;
}

let offline = scanForOffline(qa, 'qa.txt');

if (logPath) {
  const resolvedLog = path.resolve(repoRoot, logPath);
  if (!fs.existsSync(resolvedLog)) {
    die(`指定了 --log 但找不到日誌：${resolvedLog}`);
  }
  const log = fs.readFileSync(resolvedLog, 'utf8');
  // 日誌不受 input/ignoreWarnings.txt 影響，是比 qa.txt 更可靠的連線證據
  if (scanForOffline(log, 'publisher 執行日誌')) offline = true;

  if (expectTx) {
    const usedOfflineTx = /-tx\s+n\/a/.test(log);
    const sawTxServer = /tx\.fhir\.org|Terminology Server:|txServer/i.test(log);
    if (usedOfflineTx) {
      console.error('\n✖ 日誌顯示本次建置使用 -tx n/a（離線）。--expect-tx 要求連線建置。');
      offline = true;
    } else if (!sawTxServer) {
      console.error(
        '\n✖ --expect-tx：日誌中找不到術語伺服器使用跡象。' +
          '\n  無法證明本次建置確實經過術語驗證，故視為失敗。'
      );
      offline = true;
    }
  }
} else if (expectTx) {
  die('--expect-tx 需要同時指定 --log <publisher 執行日誌>。');
}

if (offline) failed = true;

// ---------------------------------------------------------------- 基準線下調
if (improved) {
  const next = {
    ...baseline,
    totals: { ...totals },
    categories: Object.fromEntries(
      rows.filter((r) => !r.label.startsWith('TOTAL ')).map((r) => [r.label, Math.min(r.actual, r.limit)])
    ),
  };
  if (update) {
    if (failed) {
      console.error('\n✖ 有退步項目，拒絕以 --update 下調基準線。請先修正退步再重跑。');
      process.exit(1);
    }
    next.measuredAt = new Date(fs.statSync(qaPath).mtime).toISOString().slice(0, 10);
    next.igPublisherVersion = igVersion;
    next.source = `本機／CI 建置之 output/qa.txt（前次：${baseline.source}）`;
    fs.writeFileSync(baselinePath, `${JSON.stringify(next, null, 2)}\n`);
    console.log(`\n✔ 已下調基準線並寫回 ${path.relative(repoRoot, baselinePath)}。請一併提交。`);
  } else {
    console.log('\nℹ 有類別低於基準線（改善）。確認無誤後執行以下指令下調基準線並提交：');
    console.log('    npm run qa -- --update');
  }
}

if (failed) {
  console.error('\n✖ QA 閘門未通過。');
  process.exit(1);
}
console.log('\n✔ QA 閘門通過：無任何類別高於基準線。');
