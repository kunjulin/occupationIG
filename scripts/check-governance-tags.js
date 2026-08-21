#!/usr/bin/env node
'use strict';
// ============================================================================
// 權責標籤／合規層級閘門（JOB-30 步驟 4、驗收 #6）
// ============================================================================
//
// 檢查四件事：
//   G-1  每支 Profile／Extension／ValueSet／CodeSystem 之 Description 起首均有權責標籤，
//        且與 scripts/governance-map.js 之登記一致。
//   G-2  登記表無孤兒項（登記了但 FSH 已不存在）——防止改名後標籤悄悄失效。
//   G-3  standards-status extension 與登記之合規層級一致
//        （level 1 → trial-use；level 2 → draft；level 0 → 不標）。
//   G-3b standards-status = draft 者，資源自身之 ^status 必須也是 draft。
//        IG Publisher 會交叉檢查兩者；v0.5.0 只標了 standards-status 而未動 status，
//        實測 71 件全部被判 not consistent——當時是 IG Publisher 抓到、閘門沒抓到，
//        故本輪把它變成閘門的責任（自我測試案 ②c／②d）。
//   G-4  全 repo 不得出現「把職安署寫成本指引之治理／主管機關」之表述（越權主張）。
//
// ⚠️ G-4 之否定句豁免：本專案的文件**必須**能寫出「不得把職安署列為治理機關」這句話，
//    否則規範自己就違反自己。故同一行若含否定詞即豁免，**並把豁免行逐行印出**——
//    抑制要看得見，不能靜默（比照 check-pagecontent-refs.js 之 backlog 標註慣例）。
//
// 用法：
//   node scripts/check-governance-tags.js              實檢
//   node scripts/check-governance-tags.js --self-test  負向自我測試（先跑這個）

const fs = require('fs');
const path = require('path');
const os = require('os');
const { TAGS, MAP, STANDARDS_STATUS_URL, statusOf, resourceStatusOf } = require('./governance-map');

const FSH_DIRS = ['profiles', 'extensions', 'valuesets', 'codesystems', 'namingsystems'];
const KINDS = ['Profile', 'Extension', 'ValueSet', 'CodeSystem'];

// JOB-31 §5(A)：ConceptMap 與 NamingSystem 在 FSH 中以 `Instance:` ＋ `InstanceOf:` 宣告，
// 舊版 scanFsh 一律排除，故 G-1「未登記即失敗」對它們不會觸發——TWHealthCheckLaboratoryMap
// 是 Level 1 對外宣告 trial-use 時的必要配套（acceptable→preferred 歸一），卻既無成熟度標記
// 也不受閘門保護。現納入登記範圍。
const INSTANCE_KINDS = ['ConceptMap', 'NamingSystem'];

// ⚠️ **status 之解析必須依宣告種類分開，不可統一放寬成 `\*\s*\^?status`。**
//    定義類（Profile 等）之 `* status = #final` 是**約束實例的 status 元素**，
//    與該 artifact 自身的 status 無關——本 repo 之 TWHA-Composition、TWHA-WorkExposure、
//    TWHA-Observation-ServiceFinding 等多支 profile 都有這一行。若放寬正則，
//    會把 profile 自身讀成 status = final，G-3b 全面誤判。
//    定義類只認 `^status`；Instance 類只認裸 `status`（Instance 沒有 `^` 形式）。
const statusRe = (kind) =>
  INSTANCE_KINDS.includes(kind) ? /^\*\s*status\s*=\s*#(\S+)/ : /^\*\s*\^status\s*=\s*#(\S+)/;

