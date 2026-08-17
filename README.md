# 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG - TWHA IG)

臺灣勞工健康檢查與臨場健康服務執行紀錄之 FHIR 實作指引。本指引依據中華民國《勞工健康保護規則》設計，並繼承「臺灣核心實作指引」(Taiwan Core IG / TW Core IG)，以勞工健康檢查為核心，並可向特殊職類與一般健康檢查／成人預防保健需求擴充。

> 📖 **第一次接觸 FHIR／IG？請先看 [快速入門 (Quick Start)](quickstart.md)**（約 6 分鐘，不需資訊背景）。
> 該頁亦發佈於 IG 網站：<https://kunjulin.github.io/occupationIG/quickstart.html>

## 專案簡介
* **ID**: `mohw.tw.twha`
* **Canonical**: `https://twcore.mohw.gov.tw/ig/twha`（`twha` 為技術命名空間 token，詳見 [terminology.md](input/pagecontent/terminology.md)）
* **FHIR 版本**: `4.0.1` (R4)
* **版本**: `0.2.3`（STU1 草案；版本歷程見 [`package-list.json`](package-list.json)）
* **發布者**: 衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院

---

## 專案結構與目錄說明

* `CLAUDE.md`：作業前提索引（五條鐵則、常犯錯誤、檢查指令）。新接手者請先看這份。
* `quickstart.md`：**非技術讀者導覽頁**（給長官、業務單位、審查人員）。與 `input/pagecontent/quickstart.md` 為同一份內容之兩個版本（前者連結指向已發佈網站，後者為站內相對連結），**修改時須兩處同步**。
* `input/`：包含 IG 的原始輸入內容，如頁面內容（`pagecontent/`）、FHIR 資源定義（`fsh/`）、下載資產（`assets/`）等。
* `sushi-config.yaml`：SUSHI 編譯器的設定檔，包含專案中繼資料、依賴項、建置參數以及導覽選單配置。
* `ig.ini`：HL7 IG Publisher 的設定檔。
* `package-list.json`：版本歷程清單，供 publish box 與發佈流程使用。
* `docs/optimization/`：**現行優化工作範圍（13 個 JOB）——待辦事項看這裡。**
* `docs/regulations/`：法規附表 PDF 原文，為各項涵蓋度對照表之權威來源。
* `docs/history/`：已被取代之歷史規劃文件（非現行規範）。
* `docs/drafts/`：尚未接入建置流程之資源草稿。
* `scripts/`：檢查腳本（`check-pagecontent-refs.js`）與一次性工具。
* `template/`：IG 模板之本機複本（角色待釐清，見 JOB-09）。
* `_genonce.bat`：用於一鍵下載 IG Publisher 並執行編譯與發布的 Windows 批次檔。
* `_updatePublisher.bat`：用於更新本地 `publisher.jar` 的批次檔。

---

## 建置與編譯步驟

