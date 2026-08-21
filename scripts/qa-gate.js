#!/usr/bin/env node
// QA 閘門：解析 IG Publisher 之 output/qa.txt，與 qa-baseline.json 比對。
//
// ⚠️ v0.8.2 起為**雙向**閘門：高於基準線失敗（退步），低於基準線亦失敗（基準線未校準）。
//    改為雙向的理由是實測出來的，不是論證出來的——見 §容差 與 qa-baseline.json 之 _v082Note。
//
//    單向閘門在本 repo 已連續三次讓過期天花板存活：152 vs 91、91 vs 90、467 vs 464。
//    三次都是「改善了忘了下調」，三次都靠人在事後複驗已發佈站台才發現。
//    單向閘門對此**結構上不可能**發出訊號——低於天花板正是它定義的成功。
//
// 另設一道獨立的術語伺服器連線檢查：input/ignoreWarnings.txt 目前以泛用字串抑制
// "No server available" 與 PKIX 錯誤（離線建置所需），這會讓送審用的 tx 建置
// 「連不上 tx」與「通過驗證」外觀相同。因此本檔另行掃描 publisher 執行日誌，
// 不依賴 qa.txt——抑制檔管不到日誌。詳見 docs/optimization/JOB-09。
//
// ── 容差（tolerance）─────────────────────────────────────────────
// qa-baseline.json 之 `tolerance` 物件設定四個方向的容差；**未設定時退回 v0.8.1 以前
// 之單向行為**（低於基準線不失敗），以免舊分支被新規則追溯處罰。
//
//   totalsAbove      TOTAL 高於基準線之容差（應為 0——退步就是退步）
//   totalsBelow      TOTAL 低於基準線之容差＝**同輸入建置之波動帶寬度**
//   categoriesAbove  具名類別高於基準線之容差（應為 0）
//   categoriesBelow  具名類別低於基準線之容差（應為 0——具名類別歷來完全可重現）
//
// 為何 TOTAL 與具名類別的容差不對稱：totals 含 tx 回應波動（同一份輸入連跑會不同），
// 具名類別在歷次多輪同輸入建置中逐項相同。對 totals 設 0 會製造假性失敗，
// 對具名類別設 >0 則是白送一段看不見的緩衝。
//
// Usage:
//   node scripts/qa-gate.js                                  # 讀 output/qa.txt
//   node scripts/qa-gate.js --qa path/to/qa.txt
//   node scripts/qa-gate.js --log input-cache/publisher-run.log   # 加做連線檢查
//   node scripts/qa-gate.js --expect-tx                      # 要求日誌顯示確實使用了 tx server
//   node scripts/qa-gate.js --update                         # 校準基準線並寫回
//   node scripts/qa-gate.js --self-test                      # 負向自我測試（先跑這個）
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

// 未設定 tolerance 時之預設＝v0.8.1 以前之單向行為。
const LEGACY_TOLERANCE = {
  totalsAbove: 0,
  totalsBelow: Infinity,
  categoriesAbove: 0,
  categoriesBelow: Infinity,
};

function toleranceOf(baseline) {
  const t = baseline.tolerance;
  if (!t || typeof t !== 'object') return { ...LEGACY_TOLERANCE, _legacy: true };
  const pick = (k) => (typeof t[k] === 'number' ? t[k] : LEGACY_TOLERANCE[k]);
  return {
    totalsAbove: pick('totalsAbove'),
    totalsBelow: pick('totalsBelow'),
    categoriesAbove: pick('categoriesAbove'),
    categoriesBelow: pick('categoriesBelow'),
    _legacy: false,
  };
}

function countOccurrences(haystack, needle) {
  let n = 0;
  let i = 0;
  while ((i = haystack.indexOf(needle, i)) !== -1) {
    n++;
    i += needle.length;
  }
  return n;
}

// 形態＝把引號內容、數字與 URL 正規化後的訊息骨架，讓同類訊息聚合成一列。
function signature(line) {
  return line
    .replace(/'[^']*'/g, "'X'")
    .replace(/"[^"]*"/g, '"X"')
    .replace(/https?:\/\/\S+/g, 'URL')
    .replace(/\b\d+\b/g, 'N')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 200);
}

