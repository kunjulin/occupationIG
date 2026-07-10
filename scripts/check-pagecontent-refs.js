#!/usr/bin/env node
// Scans input/pagecontent/*.md for VS_*/CS_*/ext-*/TWHA-* tokens and verifies each
// resolves to a definition somewhere under input/fsh/. Prevents pagecontent from
// drifting out of sync with the FSH source (see develop.md §1.1, §3.4).
'use strict';

const fs = require('fs');
const path = require('path');

const repoRoot = path.resolve(__dirname, '..');
const pagecontentDir = path.join(repoRoot, 'input', 'pagecontent');
const fshDir = path.join(repoRoot, 'input', 'fsh');

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

const mdFiles = walk(pagecontentDir, ['.md']);
const unresolved = [];

for (const file of mdFiles) {
  const text = fs.readFileSync(file, 'utf8');
  const seen = new Set();
  let m;
  while ((m = tokenPattern.exec(text))) {
    const token = m[1];
    if (seen.has(token) || ALLOWLIST.has(token)) continue;
    seen.add(token);
    if (!resolves(token)) {
      unresolved.push({ file: path.relative(repoRoot, file), token });
    }
  }
}

if (unresolved.length) {
  console.error('Unresolved pagecontent references (no matching FSH definition found):');
  for (const { file, token } of unresolved) {
    console.error(`  ${file}: ${token}`);
  }
  process.exit(1);
} else {
  console.log(`OK: all tokens in ${mdFiles.length} pagecontent file(s) resolve to FSH definitions.`);
}