本專案採用 [FSH (FHIR Shorthand)](https://hl7.org/fhir/uv/shorthand-codegen/) 與 [SUSHI](https://github.com/FHIR/sushi) 進行開發，並使用官方的 HL7 IG Publisher 來產出最終的靜態網頁與資源。

### 準備環境
1. **Node.js**：請安裝 Node.js (建議 LTS 版本)。
2. **Java JDK**：HL7 IG Publisher 執行需要 Java 環境 (建議 Java 11 或以上)。
3. **Ruby + Jekyll**：IG Publisher 最終階段以 Jekyll 產生頁面，需先安裝（`gem install jekyll bundler`）。
4. **SUSHI 編譯器**：可透過 npm 安裝：
   ```bash
   npm install -g fsh-sushi
   ```

### 執行編譯（兩種建置，用途不同）

| 腳本 | 術語伺服器 | 用途 |
|:--|:--|:--|
| `_genonce.bat` / `npm run build:offline` | `-tx n/a`（離線） | **日常快速建置**。不連外、速度快。 |
| `_genonce_tx.bat` / `npm run build` | `-tx https://tx.fhir.org/r4` | **送審／對外發佈前必跑**。逐碼驗證 LOINC/SNOMED。 |

兩者流程相同（SUSHI 編譯 → 下載 `publisher.jar` → 產出 `output/`），差別僅在是否連線術語伺服器。

**跨平台建置（Linux/macOS/CI）**：`.bat` 為 Windows 專用，等效之跨平台指令為

```bash
npm ci                 # 安裝已釘版之 SUSHI（3.20.0）
npm run build          # SUSHI → IG Publisher（帶 tx，publisher 釘版 2.2.11）
npm run verify         # pagecontent 參照檢查 + QA 閘門
```

`npm run build` 會將 publisher 完整輸出寫入 `input-cache/publisher-run.log`，
供 QA 閘門做獨立的術語伺服器連線檢查。

### QA 閘門

```bash
npm run qa             # 比對 output/qa.txt 與 qa-baseline.json
npm run qa:tx          # 另要求日誌能證明確實連上術語伺服器
npm run qa -- --update # 改善後下調基準線（請一併提交）
```

`qa-baseline.json` 記錄各類訊息之允許上限，**任一類別數值高於基準線即失敗**（只能降不能升）。
現行基準線量測於 2026-07-29（`err = 0, warn = 152, info = 459`），以該檔內容為準；
最初之基準線（2026-07-26，`warn = 208, info = 257`）與稽核明細見
[`docs/optimization/evidence/qa-summary-2026-07-26.md`](docs/optimization/evidence/qa-summary-2026-07-26.md)。

CI（[`.github/workflows/build-ig.yml`](.github/workflows/build-ig.yml)）於 push 與 PR 時
自動執行上述流程並上傳 `qa.txt`／`qa.html`／建置產出物。
**目前 CI 不自動發佈** gh-pages，發佈仍為手動。

> 從變更到線上網站更新的完整步驟、各道閘門失敗之判讀，見
> **[`docs/RELEASE.md`](docs/RELEASE.md)（發佈流程清單）**。

> ⚠️ **離線建置（`-tx n/a`）不得作為送審依據**（文件一 v3.2 §6.6）。
> 離線模式**不會驗證代碼是否存在、顯示名是否正確**——語法合法但語意錯誤的代碼（例如以「出院指示」的代碼記錄「職業危害暴露」）在離線建置下完全不會報錯。
> **對外發佈或送委員審查前，一律以 `_genonce_tx.bat` 重建並檢視 `output/qa.html`。**
>
> ⚠️ **驗證結果之意義界定**：IG Publisher 之驗證通過，僅證明**語法正確**且**已被引用之術語**通過代碼有效性檢查；
> **不包含臨床適切性、法規符合性與情境完整性之保證**，亦不涵蓋未被任何 profile／ValueSet 引用之對照表代碼。
> 故不得以驗證結果作為 IG 整體品質之保證表述。
>
> ⚠️ **已知盲區——建置驗證不檢查 ValueSet 內之顯示名語意**：
> IG Publisher 驗證 ValueSet 成員之「代碼是否存在於該 CodeSystem」，
> **不驗證其 `display` 是否與代碼真實語意相符**。因此語意完全錯誤的代碼（例如以過敏原檢測之代碼
> 標示為「純音聽力 500Hz」）可一路通過 0 Error 建置。本 IG 於 2026-07-26 即依此查出並移除 16 個錯碼。
> **新增或引用代碼時，須另以 `$lookup` 取得官方 display 並人工確認語意**，
> 程序見 [`.claude/skills/fhir-tx-audit/SKILL.md`](.claude/skills/fhir-tx-audit/SKILL.md)。

若公司網路以 TLS 攔截（如防毒軟體／proxy）導致連線失敗，先設定：

```bash
set JAVA_TOOL_OPTIONS=-Djavax.net.ssl.trustStoreType=Windows-ROOT
set NODE_OPTIONS=--use-system-ca
```

代碼問題之查證與修正流程見 [`.claude/skills/fhir-tx-audit/SKILL.md`](.claude/skills/fhir-tx-audit/SKILL.md)（特別注意：**「顯示名不符」可能代表用錯碼，而非僅顯示名不精確**）。

---

## 依賴指引 (Dependencies)
* **tw.gov.mohw.twcore**: `1.0.0`（`sushi-config.yaml` 之 IG 套件依賴）
* **TWCR_SF（臺灣癌症登記短表 IG, `hapi.fhir.tw`）**：**非套件層級依賴**。
  嚼檳榔相關之 5 個 CodeSystem 與 4 個 ValueSet 由本 IG 以【本地 stub】承載
  （`input/fsh/codesystems/TWCRSF-mocks.fsh`），其 canonical 屬 TWCR_SF 命名空間，
  並以 `sushi-config.yaml` 之 `parameters.special-url` 列為例外。

  > ⚠️ **這不是「引用外部定義」，是本 IG 自行定義了他方命名空間下的資源。**
  > 2026-07-28 CI 實測：`fhir.twcrsf` 套件在三個 registry 之根路徑皆 404，
  > 該 10 個 canonical 於 `hapi.fhir.tw` 亦全部 404（伺服器有回應，只是不服務這些資源）。
  > 故已依 JOB-10 路徑 B 降級為 stub：`content = #fragment`、`status = #draft`、
  > `experimental = true`、標題冠【本地 stub】、`copyright` 載明權威來源。
  >
  > **實作端應以 TWCR_SF 官方定義為準。** 本 stub 之代碼清單未經上游核對——
  > 無從核對，因為上游不可達。詳見[未決事項 G-5](input/pagecontent/open-issues.md)。

---

## 優化工作範圍 (Optimization Job Scopes)

2026-07-26 就發佈網站（<https://kunjulin.github.io/occupationIG/>）進行審閱後，
已將待優化事項整理為 **13 個可獨立執行的 JOB**，置於 [`docs/optimization/`](docs/optimization/README.md)：

* [`docs/optimization/README.md`](docs/optimization/README.md)：審閱總結、優先序矩陣、建議執行順序、全域驗收標準。
* [`docs/optimization/evidence/qa-summary-2026-07-26.md`](docs/optimization/evidence/qa-summary-2026-07-26.md)：
  tx 建置 QA 統計基準線（err 0 / warn 208 / info 257）與術語稽核明細，供各 JOB 驗收比對。
  **重跑 tx 建置後請一併更新此檔。**
* `docs/optimization/JOB-01` ~ `JOB-23`：各 JOB 之問題證據、驗收標準、工作項目與風險；
  每份結尾均附「交給 Claude 規劃用提示」，可直接複製使用。
  （JOB-14 以後為後續審閱／主管指示新增之工作項；最新為
  [`JOB-23`](docs/optimization/JOB-23-navigation-alignment-twcore.md)——導覽列比照 TW Core IG 之差異分析，
  **評估完成、待核准後實作**。）

建議節奏：一個 JOB → 一次規劃 → 一個 commit。優先處理 P0（JOB-01～03）。

---

## 版本與更新記錄 (Update History)

### v0.2.3（2026-08-16）導覽列比照 TW Core IG 調整（JOB-23 實作）
> 說明：本次為**導覽與呈現層變更**，未變更任何 Profile、ValueSet、CodeSystem、Extension 或範例之**定義**，不影響既有實作之資料結構。
> **既有 15 個 pagecontent 頁面之檔名與網址全數未變更**（以 `git diff --name-status` 佐證），既發函文、委員意見書與簡報中之連結不受影響。
- **`sushi-config.yaml` 之 `menu` 依 [JOB-23](docs/optimization/JOB-23-navigation-alignment-twcore.md) §2.4 核准版套用**：頂層由 9 項縮為 **8 項**（與 TW Core IG v1.0.0 相同），排列邏輯由「業務主題導向」改為 TW Core 之「文件類型導向」——應用說明 → 目錄 → 規範文件 → 檢查與紀錄 → 範例 → 結構定義與範例檔下載 → 安全性 → 未決事項；標籤改為**純中文**（英文名稱保留於各頁 H1）。
  - 新增〈**目錄**〉入口（`toc.html`，TW Core 置於第 2 位；本 IG 先前有建置產出但未列入 menu）。
  - 新增〈**範例**〉頂層入口。
  - 〈**安全性**〉由下拉第 2 層**提升為頂層**。
- **移除四條位移型錨點連結**：`artifacts.html#1`～`#4`（Profiles／Extensions／Value Sets／Code Systems）。該編號係 **IG Publisher 依「該次建置中實際存在的 artifact 類別」出現順序自動產生**，並非固定語意；新增或移除任一類別即整體位移，導覽連結會**靜默指向錯誤區段而 `err = 0` 仍成立**（Publisher 不檢查頁內錨點語意）。改指向新增之策展頁與既有 `terminology.html`，作法比照 TW Core。
- **新增 [`input/pagecontent/profiles-and-extensions.md`](input/pagecontent/profiles-and-extensions.md)〈Profiles 與 Extensions〉策展頁**：依 FHIR resource 分類列出本指引之 **41 個 Profile**（Observation 16 個再依生命徵象／生理功能／實驗室檢驗／生活習慣／職業暴露與健康管理五組細分）與 **11 個 Extension**（依事業單位與受僱關係／檢查作業屬性／生活習慣量化／健康管理與適性配工四組），各列繼承來源與用途。頁首載明**權威清單仍為資源總覽（`artifacts.html`）**，本頁不重複技術定義，兩處有出入時以資源總覽及各 StructureDefinition 頁面為準。
- **新增 [`input/pagecontent/examples.md`](input/pagecontent/examples.md)〈範例〉策展頁**：依使用情境與檢查類別列出 **67 個範例實例**，並說明 UC-008／UC-009 內含之 10 個 `Usage: #inline` 實例不會產生獨立頁面。另設「特殊示範」一節，集中 `dataAbsentReason` 缺值處理、雇主端摘要不含檢驗數值之揭露界線、上傳冪等重傳與 `urn:uuid` 內部參照四項易做錯之作法。
- **新增 [`scripts/check-menu.js`](scripts/check-menu.js) 導覽列閘門**並掛入 `npm run verify` 與 CI：
  - **R-1** menu 之 target 必須存在（或屬 IG Publisher 自動產生頁白名單）；**R-2** 禁用 `artifacts.html#<數字>`（失敗）；**R-3** 其他純數字錨點（警告）；**R-4** 頂層項目數上限 9（警告）；**R-5** pagecontent 有產出但未被 menu 引用之**孤兒頁**須具名列入白名單並附理由（警告，`--strict` 時失敗）。R-5 承接 [JOB-12](docs/optimization/JOB-12-navigation-and-repo-hygiene.md) §1(1) 之 `conformance.html` 孤兒頁問題，改以機制防止復發。
  - 內建 `--self-test` **負向測試三組**（不存在之 target／`artifacts.html#2`／未白名單之孤兒頁），CI 中**先跑負向測試再跑實檢**——閘門本身失效時會「全綠但其實沒檢查」，比照 JOB-20／21／22 之作法。
  - 對 0.2.2 之舊 menu 實跑可攔下全部 4 條 `artifacts.html#N`（回歸佐證）。
- **孤兒頁白名單**目前僅 `history.md`（版本歷程頁，由 `package-list.json` 與 `path-history` 驅動，經 publish box 之 Releases 連結進入，不佔導覽列版位）。
- **`sushi-config.yaml`**：`version` 由 `0.2.2` 調整為 `0.2.3`。**`package-list.json`**：新增 0.2.3 條目。
- ⚠️ **JOB-23 §2.1 之 A-7（`ig.ini` 模板釘版）本次未執行**。理由：[JOB-09](docs/optimization/JOB-09-build-config-hardening.md) §197 已裁示「本環境無法連線模板來源，**不宜憑猜測寫入版本號**——寫錯會讓建置直接失敗」，並已於 CI 加入 `Report resolved template version` 步驟。應待該步驟自 publisher 日誌取得實際解析到的版本後再行釘定。A-7 移列 JOB-09 續辦。
- ✅ **CI tx 建置已完成並通過（`err = 0`）**。撰寫實作之容器因 proxy 封鎖 `packages.fhir.org`／`packages2.fhir.org` 而只能做靜態驗證（FSH 剖析 98 definitions／84 instances 無錯誤、`npm run check:refs`、`npm run check:menu` 含負向測試、兩張新頁 **140 條連結目標全數可解析**）；tx 建置與 QA 實測改於 CI 完成。
  - **`qa-baseline.json` 依既定例外程序上調**：`cannot be resolved` 2313 → **2317（+4）**——兩張新頁各 +2（根層轉址殼頁與 zh-TW 語言層），與 v0.2.1 之 `_quickstartNote` 所載 +2／頁規則完全一致；斷鏈標的仍為 publish box 之 `history.html`，屬 P-1（canonical 核定）之既有問題，非本次引入。具名說明見 `qa-baseline.json` 之 `_job23Note`，程序見 [`docs/RELEASE.md`](docs/RELEASE.md) §2.2。
  - `TOTAL info` 實測 439（基準 459）、`TOTAL warn` 實測 96（基準 152）為未歸因改善，依 `_warnNote` 之既定政策**不下調天花板**。
  - ⚠️ 本機（Windows）曾量得 `cannot be resolved` 3600、`warn` 380，與 CI 差距極大，係本機環境所致（tx TLS 攔截、模板 `#current` 未釘版），**未採信亦未寫入基準線**。**基準線一律以 CI 實測為準。**

### v0.2.2（2026-08-16）導覽列比照 TW Core IG 之差異分析（評估，未變更 menu）
> 說明：本次為**評估文件新增與版次更新**，**未變更 `sushi-config.yaml` 之 `menu`**，亦未變更任何 Profile、ValueSet、CodeSystem、Extension 或範例，不影響既有實作與 QA 基準線。導覽列之實際調整待核准後另以 v0.2.3 發佈。
- **緣起**：2026-08-16 主管指示，本 IG 之頁籤內容與順序請參考 [TW Core IG](https://twcore.mohw.gov.tw/ig/twcore/) 之樣式調整。
- **新增 [`docs/optimization/JOB-23-navigation-alignment-twcore.md`](docs/optimization/JOB-23-navigation-alignment-twcore.md)**，內容為：
  - **並排對照**：TW Core IG v1.0.0（頂層 8 項／下拉 1 組／總入口 13）對 TWHA IG v0.2.1（頂層 9 項／下拉 4 組／總入口 21），比對基準為 2026-08-16 實地檢視之導覽列 DOM 與 `toc.html`。
  - **五項結構性差異**：D-1 排列邏輯（文件類型導向 vs 業務主題導向）／D-2 缺〈目錄〉頁籤／D-3 缺〈範例〉頂層入口／D-4 安全性位階過低／D-5 中英雙語標籤。
  - **一項實質缺陷（非樣式問題）**：現行 menu 之 `artifacts.html#1`～`#4` 為 **IG Publisher 依該次建置實際存在之 artifact 類別自動編號**的錨點，一旦新增或移除任一類別即整體位移，四個導覽連結會**靜默指向錯誤區段**，且 `err = 0` 仍成立（IG Publisher 不檢查頁內錨點語意）。TW Core 之解法為建策展頁（`profiles-and-extensions.html`／`terminologies.html`），本案建議比照。
  - **建議方案三分類**：A 類建議採納 7 項（含 8 項頂層之新 `menu` 草案，**所有既有頁面檔名皆不變更**）；B 類不建議採納 4 項（不刪〈快速入門〉〈未決事項〉、不改檔名、不比照 `TWCDI.html`、不比照 MOHW 視覺識別——後者屬授權與治理議題，且 canonical 仍為 provisional [M-1](input/pagecontent/open-issues.md)）；C 類後續評估 2 項（〈驗證教學〉頁、CapabilityStatement 策展頁）。
  - **`scripts/check-menu.js` 規格**（R-1～R-5 ＋負向自我測試）：把「導覽列指向不存在頁面」「使用位移型錨點」「孤兒頁」自人工目視改為 CI 阻斷。現行 `npm run check:refs` 只檢查 pagecontent 內文，**不涵蓋 menu**。R-5 承接 [JOB-12](docs/optimization/JOB-12-navigation-and-repo-hygiene.md) §1(1) 之 `conformance.html` 孤兒頁問題，改以機制防止復發。
- **附帶發現（登記，本次未處理）**：`ig.ini` 之 `template = fhir2.base.template#current` **未釘版**（JOB-09 已登記），上游模板改版時本站導覽外觀會在無程式碼變更之情況下自行改變——與本次「樣式為何不一致」直接相關，建議於 JOB-23 實作時一併釘版。
- **`sushi-config.yaml`**：`version` 由 `0.2.1` 調整為 `0.2.2`（`menu` 未變更）。
- **`package-list.json`**：新增 0.2.2 版次條目。
- ⚠️ 本次未新增 pagecontent 頁面，`qa-baseline.json` 不變動。對外發佈前一律以 `_genonce_tx.bat`（tx 建置）重建並檢視 `output/qa.html`。

### v0.2.1（2026-08-05）新增快速入門導覽頁
> 說明：本次為**導覽性（non-normative）內容新增**，未變更任何 Profile、ValueSet、CodeSystem、Extension 或範例，不影響既有實作。
> （QA 基準線仍會因新增一頁而變動——新頁面自身之連結訊息會計入 `cannot be resolved`，見下方 `qa-baseline.json` 一條。）
- **新增 [`input/pagecontent/quickstart.md`](input/pagecontent/quickstart.md)〈快速入門 (Quick Start)〉**：以第一次接觸 FHIR／IG 的主管、業務單位與審查人員為對象，內容包含
  - FHIR／IG／Profile／ValueSet／LOINC／Must Support 之白話說明與比喻；
  - 本指引範疇（Core ＋ 特殊職類擴充 ＋ 一般健檢／預防保健擴充）與四張法規附表之對應；
  - **三種資料集之區辨**（① IG scope ≠ ② Core 最小上傳集 21 列 ≠ ③ 法定情境資料集），呼應 [index.md](input/pagecontent/index.md) §3 與[未決事項 M-5](input/pagecontent/open-issues.md)；
  - **「0 Error」之意義界定**（呼應[未決事項 G-2、G-3](input/pagecontent/open-issues.md)）：以**頁尾附註**形式呈現，載明技術驗證通過為必要非充分條件，不代表臨床適切性或法規符合性；
  - 外部待決事項摘要（M-5／M-6／M-7／M-10／T-1／T-3／P-1／P-2）與各角色閱讀路徑，並敘明該等事項為**外部依賴，非團隊未完成之工作項目**。
- **[`CLAUDE.md`](CLAUDE.md) §2.4 更正**：③ 情境資料集原記為「尚未以值集定義（backlog；見 JOB-07）」，惟 `VS-Appendix9-RequiredSet` 與 `VS-Appendix10-RequiredSet` 已於 0.2.0 落地且 [index.md](input/pagecontent/index.md) §3 已引用，故更正為實際產物並保留附表十未審家族之提醒（M-8）。
- **同步新增 repo 根目錄 [`quickstart.md`](quickstart.md)**：內容同上，站內連結改為已發佈網站絕對位址，供 GitHub 讀者直接閱讀。**兩檔須同步維護。**
- **`sushi-config.yaml`**：`menu` 於「首頁」下新增「快速入門 (Quick Start)」；`version` 由 `0.2.0` 調整為 `0.2.1`。
- **`package-list.json`**：新增 0.2.1 版次條目。
- **`qa-baseline.json`**：新增一頁 pagecontent 會帶進該頁自身之連結訊息，`cannot be resolved` 依 CI 實測值上調並具名說明（`_quickstartNote`）。**上調量以 CI 實測為準，未預先猜測**；程序見 [`docs/RELEASE.md`](docs/RELEASE.md) §2.2。
- ⚠️ 對外發佈前一律以 tx 建置重建並檢視 `output/qa.html`。現行基準線為 2026-07-29 之 `err 0 / warn 152 / info 459`（以 `qa-baseline.json` 為準；`warn 208 / info 257` 為 2026-07-26 之最初基準線，已不適用）。

### 2026-07-23 更新（法規 115.06.26 同步 ＋ 四方委員意見合併）
> 說明：本 IG 為工業技術研究院委託研擬中之草案，尚未定稿；本次更新反映法規修正與委員意見。
- **法規同步（勞工健康保護規則 115.06.26 修正）**：
  - 附表九項5 新增紅血球數（RBC `789-8`）、平均紅血球容積（MCV `787-2`）；血糖明定空腹血糖（`1558-6`）。已補入 [general-exam.md](input/pagecontent/general-exam.md) §4 與 [VS-OccHealthCheck-Required](input/fsh/valuesets/VS-OccHealthCheck-Required.fsh)。
  - 附表十由 32 項增為 **35 項**，新增 33 苯乙烯／34 甲苯／35 二甲苯具名作業；多類新增腎絲球過濾率（eGFR，Core 已收 `88293-6`），飯前血糖統一為空腹血糖。
  - **涵蓋度對照重建**：[special-exam.md](input/pagecontent/special-exam.md) 之涵蓋表由「18 類」口徑改以**附表十 35 項為列主鍵**，並保留 12 危害家族歸併欄。
- **新增第二層術語與對照（可追溯性，回應 IG 技術審意見）**：
  - 新增 [CS-Appendix10Operation](input/fsh/codesystems/CS-Appendix10Operation.fsh)（35 項具名作業）與 VS-Appendix10-Operation。
  - 新增 [ConceptMap Appendix10-to-HazardType](input/fsh/codesystems/ConceptMap-Appendix10ToHazardType.fsh)：附表十 35 項 → CS-HazardType 12 家族之對映。
  - [CS-HazardType](input/fsh/codesystems/CS-HazardType.fsh) Description 敘明 12 家族（家族層）與 35 項具名作業之關係。
- **四方委員意見合併（國健署原案／國健署委員／職業病醫師／檢驗科／IG 技術審）**：
  - 腰圍 Preferred 由 `56086-2` 調整為 `8280-0`（臍位皮尺，委員已查證），`56086-2` 降為 Acceptable（[VS-TWHAVitalSigns](input/fsh/valuesets/VS-TWHAVitalSigns.fsh)、terminology.md、datamodel.md 同步）。送件前另以 loinc.org 覆核 `56086-2` 顯示名。
  - 聽力維持 `89015-2` panel 為 Preferred，職醫／院內 LIS 之 `21104-5` 系列（含 14 個頻率碼）列為 Acceptable（[VS-ExtendedDataset](input/fsh/valuesets/VS-ExtendedDataset.fsh)）。
  - LDL-C 維持直接測定法 `2089-1` 為 Preferred，計算法 `13457-7` 為 Acceptable（委員 QA-7，原已符）。
  - terminology.md：§2/§3.1 補「Preferred（代碼層級）≠ 綁定強度 preferred（本 IG 為 extensible）」用語澄清；§4 對照表新增 RBC 與腰圍列。
- **一致性與可實作補強（Batch 3）**：
  - `Observation.performer` 於 [TWHA-LabResult-General](input/fsh/profiles/TWHA-LabResult-General.fsh)、[TWHA-LabResult-Special](input/fsh/profiles/TWHA-LabResult-Special.fsh)、[TWHA-VitalSigns](input/fsh/profiles/TWHA-VitalSigns.fsh) 標 **Must Support**，支援第 19 條紀錄保存與稽核之執行者追溯。
  - 新增 **dataAbsentReason 缺值範例** `obs-lab-egfr-absent`（[10-absent-and-emergency.fsh](input/fsh/examples/10-absent-and-emergency.fsh)），示範治理原則「缺值以 dataAbsentReason 標明而非省略」之實際填法。
  - 新增 **職業健康急診友善摘要** Profile [TWHA-Composition-EmergencySummary](input/fsh/profiles/TWHA-Composition-EmergencySummary.fsh) 及範例（暴露史 `obs-exposure-lead`＋摘要 Composition `composition-emergency-summary`＋封包 UC-007），將原候選欄位清單落實為可驗證之 FHIR 文件。
- **未決事項**：所有需外部機關或臨床單位決定之事項，集中列於網站之
  [未決事項與已知限制](https://kunjulin.github.io/occupationIG/open-issues.html)頁
  （原始碼：`input/pagecontent/open-issues.md`）。該頁載明每項之現況、決定者、
  所需輸入與「若決策不同的影響」。**本 README 之警語不因該頁存在而簡化**——
  README 讀者未必會看網站。
- **文件狀態**：本 IG 為工研院委託研擬中之草案，尚未定稿，後續得依共識會議、委員意見及主管機關規範調整。

### 2026-07-09 更新 (同步勞工體檢項目)
- **擴充值集 (ValueSet Expansion)**: 
  - [VS-CoreDataset](input/fsh/valuesets/VS-CoreDataset.fsh): 新增 83 個一般健檢檢驗項目代碼（白血球分類計數與異常細胞、葡萄糖 AC、無 P-5'-P 的 AST/ALT、直接 LDL-C、CA19-9、PSA、AFP、IgE、肝炎病毒抗體、尿液常規/沉渣鏡檢、以及新增之**糞便檢查**區段與相關代碼）。
  - [VS-ExtendedDataset](input/fsh/valuesets/VS-ExtendedDataset.fsh): 新增 11 個特殊健檢與進階檢驗項目代碼（血中/尿中重金屬錳/鎘/鉻與肌酸酐比值、沙門氏菌與志賀氏菌糞便培養、以及尿液毒品篩檢）。
- **修復錯誤與調整對應 (ConceptMap Alignment)**: 
  - **修復 LOINC 83085-1 標記錯誤**: 修正原誤將 `83085-1` (癌胚抗原 CEA by IA) 標記為 CA-125 的 Bug，將 CA-125 可接受代碼修正為 `83082-8`，並建立正確的 CEA (`83085-1` -> `2039-6`) 與 CA-125 (`83082-8` -> `10334-1`) 對應關係。
  - 新增無 P-5'-P 的 AST/ALT (`88112-8` / `1744-2`) 以及葡萄糖 AC (`2345-7`) 對應至 preferred 代碼之規則。
- **術語對照表同步**:
  - 更新 [snomed-loinc-mappings.csv](input/assets/snomed-loinc-mappings.csv) 與 [terminology.md](input/pagecontent/terminology.md)，納入 CEA (SNOMED CT `60267001`) 並修正 CA-125 的 acceptable 代碼。

### 2026-07-10 更新 (依 develop.md 對接文件一/二/三 v1.1)
- **正式名稱與架構定位**：`sushi-config.yaml`、`README.md`、`index.md`、`background.md` 之標題與敘述改回徵求書名稱「臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG)」；架構敘述由「兩層 Foundation/Domain Supplement」統一為「Core（勞工健檢）＋特殊職類／一般健檢兩類開放式擴充」。技術 ID/Canonical/`TWHA-` 前綴維持不變。
- **修正 pagecontent 失效引用**：`general-exam.md` 中不存在的 `VS_GeneralLabTests`、`VS_BetelNutStatus`、`ext-betelnut-quantity` 改為對應實際 FSH 物件（`VS-CoreDataset` extensible、TWCR_SF 元件模型）。
- **LDL-C Preferred 代碼修正**：由計算法 `13457-7` 改為直接測定法 `2089-1`（對齊文件二 §2.3），同步修正 ConceptMap、`terminology.md`、`datamodel.md`、`general-exam.md`。
- **新增 [VS-OccHealthCheck-Required](input/fsh/valuesets/VS-OccHealthCheck-Required.fsh)**：第一期法定必驗項目草案子集（一般必驗 + 噪音/鉛/粉塵三模組），待正式法規盤點後修訂。
- **Core/Extended 重分層**：將腫瘤標記（AFP/CEA/PSA/CA125/CA19-9/CA15-3/SCC/EBV/IgE）與進階心血管/自體免疫項目（Lp(a)/ApoA-I/ApoB/NT-proBNP/ANA/RF/CYFRA21-1）自 `VS-CoreDataset` 移至 `VS-ExtendedDataset`（代碼不刪除，僅重分層），使 Core 回歸最小共通集。
- **危害類別對照**：`CS-HazardType` 之 `specific-chemical` 補充子類說明，對應 `VS-SpecificChemicalType`，呼應文件一 18 類展開。
- **第一期範疇說明**：`special-exam.md` 新增段落區分「噪音/鉛/粉塵已結構化必驗」與「其餘 9 類以 LabResult-Special 通用承載」。
- **新增 [scripts/check-pagecontent-refs.js](scripts/check-pagecontent-refs.js)**：掃描 pagecontent 中 `VS_*`/`CS_*`/`ext-*`/`TWHA-*` 引用是否皆能在 `input/fsh/` 中找到對應定義，避免再度出現失效引用。

### 2026-07-10 更新（議題5／C-04：附表十特殊作業模組完整性與臨床適當性）
- **純音聽力圖 LOINC 更正與補齊**：原 `TWHA-HearingTest`／`VS-ExtendedDataset` 之頻率×耳別代碼多處錯置（如以 `89017-8`、`89028-5`、`89020-2` 等誤標左右耳頻率），且僅收錄 4 頻率。已依 LOINC `89015-2` panel 成員逐一更正，並補齊 3/6/8 kHz，成為雙耳 0.5–8 kHz 共 14 個氣導聽閾代碼，符合附表十噪音作業要求；範例 `obs-hearing` 同步更新。
- **肺功能 FEV1 代碼更正**：原以 `19868-9` 標示 FEV1，惟該碼實為 FVC（Forced vital capacity）。FEV1 之正確 LOINC 為 `20150-9`（`TWHA-PulmonaryFunction` Profile 原已正確使用），已同步修正 `VS-CoreDataset`、`VS-ExtendedDataset`、`VS-PulmonaryFunction`、`VS-OccHealthCheck-Required`、`terminology.md`、`special-exam.md` 之標示。
- **附表十 18 類涵蓋度對照表**：`special-exam.md` 新增完整 18 類特別危害作業涵蓋度審查表（對應文件一 §2.1.1），逐類標註共用／專屬項目、Preferred LOINC 與承載方式，並補齊臨床缺口：高溫作業電解質氯（`2075-0`）與 BUN、游離輻射甲狀腺功能（TSH `11580-8`／Free T4 `3024-7`）、異常氣壓心電圖、有機溶劑肝功能（γ-GT `2324-2`）、二硫化碳心血管監測、粉塵單張 PA 胸片（`24648-8`）等。
- **血中鉛雙碼**：血中鉛 Preferred `5671-3`（Lead in Blood），院內 LIS 實際報告之 `23749-5`（Lead in Specimen）列為 Acceptable。

