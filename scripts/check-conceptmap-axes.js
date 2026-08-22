#!/usr/bin/env node
// ConceptMap equivalence 一致性檢查：判準為**六軸實測**，不是 comment 散文。
//
// 為何換判準（根因）：舊的 fix-conceptmap-equivalence.js --check 只讀 comment。
// element[38]（57735-3 → 5804-0）原 comment 為「source 指定自動化試紙判讀，
// target 方法未指定自動化；target 語意較廣」——就 METHOD 一軸而言完全正確，
// 命中規則 R2、判 wider、通過。錯的是它沒提 PROPERTY（PrThr vs MCnc）與
// SCALE（Ord vs SemiQn）亦不同。閘門的輸入就只有那段散文，無從得知有兩軸沒被看過。
//
// 「未涵蓋」與「已檢查且通過」在舊輸出中都是綠的；--min-coverage 只擋得住
// 「規則全未命中」，擋不住「規則命中了但看錯軸」。本腳本改以軸為輸入，
// 該看的軸由資料決定而非由撰寫者記得與否決定。
//
// 資料來源：input/assets/loinc-axes-reference.csv（六軸 LP 代碼）
//           input/assets/loinc-part-subsumption.csv（Part 階層與其可採信之證據）
// 兩檔由 scripts/fetch-loinc-axes.js 自 tx.fhir.org 取得，CI 另有一步驗其與上游一致。
//
// Usage:
//   node scripts/check-conceptmap-axes.js              # dry-run：宣告值 vs 六軸推導值對照表
//   node scripts/check-conceptmap-axes.js --check      # 閘門模式
//   node scripts/check-conceptmap-axes.js --self-test  # 負向自我測試
//
// 選項：
//   --max-unresolved <n>  「需人工判定」之上限（預設 0，即 2026-08-22 實測值）。
//                          超過即失敗——新增組別不得靜默落進這個桶子。
//   --strict-hierarchy    改採保守讀法（source 軸代碼無 parent 即記為 unknown）。
//                          供覆核對照用，不是閘門的預設。
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const cmPath = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');
const axesPath = path.join(repoRoot, 'input', 'assets', 'loinc-axes-reference.csv');
const subPath = path.join(repoRoot, 'input', 'assets', 'loinc-part-subsumption.csv');

const argv = process.argv.slice(2);
const checkMode = argv.includes('--check');
const selfTest = argv.includes('--self-test');
const maxUnresolved = Number((argv.indexOf('--max-unresolved') !== -1 && argv[argv.indexOf('--max-unresolved') + 1]) || '0');
// 「source 軸代碼無 parent」之讀法。**預設採放寬**：無 parent 即視為該 Part 於
// 階層中為根節點，其上無可包含之概念，故 not-subsumed 為可採信之結論。
//
// 依據與代價（2026-08-22 裁示）：tx 之 Part 階層確實不完整，但已知的缺漏形態
// （LP65527-1 Test strip.automated 無 parent）由名稱點號規則涵蓋，保守讀法的主要
// 理由因而消解。若改採保守讀法，27／49 組不受檢——**包含 element[38] 本身**，
// 亦即判準對當初的動機案例仍然沉默，這已由負向驗證實測確認。
// --strict-hierarchy 可切回保守讀法，供覆核時對照。
const strictHierarchy = argv.includes('--strict-hierarchy');
const trustRootless = !strictHierarchy;

const AXES = ['component', 'property', 'time', 'system', 'scale', 'method'];

// §2.6 具名例外：經治理裁示而與推導結果不同者。目前為 0。
// ⚠️ 不得以放寬規則或加關鍵詞讓某一組通過——那正是本次要根除的作法。
const AXIS_EXCEPTIONS = {};

// ---- CSV -------------------------------------------------------------------
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
  const lines = fs.readFileSync(p, 'utf8').replace(/^﻿/, '').trim().split(/\r?\n/);
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
  return Object.keys(el).map(Number).sort((a, b) => a - b)
    .map((i) => ({ i, source: el[i].s_code, target: el[i].t_code, declared: el[i].t_equivalence, comment: el[i].t_comment || '' }));
}