// ---------------------------------------------------------------- 核心比對
// 抽成純函式，讓 --self-test 能以合成 qa.txt 驗證判定邏輯本身
// （否則自測只能驗到 I/O，驗不到「該紅的有沒有紅」）。
function evaluate(qa, baseline) {
  const totalsMatch = qa.match(/err\s*=\s*(\d+),\s*warn\s*=\s*(\d+),\s*info\s*=\s*(\d+)/);
  if (!totalsMatch) return { parseError: true };
  const totals = {
    err: Number(totalsMatch[1]),
    warn: Number(totalsMatch[2]),
    info: Number(totalsMatch[3]),
  };

  const versionMatch = qa.match(/IG Publisher Version:\s*([\d.]+)/);
  const igVersion = versionMatch ? versionMatch[1] : 'unknown';
  const tol = toleranceOf(baseline);

  const rows = [];
  let regressed = false;   // 高於基準線
  let stale = false;       // 低於基準線且超出容差＝基準線未校準
  let improved = false;    // 低於基準線（不論是否超容差），供 --update 判斷

  const judge = (label, limit, actual, above, below) => {
    const delta = actual - limit;
    const over = delta > above;
    const under = -delta > below;
    if (over) regressed = true;
    if (under) stale = true;
    if (delta < 0) improved = true;
    rows.push({ label, limit, actual, delta, over, under });
  };

  for (const [needle, limit] of Object.entries(baseline.categories)) {
    judge(needle, limit, countOccurrences(qa, needle), tol.categoriesAbove, tol.categoriesBelow);
  }
  for (const key of ['err', 'warn', 'info']) {
    judge(`TOTAL ${key}`, baseline.totals[key], totals[key], tol.totalsAbove, tol.totalsBelow);
  }
  // TOTAL 置頂（judge 是依序 push 的，故此處重排而非在迴圈內 unshift）
  rows.sort((a, b) => Number(b.label.startsWith('TOTAL ')) - Number(a.label.startsWith('TOTAL ')));

  return { totals, igVersion, tol, rows, regressed, stale, improved };
}

// ------------------------------------------- 未具名 WARNING 之歸因報表
// 具名類別提供的是**歸因**（多出來的那一筆是什麼），緊天花板提供的是**偵測**（有沒有多）。
// 兩者不能互相取代：v0.8.1 之 warn 90 中有 24 筆不落在任何具名類別內——閘門看得見
// 總數變動，卻說不出變的是哪一類。本報表把那 24 筆按形態列出，使歸因不必臨時加步驟。
function unnamedWarnings(qa, baseline) {
  const needles = Object.keys(baseline.categories);
  const lines = qa.split(/\r?\n/).filter((l) => /^\s*WARNING:/.test(l));
  const unnamed = lines.filter((l) => !needles.some((n) => l.includes(n)));
  const groups = new Map();
  for (const l of unnamed) {
    const s = signature(l);
    groups.set(s, (groups.get(s) || 0) + 1);
  }
  return { total: lines.length, unnamed: unnamed.length, groups };
}

