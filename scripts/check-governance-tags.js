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
//   G-3  standards-status extension 與登記之合規層級一致（level 1 → trial-use，餘 draft）。
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
const { TAGS, MAP, STANDARDS_STATUS_URL, statusOf } = require('./governance-map');

const FSH_DIRS = ['profiles', 'extensions', 'valuesets', 'codesystems'];
const KINDS = ['Profile', 'Extension', 'ValueSet', 'CodeSystem'];

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
      const close = () => { if (cur) found.push(cur); cur = null; };
      lines.forEach((line, i) => {
        const decl = line.match(/^([A-Za-z]+):\s+(\S+)/);
        if (decl) {
          const kind = decl[1];
          if (KINDS.includes(kind) || /^(Instance|Logical|Resource|RuleSet|Invariant|Mapping|Alias)$/.test(kind)) {
            close();
            if (KINDS.includes(kind)) {
              cur = { kind, file: rel, line: i + 1, id: null, desc: null, statusCode: null };
            }
            return;
          }
        }
        if (!cur) return;
        const id = line.match(/^Id:\s+(\S+)/);
        if (id) { cur.id = id[1]; return; }
        const desc = line.match(/^Description:\s+"(.*)$/);
        if (desc) { cur.desc = desc[1]; return; }
        const st = line.match(/standards-status\]\.valueCode\s*=\s*#(\S+)/);
        if (st) { cur.statusCode = st[1]; }
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
    if (a.statusCode === null) {
      violations.push(`[G-3] ${where} ${a.id} 缺 standards-status（應為 #${want}）`);
    } else if (a.statusCode !== want) {
      violations.push(`[G-3] ${where} ${a.id} standards-status 為 #${a.statusCode}，登記層級 ${level} 應為 #${want}`);
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

// ---------------------------------------------------------------- 負向自測
function selfTest() {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'govtag-'));
  const mk = (sub, name, body) => {
    fs.mkdirSync(path.join(tmp, sub), { recursive: true });
    fs.writeFileSync(path.join(tmp, sub, name), body);
  };
  const good = (id, tag, status) =>
    `ValueSet: X\nId: ${id}\nTitle: "t"\nDescription: "${tag}測試值集。"\n` +
    `* ^extension[${STANDARDS_STATUS_URL}].valueCode = #${status}\n`;
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
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'draft') + good('VS-Bad', TAGS.reg, 'draft'));
  run('② level 1 卻標 draft', () => checkArtifacts(tmp, M).violations.some((v) => v.startsWith('[G-3]')));

  // ③ 未登記之新 artifact → 必須被抓到
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft') +
     good('VS-Unregistered', TAGS.tech, 'draft'));
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

  // ⑦ 完整正例：全部登記齊備時不得誤報
  reset();
  mk('valuesets', 'a.fsh', good('VS-Ok', TAGS.hpa, 'trial-use') + good('VS-Bad', TAGS.reg, 'draft'));
  run('⑦ 齊備時不誤報（正向對照）', () => checkArtifacts(tmp, M).violations.length === 0);

  let bad = 0;
  console.log('負向自我測試（①～⑤ 必須被抓到；⑥⑦ 為正向對照，必須不被抓到）：');
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

  const byTag = {};
  const byLevel = {};
  for (const [id, [t, l]] of Object.entries(MAP)) {
    byTag[t] = (byTag[t] || 0) + 1;
    byLevel[l] = (byLevel[l] || 0) + 1;
    void id;
  }
  console.log(`權責標籤閘門：掃描 ${a.count} 個定義型 artifact，登記 ${Object.keys(MAP).length} 筆`);
  console.log(`  標籤分佈　國健署 ${byTag.hpa || 0}／勞工健康保護規則附表 ${byTag.reg || 0}／技術規格 ${byTag.tech || 0}`);
  console.log(`  層級分佈　Level 1 ${byLevel[1] || 0}（standards-status = trial-use）／` +
              `Level 2 ${byLevel[2] || 0}／共用技術結構 ${byLevel[0] || 0}（draft）`);
  if (o.exempted.length) {
    console.log(`  G-4 否定句豁免 ${o.exempted.length} 行（逐行列出，抑制不得靜默）：`);
    o.exempted.forEach((e) => console.log(`    - ${e}`));
  }

  const all = [...a.violations, ...o.violations];
  if (all.length) {
    console.error(`\n✖ 權責標籤閘門失敗，共 ${all.length} 筆：`);
    all.forEach((v) => console.error('  ' + v));
    process.exit(1);
  }
  console.log('\n✔ 權責標籤與合規層級一致，且無把職安署寫成本指引治理／主管機關之表述。');
}

main();