// ---- 逐軸關係 ---------------------------------------------------------------
// 四種以上的狀態，不是提示詞所列之三態。多出來的是「一方未指定」——
// LOINC 之 METHOD 有 33 碼確實未指定，那與「兩碼方法不同」是實質不同的關係：
// 前者是通用碼與特化碼（有包含關係），後者是兄弟碼（沒有）。
// 併成三態會把 element[36]（3137-7 Body height Measured → 8302-2 Body height）
// 誤判成 unrelated。
//   same      兩碼該軸相同（含兩者皆未指定）
//   src-only  source 指定、target 未指定 → source 為該軸之特化
//   tgt-only  target 指定、source 未指定
//   isa       兩碼皆指定且不同，且 source 為 target 之後裔
//   isa-rev   反向
//   unrelated 兩碼皆指定且不同，且已確認無階層關係
//   unknown   兩碼皆指定且不同，但階層無從解析 → 需人工判定，不得預設
function axisRelation(axis, a, b, subs, aDisp, bDisp) {
  if (!a && !b) return 'same';
  if (a === b) return 'same';
  if (a && !b) return 'src-only';
  if (!a && b) return 'tgt-only';
  const o = subs.get(`${axis}|${a}|${b}`);
  if (o === 'subsumed-by') return 'isa';
  if (o === 'subsumes') return 'isa-rev';
  if (o === 'equivalent') return 'same';
  // 伺服器之 Part 階層不完整（見 nameRelation 之說明），故名稱慣例先於 not-subsumed。
  const byName = nameRelation(aDisp, bDisp);
  if (byName) return byName;
  if (axis === 'property') {
    const byUnion = unionRelation(aDisp, bDisp);
    if (byUnion) return byUnion;
  }
  if (o === 'not-subsumed') return 'unrelated';
  if (o === 'unknown' && trustRootless) return 'unrelated';
  return 'unknown';
}

// LOINC Part 之名稱以點號表示特化：`Test strip.automated` 是 `Test strip` 之子，
// `Circumference.at umbilicus` 是 `Circumference` 之子。這是可查證的命名慣例，
// 與 $subsumes 互相獨立。
//
// ⚠️ 之所以讓名稱慣例**優先於** not-subsumed：2026-08-22 實測 LP65527-1
//    （Test strip.automated）在 tx 上沒有 parent，$subsumes 因而答不出它與
//    LP6548-4（Test strip）的關係。名稱明說是特化、伺服器卻不知道，
//    即證明該伺服器之 Part 階層並不完整。既然不完整，它的 not-subsumed
//    就不能凌駕於一個明確的名稱事實之上。
//    ⚠️ 點號只在**前綴**成立時採用：`Automated count` 與 `Automated` 無點號關係，
//    是兄弟碼而非特化，不得因字串開頭相同就判為包含。
// LOINC 之聯集量綱：MSCnc（Mass or Substance concentration）涵蓋 MCnc 與 SCnc。
// 聯集包含其成員，故兩者之間確有包含關係，只是 LOINC 之 Part 階層未以 parent／child
// 表達，名稱亦無點號——不明文列出就只能落到 unrelated，把 element[4]
// （35200-5 MSCnc → 2093-3 MCnc）誤判為無包含關係。
//
// ⚠️ 本表**只列 LOINC 定義上確為聯集者**，不得為了讓某一組通過而擴充。
//    量綱名稱相似（如 NCnc 與 MCnc）不構成聯集關係。
const PROPERTY_UNIONS = {
  MSCnc: ['MCnc', 'SCnc'],
};
function unionRelation(aDisp, bDisp) {
  const a = String(aDisp || '');
  const b = String(bDisp || '');
  if (!a || !b || a === b) return null;
  if ((PROPERTY_UNIONS[a] || []).includes(b)) return 'isa-rev';  // source 為聯集，target 較窄
  if ((PROPERTY_UNIONS[b] || []).includes(a)) return 'isa';      // target 為聯集，source 較窄
  return null;
}

function nameRelation(aDisp, bDisp) {
  const a = String(aDisp || '');
  const b = String(bDisp || '');
  if (!a || !b || a === b) return null;
  if (a.startsWith(b + '.')) return 'isa';
  if (b.startsWith(a + '.')) return 'isa-rev';
  return null;
}

