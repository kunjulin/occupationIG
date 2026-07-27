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
//   node scripts/run-publisher.js --repo <git 網址> --target <網站網址>   # CI 建置模式
'use strict';

const fs = require('fs');
const os = require('os');
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

// CI 建置模式（-auto-ig-build）。給定 --repo／--target 即啟用。
//
// 作用：把 publish box 由「Local Development build」改為 CI build 文案——
//   「…This guide is not an authorized publication; it is the continuous build for
//     version {v}… based on the current content of {repo}…」
// 與 package-list.json 之 status: ci-build 相符，也才是本站的實況。
//
// 依據（反編譯 publisher.jar 2.2.11 確認，非推測）：
//   PublisherGenerator 依 PublisherSettings.getMode() 三選一產生 publish box——
//     MANUAL      → STATUS_MSG_LOCAL_BUILD       「Local Development build」
//     AUTOBUILD   → STATUS_MSG_AUTOBUILD         CI build 文案
//     PUBLICATION → STATUS_MSG_PUBLICATION_HOLDER 由發佈工具鏈填寫
//   Publisher 之 CLI 解析：-auto-ig-build 設 mode=AUTOBUILD，且**只有在該旗標存在時**
//   才會讀取 -target 與 -repo，故三者必須同時給。
//   文案中的來源網址取自 gh()：優先用 -repo，否則以 -target 推導。
const repoSource = arg('--repo', process.env.IG_REPO_SOURCE || null);
const targetOutput = arg('--target', process.env.IG_TARGET_OUTPUT || null);
const autoBuild = Boolean(repoSource || targetOutput);

// ⚠️ -auto-ig-build 會連帶把 FHIR **套件快取**由使用者家目錄改為系統目錄。
// PublisherBase.getFilesystemPackageCacheManager() 之邏輯（反編譯確認）：
//
//   if (settings.getPackageCacheFolder() != null)  → 用指定的資料夾
//   else if (mode == MANUAL || mode == PUBLICATION) → ~/.fhir/packages
//   else                                            → 系統快取（Linux 為 /var/lib/.fhir/packages）
//
// GitHub runner 上 /var/lib/.fhir/packages 不存在，findPackageFolder() 對
// listFiles() 之 null 直接取 .length，建置在載入模板時即以 NullPointerException
// 中止（實測：run 30233555524，1 秒內失敗，錯誤訊息指向 template 但根因是快取路徑）。
//
// 故啟用 CI 模式時一律明示套件快取位置，讓它與 workflow 所快取的目錄一致。
const packageCache = arg(
  '--package-cache',
  process.env.IG_PACKAGE_CACHE || (autoBuild ? path.join(os.homedir(), '.fhir', 'packages') : null)
);

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

  if (autoBuild) {
    if (!repoSource || !targetOutput) {
      console.error(
        '\n✖ --repo 與 --target 必須同時給定。\n' +
          '  IG Publisher 只有在 -auto-ig-build 存在時才讀取這兩個參數，\n' +
          '  只給其中一個會讓 publish box 的來源網址落空。'
      );
      process.exit(1);
    }
    args.push('-auto-ig-build', '-repo', repoSource, '-target', targetOutput);
    console.log(
      `CI 建置模式（-auto-ig-build）：publish box 將標示為 continuous build。\n` +
        `  來源 repo：${repoSource}\n` +
        `  網站網址：${targetOutput}\n` +
        `  注意：此模式下術語快取改用系統暫存目錄（非 ~/.fhir/vscache）。\n`
    );
  }

  if (packageCache) {
    fs.mkdirSync(packageCache, { recursive: true });
    args.push('-package-cache-folder', packageCache);
    console.log(`FHIR 套件快取：${packageCache}\n`);
  } else {
    console.log(
      '本機建置模式：publish box 會標示為「Local Development build」。\n' +
        '  對外發佈之建置請加 --repo 與 --target。\n'
    );
  }

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
