#!/usr/bin/env node
// Scans input/pagecontent/*.md for VS_*/CS_*/ext-*/TWHA-* tokens and verifies each
// resolves to a definition somewhere under input/fsh/. Prevents pagecontent from
// drifting out of sync with the FSH source (see develop.md §1.1, §3.4).
//
// Backlog-annotated references
// ----------------------------
// The IG deliberately names artifacts that do not exist yet, always annotated inline
// (e.g. "（列為 backlog：`VS-Appendix9-RequiredSet`）"). Those are intentional, not drift,
// so they are reported separately and do NOT fail the run. Previously they were reported
// as errors, which meant this script always exited 1 and could not be used as a gate.
//
// Markdown link targets
// ---------------------
// Also rejects two link forms that break the build or silently 404 in the published site:
//   ](../...)   escapes the output root. IG Publisher's HTMLInspector throws a hard
//               RuntimeException ("Computed path does not start with first element") and
//               aborts the whole build — it is not downgraded to a broken-link warning.
//               Cost of learning this the hard way: a full ~5 minute CI round (run 30540241236).
//   ](*.md)     repo-relative markdown target. Only *.md under input/pagecontent/ is rendered
//               (as .html); anything else (e.g. docs/optimization/JOB-nn.md) is never published.
// Link to unpublished repo files with an absolute GitHub blob URL instead — the convention
// already used for JOB-01/08/10/14 references.
//
// Usage:
//   node scripts/check-pagecontent-refs.js            # fail only on genuine drift (CI default)
//   node scripts/check-pagecontent-refs.js --strict    # also fail on backlog-annotated refs
//                                                     # (release gate: proves backlog is cleared)
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const pagecontentDir = path.join(repoRoot, 'input', 'pagecontent');
const fshDir = path.join(repoRoot, 'input', 'fsh');
const strict = process.argv.includes('--strict');

function walk(dir, exts) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full, exts));
    else if (exts.some((e) => entry.name.endsWith(e))) out.push(full);
  }
  return out;
}

const fshFiles = walk(fshDir, ['.fsh']);
const fshText = fshFiles.map((f) => fs.readFileSync(f, 'utf8')).join('\n');

// Token patterns used throughout pagecontent to reference FSH artifacts.
const tokenPattern = /\b(VS[_-][A-Za-z0-9-]+|CS[_-][A-Za-z0-9-]+|ext-[A-Za-z0-9-]+|TWHA-[A-Za-z0-9-]+)\b/g;

// A token resolves if it appears as an Id:, Alias:, or extension name anywhere in the FSH source
// (accepting both underscore alias form and hyphenated Id form).
function resolves(token) {
  const hyphenForm = token.replace(/_/g, '-');
  const underscoreForm = token.replace(/-/g, '_');
  return (
    fshText.includes(`Id: ${hyphenForm}`) ||
    fshText.includes(`Alias: ${underscoreForm}`) ||
    fshText.includes(`Alias: ${token}`) ||
    fshText.includes(`named ${hyphenForm}`) ||
    fshText.includes(hyphenForm) // last-resort substring match (e.g. named extension slices, profile refs)
  );
}

// Conceptual/prose tokens that intentionally have no FSH artifact (e.g. named exchange
// package concepts referenced in narrative text, not actual Profiles/ValueSets/CodeSystems).
const ALLOWLIST = new Set(['TWHA-EP']);

// An occurrence is "backlog-annotated" when its own line says so. Keep this list narrow:
// a vague hedge elsewhere on the page must not excuse a genuinely broken reference.
const BACKLOG_MARKERS = /backlog|尚未以值集|尚未定義|尚未以\s*extension|不以\s*extension/i;

const mdFiles = walk(pagecontentDir, ['.md']);
const drift = [];
const backlog = [];

for (const file of mdFiles) {
  const rel = path.relative(repoRoot, file);
  const text = fs.readFileSync(file, 'utf8');
  const lines = text.split(/\r?\n/);
  // token -> { annotated: [lineNo], plain: [lineNo] }
  const found = new Map();

  lines.forEach((line, i) => {
    const annotated = BACKLOG_MARKERS.test(line);
    let m;
    tokenPattern.lastIndex = 0;
    while ((m = tokenPattern.exec(line))) {
      const token = m[1];
      if (ALLOWLIST.has(token) || resolves(token)) continue;
      if (!found.has(token)) found.set(token, { annotated: [], plain: [] });
      found.get(token)[annotated ? 'annotated' : 'plain'].push(i + 1);
    }
  });

  for (const [token, hits] of found) {
    if (hits.plain.length) drift.push({ file: rel, token, lines: hits.plain });
    else backlog.push({ file: rel, token, lines: hits.annotated });
  }
}

// ---- markdown link-target check（見檔頭「Markdown link targets」）--------------
const badLinks = [];
for (const file of mdFiles) {
  const rel = path.relative(repoRoot, file).split(path.sep).join('/');
  const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
  lines.forEach((line, i) => {
    for (const m of line.matchAll(/\]\(([^)\s]+)/g)) {
      const target = m[1];
      if (/^(https?:|mailto:|#)/.test(target)) continue;           // 絕對網址／頁內錨點：放行
      if (target.startsWith('../')) badLinks.push({ rel, n: i + 1, target, why: '相對路徑逸出輸出根目錄（IG Publisher 會擲例外中止建置）' });
      else if (/\.md([#?]|$)/.test(target)) badLinks.push({ rel, n: i + 1, target, why: '指向 .md（僅 pagecontent 之 .md 會渲染為 .html，其餘不隨網站發佈）' });
    }
  });
}
if (badLinks.length) {
  console.error('Invalid markdown link targets in pagecontent:');
  for (const b of badLinks) console.error(`  ${b.rel}:${b.n}: ](${b.target}  ← ${b.why}`);
  console.error('  改用絕對 GitHub blob URL（如 https://github.com/kunjulin/occupationIG/blob/main/docs/...），或改為純文字。');
  process.exit(1);
}

if (backlog.length) {
  const label = strict ? 'FAIL (--strict)' : 'NOTE';
  console.log(`${label}: backlog-annotated references (artifact not defined yet, annotated inline):`);
  for (const { file, token, lines } of backlog) {
    console.log(`  ${file}:${lines.join(',')}: ${token}`);
  }
  console.log('');
}

if (drift.length) {
  console.error('Unresolved pagecontent references (no matching FSH definition, and not annotated as backlog):');
  for (const { file, token, lines } of drift) {
    console.error(`  ${file}:${lines.join(',')}: ${token}`);
  }
  process.exit(1);
}

console.log(
  `OK: all tokens in ${mdFiles.length} pagecontent file(s) resolve to FSH definitions，且連結目標合法` +
    (backlog.length ? ` (${backlog.length} backlog-annotated reference(s) tolerated).` : '.')
);

if (strict && backlog.length) process.exit(1);
