# JOB-08｜CI/CD：可重現 tx 建置、QA 閘門與自動發佈

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（其他 JOB 的驗收基礎設施） |
| **類別** | 工程 |
| **預估** | M（2–4 人日） |
| **相依** | 無；建議與 JOB-02 一起做（發佈路徑會變） |
| **主要影響檔案** | 新增 `.github/workflows/build-ig.yml`、`.github/workflows/publish-pages.yml`、新增 `scripts/qa-gate.js`、`README.md` |

---

## 1. 問題（證據）

### (1) 發佈網站不可重現

qa.txt 記錄的建置路徑：

```
C:\repo\occupationIG-main\fsh-generated\resources\Bundle-UC-001 : 0 / 8 / 34
```

即發佈站內容是**某台 Windows 機器的本機建置**，手動推到 gh-pages。後果：

- 無人能確認 gh-pages 上的內容對應哪個 commit（gh-pages `9fd146f` 與 main `7169521` 無血緣關係）；
- 建置環境（Java 版本、Jekyll 版本、IG Publisher 版本、套件快取狀態）不可追溯；
- 換人接手或換機器就可能產出不同結果。

### (2) 沒有任何自動檢查

repo 無 `.github/workflows/`。因此：

- PR 不會跑建置，錯誤要到本機建置才發現；
- **README 已明訂「對外發佈前一律以 `_genonce_tx.bat` 重建」，但這條規則沒有任何機制保證**；
- `scripts/check-pagecontent-refs.js` 已經寫好，卻沒有任何地方自動執行。

### (3) 建置腳本僅限 Windows

`_genonce.bat` / `_genonce_tx.bat` 皆為批次檔（含 PowerShell 下載指令），
Linux/macOS 開發者與 CI 無法直接使用。

---

## 2. 目標與驗收標準

1. 每個 push／PR 自動執行：SUSHI → IG Publisher（**帶 tx**）→ QA 閘門。
2. **QA 閘門**（`scripts/qa-gate.js`）解析 `output/qa.txt`，於下列條件失敗：
   - `err > 0`；
   - `Wrong Display Name > 0`（JOB-01 完成後啟用）；
   - `No definition could be found for URL value > 0`（JOB-06 完成後啟用）；
   - `contains no examples > 0`（JOB-05 完成後啟用）；
   - warning 總數超過已核可基準線（baseline，隨 JOB 推進逐步下調）。
3. `main` 分支建置成功後自動發佈至 gh-pages，且**發佈內容含來源 commit SHA**。
4. 提供跨平台建置腳本（`npm run build` / `build.sh`），`.bat` 保留供 Windows 使用者。
5. `README.md` 更新建置說明，指向 CI 為權威建置方式。

---

## 3. 工作項目

### 3.1 Workflow 設計

```yaml
# 概念示意，實作時請確認各 action 版本
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - checkout
      - setup-java (temurin 17)
      - setup-node (LTS)
      - setup-ruby + gem install jekyll bundler
      - cache: ~/.fhir, input-cache/publisher.jar
      - npx fsh-sushi .
      - java -jar publisher.jar -ig ig.ini -no-sushi -tx https://tx.fhir.org/r4
      - node scripts/qa-gate.js output/qa.txt
      - node scripts/check-pagecontent-refs.js
      - upload-artifact: output/qa.txt, output/qa.html
```

要點：

- **快取 `~/.fhir`**（套件快取）與 `publisher.jar`，否則每次建置都要重新下載，CI 會很慢；
- IG Publisher 需要 **Ruby + Jekyll**（README 已註明），CI 也必須裝；
- `-tx https://tx.fhir.org/r4` 是外部服務，會有偶發失敗。建議：
  - 對 PR 使用 tx 建置但允許 retry；
  - 若 tx 不可用，**明確標示為「未經術語驗證之建置」而非默默通過**
    （這點與 README 的核心警告一致，不可妥協）。

### 3.2 QA 閘門與 baseline

不要一開始就要求 warning 歸零（現有 208 筆）。做法：

1. 建立 `qa-baseline.json`，記錄各類訊息目前筆數；
2. 閘門規則：**任一類別的筆數不得高於 baseline**（只能降不能升）；
3. 每個 JOB 完成後同步下調 baseline。

這樣 CI 從第一天就能防止退步，又不會卡住現有工作。

### 3.3 發佈

- `main` 建置成功 → 以 `output/` 內容更新 gh-pages；
- 在發佈內容中寫入來源 commit（例如產生 `build-info.json`，或利用 IG Publisher 的
  `parameters.releaselabel`／版本欄位），使網站可回溯；
- 注意與 **JOB-02** 的語言／路徑決策協調：若輸出路徑改變，發佈步驟需同步調整
  （避免 gh-pages 上殘留舊的 `/en/` 空殼頁）。

### 3.4 跨平台腳本

新增 `package.json` scripts（目前 repo 無 `package.json`，本 JOB 需建立）：