// ---- COMPONENT 之子欄位 ------------------------------------------------------
// LOINC 之 COMPONENT 以 `^` 分隔 analyte^challenge^adjustment。
// challenge 差異（如 `Triglyceride^post CFst` vs `Triglyceride`）是條件特化，有包含關係；
// adjustment 差異（如 `Hemoglobin A1c/Hemoglobin.total^^standardized per IFCC-RMP for CDT`）
// 是標準化方法不同，需單位換算而**沒有**包含關係。兩者不可混為一談。
function componentParts(display) {
  const [analyte = '', challenge = '', adjustment = ''] = String(display || '').split('^');
  return { analyte, challenge, adjustment };
}
function componentRelation(srcDisp, tgtDisp) {
  const s = componentParts(srcDisp);
  const t = componentParts(tgtDisp);
  if (!srcDisp || !tgtDisp) return null;              // 無顯示名可判，回退至階層
  if (s.analyte !== t.analyte) {
    const byName = nameRelation(s.analyte, t.analyte);   // 分析物之點號特化（Circumference.at umbilicus）
    return byName || 'unrelated';
  }
  if (s.adjustment !== t.adjustment) return 'unrelated'; // 標準化不同，須換算
  if (s.challenge === t.challenge) return 'same';
  if (s.challenge && !t.challenge) return 'src-only'; // source 帶條件，target 未限定
  if (!s.challenge && t.challenge) return 'tgt-only';
  return 'unrelated';                                 // 兩者條件不同
}

// ---- 由六軸推導 equivalence --------------------------------------------------
// R4 之 equivalence 為 target-relative：wider = target 語意較廣。
function derive(rel) {
  const unknowns = AXES.filter((a) => rel[a] === 'unknown');
  if (unknowns.length) return { eq: null, reason: `需人工判定：${unknowns.join('／')} 之階層無從解析` };

  // **任一軸**為 unrelated → 無包含關係，須經閾值或公式轉換。
  // ⚠️ METHOD 起初被漏在這份清單外，是本推導表的一個實際錯誤：
  //    element[43]／[44]（56114-2／56115-9 → 8280-0）之 COMPONENT 為 isa-rev、
  //    METHOD 為 unrelated（NHANES／NCFS 與 Tape measure 為兄弟量測法），
  //    漏掉 METHOD 就只剩一個方向，被判成 narrower。
  //    兩個量測 protocol 與皮尺量測之間沒有包含關係，正確為 relatedto。
  //    「某一軸互不相關」不因它是哪一軸而改變結論——會改變的只有理由的措辭。
  for (const [axis, why] of [
    ['property', '量綱不同'], ['scale', '尺度不同'],
    ['system', '檢體不同'], ['component', '量測對象或標準化不同'], ['time', '時相不同'],
    ['method', '量測方法為兄弟碼'],
  ]) {
    if (rel[axis] === 'unrelated') return { eq: 'relatedto', reason: `${axis} ${why}，無包含關係` };
  }

  const diff = AXES.filter((a) => rel[a] !== 'same');
  if (!diff.length) return { eq: 'equivalent', reason: '六軸全同' };

  const widerish = diff.filter((a) => rel[a] === 'src-only' || rel[a] === 'isa');
  const narrowish = diff.filter((a) => rel[a] === 'tgt-only' || rel[a] === 'isa-rev');
  if (widerish.length && !narrowish.length) return { eq: 'wider', reason: `source 於 ${widerish.join('／')} 為特化，target 較廣` };
  if (narrowish.length && !widerish.length) return { eq: 'narrower', reason: `target 於 ${narrowish.join('／')} 為特化，target 較窄` };
  return { eq: 'relatedto', reason: `方向互見（較特化：${widerish.join('／')}；較通用：${narrowish.join('／')}），無單向包含` };
}

