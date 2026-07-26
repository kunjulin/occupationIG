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