// ================================================================== 自我測試
function selfTest() {
  const BASE = {
    totals: { err: 0, warn: 10, info: 100 },
    categories: { 'alpha thing': 3, 'beta thing': 2 },
    tolerance: { totalsAbove: 0, totalsBelow: 2, categoriesAbove: 0, categoriesBelow: 0 },
  };
  // 合成 qa.txt：以重複行製造指定筆數
  const mk = ({ err = 0, warn = 10, info = 100, alpha = 3, beta = 2, extraWarn = [] }) =>
    [
      'IG Publisher Version: 2.2.11',
      ...Array.from({ length: alpha }, (_, i) => `WARNING: x${i}: alpha thing happened`),
      ...Array.from({ length: beta }, (_, i) => `INFORMATION: y${i}: beta thing happened`),
      ...extraWarn,
      `err = ${err}, warn = ${warn}, info = ${info}`,
    ].join('\n');

  const results = [];
  const run = (name, fn) => {
    let ok = false;
    try {
      ok = fn();
    } catch {
      ok = false;
    }
    results.push([name, ok]);
  };

  // ① 完全相符 → 通過
  run('① 完全相符不誤報（正向對照）', () => {
    const r = evaluate(mk({}), BASE);
    return !r.regressed && !r.stale;
  });

  // ② 具名類別高於基準線 → 退步，必須紅
  run('② 具名類別退步 → 失敗', () => {
    const r = evaluate(mk({ alpha: 4 }), BASE);
    return r.regressed && r.rows.find((x) => x.label === 'alpha thing').over;
  });

  // ③ 具名類別低於基準線 → **基準線未校準，必須紅**（v0.8.2 之新規則）
  //    這是三次過期天花板（152/91、91/90、467/464）之直接對策。
  run('③ 具名類別低於基準線 → 失敗（未校準）', () => {
    const r = evaluate(mk({ alpha: 2 }), BASE);
    return r.stale && r.rows.find((x) => x.label === 'alpha thing').under;
  });

  // ④ TOTAL 高於基準線 → 必須紅（容差 0，多 1 筆就算）
  run('④ TOTAL warn +1 → 失敗', () => {
    const r = evaluate(mk({ warn: 11 }), BASE);
    return r.regressed && r.rows.find((x) => x.label === 'TOTAL warn').over;
  });

  // ⑤ TOTAL 低於基準線但在波動帶內（-2，容差 2）→ **不得**紅（正向對照）
  //    這正是 _runVarianceNote 所記之 ±2；把它設成 0 會製造假性失敗。
  run('⑤ TOTAL warn -2（容差內）不誤報（正向對照）', () => {
    const r = evaluate(mk({ warn: 8 }), BASE);
    return !r.stale && !r.regressed;
  });

  // ⑥ TOTAL 低於基準線且超出波動帶（-3）→ 必須紅
  run('⑥ TOTAL warn -3（超出容差）→ 失敗', () => {
    const r = evaluate(mk({ warn: 7 }), BASE);
    return r.stale && r.rows.find((x) => x.label === 'TOTAL warn').under;
  });

  // ⑦ 未設 tolerance → 退回單向行為，低於基準線不得紅（正向對照）
  //    確保舊分支／舊基準線檔不被新規則追溯處罰。
  run('⑦ 未設 tolerance 時退回單向（正向對照）', () => {
    const legacy = { totals: BASE.totals, categories: BASE.categories };
    const r = evaluate(mk({ alpha: 0, warn: 1, info: 1 }), legacy);
    return !r.stale && !r.regressed;
  });

  // ⑧ 未具名 WARNING 報表：只算 WARNING 級，且排除落在具名類別內者
  run('⑧ 未具名 WARNING 之辨識', () => {
    const qa = mk({ extraWarn: ['WARNING: z: some other unnamed problem'] });
    const u = unnamedWarnings(qa, BASE);
    // alpha 3 筆為 WARNING 且具名；beta 為 INFORMATION 不計；另 1 筆未具名
    return u.total === 4 && u.unnamed === 1;
  });

  // ⑨ 解析失敗要能被辨識，不得靜默通過
  run('⑨ qa.txt 無總數列 → 辨識為解析失敗', () => evaluate('nothing here', BASE).parseError === true);

  console.log('QA 閘門負向自我測試（標「正向對照」者必須不被判失敗，其餘必須被判失敗）：');
  let bad = 0;
  for (const [name, ok] of results) {
    console.log(`  ${ok ? '✔' : '✖'} ${name}`);
    if (!ok) bad++;
  }
  if (bad) {
    console.error(`✖ 自我測試失敗 ${bad} 項——閘門本身有問題，實檢結果不可信。`);
    process.exit(1);
  }
  console.log('✔ 自我測試全數通過。');
}

if (hasFlag('--self-test')) {
  selfTest();
  process.exit(0);
}

// ================================================================== 實檢
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

const ev = evaluate(qa, baseline);
if (ev.parseError) die('無法從 qa.txt 解析 "err = N, warn = N, info = N"。qa.txt 格式可能已變更。');
const { totals, igVersion, tol, rows } = ev;
let failed = ev.regressed || ev.stale;

// ---------------------------------------------------------------- 報表
const width = Math.max(...rows.map((r) => r.label.length), 24);
console.log(`\nQA 閘門 — ${path.relative(repoRoot, qaPath)}`);
console.log(`IG Publisher ${igVersion}（基準線量測於 ${baseline.igPublisherVersion}）`);
console.log(
  tol._legacy
    ? '容差：未設定 → 單向閘門（僅攔退步）。設定 qa-baseline.json 之 tolerance 可啟用雙向。\n'
    : `容差：TOTAL 高於 +${tol.totalsAbove}／低於 -${tol.totalsBelow}；` +
        `具名類別 高於 +${tol.categoriesAbove}／低於 -${tol.categoriesBelow}\n`
);
console.log(`${'訊息類別'.padEnd(width)}  基準線   實際    差異  判定`);
console.log('-'.repeat(width + 30));
for (const r of rows) {
  const verdict = r.over ? 'FAIL 退步' : r.under ? 'FAIL 未校準' : r.delta < 0 ? 'OK  改善（容差內）' : 'OK';
  const sign = r.delta > 0 ? `+${r.delta}` : `${r.delta}`;
  console.log(
    `${r.label.padEnd(width)}  ${String(r.limit).padStart(6)} ${String(r.actual).padStart(6)} ${sign.padStart(7)}  ${verdict}`
  );
}