// ---- 散文交叉檢查（§2.4）-----------------------------------------------------
// 散文降級為次級檢查：不再是判準，但矛盾即失敗。
// 它抓的是「comment 寫的跟實際做的不一致」，只是不再被誤當成「已驗證」。
const PROSE_NON_DIRECTIONAL = ['不可直接比較', '需換算', '換算', '不同具體方法', '無包含關係', '非包含關係', '互有寬窄', '性質不同', '非單純包含', 'Unit conversion required', '不同估算公式', '數值不可', '檢體不同'];
// ⚠️ 比對前先剝除「」內之引述。本 repo 的更正註記慣例是把**舊的**措辭原文引述
//    進新 comment（element[11]／[38] 皆然），而關鍵詞比對分不出「引述」與「主張」——
//    不剝除，一則正確的更正註記會因為忠實引述了自己要更正的錯誤說法而被判為矛盾。
//    引述是註記，主張才是 comment 的內容；只有後者該被交叉檢查。
function stripQuotes(text) {
  return String(text || '').replace(/「[^」]*」/g, '');
}
function proseContradicts(comment, derived) {
  const c = stripQuotes(comment);
  if (!derived) return null;
  const saysNoContainment = PROSE_NON_DIRECTIONAL.some((k) => c.includes(k));
  if (saysNoContainment && (derived === 'wider' || derived === 'narrower')) {
    return `comment 主張無包含關係，六軸推導卻為 ${derived}`;
  }
  if (derived === 'relatedto' && /語意較\s*target[^，。]*廣|target\s*語意較廣/.test(c) && !saysNoContainment) {
    return 'comment 主張單向包含（target 較廣），六軸推導卻為 relatedto';
  }
  return null;
}

