#!/usr/bin/env node
// 探測一組 canonical URL 是否可解析，並在對方回傳 FHIR 資源時列出關鍵欄位，
// 供與本 IG 之定義比對。
//
// 為什麼需要：本 IG 在 hapi.fhir.tw 命名空間下定義了 9 個 artifact
// （input/fsh/codesystems/TWCRSF-mocks.fsh，檔頭自述為「bypass dependency errors」）。
// 該命名空間**不屬於本專案**，故必須確認：
//   (1) 對方是否真的服務這些 canonical；
//   (2) 若服務，其內容與本 IG 的複本是否一致。
// 不一致代表同一個 canonical 有兩份互相衝突的權威來源——那是比「找不到」更糟的狀況。
//
// 開發環境連不到 hapi.fhir.tw（實測 HTTP 000），故設計為由 CI 執行。
// 本檔只做 HTTP GET 與欄位摘要，不修改任何檔案。
//
// Usage:
//   node scripts/probe-canonicals.js --urls-from <檔案，每行一個 URL>
//   node scripts/probe-canonicals.js --url <URL> [--url <URL> ...]
//   （可加 --json out.json）
'use strict';

const fs = require('fs');
const https = require('https');
const http = require('http');

function args(name) {
  const out = [];
  process.argv.forEach((a, i) => {
    if (a === name && process.argv[i + 1]) out.push(process.argv[i + 1]);
  });
  return out;
}

const urls = [
  ...args('--url'),
  ...args('--urls-from').flatMap((f) =>
    fs
      .readFileSync(f, 'utf8')
      .split(/\r?\n/)
      .map((l) => l.trim())
      .filter((l) => l && !l.startsWith('#'))
  ),
];
const jsonOut = args('--json')[0];

if (!urls.length) {
  console.error('用法：node scripts/probe-canonicals.js --urls-from <檔案> | --url <URL>');
  process.exit(1);
}

// FHIR 伺服器對 canonical 端點通常回 JSON；明確要求之，避免拿到 HTML 導覽頁。
function get(url, redirects = 0) {
  return new Promise((resolve) => {
    if (redirects > 5) return resolve({ status: 'too-many-redirects' });
    const lib = url.startsWith('http://') ? http : https;
    const req = lib.get(
      url,
      { headers: { Accept: 'application/fhir+json, application/json;q=0.9, */*;q=0.1' }, timeout: 30000 },
      (res) => {
        if ([301, 302, 303, 307, 308].includes(res.statusCode) && res.headers.location) {
          res.resume();
          return get(new URL(res.headers.location, url).toString(), redirects + 1).then(resolve);
        }
        let body = '';
        res.setEncoding('utf8');
        res.on('data', (d) => {
          // 只留前 256KB——這裡要的是欄位摘要，不是完整資源
          if (body.length < 262144) body += d;
        });
        res.on('end', () => resolve({ status: res.statusCode, contentType: res.headers['content-type'], body }));
      }
    );
    req.on('timeout', () => {
      req.destroy();
      resolve({ status: 'timeout' });
    });
    req.on('error', (e) => resolve({ status: 'error', error: e.message }));
  });
}

(async () => {
  const results = [];
  for (const url of urls) {
    const r = await get(url);
    const row = { url, status: r.status };

    if (r.status === 200 && r.body) {
      try {
        const j = JSON.parse(r.body);
        row.resourceType = j.resourceType;
        row.id = j.id;
        row.canonicalInResource = j.url;
        row.version = j.version;
        row.resourceStatus = j.status;
        row.name = j.name;
        row.title = j.title;
        if (j.resourceType === 'CodeSystem') {
          row.content = j.content;
          row.conceptCount = Array.isArray(j.concept) ? j.concept.length : 0;
          row.firstConcepts = (j.concept || []).slice(0, 5).map((c) => `${c.code}=${c.display}`);
        }
        if (j.resourceType === 'ValueSet') {
          row.includeCount = j.compose && Array.isArray(j.compose.include) ? j.compose.include.length : 0;
        }
      } catch {
        row.parseError = true;
        row.bodyHead = r.body.slice(0, 200).replace(/\s+/g, ' ');
      }
    } else if (r.error) {
      row.error = r.error;
    }

    results.push(row);

    const mark = r.status === 200 ? '✔' : '✖';
    console.log(`${mark} ${String(r.status).padEnd(8)} ${url}`);
    if (row.resourceType) {
      console.log(
        `    ${row.resourceType} id=${row.id} status=${row.resourceStatus}` +
          (row.conceptCount !== undefined ? ` concepts=${row.conceptCount}` : '') +
          (row.includeCount !== undefined ? ` includes=${row.includeCount}` : '')
      );
      if (row.canonicalInResource && row.canonicalInResource !== url) {
        console.log(`    ⚠️ 資源內宣告之 url 與請求位址不同：${row.canonicalInResource}`);
      }
      if (row.firstConcepts && row.firstConcepts.length) {
        console.log(`    前 5 碼：${row.firstConcepts.join('  ')}`);
      }
    } else if (row.parseError) {
      console.log(`    ⚠️ 回應非 JSON（content-type=${r.contentType}）：${row.bodyHead}`);
    } else if (row.error) {
      console.log(`    ${row.error}`);
    }
  }

  const ok = results.filter((r) => r.status === 200).length;
  console.log(`\n合計 ${results.length} 個，可解析 ${ok} 個，無法解析 ${results.length - ok} 個。`);

  if (jsonOut) {
    fs.writeFileSync(jsonOut, `${JSON.stringify(results, null, 2)}\n`);
    console.log(`已寫出 ${jsonOut}`);
  }
})();