// ---------------------------------------------------------------- 退步明細
// 總數退步時只看到一個數字無從診斷，故就退步的等級列出訊息形態分布。
const LEVEL_PREFIX = { err: 'ERROR', warn: 'WARNING', info: 'INFORMATION' };

const regressedLevels = rows
  .filter((r) => r.label.startsWith('TOTAL ') && r.over)
  .map((r) => LEVEL_PREFIX[r.label.replace('TOTAL ', '')])
  .filter(Boolean);

// 具名類別退步時，總數表只給一個數字，同樣無從診斷。列出實際訊息（取樣），
// 免得每次都要臨時加一個 grep 步驟才知道多出來的是什麼。
// 低於基準線（未校準）同理需要明細：新增一個具名類別而筆數填錯時，光看「-2」
// 無從判斷是樣態字串沒對上、還是真的改善了。兩個方向都印。
const deviantCategories = rows.filter((r) => !r.label.startsWith('TOTAL ') && (r.over || r.under));
for (const r of deviantCategories) {
  const samples = qa
    .split(/\r?\n/)
    .filter((l) => l.includes(r.label))
    .slice(0, 10);
  const how = r.over ? `退步 +${r.delta}` : `低於基準線 ${r.delta}（未校準或樣態未對上）`;
  console.log(`\n類別「${r.label}」${how}——實際訊息（最多 10 筆）：`);
  if (!samples.length) console.log('  （qa.txt 中找不到含此字串之行——樣態字串可能打錯）');
  for (const s of samples) console.log(`  ${s.trim().slice(0, 200)}`);
}

for (const level of regressedLevels) {
  let lines = qa.split(/\r?\n/).filter((l) => l.startsWith(`${level}:`));

  // ERROR 等級的特殊處理：qa.txt 的斷鏈也以 ERROR: 開頭，動輒兩千筆，
  // 會把真正的驗證錯誤徹底淹沒（實測：err +6 時前 15 名形態全是連結樣式，
  // 一筆真錯誤都看不到）。斷鏈已是具名類別（cannot be resolved）有自己的
  // 抽樣，此處排除之，剩下的才是「err = N」計數的驗證錯誤——通常筆數少，
  // 直接逐筆列出而非歸形態。
  if (level === 'ERROR') {
    const excluded = lines.filter((l) => l.includes('cannot be resolved')).length;
    lines = lines.filter((l) => !l.includes('cannot be resolved'));
    console.log(`\nERROR 退步明細（已排除 ${excluded} 筆斷鏈——該類另由「cannot be resolved」具名追蹤）：`);
    for (const l of lines.slice(0, 20)) console.log(`  ${l.trim().slice(0, 250)}`);
    if (lines.length > 20) console.log(`  …另有 ${lines.length - 20} 筆`);
    if (lines.length === 0) console.log('  （無——err 之增加全數來自斷鏈以外之計數差異，請直接查 qa.txt）');
    continue;
  }

  const groups = new Map();
  for (const l of lines) {
    const s = signature(l);
    groups.set(s, (groups.get(s) || 0) + 1);
  }
  const top = [...groups.entries()].sort((a, b) => b[1] - a[1]).slice(0, 15);
  console.log(`\n${level} 退步明細——訊息形態分布（共 ${lines.length} 筆，${groups.size} 種形態，列出前 ${top.length} 種）：`);
  for (const [sig, n] of top) console.log(`  ${String(n).padStart(5)} × ${sig}`);
}

// ---------------------------------------------- 未具名 WARNING 之歸因報表（每輪都印）
const uw = unnamedWarnings(qa, baseline);
console.log(
  `\n未具名 WARNING 歸因報表：WARNING 共 ${uw.total} 筆，其中 ${uw.unnamed} 筆不落在任何具名類別內` +
    `（${uw.groups.size} 種形態）。`
);
if (uw.unnamed) {
  for (const [sig, n] of [...uw.groups.entries()].sort((a, b) => b[1] - a[1]).slice(0, 40)) {
    console.log(`  ${String(n).padStart(4)} × ${sig}`);
  }
  console.log(
    '  ↑ 這些筆數只受 TOTAL warn 一個數字看管；要逐類看管請把形態加入 categories。'
  );
} else {
  console.log('  全部 WARNING 均已具名——每一類皆獨立受天花板看管。');
}

