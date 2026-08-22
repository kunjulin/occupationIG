#!/usr/bin/env node
// LOINC 六軸實測快取：以術語伺服器 $lookup／$subsumes 取回 ConceptMap 各組
// source 與 target 之六軸，寫成離線對照檔供閘門判準使用。
//
// 為何需要本檔：`check-conceptmap-axes.js` 的判準是**六軸事實**，不是 comment 散文。
// 六軸必須向術語伺服器求證，而閘門本身要能在無網路環境執行（比照
// `extended-ucum-reference.csv` 之作法），故以本工具取數、以 CSV 承載。
//
// ⚠️ 本工具**只取事實，不做判斷**。equivalence 之推導在 check-conceptmap-axes.js，
//    兩者刻意分開：取數可自動，判斷須留下可覆核的推導鏈。
//
// ⚠️ 「上游有、我方沒有 → 失敗」：--verify 會實際向 tx 查詢並與已提交之 CSV 比對，
//    任一碼缺漏或任一軸漂移即失敗。這道檢查存在的理由，是本專案已有四次
//    「閘門在跑、輸出是綠的，但它檢查的範圍比它宣稱的窄」（見 CLAUDE.md §4）。
//
// Usage:
//   node scripts/fetch-loinc-axes.js                 # 取數並寫入對照檔
//   node scripts/fetch-loinc-axes.js --emit          # 取數並印出 CSV（不寫檔，供引導用）
//   node scripts/fetch-loinc-axes.js --verify        # 取數並與已提交之對照檔比對（CI 閘門）
//   node scripts/fetch-loinc-axes.js --self-test     # 負向自我測試（不連網）
//
// 選項：
//   --tx <url>     術語伺服器（預設 https://tx.fhir.org/r4）
//   --delay <ms>   查詢間隔（預設 250ms）
'use strict';

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

const repoRoot = path.resolve(__dirname, '..');
const cmPath = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');
const axesPath = path.join(repoRoot, 'input', 'assets', 'loinc-axes-reference.csv');
const subPath = path.join(repoRoot, 'input', 'assets', 'loinc-part-subsumption.csv');

const argv = process.argv.slice(2);
const arg = (n, d) => {
  const i = argv.indexOf(n);
  return i !== -1 && argv[i + 1] && !argv[i + 1].startsWith('--') ? argv[i + 1] : d;
};
const emitMode = argv.includes('--emit');
const verifyMode = argv.includes('--verify');
const selfTest = argv.includes('--self-test');
const tx = arg('--tx', 'https://tx.fhir.org/r4').replace(/\/$/, '');
const delayMs = Number(arg('--delay', '250'));

// LOINC 六軸。CLASS／STATUS 一併取回：STATUS 是「這個碼還能不能用」的事實，
// 與六軸同屬取數範圍；CLASS 供人工覆核時定位用。
const AXES = ['component', 'property', 'time', 'system', 'scale', 'method'];
const AXIS_PROP = {
  COMPONENT: 'component',
  PROPERTY: 'property',
  TIME_ASPCT: 'time',
  SYSTEM: 'system',
  SCALE_TYP: 'scale',
  METHOD_TYP: 'method',
  CLASS: 'class',
  STATUS: 'status',
};

// ---- CSV -------------------------------------------------------------------
// 欄位較提示詞所列之 9 欄為多，理由具名如下（刻意偏離，非疏漏）：
//   1. 判準比對的是**軸之 LP 代碼**——tx 之 $lookup 於軸值只回 LP 代碼，
//      且 LP 代碼才是身分（名稱會隨 LOINC 改版漂移）。但 LP 代碼人讀不出來，
//      覆核「LP65527-1 是否為 LP6548-4 之後裔」時，看得懂那是「Automated test strip」
//      與「Test strip」才判斷得了對錯，故另以第二趟查詢補上 `*_display`。
//      只留其一都會讓這個檔失去它該有的用途之一：只留代碼則無法覆核，
//      只留名稱則判準沒有可靠的身分可比。
//   2. `status` 為取數當下之事實，與六軸同一批取回，分開存反而會不同步。
const AXES_HEADER = [
  'loinc', 'display',
  ...AXES.flatMap((a) => [a, `${a}_display`]),
  'class', 'status', 'source', 'fetched_at',
];
const SUB_HEADER = ['axis', 'code_a', 'code_b', 'outcome', 'source', 'fetched_at'];

