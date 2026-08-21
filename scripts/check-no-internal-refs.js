#!/usr/bin/env node
'use strict';
// ============================================================================
// 對外產出之內部工作痕跡閘門（JOB-33 步驟 1）
// ============================================================================
//
// 對外試用版不應出現本團隊的內部工作編號與開發過程敘述——`JOB-19 §5`、
// 「初稿誤寫」這類字樣對試用單位是純噪音，且會讓人以為那是可查閱的公開文件。
//
// 掃描範圍（**只掃會進入產出者**）：
//   1. input/pagecontent/*.md              —— 整份渲染成頁面
//   2. input/fsh/**.fsh 之**字串內容**      —— Description／Title／概念定義等
//
// ⚠️ **FSH 之 `//` 註解一律不掃**（行首與行尾皆然）：註解不進產出，且是維護資訊。
//    判定方式為「找不在引號內的 `//`」——不能只排除行首，本 repo 之
//    VS-ExtendedDataset.fsh 有大量**行尾**註解記載換碼理由，那些必須保留。
//
// ⚠️ **docs/ 與 README.md 不在掃描範圍**：那是內部文件，JOB 編號正是其索引。
//
// ⚠️ 為何 FSH 之 Description 特別要緊：它會渲染進 `.html`／`.json`／`.xml`／`.ttl`
//    四種變體，再乘上根層與 zh-TW 兩層——**一處未清即擴散八處**。
//
// 用法：
//   node scripts/check-no-internal-refs.js              實檢
//   node scripts/check-no-internal-refs.js --self-test  負向自我測試（先跑這個）

const fs = require('fs');
const path = require('path');
const os = require('os');

// 命中即失敗之樣態。說明欄會印在違規訊息裡，讓人知道該怎麼改。
const PATTERNS = [
  { re: /JOB-\d+/g, why: '內部工作編號；需要溯源請改寫為「本指引 v0.x 之修訂」' },
  { re: /§[A-Z]\.?\d+[a-z]?/g, why: '內部節號（JOB 文件之節次），對外讀者無從解讀' },
  { re: /初稿/g, why: '開發過程敘述' },
  { re: /本評估/g, why: '開發過程敘述' },
  // ⚠️ 只禁「已於 v… 更正／修正」這類**開發過程敘述**，不禁「已於 v… 發佈」這類
  //    **版次事實陳述**——後者對實作端是有用的相容性資訊（例如「該碼已於 v0.4.0
  //    發佈，改名屬破壞性變更」）。且規格指定之替代寫法「本指引 v0.x 之修訂」
  //    本身就含 v0.x，樣態訂太寬會咬到自己開的處方。
  { re: /已於 v[\d.]+\s*(?:更正|修正|改正|誤植|誤寫)/g, why: '開發過程敘述；改寫為規範性陳述或逕行刪除' },
  { re: /該推論不成立/g, why: '開發過程敘述' },
  { re: /一次性(統計|診斷)/g, why: 'CI 一次性診斷之殘留說明' },
  { re: /施作方/g, why: '內部角色稱謂' },
];

// 找出不在引號內的 `//`，回傳其索引；無則 null。
function commentStart(line) {
  let inQuote = false;
  for (let i = 0; i < line.length - 1; i++) {
    const c = line[i];
    if (c === '"') inQuote = !inQuote;
    else if (c === '/' && line[i + 1] === '/' && !inQuote) return i;
  }
  return null;
}

function scanMarkdown(root) {
  const dir = path.join(root, 'input', 'pagecontent');
  const out = [];
  if (!fs.existsSync(dir)) return out;
  for (const f of fs.readdirSync(dir).filter((x) => x.endsWith('.md'))) {
    const rel = `input/pagecontent/${f}`;
    fs.readFileSync(path.join(dir, f), 'utf8').split(/\r?\n/).forEach((line, i) => {
      for (const p of PATTERNS) {
        for (const m of line.matchAll(p.re)) {
          out.push({ file: rel, line: i + 1, hit: m[0], why: p.why, text: line.trim().slice(0, 80) });
        }
      }
    });
  }
  return out;
}

function scanFsh(root) {
  const base = path.join(root, 'input', 'fsh');
  const out = [];
  if (!fs.existsSync(base)) return out;
  const walk = (d) => {
    for (const e of fs.readdirSync(d, { withFileTypes: true })) {
      const p = path.join(d, e.name);
      if (e.isDirectory()) walk(p);
      else if (e.name.endsWith('.fsh')) {
        const rel = path.relative(root, p).split(path.sep).join('/');
        fs.readFileSync(p, 'utf8').split(/\r?\n/).forEach((line, i) => {
          const cs = commentStart(line);
          for (const pat of PATTERNS) {
            for (const m of line.matchAll(pat.re)) {
              if (cs !== null && m.index >= cs) continue;   // 註解內：保留
              out.push({ file: rel, line: i + 1, hit: m[0], why: pat.why, text: line.trim().slice(0, 80) });
            }
          }
        });
      }
    }
  };
  walk(base);
  return out;
}

function check(root) {
  return [...scanMarkdown(root), ...scanFsh(root)];
}

