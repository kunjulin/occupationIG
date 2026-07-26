// TWCR_SF 套件取得嘗試腳本（一次性工具，非建置流程之一部分）
//
// 用途：下載臺灣癌症登記短表實作指引 (TWCR_SF) 之 FHIR 套件，以便本 IG 能以
// 正式套件依賴引用嚼檳榔相關 CodeSystem/ValueSet，而非自行 mock。
//
// 現況：此嘗試未成功。因此 input/fsh/codesystems/TWCRSF-mocks.fsh 目前在
// hapi.fhir.tw（他方 canonical）命名空間下定義 5 個 CodeSystem 與 4 個 ValueSet，
// 並以 sushi-config.yaml 之 parameters.special-url 讓建置通過。這是治理問題而非
// 已解決的事項 —— 詳見 docs/optimization/JOB-10-twcrsf-dependency-governance.md。
//
// 保留本檔之理由：其中的候選位址是 JOB-10 查證工作的起點，不應遺失。
// 若 JOB-10 改採正式套件依賴或確認套件不可得，本檔即可刪除。
'use strict';

const https = require('https');
const http = require('http');
const fs = require('fs');
const url = require('url');

function download(fileUrl) {
  console.log('Downloading:', fileUrl);
  const parsedUrl = url.parse(fileUrl);
  const requestModule = parsedUrl.protocol === 'https:' ? https : http;
  
  requestModule.get(fileUrl, (res) => {
    if (res.statusCode === 301 || res.statusCode === 302) {
      console.log('Redirecting to:', res.headers.location);
      download(res.headers.location);
      return;
    }
    if (res.statusCode !== 200) {
      console.error('Failed to download:', res.statusCode);
      process.exit(1);
    }
    const file = fs.createWriteStream('package.tgz');
    res.pipe(file);
    file.on('finish', () => {
      file.close();
      console.log('Downloaded successfully');
    });
  }).on('error', (err) => {
    console.error('Error:', err.message);
    process.exit(1);
  });
}

download('https://mitw.dicom.org.tw/IG/TWCR_SF/package.tgz');