function esc(s) {
  const v = String(s ?? '');
  return /[",\n]/.test(v) ? `"${v.replace(/"/g, '""')}"` : v;
}
function toCsv(header, rows) {
  return [header.join(','), ...rows.map((r) => header.map((h) => esc(r[h])).join(','))].join('\n') + '\n';
}
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
function readCsv(p) {
  if (!fs.existsSync(p)) return null;
  const lines = fs.readFileSync(p, 'utf8').replace(/^﻿/, '').trim().split(/\r?\n/);
  if (!lines.length) return null;
  const header = parseCsvLine(lines[0]);
  return lines.slice(1).filter((l) => l.trim()).map((l) => {
    const cells = parseCsvLine(l);
    return Object.fromEntries(header.map((h, i) => [h, cells[i] ?? '']));
  });
}

// ---- ConceptMap 解析 --------------------------------------------------------
function parseConceptMap(text) {
  const el = {};
  for (const line of text.split(/\r?\n/)) {
    const m = line.match(/^\*\s*group\[0\]\.element\[(\d+)\](\.target\[0\])?\.(code|display|equivalence|comment)\s*=\s*(.+)$/);
    if (!m) continue;
    const i = Number(m[1]);
    const key = (m[2] ? 't_' : 's_') + m[3];
    el[i] = el[i] || {};
    el[i][key] = m[4].trim().replace(/^"|"$/g, '').replace(/^#/, '');
  }
  return el;
}
function elementPairs(el) {
  return Object.keys(el).map(Number).sort((a, b) => a - b)
    .map((i) => ({ i, source: el[i].s_code, target: el[i].t_code, equivalence: el[i].t_equivalence, comment: el[i].t_comment }));
}

// ---- HTTP ------------------------------------------------------------------
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

// ---- $lookup 解析 -----------------------------------------------------------
// 軸值之回覆型別因伺服器而異：可能是 valueCoding（code ＋ display），
// 也可能是 **valueString 內直接放 LP 代碼**——tx.fhir.org 2026-08-22 實測即為後者
// （`PROPERTY` 回 `"LP6827-2"`，不是 `"MCnc"`）。
//
// ⚠️ 這一點本工具第一版判斷錯了，值得留下記錄：當時假設 valueString 只會是顯示名，
//    於是把 LP 代碼寫進 display 欄、code 欄留空。後果不是報錯，而是
//    **「需階層判定之軸配對：0 組」**——階層比對讀到的兩邊都是空字串，一律相等，
//    整個階層檢查靜默地什麼都沒查。閘門在跑、輸出照印，而它的輸入是空的。
//    這正是本次改判準要根除的形態，只是這次發生在新寫的工具自己身上。
//    故新增 assertAxesResolved()：五個必有之軸任一為空即失敗，不讓它再靜默一次。
const LP_CODE = /^LP\d+-\d+$/;

function parseLookup(res) {
  const out = { display: '', axes: {}, propNames: [], error: null };
  if (!res || res.resourceType !== 'Parameters') {
    out.error = res && res.resourceType === 'OperationOutcome'
      ? (res.issue || []).map((i) => i.diagnostics || (i.details && i.details.text)).filter(Boolean).join('; ')
      : `非預期回應（${res && res.resourceType}）`;
    return out;
  }
  for (const p of res.parameter || []) {
    if (p.name === 'display') out.display = p.valueString || '';
    if (p.name !== 'property') continue;
    const parts = Object.fromEntries((p.part || []).map((x) => [x.name, x]));
    const propCode = (parts.code && (parts.code.valueCode || parts.code.valueString)) || '';
    if (propCode) out.propNames.push(propCode);
    const axis = AXIS_PROP[propCode];
    if (!axis) continue;
    const v = parts.value;
    if (!v) continue;
    if (v.valueCoding) { out.axes[axis] = { code: v.valueCoding.code || '', display: v.valueCoding.display || '' }; continue; }
    const s = String(v.valueString ?? v.valueCode ?? v.valueBoolean ?? '');
    // LP 代碼即為該軸之身分；其餘字串（如 STATUS 之 "ACTIVE"）不是代碼，留在 display。
    out.axes[axis] = LP_CODE.test(s) ? { code: s, display: '' } : { code: '', display: s };
  }
  return out;
}

// 軸值解析塌陷之防呆。COMPONENT／PROPERTY／TIME／SYSTEM／SCALE 於 LOINC 恆有值
// （2026-08-22 實測 83 碼全數具備）；METHOD 則有 33 碼確實未指定，那是實質資訊而非缺漏，
// 故不列入必檢。任一必檢軸為空 → 失敗並具名，不得寫入對照檔。
const REQUIRED_AXES = ['component', 'property', 'time', 'system', 'scale'];
function assertAxesResolved(rows) {
  const bad = [];
  for (const r of rows) {
    const missing = REQUIRED_AXES.filter((a) => !r[a]);
    if (missing.length) bad.push(`${r.loinc}：${missing.join('／')} 無 LP 代碼`);
  }
  return bad;
}

// ---- $subsumes --------------------------------------------------------------
// 回傳 equivalent／subsumes／subsumed-by／not-subsumed，或 unsupported（伺服器不支援）。
// ⚠️ 解析不出來時回 unsupported，**絕不預設為 not-subsumed**——
//    「查不到關係」與「確認無關係」是兩件事，混為一談正是本次要根除的那類錯誤。
function parseSubsumes(res) {
  if (!res || res.resourceType !== 'Parameters') return 'unsupported';
  for (const p of res.parameter || []) {
    if (p.name === 'outcome') return p.valueCode || p.valueString || 'unsupported';
  }
  return 'unsupported';
}

// ---- 自我測試（不連網）------------------------------------------------------
function runSelfTest() {
  const cases = [];
  const ok = (name, cond) => cases.push({ name, pass: !!cond });

  const lk = parseLookup({
    resourceType: 'Parameters',
    parameter: [
      { name: 'display', valueString: 'Protein [Mass/volume] in Urine by Test strip' },
      { name: 'property', part: [{ name: 'code', valueCode: 'PROPERTY' }, { name: 'value', valueCoding: { code: 'LP6827-2', display: 'MCnc' } }] },
      { name: 'property', part: [{ name: 'code', valueCode: 'SCALE_TYP' }, { name: 'value', valueString: 'LP436123-6' }] },
      { name: 'property', part: [{ name: 'code', valueCode: 'STATUS' }, { name: 'value', valueString: 'ACTIVE' }] },
    ],
  });
  ok('① valueCoding 之 LP 代碼與顯示名皆取回', lk.axes.property && lk.axes.property.code === 'LP6827-2' && lk.axes.property.display === 'MCnc');
  // ② tx.fhir.org 實測即為此形：軸值以 valueString 承載 LP 代碼。
  //    本案例鎖的是「LP 代碼必須落在 code 欄」——首版誤放到 display 欄，
  //    使階層比對兩邊皆空而一律相等，靜默地什麼都沒查。
  ok('② valueString 內之 LP 代碼須落在 code 欄，不得誤判為顯示名', lk.axes.scale && lk.axes.scale.code === 'LP436123-6' && lk.axes.scale.display === '');
  ok('③ 非 LP 形式之 valueString（如 STATUS）不得被當成代碼', lk.axes.status && lk.axes.status.code === '' && lk.axes.status.display === 'ACTIVE');
  ok('④ 未回覆之軸為 undefined（代表未指定），不是空物件', lk.axes.method === undefined);

  ok('⑤ 必檢軸為空即判為塌陷並具名', (() => {
    const bad = assertAxesResolved([{ loinc: 'X-1', component: 'LP1-1', property: '', time: 'LP3-3', system: 'LP4-4', scale: 'LP5-5' }]);
    return bad.length === 1 && bad[0].includes('X-1') && bad[0].includes('property');
  })());
  ok('⑥ METHOD 為空不算塌陷（33 碼確實未指定方法）', assertAxesResolved([{ loinc: 'X-1', component: 'LP1-1', property: 'LP2-2', time: 'LP3-3', system: 'LP4-4', scale: 'LP5-5', method: '' }]).length === 0);

  const oo = parseLookup({ resourceType: 'OperationOutcome', issue: [{ diagnostics: 'Unknown code' }] });
  ok('⑦ OperationOutcome 轉為具名錯誤而非靜默空值', oo.error === 'Unknown code');

  ok('⑧ $subsumes 之 outcome 正確取出', parseSubsumes({ resourceType: 'Parameters', parameter: [{ name: 'outcome', valueCode: 'subsumed-by' }] }) === 'subsumed-by');
  ok('⑨ $subsumes 無法解析時回 unsupported，不得預設為 not-subsumed', parseSubsumes({ resourceType: 'OperationOutcome' }) === 'unsupported');
  ok('⑩ $subsumes 缺 outcome 參數時回 unsupported', parseSubsumes({ resourceType: 'Parameters', parameter: [] }) === 'unsupported');
  // 陽性對照之判準：同一代碼對自己必為 equivalent，否則該伺服器不回答階層。
  // 鎖住這一條，是因為 tx.fhir.org 對不支援的階層查詢**不報錯**，一律回 not-subsumed
  // ——若直接採信，判準會把「答不出來」寫成「確認無包含關係」。
  // 兩道對照必須同時成立才視為階層可用。⑮ 是本工具第二個判斷錯的地方：
  // 只做自身比對時，實測「對照通過」而 31 組配對仍全數 not-subsumed。
  const hierOk = (self, partsCount) => self === 'equivalent' && partsCount > 0;
  ok('⑬ 兩道對照皆成立才視為階層可用', hierOk('equivalent', 3) === true);
  ok('⑭ 自身比對失敗即不可用', hierOk('not-subsumed', 3) === false && hierOk('unsupported', 3) === false);
  ok('⑮ 自身比對過、但無任何 Part 回報 parent／child → 仍不可用', hierOk('equivalent', 0) === false);

  const cm = parseConceptMap([
    '* group[0].element[0].code = #804-5',
    '* group[0].element[0].target[0].code = #6690-2',
    '* group[0].element[0].target[0].equivalence = #relatedto',
    '* group[0].element[1].code = #26464-8',
    '* group[0].element[1].target[0].code = #6690-2',
    '* group[0].element[1].target[0].equivalence = #narrower',
  ].join('\n'));
  const pairs = elementPairs(cm);
  ok('⑪ ConceptMap 解析出正確之組數與 source／target', pairs.length === 2 && pairs[0].source === '804-5' && pairs[1].target === '6690-2');

  const csv = toCsv(['a', 'b'], [{ a: 'x,y', b: 'he said "hi"' }]);
  const back = parseCsvLine(csv.split('\n')[1]);
  ok('⑫ CSV 逸出與回讀為可逆（含逗號與雙引號）', back[0] === 'x,y' && back[1] === 'he said "hi"');

  let allPass = true;
  console.log('LOINC 六軸取數工具自我測試：');
  for (const c of cases) {
    console.log(`  ${c.pass ? '✔' : '✖'} ${c.name}`);
    if (!c.pass) allPass = false;
  }
  if (!allPass) { console.error('\n✖ 自我測試未全數通過。'); process.exit(1); }
  console.log('✔ 自我測試全數通過。');
  process.exit(0);
}

if (selfTest) runSelfTest();

// ---- 主流程 ----------------------------------------------------------------
(async () => {
  const el = parseConceptMap(fs.readFileSync(cmPath, 'utf8'));
  const pairs = elementPairs(el);
  const codes = [...new Set(pairs.flatMap((p) => [p.source, p.target]))];
  const fetchedAt = new Date().toISOString().slice(0, 10);

  console.log(`術語伺服器：${tx}`);
  console.log(`ConceptMap 組數：${pairs.length}；相異 LOINC 碼：${codes.length}\n`);

  // ── 1. 逐碼 $lookup ────────────────────────────────────────────────
  const axesRows = [];
  const failures = [];
  for (let i = 0; i < codes.length; i++) {
    const code = codes[i];
    const url = `${tx}/CodeSystem/$lookup?system=${encodeURIComponent('http://loinc.org')}&code=${encodeURIComponent(code)}&property=*`;
    let r;
    try { r = parseLookup(await getJson(url)); }
    catch (e) { r = { display: '', axes: {}, error: e.message }; }
    if (r.error) { failures.push({ code, error: r.error }); console.log(`[${String(i + 1).padStart(3)}/${codes.length}] ${code} ✖ ${r.error}`); }
    else console.log(`[${String(i + 1).padStart(3)}/${codes.length}] ${code} ${r.display}`);
    // class／status 之回覆型別與軸值相同（可能是 LP 代碼、也可能是 ACTIVE 這類字串），
    // 故兩個欄位都取，不預設落在哪一邊——首版即因預設而讓 class 變成空白。
    const pick = (k) => { const a = r.axes[k] || {}; return a.code || a.display || ''; };
    const row = { loinc: code, display: r.display, class: pick('class'), status: pick('status'), source: 'tx $lookup', fetched_at: fetchedAt };
    for (const a of AXES) {
      row[a] = (r.axes[a] || {}).code || '';
      row[`${a}_display`] = (r.axes[a] || {}).display || '';
    }
    axesRows.push(row);
    if (i < codes.length - 1) await new Promise((res) => setTimeout(res, delayMs));
  }
  axesRows.sort((a, b) => a.loinc.localeCompare(b.loinc));

  // ── 1b. LP 代碼之顯示名 ────────────────────────────────────────────
  // tx 之 $lookup 於軸值只回 LP 代碼，不回其名稱。LP 代碼人讀不出來，
  // 而覆核「LP65527-1 是否為 LP6548-4 之後裔」這種判斷時，看得懂那兩個是
  // 「Automated test strip」與「Test strip」才有辦法判斷對錯。故逐一補查（去重）。
  // ⚠️ 查不到不算失敗——顯示名只供人閱讀，判準用的是 LP 代碼本身。
  const lpCodes = [...new Set(axesRows.flatMap((r) => AXES.map((a) => r[a]).filter(Boolean)))].sort();
  console.log(`\n相異 LP 代碼：${lpCodes.length}，補查顯示名…`);
  const lpDisplay = new Map();
  // 同一趟順便蒐集階層證據：這台伺服器對 LOINC Part 有沒有回 parent／child。
  // 這是判斷 $subsumes 之 not-subsumed 可不可信的關鍵，見下方 hierarchySupported。
  let lpWithParentChild = 0;
  for (let i = 0; i < lpCodes.length; i++) {
    const url = `${tx}/CodeSystem/$lookup?system=${encodeURIComponent('http://loinc.org')}&code=${encodeURIComponent(lpCodes[i])}&property=*`;
    let d = '';
    try {
      const r = parseLookup(await getJson(url));
      d = (r || {}).display || '';
      if ((r.propNames || []).some((n) => /^(parent|child)$/i.test(n))) lpWithParentChild++;
    } catch { d = ''; }
    lpDisplay.set(lpCodes[i], d);
    if (i < lpCodes.length - 1) await new Promise((res) => setTimeout(res, delayMs));
  }
  console.log(`  回報 parent／child 之 LP 代碼：${lpWithParentChild}／${lpCodes.length}`);
  const unresolved = lpCodes.filter((c) => !lpDisplay.get(c));
  console.log(`  取得 ${lpCodes.length - unresolved.length}／${lpCodes.length}${unresolved.length ? `；未取得（不影響判準）：${unresolved.join(' ')}` : ''}`);
  for (const r of axesRows) for (const a of AXES) r[`${a}_display`] = r[a] ? (lpDisplay.get(r[a]) || '') : '';

  // ── 2. 需要階層判定之軸配對 ────────────────────────────────────────
  // 只查「兩碼該軸皆有 LP 代碼且不相同」者——皆空或僅一方有值不需要階層即可判定。
  const byCode = new Map(axesRows.map((r) => [r.loinc, r]));
  const need = new Map();
  for (const p of pairs) {
    const s = byCode.get(p.source);
    const t = byCode.get(p.target);
    if (!s || !t) continue;
    for (const a of AXES) {
      if (!s[a] || !t[a] || s[a] === t[a]) continue;
      need.set(`${a}|${s[a]}|${t[a]}`, { axis: a, code_a: s[a], code_b: t[a] });
    }
  }
  const subRows = [];
  const needList = [...need.values()];
  const subsumesUrl = (a, b) => `${tx}/CodeSystem/$subsumes?system=${encodeURIComponent('http://loinc.org')}&codeA=${encodeURIComponent(a)}&codeB=${encodeURIComponent(b)}`;
  const askSubsumes = async (a, b) => {
    try { return parseSubsumes(await getJson(subsumesUrl(a, b))); }
    catch { return 'unsupported'; }
  };

  // ── 陽性對照：先問「某 LP 代碼與它自己」──────────────────────────
  //
  // 2026-08-22 實測：tx.fhir.org 對 31 組 LOINC Part 配對**全部**回 not-subsumed，
  // 包含 LP65527-1（Automated test strip）對 LP6548-4（Test strip）這種依 LOINC
  // Part 階層理應成立者。伺服器不會因「我沒有這個階層」而報錯，它就回 not-subsumed。
  //
  // 若把那個回覆當成事實，判準會據以宣告「兩軸無包含關係」——那是拿
  // 「查不到關係」冒充「確認無關係」，正是本次要根除的東西。
  //
  // 故先做陽性對照：$subsumes 若有實作，同一個代碼對自己必然是 equivalent。
  // 對照不成立即判定本伺服器不回答 LOINC Part 階層，全部結果改記 unknown，
  // 由判準路由至「需人工判定」並具名列出。對照本身也寫進對照檔——
  // 日後 tx 若補上支援，對照會翻成 equivalent 而讓人注意到。
  //
  // ⚠️ 對照分兩道，缺一不可。第一版只做了自身比對，那太弱——
  //    2026-08-22 實測 LP6377-8 對自身確實回 equivalent（對照「通過」），
  //    但 31 組真實配對仍全數 not-subsumed。自身比對可能只是相等判斷，
  //    證明不了伺服器真的走了 Part 階層。以那個對照放行，等於用一個
  //    證明不了事情的檢查去背書 31 個結論，與本次要修的毛病同型。
  //
  //    第二道才有鑑別力：這台伺服器對 LOINC Part 究竟有沒有 parent／child。
  //    一個都沒有，就表示它手上沒有 Part 階層，其 not-subsumed 一律不可採信。
  const controlCode = needList.length ? needList[0].code_a : 'LP6548-4';
  const controlOutcome = await askSubsumes(controlCode, controlCode);
  const selfOk = controlOutcome === 'equivalent';
  const partsOk = lpWithParentChild > 0;
  const hierarchySupported = selfOk && partsOk;
  console.log(`\n階層對照一（自身比對）：${controlCode} vs 自身 → ${controlOutcome}　${selfOk ? '✔' : '✖'}`);
  console.log(`階層對照二（Part 階層是否存在）：${lpWithParentChild}／${lpCodes.length} 個 LP 代碼回報 parent／child　${partsOk ? '✔' : '✖'}`);
  console.log(hierarchySupported
    ? '→ $subsumes 之結果可採信。'
    : '→ ⚠️ 本伺服器不回答 LOINC Part 階層，所有結果一律記為 unknown，由判準路由至「需人工判定」。');
  subRows.push({ axis: '__control_self__', code_a: controlCode, code_b: controlCode, outcome: controlOutcome, source: 'tx $subsumes', fetched_at: fetchedAt });
  subRows.push({ axis: '__control_parts__', code_a: `${lpWithParentChild}/${lpCodes.length}`, code_b: 'parent|child', outcome: partsOk ? 'present' : 'absent', source: 'tx $lookup', fetched_at: fetchedAt });

  console.log(`需階層判定之軸配對：${needList.length} 組`);
  for (let i = 0; i < needList.length; i++) {
    const { axis, code_a, code_b } = needList[i];
    const raw = await askSubsumes(code_a, code_b);
    const outcome = hierarchySupported ? raw : 'unknown';
    console.log(`  [${String(i + 1).padStart(2)}/${needList.length}] ${axis} ${code_a} vs ${code_b} → ${outcome}${hierarchySupported ? '' : `（伺服器原答 ${raw}，因對照不成立而不採信）`}`);
    subRows.push({ axis, code_a, code_b, outcome, source: 'tx $subsumes', fetched_at: fetchedAt });
    if (i < needList.length - 1) await new Promise((res) => setTimeout(res, delayMs));
  }
  subRows.sort((a, b) => `${a.axis}${a.code_a}${a.code_b}`.localeCompare(`${b.axis}${b.code_a}${b.code_b}`));

  const axesCsv = toCsv(AXES_HEADER, axesRows);
  const subCsv = toCsv(SUB_HEADER, subRows);

  // ── 3. 輸出 ───────────────────────────────────────────────────────
  if (failures.length) {
    console.error(`\n✖ ${failures.length} 碼查詢失敗：`);
    for (const f of failures) console.error(`    ${f.code}：${f.error}`);
    console.error('  查詢失敗不得寫入對照檔——空白的軸值會被判準讀成「該軸未指定」。');
    process.exit(1);
  }

  const unresolvedAxes = assertAxesResolved(axesRows);
  if (unresolvedAxes.length) {
    console.error(`\n✖ 軸值解析塌陷：${unresolvedAxes.length} 碼之必檢軸無 LP 代碼`);
    for (const b of unresolvedAxes) console.error(`    ${b}`);
    console.error('  空白軸值會讓判準把兩碼讀成「該軸相同」而靜默放行——不得寫入對照檔。');
    console.error('  多半是伺服器回覆型別改變（本工具首版即因此把 LP 代碼寫進 display 欄）。');
    process.exit(1);
  }

  if (emitMode) {
    console.log(`\n===== BEGIN ${path.basename(axesPath)} =====`);
    process.stdout.write(axesCsv);
    console.log(`===== END ${path.basename(axesPath)} =====`);
    console.log(`===== BEGIN ${path.basename(subPath)} =====`);
    process.stdout.write(subCsv);
    console.log(`===== END ${path.basename(subPath)} =====`);
    process.exit(0);
  }

  if (verifyMode) {
    const problems = [];
    const have = readCsv(axesPath);
    if (!have) problems.push(`對照檔不存在：${path.relative(repoRoot, axesPath)}`);
    else {
      const haveMap = new Map(have.map((r) => [r.loinc, r]));
      for (const r of axesRows) {
        const h = haveMap.get(r.loinc);
        if (!h) { problems.push(`${r.loinc}：上游有、對照檔沒有（新增碼未回寫）`); continue; }
        for (const a of AXES) {
          if ((h[a] || '') !== r[a]) problems.push(`${r.loinc} 之 ${a}：對照檔 "${h[a] || ''}"，上游實測 "${r[a]}"`);
        }
        haveMap.delete(r.loinc);
      }
      for (const k of haveMap.keys()) problems.push(`${k}：對照檔有、ConceptMap 已不再引用（冗列）`);
    }
    const haveSub = readCsv(subPath);
    if (!haveSub) problems.push(`對照檔不存在：${path.relative(repoRoot, subPath)}`);
    else {
      const key = (r) => `${r.axis}|${r.code_a}|${r.code_b}`;
      const haveMap = new Map(haveSub.map((r) => [key(r), r]));
      for (const r of subRows) {
        const h = haveMap.get(key(r));
        if (!h) { problems.push(`階層 ${key(r)}：上游有、對照檔沒有`); continue; }
        if (h.outcome !== r.outcome) problems.push(`階層 ${key(r)}：對照檔 "${h.outcome}"，上游實測 "${r.outcome}"`);
        haveMap.delete(key(r));
      }
      for (const k of haveMap.keys()) problems.push(`階層 ${k}：對照檔有、已不再需要（冗列）`);
    }
    console.log('\n本閘門檢查涵蓋：ConceptMap 全部 source／target 碼之六軸 LP 代碼，與所有需階層判定之軸配對。');
    console.log('刻意排除：軸之顯示名（會隨 LOINC 改版漂移，非身分）、CLASS、STATUS。');
    if (problems.length) {
      // 刻意走 stdout：CSV 也走 stdout，兩者混排時順序才是確定的。
      // 走 stderr 會在 CI 日誌裡與 CSV 交錯，令人誤以為 CSV 多了幾列。
      console.log(`\n✖ 對照檔與上游不一致：${problems.length} 處`);
      for (const p of problems) console.log(`    ${p}`);
      console.log(`\n  修法：node scripts/fetch-loinc-axes.js  然後提交更新後之對照檔。`);
      // 失敗時一併印出本次實測之 CSV：修這個失敗需要的就是這份內容，
      // 而在無法連外之環境（本專案之開發容器即是）沒有別的取得管道。
      console.log(`\n===== BEGIN ${path.basename(axesPath)} =====`);
      process.stdout.write(axesCsv);
      console.log(`===== END ${path.basename(axesPath)} =====`);
      console.log(`===== BEGIN ${path.basename(subPath)} =====`);
      process.stdout.write(subCsv);
      console.log(`===== END ${path.basename(subPath)} =====`);
      process.exit(1);
    }
    console.log(`\n✔ 對照檔與上游一致：${axesRows.length} 碼、${subRows.length} 組階層。`);
    process.exit(0);
  }

  fs.writeFileSync(axesPath, axesCsv);
  fs.writeFileSync(subPath, subCsv);
  console.log(`\n已寫入 ${path.relative(repoRoot, axesPath)}（${axesRows.length} 列）`);
  console.log(`已寫入 ${path.relative(repoRoot, subPath)}（${subRows.length} 列）`);
})();