// ---------------------------------------------------------------- 具名類別逐筆明細（術語稽核）
// 某些類別（預設「Wrong Display Name」）即使正在改善、未退步，其殘筆之「官方 display」
// 仍須可見於 CI 日誌——否則逐碼修正顯示名時看不到 tx 回報的正確字串，只能靠猜。
// 這正是 JOB-01 逐碼稽核所需之回饋（qa.txt 之逐筆訊息不會自動印到 console）。
// 以 qa-baseline.json 之 `_detailCategories`（陣列）設定；未設則預設列 Wrong Display Name。
const detailCategories = Array.isArray(baseline._detailCategories)
  ? baseline._detailCategories
  : ['Wrong Display Name'];
for (const cat of detailCategories) {
  const seen = new Set();
  const uniq = [];
  for (const l of qa.split(/\r?\n/)) {
    if (!l.includes(cat)) continue;
    const t = l.trim();
    if (seen.has(t)) continue;
    seen.add(t);
    uniq.push(t);
  }
  if (uniq.length) {
    console.log(`\n類別「${cat}」逐筆（去重後 ${uniq.length} 筆，供逐碼術語稽核；含 tx 回報之官方 display）：`);
    for (const l of uniq.slice(0, 60)) console.log(`  ${l.slice(0, 500)}`);
    if (uniq.length > 60) console.log(`  …另有 ${uniq.length - 60} 筆，詳見 qa.txt`);
  }
}

// ---------------------------------------------------------------- CI 摘要
// 把同一張表寫進 GitHub Step Summary，省去為了看幾個數字而撈數百行日誌。
if (process.env.GITHUB_STEP_SUMMARY) {
  const md = [
    `### QA 閘門 — IG Publisher ${igVersion}`,
    '',
    '| 訊息類別 | 基準線 | 實際 | 差異 | 判定 |',
    '|:--|--:|--:|--:|:--|',
    ...rows.map((r) => {
      const verdict = r.over ? '❌ 退步' : r.under ? '❌ 未校準' : r.delta < 0 ? '✅ 改善（容差內）' : 'OK';
      const sign = r.delta > 0 ? `+${r.delta}` : `${r.delta}`;
      return `| ${r.label} | ${r.limit} | ${r.actual} | ${sign} | ${verdict} |`;
    }),
    '',
    `未具名 WARNING：${uw.unnamed} / ${uw.total} 筆。`,
    ev.stale ? '⚠️ 有項目低於基準線且超出容差——基準線未校準，執行 `npm run qa -- --update`。' : '',
  ].join('\n');
  try {
    fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, md + '\n');
  } catch {
    /* 摘要寫入失敗不應影響閘門判定 */
  }
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

// ---------------------------------------------------------------- 基準線校準
if (ev.improved) {
  const next = {
    ...baseline,
    totals: { ...totals },
    categories: Object.fromEntries(
      rows.filter((r) => !r.label.startsWith('TOTAL ')).map((r) => [r.label, Math.min(r.actual, r.limit)])
    ),
  };
  if (update) {
    if (ev.regressed || offline) {
      console.error('\n✖ 有退步項目或連線疑慮，拒絕以 --update 校準基準線。請先修正再重跑。');
      process.exit(1);
    }
    next.measuredAt = new Date(fs.statSync(qaPath).mtime).toISOString().slice(0, 10);
    next.igPublisherVersion = igVersion;
    next.source = `本機／CI 建置之 output/qa.txt（前次：${baseline.source}）`;
    fs.writeFileSync(baselinePath, `${JSON.stringify(next, null, 2)}\n`);
    console.log(`\n✔ 已校準基準線並寫回 ${path.relative(repoRoot, baselinePath)}。請一併提交。`);
    process.exit(0);
  }
  if (ev.stale) {
    console.error('\n✖ 有項目低於基準線且超出容差——**基準線未校準**。');
    console.error('  低於天花板不是成功，是天花板過期了：過期的天花板等於一段看不見的緩衝，');
    console.error('  日後新增的 WARNING 會靜默地填進去。本 repo 已因此連續三次未察覺改善');
    console.error('  （152 vs 91、91 vs 90、467 vs 464），三次都靠人工複驗已發佈站台才發現。');
    console.error('  處置：確認差異來源後執行 `npm run qa -- --update`，並於 qa-baseline.json 具名說明。');
  } else {
    console.log('\nℹ 有類別低於基準線但在容差內（視為波動，不失敗）。');
  }
}

if (failed) {
  console.error('\n✖ QA 閘門未通過。');
  process.exit(1);
}
console.log('\n✔ QA 閘門通過：所有類別皆與基準線相符（或在容差內）。');
