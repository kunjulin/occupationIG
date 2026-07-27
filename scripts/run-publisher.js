#!/usr/bin/env node
// 跨平台 IG Publisher 執行器。取代 _genonce*.bat 之 Windows 專用部分，使 Linux/macOS
// 與 CI 能以同一路徑建置（.bat 仍保留供 Windows 使用者直接雙擊）。
//
// 與 .bat 的差異（皆為 JOB-08 之可重現性要求）：
//   1. publisher.jar 版本可釘定（預設 PINNED_VERSION），而非一律抓 latest；
//   2. 執行輸出同時寫入日誌檔，供 scripts/qa-gate.js 做獨立的 tx 連線檢查
//      （日誌不受 input/ignoreWarnings.txt 抑制，比 qa.txt 可靠）。
//
// Usage:
//   node scripts/run-publisher.js --tx https://tx.fhir.org/r4
//   node scripts/run-publisher.js --tx n/a              # 離線；不得作為送審依據
//   node scripts/run-publisher.js --publisher-version 2.2.11
'use strict';

const fs = require('fs');
const path = require('path');
const https = require('https');
const { spawn } = require('child_process');

const repoRoot = path.resolve(__dirname, '..');
const cacheDir = path.join(repoRoot, 'input-cache');
const jarPath = path.join(cacheDir, 'publisher.jar');
const logPath = path.join(cacheDir, 'publisher-run.log');

// 與 qa-baseline.json 之 igPublisherVersion 一致。升版時請同步兩處，
// 並預期 QA 數字會變動（qa-gate.js 會提示版本不一致）。
const PINNED_VERSION = '2.2.11';

function arg(name, fallback) {
  const i = process.argv.indexOf(name);
  return i !== -1 && process.argv[i + 1] ? process.argv[i + 1] : fallback;
}

const tx = arg('--tx', 'https://tx.fhir.org/r4');
const version = arg('--publisher-version', process.env.IG_PUBLISHER_VERSION || PINNED_VERSION);
const maxMem = arg('--max-mem', process.env.IG_PUBLISHER_MAXMEM || '4096m');

function jarUrl(v) {
  return v === 'latest'
    ? 'https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar'
    : `https://github.com/HL7/fhir-ig-publisher/releases/download/${v}/publisher.jar`;
}

function download(url, dest, redirects = 0) {
  return new Promise((resolve, reject) => {
    if (redirects > 5) return reject(new Error('重導次數過多'));
    https
      .get(url, (res) => {
        if ([301, 302, 303, 307, 308].includes(res.statusCode)) {
          res.resume();
          return download(res.headers.location, dest, redirects + 1).then(resolve, reject);
        }
        if (res.statusCode !== 200) {
          res.resume();
          return reject(new Error(`下載失敗 HTTP ${res.statusCode}：${url}`));
        }
        const tmp = `${dest}.part`;
        const file = fs.createWriteStream(tmp);
        res.pipe(file);
        file.on('finish', () => {
          file.close(() => {
            fs.renameSync(tmp, dest);
            resolve();
          });
        });
        file.on('error', reject);
      })
      .on('error', reject);
  });
}

(async () => {
  fs.mkdirSync(cacheDir, { recursive: true });

  if (!fs.existsSync(jarPath)) {
    const url = jarUrl(version);
    console.log(`publisher.jar 不存在，下載 ${version} …\n  ${url}`);
    try {
      await download(url, jarPath);
    } catch (e) {
      console.error(`\n✖ 無法下載 publisher.jar：${e.message}`);
      console.error('  若在受限網路環境，請手動放置 input-cache/publisher.jar 後重試。');
      process.exit(1);
    }
    console.log('下載完成。');
  } else {
    console.log(`使用既有 ${path.relative(repoRoot, jarPath)}（未驗證版本；如需重新下載請先刪除）。`);
  }

  if (tx === 'n/a') {
    console.log(
      '\n⚠ 離線建置（-tx n/a）：不驗證代碼是否存在、顯示名是否正確。\n' +
        '  其 0 Error 不得作為送審依據（README §建置與編譯步驟）。\n'
    );
  } else {
    console.log(`\n術語伺服器：${tx}\n`);
  }

  const args = ['-Xmx' + maxMem, '-jar', jarPath, '-ig', 'ig.ini', '-no-sushi', '-tx', tx];
  console.log(`java ${args.join(' ')}\n`);

  // 建置需 10–20 分鐘。以 spawn 串流輸出（而非 spawnSync 全部緩衝），
  // 讓 CI 日誌即時可見——否則逾時或卡住時完全看不出卡在哪一步。
  // 同時把 stdout/stderr 寫入日誌檔，供 qa-gate.js 做獨立的 tx 連線檢查。
  const status = await new Promise((resolve, reject) => {
    const logStream = fs.createWriteStream(logPath);
    const child = spawn('java', args, { cwd: repoRoot, stdio: ['ignore', 'pipe', 'pipe'] });

    child.stdout.on('data', (d) => {
      process.stdout.write(d);
      logStream.write(d);
    });
    child.stderr.on('data', (d) => {
      process.stderr.write(d);
      logStream.write(d);
    });

    child.on('error', (e) => {
      logStream.end();
      reject(e);
    });
    child.on('close', (code) => logStream.end(() => resolve(code)));
  }).catch((e) => {
    console.error(`\n✖ 無法執行 java：${e.message}`);
    process.exit(1);
  });

  console.log(`\n執行日誌：${path.relative(repoRoot, logPath)}`);
  if (status !== 0) {
    console.error(`\n✖ IG Publisher 以 exit code ${status} 結束。`);
    process.exit(status || 1);
  }
  console.log('IG Publisher 執行完成。請接著執行 QA 閘門：npm run qa');
})();