// ---------------------------------------------------------------- 負向自測
function selfTest() {
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'nointref-'));
  const mk = (sub, name, body) => {
    fs.mkdirSync(path.join(tmp, sub), { recursive: true });
    fs.writeFileSync(path.join(tmp, sub, name), body);
  };
  const reset = () => { fs.rmSync(tmp, { recursive: true, force: true }); fs.mkdirSync(tmp, { recursive: true }); };
  const results = [];
  const run = (name, fn) => { let ok = false; try { ok = fn(); } catch { ok = false; } results.push([name, ok]); };

  // ① pagecontent 之 JOB 編號 → 必須被抓到
  reset();
  mk('input/pagecontent', 'a.md', '本節之處置見 JOB-29 附錄 B.3。\n');
  run('① pagecontent 之 JOB 編號', () => check(tmp).some((v) => v.hit === 'JOB-29'));

  // ② FSH 之 Description 內 JOB 編號 → 必須被抓到（會擴散至四種渲染變體）
  reset();
  mk('input/fsh/valuesets', 'a.fsh', 'ValueSet: VS-X\nDescription: "測試值集（JOB-01 批 3）。"\n');
  run('② FSH Description 內之 JOB 編號', () => check(tmp).some((v) => v.hit === 'JOB-01'));

  // ③ FSH 之概念定義字串內 JOB 編號 → 必須被抓到
  //    這類不是 Description: 關鍵字，而是 `* #code "display" "definition"` 的第三段，
  //    同樣會進產出——只掃 Description 會漏掉。
  reset();
  mk('input/fsh/codesystems', 'a.fsh', 'CodeSystem: CS-X\n* #c "顯示" "定義文字（JOB-22）。"\n');
  run('③ FSH 概念定義字串內之 JOB 編號', () => check(tmp).some((v) => v.hit === 'JOB-22'));

  // ④ 開發過程敘述 → 必須被抓到
  reset();
  mk('input/pagecontent', 'a.md', '本頁初稿誤植，已於 v0.5 更正。\n');
  run('④ 開發過程敘述（初稿／已於 v）', () => {
    const h = check(tmp).map((v) => v.hit);
    return h.includes('初稿') && h.some((x) => /已於 v/.test(x));
  });

  // ⑤ 內部節號 → 必須被抓到
  reset();
  mk('input/pagecontent', 'a.md', '詳見 §A.5 之說明。\n');
  run('⑤ 內部節號', () => check(tmp).some((v) => v.hit === '§A.5'));

  // ⑤b 「已於 v… 發佈」為版次事實陳述 → 不得被抓到（正向對照）
  //     若把樣態訂成 `已於 v\d` 會誤殺此類相容性說明，連帶咬到規格指定之
  //     替代寫法「本指引 v0.x 之修訂」。
  reset();
  mk('input/pagecontent', 'a.md', '該代碼已於 v0.4.0 發佈，改名屬破壞性變更。\n');
  run('⑤b 版次事實陳述不誤報（正向對照）', () => check(tmp).length === 0);

  // ⑥ FSH 之**行尾** // 註解內的 JOB 編號 → 不得被抓到（正向對照）
  //    本 repo 之 VS-ExtendedDataset.fsh 有大量行尾註解記載換碼理由，
  //    若只排除行首註解，這些會被誤報而逼人刪掉維護資訊。
  reset();
  mk('input/fsh/valuesets', 'a.fsh', 'ValueSet: VS-X\n* LNC#1-2 "X"  // 2026-07-29 JOB-01 批3：官方為莫耳\n');
  run('⑥ 行尾註解不誤報（正向對照）', () => check(tmp).length === 0);

  // ⑦ FSH 之行首 // 註解 → 不得被抓到（正向對照）
  reset();
  mk('input/fsh/profiles', 'a.fsh', '// 本 Profile 之理由見 JOB-29 §2.1\nProfile: P\n');
  run('⑦ 行首註解不誤報（正向對照）', () => check(tmp).length === 0);

  // ⑧ 乾淨內容 → 不得誤報（正向對照）
  reset();
  mk('input/pagecontent', 'a.md', '本指引 v0.4.0 之修訂已將此欄位改以 component 承載。\n');
  mk('input/fsh/valuesets', 'a.fsh', 'ValueSet: VS-X\nDescription: "乾淨的描述。"\n');
  run('⑧ 乾淨內容不誤報（正向對照）', () => check(tmp).length === 0);

  console.log('負向自我測試（負向案必須被抓到；標「正向對照」者必須不被抓到）：');
  let bad = 0;
  for (const [name, ok] of results) { console.log(`  ${ok ? '✔' : '✖'} ${name}`); if (!ok) bad++; }
  fs.rmSync(tmp, { recursive: true, force: true });
  if (bad) { console.error(`✖ 自我測試失敗 ${bad} 項——閘門本身有問題，實檢結果不可信。`); process.exit(1); }
  console.log('✔ 自我測試全數通過。');
}

// ------------------------------------------------------------------ 進入點
if (process.argv.includes('--self-test')) { selfTest(); process.exit(0); }

const root = process.cwd();
const hits = check(root);
const md = hits.filter((h) => h.file.startsWith('input/pagecontent'));
const fsh = hits.filter((h) => !h.file.startsWith('input/pagecontent'));
console.log(`內部工作痕跡閘門：pagecontent ${md.length} 處、FSH 字串 ${fsh.length} 處`);
if (hits.length) {
  console.error(`✖ 對外產出含內部工作痕跡，共 ${hits.length} 處：`);
  const byFile = new Map();
  for (const h of hits) { if (!byFile.has(h.file)) byFile.set(h.file, []); byFile.get(h.file).push(h); }
  for (const [f, v] of [...byFile].sort()) {
    console.error(`  ${f}（${v.length} 處）`);
    for (const h of v.slice(0, 8)) console.error(`      L${h.line}  ${h.hit}  ——${h.why}\n          ${h.text}`);
    if (v.length > 8) console.error(`      …另 ${v.length - 8} 處`);
  }
  console.error('\nFSH 之 // 註解（行首與行尾）不在此限，可保留。docs/ 與 README.md 亦不在此限。');
  process.exit(1);
}
console.log('✔ 對外產出無內部工作編號與開發過程敘述。');