// ---- 自我測試 ---------------------------------------------------------------
function runSelfTest() {
  const cases = [];
  const ok = (n, c) => cases.push({ name: n, pass: !!c });
  const subs = new Map([
    ['method|LPa|LPb', 'subsumed-by'],
    ['method|LPc|LPd', 'not-subsumed'],
  ]);
  const R = (o) => Object.assign({ component: 'same', property: 'same', time: 'same', system: 'same', scale: 'same', method: 'same' }, o);

  ok('① 六軸全同 → equivalent', derive(R({})).eq === 'equivalent');
  ok('② PROPERTY 與 SCALE 皆 unrelated → relatedto（element[38] 之情形）',
    derive(R({ property: 'unrelated', scale: 'unrelated', method: 'unrelated' })).eq === 'relatedto');
  ok('③ 僅 METHOD 為 src-only → wider（element[36] 之情形）', derive(R({ method: 'src-only' })).eq === 'wider');
  ok('④ 僅 METHOD 為 tgt-only → narrower', derive(R({ method: 'tgt-only' })).eq === 'narrower');
  ok('⑤ 僅 METHOD 為 isa → wider', derive(R({ method: 'isa' })).eq === 'wider');
  ok('⑥ 任一軸 unknown → 需人工判定，不得推導出值', derive(R({ method: 'unknown' })).eq === null);
  ok('⑦ unknown 優先於 unrelated（不得因其他軸已足以判 relatedto 就略過未解析者）',
    derive(R({ property: 'unrelated', method: 'unknown' })).eq === null);
  ok('⑧ 方向互見 → relatedto', derive(R({ method: 'src-only', system: 'tgt-only' })).eq === 'relatedto');
  ok('⑧b METHOD 為 unrelated 時不得被其他軸之方向帶著判為 narrower（element[43]／[44] 之情形）',
    derive(R({ component: 'isa-rev', method: 'unrelated' })).eq === 'relatedto');

  ok('⑨ 兩軸皆未指定視為 same，不是「缺資料」', axisRelation('method', '', '', subs) === 'same');
  ok('⑩ 一方未指定為 src-only／tgt-only，不得併入 unrelated',
    axisRelation('method', 'LPx', '', subs) === 'src-only' && axisRelation('method', '', 'LPx', subs) === 'tgt-only');
  ok('⑪ 階層 subsumed-by → isa', axisRelation('method', 'LPa', 'LPb', subs) === 'isa');
  ok('⑫ 階層 not-subsumed → unrelated', axisRelation('method', 'LPc', 'LPd', subs) === 'unrelated');
  ok('⑬ 階層無紀錄 → unknown，不得預設為 same 或 unrelated', axisRelation('method', 'LPy', 'LPz', subs) === 'unknown');
  ok('⑬b 名稱點號特化先於 not-subsumed（伺服器 Part 階層不完整）',
    axisRelation('method', 'LPc', 'LPd', subs, 'Test strip.automated', 'Test strip') === 'isa');
  ok('⑬c 點號僅前綴成立時採用，字串開頭相同不算（Automated count vs Automated）',
    nameRelation('Automated count', 'Automated') === null);
  ok('⑬d 反向點號 → isa-rev', nameRelation('Circumference', 'Circumference.at umbilicus') === 'isa-rev');
  ok('⑬e 聯集量綱包含其成員（element[4] 之情形）', unionRelation('MSCnc', 'MCnc') === 'isa-rev');
  ok('⑬f 聯集規則為反向亦成立', unionRelation('MCnc', 'MSCnc') === 'isa');
  ok('⑬g 量綱名稱相似不構成聯集（NCnc vs MCnc）', unionRelation('NCnc', 'MCnc') === null);

  ok('⑭ COMPONENT 之 challenge 差異為特化', componentRelation('Triglyceride^post CFst', 'Triglyceride') === 'src-only');
  ok('⑮ COMPONENT 之 adjustment 差異為無包含關係（須換算），不得當成特化',
    componentRelation('Hemoglobin A1c/Hemoglobin.total^^standardized per IFCC-RMP for CDT', 'Hemoglobin A1c/Hemoglobin.total') === 'unrelated');
  ok('⑯ 分析物不同 → unrelated', componentRelation('Glucose', 'Triglyceride') === 'unrelated');
  ok('⑰ 兩者帶不同 challenge → unrelated', componentRelation('Triglyceride^post 12H CFst', 'Triglyceride^post CFst') === 'unrelated');

  ok('⑱ 散文說無包含、推導為 wider → 判為矛盾', !!proseContradicts('兩者數值不可直接比較', 'wider'));
  ok('⑲ 散文說 target 較廣、推導為 relatedto → 判為矛盾', !!proseContradicts('source 指定空腹，target 語意較廣', 'relatedto'));
  ok('⑳ 散文與推導一致時不誤報（正向對照）', !proseContradicts('source 指定空腹採檢條件，target 語意較廣', 'wider'));
  ok('㉑ 更正註記中「」引述之舊措辭不觸發矛盾（正向對照）',
    !proseContradicts('source 方法未指定，target 指定 Automated count；target 語意較窄。⚠️ 原標 relatedto，comment 為「不同具體方法，無包含關係」，惟該說法有誤。', 'narrower'));
  ok('㉒ 剝除引述後仍在的主張照樣被抓（引述不得成為規避手段）',
    !!proseContradicts('「某段引述」本組無包含關係', 'narrower'));

  let allPass = true;
  console.log('ConceptMap 六軸判準自我測試：');
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
for (const p of [axesPath, subPath]) {
  if (!fs.existsSync(p)) {
    console.error(`✖ 找不到對照檔：${path.relative(repoRoot, p)}`);
    console.error('  請執行 node scripts/fetch-loinc-axes.js（需可連線術語伺服器）。');
    process.exit(1);
  }
}

const axesRows = readCsv(axesPath);
const axesByCode = new Map(axesRows.map((r) => [r.loinc, r]));
const subs = new Map(readCsv(subPath).filter((r) => !r.axis.startsWith('__')).map((r) => [`${r.axis}|${r.code_a}|${r.code_b}`, r.outcome]));
const elements = parseConceptMap(fs.readFileSync(cmPath, 'utf8'));

const rows = [];
const missing = [];
for (const e of elements) {
  const s = axesByCode.get(e.source);
  const t = axesByCode.get(e.target);
  if (!s || !t) { missing.push(`[${e.i}] ${e.source} → ${e.target}：${!s ? e.source : e.target} 不在軸對照檔`); continue; }
  const rel = {};
  for (const a of AXES) {
    if (a === 'component') {
      const byDisplay = componentRelation(s.component_display, t.component_display);
      rel[a] = byDisplay !== null ? byDisplay : axisRelation(a, s[a], t[a], subs, s.component_display, t.component_display);
      // 顯示名判為 same 但 LP 代碼不同時，以階層為準（顯示名可能截斷）
      if (rel[a] === 'same' && s[a] !== t[a]) rel[a] = axisRelation(a, s[a], t[a], subs, s.component_display, t.component_display);
      continue;
    }
    rel[a] = axisRelation(a, s[a], t[a], subs, s[`${a}_display`], t[`${a}_display`]);
  }
  const { eq: derived, reason } = derive(rel);
  const exception = AXIS_EXCEPTIONS[e.i];
  const prose = proseContradicts(e.comment, derived);
  rows.push({ ...e, rel, derived, reason, exception, prose });
}

// §2.5：涵蓋率必須 100%。軸資料是機器取得的，不存在「無判準可循」。
if (missing.length) {
  console.error(`✖ 軸資料不完整：${missing.length} 組`);
  for (const m of missing) console.error(`    ${m}`);
  console.error('  修法：node scripts/fetch-loinc-axes.js  然後提交更新後之對照檔。');
  process.exit(1);
}

const unresolved = rows.filter((r) => r.derived === null);
const mismatched = rows.filter((r) => r.derived !== null && r.derived !== r.declared && !r.exception);
const agreed = rows.filter((r) => r.derived !== null && r.derived === r.declared);
const proseIssues = rows.filter((r) => r.prose);

console.log('本閘門檢查涵蓋：ConceptMap 全部 49 組之六軸（COMPONENT／PROPERTY／TIME_ASPCT／');
console.log('SYSTEM／SCALE_TYP／METHOD_TYP）逐軸關係，與由其推導之 equivalence。');
console.log('刻意排除：comment 散文之措辭（已降級為交叉檢查，不再作為判準）、');
console.log('          非 LOINC 之 ConceptMap（Appendix10ToHazardType 之 source／target 為本地 CodeSystem）。');
console.log('');
console.log(`ConceptMap 六軸判準（${rows.length} 組）`);
console.log(`  推導與宣告相符：${agreed.length}`);
console.log(`  推導與宣告不符：${mismatched.length}`);
console.log(`  需人工判定（階層無從解析）：${unresolved.length}（上限 ${maxUnresolved}）`);
console.log(`  散文與推導矛盾：${proseIssues.length}`);
console.log(`  具名例外：${Object.keys(AXIS_EXCEPTIONS).length}`);

const fmt = (r) => `[${String(r.i).padStart(2)}] ${`${r.source} → ${r.target}`.padEnd(20)}`;

if (mismatched.length) {
  console.log('\n── 推導與宣告不符 ──');
  for (const r of mismatched) {
    console.log(`${fmt(r)} 宣告 ${String(r.declared).padEnd(11)} 推導 ${r.derived}`);
    console.log(`       理由：${r.reason}`);
    console.log(`       逐軸：${AXES.map((a) => `${a}=${r.rel[a]}`).join(' ')}`);
  }
}
if (unresolved.length) {
  console.log('\n── 需人工判定（階層無從解析，不得預設）──');
  for (const r of unresolved) {
    console.log(`${fmt(r)} 宣告 ${String(r.declared).padEnd(11)} ${r.reason}`);
    console.log(`       逐軸：${AXES.map((a) => `${a}=${r.rel[a]}`).join(' ')}`);
  }
}
if (proseIssues.length) {
  console.log('\n── 散文與推導矛盾（§2.4 交叉檢查）──');
  for (const r of proseIssues) console.log(`${fmt(r)} ${r.prose}`);
}

if (!checkMode) {
  console.log('\n（dry-run。不修改任何 equivalence 值——出入可能是又一個 element[38] 型錯誤、');
  console.log('  推導表未涵蓋之情形，或經裁示之刻意例外，三者處置完全不同，由人判定。）');
  process.exit(0);
}

let failed = false;
if (mismatched.length) { console.error(`\n✖ ${mismatched.length} 組之宣告值與六軸推導不符。`); failed = true; }
if (proseIssues.length) { console.error(`✖ ${proseIssues.length} 組之 comment 與六軸推導矛盾。`); failed = true; }
if (unresolved.length > maxUnresolved) {
  console.error(`✖ 需人工判定 ${unresolved.length} 組 > 上限 ${maxUnresolved}——新增組別不得靜默落進這個桶子。`);
  failed = true;
}
if (failed) process.exit(1);
console.log(`\n✔ 六軸判準通過：${agreed.length} 組相符、0 不符、${unresolved.length} 組需人工判定（未超過上限）。`);
process.exit(0);
