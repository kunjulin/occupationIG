#!/usr/bin/env node
// 產生 input/assets/fsh-source.zip —— downloads.md 對外提供之「FSH 原始檔」封包。
//
// 為什麼需要這支腳本：
// 原本的 fsh-source.zip 是**手工打包的快照**（檔內時間戳為 2026-07-10，路徑分隔符為
// Windows 的反斜線），且被 .gitignore 以 `!input/assets/fsh-source.zip` 特別排除在
// `*.zip` 忽略規則之外而提交進版控。手工快照必然會落後——實測該檔仍含舊版 examples.fsh，
// 不含 NamingSystem（JOB-06）、亦不含 TWCR_SF stub 治理（JOB-10）。
// 也就是說，網站上宣稱「可直接以 SUSHI 重新編譯」的那份原始碼，重編出來的不是網站上這份 IG。
//
// 改為每次建置前重新產生，封包內容即恆等於當次建置的輸入。
//
// 收錄範圍＝SUSHI 的實際輸入：input/fsh/ 全部、sushi-config.yaml、ig.ini。
// 刻意不含 input/pagecontent（那是敘述文字，非 FSH）與 input/ignoreWarnings.txt
// （那是建置組態，不影響 SUSHI 產物）。
//
// Usage: node scripts/build-fsh-source-zip.js [--out <path>] [--check]
//   --check  只比對現有封包是否與當前原始碼一致，不寫檔（供 CI 判斷是否忘了重建）
'use strict';

const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const repoRoot = path.resolve(__dirname, '..');
const argv = process.argv.slice(2);
const outArg = argv.indexOf('--out');
const outPath = outArg !== -1 && argv[outArg + 1]
  ? path.resolve(argv[outArg + 1])
  : path.join(repoRoot, 'input', 'assets', 'fsh-source.zip');
const checkOnly = argv.includes('--check');

// 收錄清單。相對於 repo 根目錄，封包內亦使用相同的相對路徑（正斜線）。
function collect(dir, acc = []) {
  for (const name of fs.readdirSync(dir).sort()) {
    const full = path.join(dir, name);
    const st = fs.statSync(full);
    if (st.isDirectory()) collect(full, acc);
    else if (name.endsWith('.fsh')) acc.push(path.relative(repoRoot, full));
  }
  return acc;
}

const entries = [
  ...collect(path.join(repoRoot, 'input', 'fsh')),
  'sushi-config.yaml',
  'ig.ini',
].map((p) => p.split(path.sep).join('/'));

const missing = entries.filter((e) => !fs.existsSync(path.join(repoRoot, e)));
if (missing.length) {
  console.error(`✖ 缺少應收錄之檔案：${missing.join(', ')}`);
  process.exit(1);
}

// zip 需要可重現：固定時間戳，否則每次建置產生的封包位元組都不同，
// --check 會永遠不一致，git 也會出現無意義的變動。
// 以 sushi-config.yaml 的內容決定不了時間，故一律用固定值。
const FIXED_MTIME = new Date('2020-01-01T00:00:00Z');

function build(target) {
  fs.rmSync(target, { force: true });
  const stamped = entries.map((e) => path.join(repoRoot, e));
  const originals = stamped.map((f) => fs.statSync(f));
  for (const f of stamped) fs.utimesSync(f, FIXED_MTIME, FIXED_MTIME);
  try {
    // -X 去除額外屬性（uid/gid 等），使同一份輸入在不同機器產生相同封包
    execFileSync('zip', ['-qX', target, ...entries], { cwd: repoRoot });
  } finally {
    stamped.forEach((f, i) => fs.utimesSync(f, originals[i].atime, originals[i].mtime));
  }
}

if (checkOnly) {
  if (!fs.existsSync(outPath)) {
    console.error(`✖ 找不到 ${path.relative(repoRoot, outPath)}——請執行 npm run build:assets`);
    process.exit(1);
  }
  const tmp = `${outPath}.check`;
  build(tmp);
  const same = Buffer.compare(fs.readFileSync(outPath), fs.readFileSync(tmp)) === 0;
  fs.rmSync(tmp, { force: true });
  if (!same) {
    console.error('✖ fsh-source.zip 與當前 FSH 原始碼不一致——請執行 npm run build:assets 後提交。');
    process.exit(1);
  }
  console.log(`OK: fsh-source.zip 與 ${entries.length} 個原始檔一致。`);
} else {
  build(outPath);
  const size = fs.statSync(outPath).size;
  console.log(`已產生 ${path.relative(repoRoot, outPath)}（${entries.length} 個檔案，${size} bytes）。`);
}