```json
{
  "scripts": {
    "sushi": "fsh-sushi .",
    "build": "npm run sushi && node scripts/run-publisher.js --tx https://tx.fhir.org/r4",
    "build:offline": "npm run sushi && node scripts/run-publisher.js --tx n/a",
    "qa": "node scripts/qa-gate.js output/qa.txt",
    "check:refs": "node scripts/check-pagecontent-refs.js"
  }
}
```

並在 `README.md` 明確標示：**`build:offline` 不得作為送審依據**（沿用現有警語）。

---

## 4. 不在本 JOB 範圍

- 修正既有 208 筆 warning（各自屬 JOB-01/05/06/09）。
- 自架術語伺服器（若 tx.fhir.org 穩定性成為問題，另議）。

---

## 5. 風險與注意事項

- **tx.fhir.org 的可用性是 CI 的外部依賴**。務必區分「驗證失敗」與「連不上伺服器」，
  後者不可視為通過。現行 `input/ignoreWarnings.txt` 以泛用字串抑制 `No server available`，
  在 CI 中會把連線失敗吞掉——**JOB-09 必須一併處理，否則 CI 的 tx 閘門形同虛設**。
- CI 建置時間可能達 10–20 分鐘（IG Publisher + Jekyll），需設定合理 timeout 與快取。
- 首次啟用發佈自動化時，先以手動觸發（`workflow_dispatch`）驗證，再改為自動。

---

## 7. 執行紀錄（2026-07-26）

**範圍決策（使用者確認）**：本階段只做**建置 ＋ QA 閘門**，**不含自動發佈**。
gh-pages 目前是委員審閱中的網站，且 JOB-02 會把輸出路徑由 `en/` 改為 `zh-TW/`，
故先確認 CI 建置正確，再另行加上發佈步驟。

### 已完成

| # | 變更 | 檔案 |
|--:|:--|:--|
| 1 | CI workflow：快速檢查 → Java/Ruby/Jekyll 環境 → 套件與 jar 快取 → SUSHI → IG Publisher（帶 tx）→ QA 閘門 → 上傳產出物 | `.github/workflows/build-ig.yml` |
| 2 | QA 閘門，含基準線比對（只能降不能升）、改善時提示下調、`--update` 自動下調 | `scripts/qa-gate.js` |
| 3 | 基準線（源自 2026-07-26 之 qa.txt，12 個類別 ＋ 三項總數） | `qa-baseline.json` |
| 4 | 跨平台 publisher 執行器，**版本可釘定**（預設 2.2.11，與基準線一致），並寫出執行日誌 | `scripts/run-publisher.js` |
| 5 | npm scripts（`build`／`build:offline`／`qa`／`qa:tx`／`check:refs`／`verify`）＋ `fsh-sushi` 釘版 3.20.0 ＋ lockfile | `package.json`、`package-lock.json` |
| 6 | `node_modules/` 加入忽略清單 | `.gitignore` |

### 對「tx 連線失敗被抑制」的處理（JOB-08 §5 之要求）

`input/ignoreWarnings.txt` 以泛用字串抑制 `No server available` 與 PKIX 錯誤，
會讓送審用的 tx 建置「連不上 tx」與「通過驗證」外觀相同。
本 JOB **不改抑制檔**（屬 JOB-09），而是在 CI 層補一道獨立的網：

* `run-publisher.js` 把 publisher 的完整輸出寫入 `input-cache/publisher-run.log`；
* `qa-gate.js --log <日誌> --expect-tx` 掃描**日誌**而非只看 qa.txt——
  抑制檔管不到日誌，因此這道檢查無法被抑制；
* 偵測到離線跡象、或 `--expect-tx` 時找不到 tx 使用證據，即失敗；
* workflow 僅在 `tx = n/a` 時降級為警告，並在 Actions 上明示「未經術語驗證，不得作為送審依據」。

### 本機已驗證

| 項目 | 結果 |
|:--|:--|
| `qa-gate.js` 對真實 qa.txt（gh-pages `9fd146f`） | 12 類別 ＋ 3 總數**全部與基準線相符**，exit 0 |
| 退步偵測（人工加一筆 `Wrong Display Name`） | 顯示 `133 → 134 +1 FAIL 退步`，exit 1 |
| 連線失敗偵測（人工加入 `No server available`） | 失敗並輸出送審警語，exit 1 |
| `--expect-tx` 未給 `--log` | 失敗並說明，exit 1 |
| 缺 `output/qa.txt` | 失敗並提示先建置，exit 1 |
| 改善偵測（暫時提高基準線） | 標記「OK 改善」並提示 `npm run qa -- --update`，exit 0 |
| `npm run check:refs` | exit 0 |
| `npm run sushi` | 正常解析組態，僅剩套件下載之網路錯誤 |
| `scripts/run-publisher.js` | **成功下載 publisher.jar 2.2.11（230MB）並實際啟動 IG Publisher**；因缺 FHIR 套件而中止 |
| workflow YAML／各 JSON 語法 | 全部通過（14 steps） |

### 為何仍需 CI 才能完整驗證

本環境之網路政策：