// ---------------------------------------------------------------- FSH 掃描
// 逐行狀態機：遇到 `<Kind>: name` 開新區塊，直到下一個宣告為止。
// Instance:／ConceptMap 之 Instance 等非定義型 artifact 不納入（開新區塊即結束前一個）。
function scanFsh(root) {
  const found = [];
  for (const d of FSH_DIRS) {
    const dir = path.join(root, d);
    if (!fs.existsSync(dir)) continue;
    for (const file of fs.readdirSync(dir).filter((f) => f.endsWith('.fsh'))) {
      const rel = path.join(d, file);
      const lines = fs.readFileSync(path.join(dir, file), 'utf8').split(/\r?\n/);
      let cur = null;
      // pending 者（Instance 尚未讀到 InstanceOf）不納入——它可能是範例實例。
      const close = () => { if (cur && !cur.pending) found.push(cur); cur = null; };
      lines.forEach((line, i) => {
        const decl = line.match(/^([A-Za-z]+):\s+(\S+)/);
        if (decl) {
          const kind = decl[1];
          if (KINDS.includes(kind) || /^(Instance|Logical|Resource|RuleSet|Invariant|Mapping|Alias)$/.test(kind)) {
            close();
            if (KINDS.includes(kind)) {
              cur = { kind, file: rel, line: i + 1, id: null, desc: null, statusCode: null, resStatus: null, inDesc: false };
            } else if (kind === 'Instance') {
              // Instance 之型別要到下一行 InstanceOf: 才知道，故先暫存；
              // 非 ConceptMap／NamingSystem 者於該行捨棄。Instance 無 `Id:`，
              // 宣告名即其 id。
              cur = { kind: 'Instance', file: rel, line: i + 1, id: decl[2], desc: null,
                      statusCode: null, resStatus: null, inDesc: false, pending: true };
            }
            return;
          }
          if (kind === 'InstanceOf' && cur && cur.pending) {
            if (INSTANCE_KINDS.includes(decl[2])) { cur.kind = decl[2]; cur.pending = false; }
            else cur = null;   // 範例實例等，不納入登記範圍
            return;
          }
        }
        if (!cur) return;

        // ⚠️ Description 可以是**跨行字串**（開頭 `"` 到數行後才閉合）。落在字串內部的
        //    `* ^status = ...` 只是描述文字，SUSHI **不會**當成規則。v0.6.0 首版把規則
        //    插進了 6 個跨行 Description 內部，產出之 StructureDefinition 既無
        //    standards-status、status 也仍是 active——而本閘門當時逐行掃描，看到那兩行
        //    就判定齊備，**綠燈放行**。錯的不只是注入腳本，更是這個閘門：
        //    它檢查的是「檔案裡有沒有這行字」，不是「SUSHI 會不會把它當成規則」。
        //    故此處追蹤字串狀態，字串內部之行一律略過。
        if (cur.inDesc) {
          if (/"\s*$/.test(line)) cur.inDesc = false;
          return;
        }
        const id = line.match(/^Id:\s+(\S+)/);
        if (id) { cur.id = id[1]; return; }
        const desc = line.match(/^Description:\s+"(.*)$/);
        if (desc && INSTANCE_KINDS.includes(cur.kind)) {
          // Instance 類：關鍵字不採（理由見下方 INSTANCE_KINDS 區塊）。
          // 仍須追蹤跨行狀態，否則字串內部的行會被誤讀為規則。
          if (!/"\s*$/.test(line.slice('Description:'.length).trim().slice(1))) cur.inDesc = true;
          return;
        }
        if (desc) {
          cur.desc = desc[1];
          // 同一行未閉合（結尾不是未跳脫之 `"`）即為跨行字串
          if (!/"\s*$/.test(line.slice('Description:'.length).trim().slice(1))) cur.inDesc = true;
          return;
        }
        // Instance 之描述亦可寫成 `* description = "..."`（或 """ 跨行）。
        // Appendix10-to-HazardType 只有這一種；NS-ReportIdentifier 兩種都有，
        // 而 SUSHI 以規則為準，故規則存在時覆蓋 Description: 關鍵字。
        // ⚠️ Instance 類**只認 `* description =`（元素賦值），不認 `Description:` 關鍵字。**
        //    實測依據：TWHealthCheckLaboratoryMap 只有 `Description:` 關鍵字而無
        //    `Usage: #definition`，SUSHI 遂將其視為**範例之 IG 層 metadata**，
        //    **不寫入 ConceptMap.description**——v0.7.0 發佈後線上實測該資源之
        //    description 與 title 皆為 null，標籤根本沒進產出，而本閘門當時讀原始碼
        //    的 Description: 就判定齊備、綠燈放行。
        //    這是 v0.6.1「規則被插進跨行 Description 內部」之同型錯誤：
        //    **閘門驗的是原始碼有沒有寫，不是產出會不會有**。故只採必定落地之元素賦值。
        if (INSTANCE_KINDS.includes(cur.kind)) {
          if (/^Description:/.test(line)) return;   // 關鍵字：Instance 類一律不採
          const dr = line.match(/^\*\s*description\s*=\s*("""|")(.*)$/);
          if (dr) {
            if (dr[1] === '"""') {
              cur.descRulePending = true;          // 內容自下一非空行起
              if (dr[2].trim()) { cur.desc = dr[2].trim(); cur.descRulePending = false; }
            } else {
              cur.desc = dr[2];
            }
            return;
          }
          if (cur.descRulePending) {
            if (line.trim()) { cur.desc = line.trim(); cur.descRulePending = false; }
            return;
          }
        }
        // 形式一（定義類）：`* ^extension[<canonical>].valueCode = #X`
        const st = line.match(/standards-status\]\.valueCode\s*=\s*#(\S+)/);
        if (st) { cur.statusCode = st[1]; return; }
        // 形式二（Instance）：`* extension[N].url = "…standards-status"` ＋
        //                     `* extension[N].valueCode = #X`
        // 之所以不對 Instance 用形式一：那要靠 SUSHI 以 canonical 解析 extension 定義，
        // 而本容器跑不了 SUSHI（proxy 封鎖 packages.fhir.org），無從先驗證它解不解得開。
        // indexed 形式是純粹的元素賦值，不依賴任何解析，故必定成立。
        const eu = line.match(/^\*\s*extension\[(\d+)\]\.url\s*=\s*"[^"]*standards-status"/);
        if (eu) { cur.ssIdx = eu[1]; return; }
        if (cur.ssIdx !== undefined) {
          const ev = line.match(/^\*\s*extension\[(\d+)\]\.valueCode\s*=\s*#(\S+)/);
          if (ev && ev[1] === cur.ssIdx) { cur.statusCode = ev[2]; return; }
        }
        // 資源自身之 status。standards-status = draft 時必須併同設定，
        // 否則 IG Publisher 會判為不一致——v0.5.0 實測命中 71 件。
        // ⚠️ 正則依宣告種類切換，理由見檔首 statusRe 之註解（profile 之 `* status = #final`
        //    是約束實例，不是 profile 自身的 status）。
        const rs = line.match(statusRe(cur.kind));
        if (rs) { cur.resStatus = rs[1]; }
      });
      close();
    }
  }
  return found;
}

// ------------------------------------------------------- G-1～G-3：標籤與層級
function checkArtifacts(root, map) {
  const violations = [];
  const arts = scanFsh(root);
  const seen = new Set();

  for (const a of arts) {
    const where = `${a.file}:${a.line}`;
    if (!a.id) { violations.push(`[G-1] ${where} ${a.kind} 缺 Id:，無法核對`); continue; }
    seen.add(a.id);
    const entry = map[a.id];
    if (!entry) {
      violations.push(`[G-1] ${where} ${a.id} 未登記於 governance-map.js——新增 artifact 必須先登記權責歸屬`);
      continue;
    }
    const [tagKey, level] = entry;
    const tag = TAGS[tagKey];
    if (a.desc === null) {
      violations.push(`[G-1] ${where} ${a.id} 無 Description`);
    } else if (!a.desc.startsWith(tag)) {
      violations.push(`[G-1] ${where} ${a.id} Description 起首非登記之標籤 ${tag}（實為「${a.desc.slice(0, 14)}…」）`);
    }
    const want = statusOf(level);
    if (want === null) {
      // level 0（共用技術結構）不標 standards-status：它不構成合規標的。
      if (a.statusCode !== null) {
        violations.push(`[G-3] ${where} ${a.id} 層級 ${level} 不得標 standards-status（實為 #${a.statusCode}）`);
      }
    } else if (a.statusCode === null) {
      violations.push(`[G-3] ${where} ${a.id} 缺 standards-status（應為 #${want}）`);
    } else if (a.statusCode !== want) {
      violations.push(`[G-3] ${where} ${a.id} standards-status 為 #${a.statusCode}，登記層級 ${level} 應為 #${want}`);
    }

    // G-3b：standards-status 與資源自身之 status 必須一致。
    // IG Publisher 交叉檢查兩者；v0.5.0 單標 standards-status 而未動 status，
    // 實測 71 件全部被判「not consistent」。故此處逐件強制，缺一即失敗。
    const wantRes = resourceStatusOf(level);
    if (wantRes !== null && a.resStatus !== wantRes) {
      violations.push(
        `[G-3b] ${where} ${a.id} standards-status = #${want} 需併同 ^status = #${wantRes}` +
        `（實為 ${a.resStatus === null ? '未設定，將繼承 sushi-config 之 active' : '#' + a.resStatus}）`);
    }
    if (wantRes === null && a.resStatus === 'draft' && want !== null) {
      violations.push(`[G-3b] ${where} ${a.id} standards-status = #${want} 與 ^status = #draft 不一致`);
    }
  }

  for (const id of Object.keys(map)) {
    if (!seen.has(id)) violations.push(`[G-2] governance-map.js 登記之 ${id} 在 FSH 中不存在（孤兒登記）`);
  }
  return { violations, count: arts.length };
}

// ------------------------------------------------------- G-4：越權表述掃描
// ⚠️ 機關別名務必逐一列出。初版寫成 `職(業安全衛生)?署`，只吃得下「職署」與
//    「職業安全衛生署」，**抓不到最常見的「職安署」**——即本規則要禁的那三個字本身。
//    自我測試案 ⑤ 直接以「治理：職安署」為輸入，故當場失敗。
const AGENCY = '(?:勞動部職業安全衛生署|職業安全衛生署|勞動部職安署|職安署|勞動部)';
const ASSERTIVE = [
  new RegExp(`治理\\s*[：:]\\s*${AGENCY}`),
  new RegExp(`${AGENCY}[^。\\n]{0,16}為本指引[^。\\n]{0,10}(?:主管|治理)機關`),
  new RegExp(`本指引[^。\\n]{0,10}(?:主管|治理)機關[^。\\n]{0,16}${AGENCY}`),
];
const NEGATORS = /(不得|未受|未參與|未委任|非受|並非|不是|無第二個|越權|更正|初稿|禁止|勿)/;
// 本檔自身之自我測試 fixture 就是一句刻意寫成的越權表述（案 ⑤ 的輸入），
// 掃描器不掃自己的測試資料——否則閘門永遠對自己失敗。
const SELF = 'scripts/check-governance-tags.js';
const SCAN_EXCLUDE = /(^|\/)(node_modules|\.git|output|temp|template|input\/assets)(\/|$)/;
const SCAN_EXT = /\.(md|fsh|yaml|yml|json|js)$/;

function walk(dir, out = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (SCAN_EXCLUDE.test(p)) continue;
    if (e.isDirectory()) walk(p, out);
    else if (SCAN_EXT.test(e.name)) out.push(p);
  }
  return out;
}

function checkOverreach(root) {
  const violations = [];
  const exempted = [];
  for (const p of walk(root)) {
    if (path.relative(root, p).split(path.sep).join('/') === SELF) continue;
    let lines;
    try { lines = fs.readFileSync(p, 'utf8').split(/\r?\n/); } catch { continue; }
    lines.forEach((l, i) => {
      if (!ASSERTIVE.some((re) => re.test(l))) return;
      const rec = `${path.relative(root, p)}:${i + 1}: ${l.trim().slice(0, 100)}`;
      if (NEGATORS.test(l)) exempted.push(rec);
      else violations.push(`[G-4] ${rec}`);
    });
  }
  return { violations, exempted };
}

// ---------------------------------------------------------------- G-5
// conformance.md §7.4 之**明文件數**必須等於自 MAP 算出來的數。
//
// 為什麼需要這道：G-1～G-3b 管的是每一件 artifact 的標籤與成熟度**規則**，
// 敘述頁上那幾個「26 件」「51 件」則是人手抄的**統計**，沒有任何東西在看。
// 實測後果：§7.4 之標籤件數自 v0.7.2（ConceptMap／NamingSystem 納入登記，101 → 104）
// 起即與登記表脫鉤，v0.9.0 再 +1 成 105，前後**跨四個版次無人察覺**，
// 直到有人回頭手數才發現。手數一次只能修這一次，修不掉「下次又會脫鉤」。
//
// ⚠️ 本閘門最關鍵之設計是**錨點失效等同失敗**。
//    若只寫「找到數字就比對」，日後有人改寫表格措辭使正則不再命中，
//    閘門會找不到任何數字而「通過」——那正是本 repo 一再踩到的靜默失效形態
//    （JOB-23 之位置錨點、i18n 之缺鍵、JOB-34 之走訪腳本）。
//    故：每一個錨點都**必須**命中，缺一即失敗，訊息明說是錨點失效而非數字不符。
const COUNT_DOC = 'input/pagecontent/conformance.md';

function docCountAnchors(want) {
  // 每一項：[錨點名稱, 正則, 期望值陣列（依 capture group 順序）]
  // 正則刻意綁在標籤字面上，不用相對位置——位置錨點正是 JOB-23 的教訓。
  return [
    ['§7.4 標籤表：國民健康署',
      /\|\s*`【主管機關：國民健康署】`\s*\|[^|]*\|\s*(\d+)\s*\|/, [want.hpa]],
    ['§7.4 標籤表：勞工健康保護規則附表',
      /\|\s*`【依據：勞工健康保護規則附表】`\s*\|[^|]*\|\s*(\d+)\s*\|/, [want.reg]],
    ['§7.4 標籤表：技術規格',
      /\|\s*`【技術規格】`\s*\|[^|]*\|\s*(\d+)\s*\|/, [want.tech]],
    ['§7.4 成熟度表：Level 1',
      /\*\*Level 1\*\*（(\d+) 件）/, [want.l1]],
    ['§7.4 成熟度表：Level 2',
      /\*\*Level 2\*\*（(\d+) 件）/, [want.l2]],
    ['§7.4 成熟度表：共用技術結構',
      /共用技術結構（(\d+) 件）/, [want.l0]],
    // 「現值」那一行是四個數字一起寫的摘要句。刻意綁 `現值` 二字，
    // 以免吃到同段落中「原記 24／50／27，合計 101」等**歷史值**——
    // 那些是沿革記載，必須留著，不得被閘門要求改成現值。
    ['§7.4 現值摘要句',
      /現值\s*\*\*(\d+)／(\d+)／(\d+)\s*＝\s*(\d+)\*\*/, [want.hpa, want.reg, want.tech, want.total]],
  ];
}

function checkDocCounts(root, map) {
  const violations = [];
  const byTag = {};
  const byLevel = {};
  for (const [, [t, l]] of Object.entries(map)) {
    byTag[t] = (byTag[t] || 0) + 1;
    byLevel[l] = (byLevel[l] || 0) + 1;
  }
  const want = {
    hpa: byTag.hpa || 0, reg: byTag.reg || 0, tech: byTag.tech || 0,
    l1: byLevel[1] || 0, l2: byLevel[2] || 0, l0: byLevel[0] || 0,
    total: Object.keys(map).length,
  };

  const file = path.join(root, COUNT_DOC);
  if (!fs.existsSync(file)) {
    violations.push(`[G-5] 找不到 ${COUNT_DOC}——無法比對明文件數。`);
    return { violations, want, checked: 0 };
  }
  const text = fs.readFileSync(file, 'utf8');

  let checked = 0;
  for (const [name, re, expect] of docCountAnchors(want)) {
    const m = text.match(re);
    if (!m) {
      violations.push(
        `[G-5] 錨點失效：${COUNT_DOC} 找不到「${name}」。` +
        `**這不是通過**——措辭若已改寫，請同步更新 scripts/check-governance-tags.js 之 docCountAnchors()。`);
      continue;
    }
    checked += 1;
    expect.forEach((exp, i) => {
      const got = Number(m[i + 1]);
      if (got !== exp) {
        violations.push(
          `[G-5] ${name}：文件寫 ${got}，登記表（governance-map.js）實為 ${exp}。` +
          `⚠️ 先確認是文件過期還是登記表漏登，不要反射性改文件數字。`);
      }
    });
  }
  return { violations, want, checked };
}

// ---------------------------------------------------------------- 負向自測
function selfTest() {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'govtag-'));
  const mk = (sub, name, body) => {
    fs.mkdirSync(path.join(tmp, sub), { recursive: true });
    fs.writeFileSync(path.join(tmp, sub, name), body);
  };
  // status 傳 null 代表不輸出 standards-status（level 0 之正確形態）。
  // resStatus 為資源自身之 ^status；standards-status = draft 者必須併同設定為 draft。
  const good = (id, tag, status, resStatus) =>
    `ValueSet: X\nId: ${id}\nTitle: "t"\nDescription: "${tag}測試值集。"\n` +
    (resStatus ? `* ^status = #${resStatus}\n` : '') +
    (status ? `* ^extension[${STANDARDS_STATUS_URL}].valueCode = #${status}\n` : '');
  const M = { 'VS-Ok': ['hpa', 1], 'VS-Bad': ['reg', 2] };

  const results = [];
  // ⚠️ 每一案「布置完就立刻判定」。初版把判定寫成 closure 存進陣列、最後才一起跑，
  //    結果六案全部看到最後一次布置的檔案——自我測試自己抓到自己這個 bug。
  const run = (name, fn) => {
    let ok = false;
    try { ok = fn(); } catch { ok = false; }
    results.push([name, ok]);
  };
  const reset = () => { fs.rmSync(tmp, { recursive: true, force: true }); fs.mkdirSync(tmp, { recursive: true }); };

  // ① 缺標籤 → 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') +
     `\nValueSet: Y\nId: VS-Bad\nTitle: "t"\nDescription: "沒有標籤。"\n` +
     `* ^extension[${STANDARDS_STATUS_URL}].valueCode = #draft\n`);
  run('① 缺權責標籤', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-1]')));

  // ② standards-status 與層級不符 → 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'draft') + good('VS-Bad', TAGS.reg, 'draft', 'draft'));
  run('② level 1 卻標 draft', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-3]')));

  // ②b level 0 之共用技術結構卻標了 standards-status → 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft', 'draft') +
     good('VS-Shared', TAGS.tech, 'draft', 'draft'));
  run('②b level 0 卻標 standards-status',
      () => checkArtifacts(tmp, { ...M, 'VS-Shared': ['tech', 0] }).violations.some((v) => /不得標 standards-status/.test(v)));

  // ②c standards-status = draft 但未併同設 ^status = draft → 必須被抓到。
  //    這正是 v0.5.0 之 71 件不一致的形態；當時是 IG Publisher 抓到、閘門沒抓到，
  //    故本輪把它變成閘門的責任。
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft', null));
  run('②c draft 未併同改 ^status', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-3b]')));

  // ②d ^status 設成 draft 但 standards-status 是 trial-use → 反向不一致亦須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use', 'draft') + good('VS-Bad', TAGS.reg, 'draft', 'draft'));
  run('②d ^status 與 standards-status 反向不一致', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-3b]')));

  // ③ 未登記之新 artifact → 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft', 'draft') +
     good('VS-Unregistered', TAGS.tech, null));
  run('③ 未登記之 artifact', () => checkArtifacts(tmp, M).violations.some((v) => /未登記/.test(v)));

  // ④ 孤兒登記（改名後舊 id 仍在表中）→ 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  run('④ 孤兒登記', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-2]')));

  // ⑤ 越權表述（肯定句）→ 必須被抓到
  reset();
  fs.writeFileSync(path.join(tmp, 'z.md'), '本節說明治理：職安署之權責分工。\n');
  run('⑤ 越權表述（肯定句）', () => checkOverreach(tmp).violations.length > 0);

  // ⑥ 否定句**不得**被誤判——否則規範文件無法寫出自己的禁令
  reset();
  fs.writeFileSync(path.join(tmp, 'z.md'), '⚠️ 不得出現「治理：職安署」之類字樣——本指引未受該署委任。\n');
  run('⑥ 否定句不誤判（正向對照）', () => {
    const r = checkOverreach(tmp);
    return r.violations.length === 0 && r.exempted.length === 1;
  });

  // ⑧ 規則被插進**跨行 Description 字串內部** → 必須被抓到。
  //    這正是 v0.6.0 首版之錯誤形態：檔案裡看得到 `* ^status = #draft`，
  //    但它在字串內，SUSHI 不當成規則，產出之資源仍是 active 且無 standards-status。
  //    舊版閘門逐行掃描而綠燈放行，是**閘門檢查了錯的東西**。
  reset();
  mk('valuesets', 'a.fsh',
     good('VS-Ok', TAGS.hpa, 'trial-use') +
     `ValueSet: Z\nId: VS-Bad\nTitle: "t"\nDescription: "${TAGS.reg}跨行描述之第一行，\n` +
     `* ^status = #draft\n` +
     `* ^extension[${STANDARDS_STATUS_URL}].valueCode = #draft\n` +
     `這一行才是描述的結尾。"\n`);
  run('⑧ 規則被插進跨行 Description 內部',
      () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-3')));

  // ⑧b 跨行 Description ＋ 規則正確置於字串閉合之後 → 不得誤報（正向對照）
  reset();
  mk('valuesets', 'a.fsh',
     good('VS-Ok', TAGS.hpa, 'trial-use') +
     `ValueSet: Z\nId: VS-Bad\nTitle: "t"\nDescription: "${TAGS.reg}跨行描述之第一行，\n` +
     `這一行才是描述的結尾。"\n` +
     `* ^status = #draft\n` +
     `* ^extension[${STANDARDS_STATUS_URL}].valueCode = #draft\n`);
  run('⑧b 跨行 Description ＋ 規則置於其後（正向對照）',
      () => checkArtifacts(tmp, M).violations.length === 0);

  // ⑨ 未登記之 ConceptMap 必須被抓到（JOB-31 §5(A) 之驗收條件）
  //    v0.6.2 以前 scanFsh 一律排除 Instance: 宣告者，此案在補強前**跑不過**——
  //    它證明的正是本輪新增的那段解析。
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  mk('codesystems', 'cm.fsh',
     'Instance: CM-Unregistered\nInstanceOf: ConceptMap\nUsage: #definition\n' +
     '* description = "未登記之對照表。"\n* status = #active\n');
  run('⑨ 未登記之 ConceptMap', () =>
    checkArtifacts(tmp, M).violations.some((v) => v.includes('CM-Unregistered') && v.startsWith('[G-1]')));

  // ⑨b 範例實例（InstanceOf 非 ConceptMap／NamingSystem）不得被誤納（正向對照）
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  mk('codesystems', 'ex.fsh',
     'Instance: obs-example\nInstanceOf: Observation\nUsage: #example\n* status = #final\n');
  run('⑨b 範例實例不誤納（正向對照）', () =>
    !checkArtifacts(tmp, M).violations.some((v) => v.includes('obs-example')));

  // ⑩ Instance 標 draft 卻未併同改 status → 必須抓到（indexed extension 形式之解析）
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  mk('codesystems', 'cm2.fsh',
     'Instance: CM-Reg\nInstanceOf: ConceptMap\nUsage: #definition\n' +
     '* description = "' + TAGS.reg + '對照表。"\n* status = #active\n' +
     '* extension[0].url = "' + STANDARDS_STATUS_URL + '"\n* extension[0].valueCode = #draft\n');
  run('⑩ ConceptMap 標 draft 未併同改 status', () =>
    checkArtifacts(tmp, { 'VS-Ok': ['hpa', 1], 'CM-Reg': ['reg', 2] })
      .violations.some((v) => v.startsWith('[G-3b]') && v.includes('CM-Reg')));

  // ⑪ profile 之 `* status = #final` 不得被誤讀為該 profile 自身之 status（正向對照）
  //    本輪最容易踩的坑：若把 status 正則統一放寬成 `\*\s*\^?status`，
  //    本 repo 多支 profile 的 `* status = #final` 會使 G-3b 全面誤判。
  reset();
  mk('profiles', 'p.fsh',
     'Profile: P-Ok\nParent: Observation\nId: P-Ok\nTitle: "t"\n' +
     'Description: "' + TAGS.reg + '測試 profile。"\n' +
     '* ^status = #draft\n* status = #final\n' +
     '* ^extension[' + STANDARDS_STATUS_URL + '].valueCode = #draft\n');
  run('⑪ profile 之 * status = #final 不誤讀（正向對照）', () =>
    !checkArtifacts(tmp, { 'P-Ok': ['reg', 2] }).violations.some((v) => v.startsWith('[G-3b]')));

  // ⑫ Instance 之標籤只寫在 `Description:` 關鍵字（無 `Usage: #definition`）→ 必須被抓到
  //    v0.7.0 實測：這種寫法 SUSHI 不會寫入資源之 description，標籤根本不進產出，
  //    而當時之閘門讀原始碼就判定齊備。此案即為該漏洞之回歸測試。
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  mk('codesystems', 'cm3.fsh',
     'Instance: CM-KeywordOnly\nInstanceOf: ConceptMap\n' +
     'Description: "' + TAGS.hpa + '只寫在關鍵字，不會進產出。"\n* status = #active\n' +
     '* extension[0].url = "' + STANDARDS_STATUS_URL + '"\n* extension[0].valueCode = #trial-use\n');
  run('⑫ Instance 標籤僅在 Description: 關鍵字', () =>
    checkArtifacts(tmp, { 'VS-Ok': ['hpa', 1], 'CM-KeywordOnly': ['hpa', 1] })
      .violations.some((v) => v.includes('CM-KeywordOnly') && v.startsWith('[G-1]')));

  // ⑫b 同一件改以 `* description =` 提供標籤 → 不得誤報（正向對照）
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use'));
  mk('codesystems', 'cm4.fsh',
     'Instance: CM-ElementDesc\nInstanceOf: ConceptMap\n' +
     'Description: "這行是 IG 層 metadata，不算數。"\n' +
     '* description = "' + TAGS.hpa + '會進產出。"\n* status = #active\n' +
     '* extension[0].url = "' + STANDARDS_STATUS_URL + '"\n* extension[0].valueCode = #trial-use\n');
  run('⑫b Instance 標籤在 * description（正向對照）', () =>
    checkArtifacts(tmp, { 'VS-Ok': ['hpa', 1], 'CM-ElementDesc': ['hpa', 1] })
      .violations.length === 0);

  // ⑦ 完整正例：全部登記齊備時不得誤報
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft', 'draft'));
  run('⑦ 齊備時不誤報（正向對照）', () => checkArtifacts(tmp, M).violations.length === 0);

  // ---- G-5：敘述頁明文件數 vs 登記表 ------------------------------------
  // fixture 之 MAP：hpa 2／reg 1／tech 1，Level 1 = 2、Level 2 = 1、Level 0 = 1，合計 4。
  const CM = { 'A': ['hpa', 1], 'B': ['hpa', 1], 'C': ['reg', 2], 'D': ['tech', 0] };
  const doc = (hpa, reg, tech, l1, l2, l0, cur) =>
    '### 7.4 artifact 之權責標籤與成熟度\n\n' +
    '| 標籤 | 意義 | 件數 |\n|:--|:--|--:|\n' +
    `| \`【主管機關：國民健康署】\` | x | ${hpa} |\n` +
    `| \`【依據：勞工健康保護規則附表】\` | x | ${reg} |\n` +
    `| \`【技術規格】\` | x | ${tech} |\n\n` +
    `> ⚠️ 沿革：原記 24／50／27，合計 101。現值 **${cur}**\n\n` +
    '| 層級 | `standards-status` | 資源之 `status` |\n|:--|:--|:--|\n' +
    `| **Level 1**（${l1} 件） | \`trial-use\` | \`active\` |\n` +
    `| **Level 2**（${l2} 件） | \`draft\` | **\`draft\`** |\n` +
    `| 共用技術結構（${l0} 件） | 不標 | \`active\` |\n`;
  const writeDoc = (body) => {
    fs.mkdirSync(path.join(tmp, 'input', 'pagecontent'), { recursive: true });
    fs.writeFileSync(path.join(tmp, COUNT_DOC), body);
  };

  // ⑬ 標籤表件數與登記表不符 → 必須被抓到（即 v0.7.2～v0.9.0 之實際形態）
  reset();
  writeDoc(doc(24, 1, 1, 2, 1, 1, '2／1／1 ＝ 4'));
  run('⑬ 標籤表件數過期', () =>
    checkDocCounts(tmp, CM).violations.some((v) => v.includes('國民健康署') && v.includes('登記表')));

  // ⑬b 成熟度表件數與登記表不符 → 必須被抓到。
  //     ⚠️ 這一案是**實戰抓出來的**：v0.9.0 手動更正時只改了標籤表，
  //     下方成熟度表的 24／50／27 原封不動留著。兩張表要分別看，不能只看一張。
  reset();
  writeDoc(doc(2, 1, 1, 24, 50, 27, '2／1／1 ＝ 4'));
  run('⑬b 成熟度表件數過期', () =>
    checkDocCounts(tmp, CM).violations.some((v) => v.includes('Level 1') && v.includes('登記表')));

  // ⑬c 現值摘要句與登記表不符 → 必須被抓到（含合計）
  reset();
  writeDoc(doc(2, 1, 1, 2, 1, 1, '2／1／1 ＝ 99'));
  run('⑬c 現值摘要句之合計過期', () =>
    checkDocCounts(tmp, CM).violations.some((v) => v.includes('現值摘要句')));

  // ⑬d **錨點失效必須等同失敗，不得靜默通過**——本閘門最重要的一案。
  //     若表格措辭被改寫使正則不再命中，閘門會一個數字都比不到；
  //     此時「沒有不符」絕不等於「通過」，那正是本 repo 一再踩到的靜默失效。
  reset();
  writeDoc('### 7.4 artifact 之權責標籤與成熟度\n\n（表格已被改寫成散文，正則全部落空）\n');
  run('⑬d 錨點失效判為失敗', () => {
    const r = checkDocCounts(tmp, CM);
    return r.checked === 0 && r.violations.length === 7 && r.violations.every((v) => v.includes('錨點失效'));
  });

  // ⑬e 文件不存在 → 失敗（而非當成沒東西可查）
  reset();
  run('⑬e 敘述頁不存在判為失敗', () =>
    checkDocCounts(tmp, CM).violations.some((v) => v.includes('找不到')));

  // ⑬f 全部相符 → 不得誤報（正向對照）
  reset();
  writeDoc(doc(2, 1, 1, 2, 1, 1, '2／1／1 ＝ 4'));
  run('⑬f 件數全部相符（正向對照）', () => {
    const r = checkDocCounts(tmp, CM);
    return r.violations.length === 0 && r.checked === 7;
  });

  // ⑬g 沿革句中的歷史值不得被誤判為現值（正向對照）。
  //     fixture 之沿革句刻意保留「原記 24／50／27，合計 101」——那是必須留存的
  //     版次沿革記載，閘門若連它一起要求改成現值，等於逼人竄改歷史。
  reset();
  writeDoc(doc(2, 1, 1, 2, 1, 1, '2／1／1 ＝ 4'));
  run('⑬g 沿革句之歷史值不誤判（正向對照）', () =>
    checkDocCounts(tmp, CM).violations.length === 0);

  let bad = 0;
  console.log('負向自我測試（負向案必須被抓到；標「正向對照」者必須不被抓到）：');
  for (const [name, ok] of results) {
    console.log(`  ${ok ? '✔' : '✖'} ${name}`);
    if (!ok) bad++;
  }
  fs.rmSync(tmp, { recursive: true, force: true });
  if (bad) { console.error(`\n✖ 自我測試失敗 ${bad} 項——閘門本身有問題，實檢結果不可信。`); process.exit(1); }
  console.log('✔ 自我測試全數通過。\n');
}