| 端點 | 狀態 |
|:--|:--|
| `registry.npmjs.org` | ✅ 可連 |
| `github.com`（release 下載） | ✅ 可連（publisher.jar 已實測下載成功） |
| `packages.fhir.org`／`packages2.fhir.org` | ❌ 封鎖 |
| `tx.fhir.org` | ❌ 封鎖 |
| `build.fhir.org` | ❌ 封鎖 |

FHIR 套件與術語伺服器皆不可達，故**本機無法完成建置**。
GitHub Actions runner 無此限制，因此 CI 的第一次執行即為 JOB-02／JOB-03 之
「待建置驗證」項目的實際驗收場。

### ✅ 第一次 CI 執行結果（run 30208978845，commit `083c807b`）

**全部步驟成功**，總耗時 6:51（IG Publisher 5:32），遠低於 `timeout-minutes: 60`。

| 事項 | 結果 |
|:--|:--|
| 環境（Java 17／Ruby 3.2／Jekyll／Node 20） | 全部就緒 |
| `npm run check:refs` | ✅ 通過——**修正前這步會 exit 1**，證明 JOB-12 之修正使其成為可用閘門 |
| SUSHI | ✅ 通過，`language: zh-TW` 被接受、套件解析正常 |
| IG Publisher（`-tx https://tx.fhir.org/r4`） | ✅ 成功 |
| QA 閘門（`--expect-tx`） | ✅ 通過。tx 連線檢查證實確為連線建置 |
| 產出物 | `qa-<sha>`（qa.txt／qa.html／qa.json／publisher 日誌）、`site-<sha>`（4502 檔、89MB） |
| 快取 | publisher.jar（212MB）與 FHIR 套件（76MB）已存入，後續建置會更快 |

QA 閘門實際輸出：`err 0`、`warn 208 → 204`、
`is not included anywhere ... → 0`（**JOB-03 達成**），其餘 10 類持平。
基準線已下調並提交，改善已鎖定。

### 據 CI 結果所做的追加修正

| 問題 | 修正 |
|:--|:--|
| 同一 commit 觸發兩份建置（push 與 pull_request 各一） | `push` 改為只掛 `main`，功能分支交由 `pull_request` |
| `spawnSync` 緩衝全部輸出，CI 上看不到建置進度 | 改為 `spawn` 串流，仍寫日誌 |
| 「輸出是否落在 `zh-TW/`」只能靠人工目視 | 新增 **Verify publication layout** 步驟，斷言 `output/zh-TW/{index,history,ip-statements,conformance}.html` 存在、`output/en` 不存在、首頁 `lang="zh-TW"`——把 JOB-02／JOB-03 之驗收條件固化為每次建置皆執行的檢查 |

### 其餘應持續留意

1. **`Verify publication layout` 步驟的第一次執行結果**——該步驟於本輪之後才加入，
   故 run 30208978845 未執行到它。下一次 CI 執行即為 JOB-02（`zh-TW/` 輸出）之正式驗收。
2. IG Publisher 若升版，`qa-baseline.json` 之 `igPublisherVersion` 與
   `scripts/run-publisher.js` 之 `PINNED_VERSION` 須同步；閘門會在版本不一致時提示。
3. Actions 已警告 `actions/*@v4` 系列的 Node 20 執行環境即將淘汰，屆時需升版 action。

### 尚未做（下一階段）

* **自動發佈至 gh-pages**：依使用者決定暫緩。加入時需注意
  舊 `en/` 目錄與 1012 個根目錄殼頁應以**全量覆蓋**清除，而非增量推送。
* **`en/` 轉址**：使用者確認**不需保留**，直接切換至 `zh-TW/`。
* 發佈內容記錄來源 commit（`build-info.json`）——併入發佈階段。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-08-ci-cd-reproducible-build.md、_genonce.bat、_genonce_tx.bat、
ig.ini、input/ignoreWarnings.txt 與 scripts/check-pagecontent-refs.js，為這個 JOB 產出實作計畫。

要求：
1. 設計 GitHub Actions workflow：SUSHI → IG Publisher（帶 -tx）→ QA 閘門 → 發佈 gh-pages。
   需包含 Java/Node/Ruby+Jekyll 環境、~/.fhir 與 publisher.jar 的快取策略。
2. 設計 scripts/qa-gate.js 與 qa-baseline.json 的 baseline 機制（只能降不能升），
   起始 baseline 請以 docs/optimization/evidence/qa-summary-2026-07-26.md 的統計為準。
3. 特別處理「tx.fhir.org 連不上」與「術語驗證失敗」的區分——連不上不可視為通過。
   同時檢查 input/ignoreWarnings.txt 目前用泛用字串抑制 "No server available" 與 PKIX 錯誤
   會不會讓 CI 的 tx 閘門失效，並提出修正（可與 JOB-09 協調）。
4. 建立 package.json 與跨平台建置腳本，保留 .bat 供 Windows 使用，
   並維持 README「離線建置不得作為送審依據」的警語。
5. 規劃發佈內容如何記錄來源 commit，以及與 JOB-02（語言／路徑變更）的協調順序。
6. 先以 workflow_dispatch 手動驗證再改自動，請在計畫中排入這個階段。
```
</content>