// ---------------------------------------------------------------- main
function main() {
  const root = path.resolve(__dirname, '..');
  if (process.argv.includes('--self-test')) { selfTest(); return; }

  const a = checkArtifacts(path.join(root, 'input', 'fsh'), MAP);
  const o = checkOverreach(root);
  const d = checkDocCounts(root, MAP);

  const byTag = {};
  const byLevel = {};
  for (const [id, [t, l]] of Object.entries(MAP)) {
    byTag[t] = (byTag[t] || 0) + 1;
    byLevel[l] = (byLevel[l] || 0) + 1;
    void id;
  }
  console.log(`權責標籤閘門：掃描 ${a.count} 個定義型 artifact，登記 ${Object.keys(MAP).length} 筆`);
  console.log(`  標籤分佈　國健署 ${byTag.hpa || 0}／勞工健康保護規則附表 ${byTag.reg || 0}／技術規格 ${byTag.tech || 0}`);
  console.log(`  層級分佈　Level 1 ${byLevel[1] || 0}（standards-status = trial-use，status 維持 active）／` +
              `Level 2 ${byLevel[2] || 0}（standards-status = draft ＋ ^status = draft，兩者由 G-3b 強制一致）／` +
              `共用技術結構 ${byLevel[0] || 0}（不標 standards-status）`);
  if (o.exempted.length) {
    console.log(`  G-4 否定句豁免 ${o.exempted.length} 行（逐行列出，抑制不得靜默）：`);
    o.exempted.forEach((e) => console.log(`    - ${e}`));
  }

  console.log(`  G-5 敘述頁件數　${COUNT_DOC} 比中 ${d.checked}／7 個錨點` +
              `（國健署 ${d.want.hpa}／附表 ${d.want.reg}／技術 ${d.want.tech}，` +
              `Level 1 ${d.want.l1}／Level 2 ${d.want.l2}／共用 ${d.want.l0}，合計 ${d.want.total}）`);

  const all = [...a.violations, ...o.violations, ...d.violations];
  if (all.length) {
    console.error(`\n✖ 權責標籤閘門失敗，共 ${all.length} 筆：`);
    all.forEach((v) => console.error('  ' + v));
    process.exit(1);
  }
  console.log('\n✔ 權責標籤與合規層級一致，敘述頁明文件數與登記表相符，' +
              '且無把職安署寫成本指引治理／主管機關之表述。');
}

main();
