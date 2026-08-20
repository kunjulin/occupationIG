# 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG - TWHA IG)

臺灣勞工健康檢查與臨場健康服務執行紀錄之 FHIR 實作指引。本指引依據中華民國《勞工健康保護規則》設計，並繼承「臺灣核心實作指引」(Taiwan Core IG / TW Core IG)，以勞工健康檢查為核心，並可向特殊職類與一般健康檢查／成人預防保健需求擴充。

> 📖 **第一次接觸 FHIR／IG？請先看 [快速入門 (Quick Start)](quickstart.md)**（約 6 分鐘，不需資訊背景）。
> 該頁亦發佈於 IG 網站：<https://kunjulin.github.io/occupationIG/quickstart.html>

## 專案簡介
* **ID**: `mohw.tw.twha`
* **Canonical**: `https://twcore.mohw.gov.tw/ig/twha`（`twha` 為技術命名空間 token，詳見 [terminology.md](input/pagecontent/terminology.md)）
* **FHIR 版本**: `4.0.1` (R4)
* **版本**: `0.6.0`（STU1 草案；版本歷程見 [`package-list.json`](package-list.json)）
* **發布者**: 衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院

---

## 專案結構與目錄說明

* `CLAUDE.md`：作業前提索引（五條鐵則、常犯錯誤、檢查指令）。新接手者請先看這份。
* `quickstart.md`：**非技術讀者導覽頁**（給長官、業務單位、審查人員）。與 `input/pagecontent/quickstart.md` 為同一份內容之兩個版本（前者連結指向已發佈網站，後者為站內相對連結），**修改時須兩處同步**。
* `input/`：包含 IG 的原始輸入內容，如頁面內容（`pagecontent/`）、FHIR 資源定義（`fsh/`）、下載資產（`assets/`）等。
* `sushi-config.yaml`：SUSHI 編譯器的設定檔，包含專案中繼資料、依賴項、建置參數以及導覽選單配置。
* `ig.ini`：HL7 IG Publisher 的設定檔。
* `package-list.json`：版本歷程清單，供 publish box 與發佈流程使用。
* `docs/optimization/`：**現行優化工作範圍（JOB-01～JOB-29）——待辦事項看這裡。**
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
npm run verify         # pagecontent 參照 + 導覽列 + 外部相依 + 下載資產 + QA 閘門
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

* **tw.gov.mohw.twcore**: `1.0.0` —— 臺灣核心實作指引（母規範）。
* **fhir.TWCRSF**: `0.1.1` —— 臺灣癌症登記短表實作指引（TWCR_SF），提供嚼檳榔行為之
  5 個 CodeSystem 與 4 個 ValueSet（`sf-BetNutChew*`／`sf-ObserBeh`）。
  本指引之 `TWHA-SocialHistory-BetelNut` 採其元件架構與值集（**required 綁定**），
  以與癌症登記語意一致。授權 **CC0-1.0**。

  > ⚠️ **該套件未上架任何公開 registry**（`fhir.twcrsf`／`fhir.TWCRSF` 大小寫皆 404，
  > 2026-07-28 與 2026-08-20 兩度實測）。其 IG 站台提供標準之 `package.tgz`，
  > 故 **CI 自站台取得並解入 FHIR 套件快取**，見 `.github/workflows/build-ig.yml`
  > 之「Fetch TWCR_SF package」步驟。本機建置亦須比照辦理，或先行取得該套件。
  >
  > 站台：<https://mitw.dicom.org.tw/IG/TWCR_SF/>　canonical：`https://hapi.fhir.tw/fhir/...`
  > （**canonical 是識別碼，不是下載位址；FHIR 不要求其可解析**——0.2.5 以前誤以
  > canonical 之 404 推論上游不存在，見 [JOB-28](docs/optimization/JOB-28-twcrsf-upstream-dependency.md) §1.2）。

  > 📌 **0.3.0 起本指引不再自行定義他方命名空間下的資源。** 先前之 9 個本地 stub
  > 與 `special-url` 之 9 條例外均已刪除，並由
  > [`scripts/check-dependencies.js`](scripts/check-dependencies.js) 於 CI 阻擋其復現
  > （D-1～D-4）。**CI 若抓不到套件，請修取得步驟，不要把 stub 貼回來。**

---

## 優化工作範圍 (Optimization Job Scopes)

2026-07-26 就發佈網站（<https://kunjulin.github.io/occupationIG/>）進行審閱後，
已將待優化事項整理為可獨立執行之 JOB（現至 **JOB-30**），置於 [`docs/optimization/`](docs/optimization/README.md)：

* [`docs/optimization/README.md`](docs/optimization/README.md)：審閱總結、優先序矩陣、建議執行順序、全域驗收標準。
* [`docs/optimization/evidence/qa-summary-2026-07-26.md`](docs/optimization/evidence/qa-summary-2026-07-26.md)：
  tx 建置 QA 統計基準線（err 0 / warn 208 / info 257）與術語稽核明細，供各 JOB 驗收比對。
  **重跑 tx 建置後請一併更新此檔。**
* `docs/optimization/JOB-01` ~ `JOB-29`：各 JOB 之問題證據、驗收標準、工作項目與風險；
  每份結尾均附「交給 Claude 規劃用提示」，可直接複製使用。
  （JOB-14 以後為後續審閱、主管指示或外部來函所新增之工作項。最近三項為
  [`JOB-26`](docs/optimization/JOB-26-open-issues-convergence.md) 未決事項收斂、
  [`JOB-27`](docs/optimization/JOB-27-access-control-scope.md) 存取控制範疇界定、
  [`JOB-28`](docs/optimization/JOB-28-twcrsf-upstream-dependency.md) TWCR_SF 改正式相依，
  均已於 v0.3.0 執行；
  [`JOB-29`](docs/optimization/JOB-29-betelnut-terminology-and-upstream-coupling.md)
  嚼檳榔術語與上游耦合度為 v0.3.1／v0.3.2 之**評估**，尚未實作。）

建議節奏：一個 JOB → 一次規劃 → 一個 commit。優先處理 P0（JOB-01～03）。

---

## 版本與更新記錄 (Update History)

### v0.6.0（2026-08-20）主管機關答覆之落地 ＋ 勞工區塊標 `draft`（JOB-30 §7.8）

> ⚠️ **本版含規範性中繼資料變更**：Level 2 之 50 件 artifact，其 `status` 由 `active`
> 改為 `draft`。實作端據 `status` 判斷該 artifact 是否可納入正式系統，**請留意**。
> Level 1 之 24 件不受影響（`status` 仍為 `active`）——**這正是分軌的目的**。

**三項差異已獲主管機關答覆**（2026-08-20，口頭轉述，書面待補）：

| # | 事項 | 答覆 | 處置 |
|:--|:--|:--|:--|
| ① | BMI 是否納入 21 列 | **不納入** | 維持現況；`39156-5` 供生理量測用，不屬最小上傳集 |
| ② | 第 11 列「嚼檳月數」語意 | **指「嚼了多久」** | 對映至 `component[durationYears]`；單位由固定 `a` 放寬為 `a` 或 `mo` |
| ③ | 嚼檳量單位標記 | **同意採 `{quid}/d`** | 維持現況 |

- ②之落地：`component[durationYears]` 改綁 `VS-TimeUnitYearMonth`（required），
  **不做強制換算**——把「嚼 18 個月」寫成「1.5 年」同樣會偽造精度。
  顯示名由「嚼食年數」改為「**嚼食持續期間**」；**代碼 id 保留 `duration-years`**
  （該碼已於 v0.4.0 發佈，改名屬破壞性變更；真實語意以顯示名與定義為準，不以 id 為準）。
  範例 `obs-betelnut-current` 改以 `240 mo` 示範，與 `obs-betelnut` 之 `10 a` 並存。
- ⚠️ **上開答覆為口頭轉述**：依既定立場，**取得可引用之書面依據前，M-5 狀態、
  嚼檳系列 `experimental` 與 Level 1 成熟度一律不變更**。本版僅做技術相容性調整。
- **依 PI 裁示，勞工區塊改以機器可讀方式標 `draft`**（JOB-30 §7.7 之路徑 (a)）：
  Level 2 之 50 件同時設 `standards-status = draft` 與 `^status = #draft`
  （44 件新增、6 件原已為 draft）。共用技術結構 27 件**維持不標**——裁示文字為
  「勞工區塊」，**不擴大解釋**。
- **閘門新增 G-3b**：`standards-status` 與資源 `status` 必須一致，缺一即失敗，
  反向不一致亦攔；自我測試由 8 組增為 **10 組**。
  > v0.5.0 那 71 件不一致是 **IG Publisher 抓到、本專案閘門沒抓到**——閘門當時只核對
  > 標記與登記層級是否相符，**沒核對它與資源 `status` 是否相容**。本輪補上。
- **QA 實測**：`warn` 由 v0.5.0 首輪之 162 回到 **91**（71 件 `not consistent` 全數消失）；
  `info` 具名上調 459 → **467**，新增具名類別 `Reference to draft` = 12 筆，逐筆歸因無餘數
  （`CS-PhysicalExamSystems` 6 ＋ `CS-HazardType` 4 ＝ 本次引入 10；另 2 筆為 HL7 R4 核心之
  `narrative-status`，其 status 在 R4 即為 draft，**非本次引入**）。`457 + 10 = 467`。
  ⚠️ 該類別**跟著範例走、不跟著 artifact 數走**——18 個 Level 2 CodeSystem 全改 draft，
  但只有被範例實際引用的 2 個產生訊息，**不得以「18 × N」推算**。
- **更正 v0.5.0 之一處計數敘述**：16 主項／21 列之關係為「主項＝不重複之健保醫令」，
  16 項中僅吸菸 3 列、嚼檳 3 列、尿蛋白 2 列展開，其餘 13 項各 1 列（`13+3+3+2=21`）。
  v0.5.0 誤記為「血壓 2 列」——**收縮壓 `30904X` 與舒張壓 `30905X` 是兩個獨立醫令、
  各 1 列**；兩者在 FHIR 併為一個 Observation 的兩個 component 是本指引的建模方式，
  **不是原案的計列方式**。

### v0.5.0（2026-08-20）呈現分層與權責界線（JOB-30 實作，A 部＋B 部一批完成）

> 說明：本版**未變更任何 Profile 之結構約束、值集成員或範例內容**；變更集中於
> 敘述頁、artifact 之 `Description` 標籤與 `standards-status`。
> `open-issues.md` 之**檔名、所有 `<a id>` 錨點與 `menu` target 一律未動**。
> 對外發佈前仍須以 `_genonce_tx.bat` 重跑 tx 建置。

**B 部｜治理分軌**

- `conformance.md` 新增 **§7 合規層級**：**Level 1｜Core 上傳合規**（內容依據為國民健康署
  健檢上傳欄位規範）與 **Level 2｜勞工健檢涵蓋**（內容依據為《勞工健康保護規則》附表）。
  **Level 2 以 Level 1 為前提，Level 1 不以 Level 2 為前提**；層級係本指引之
  **技術符合性層級，不構成主管機關之認證或採認**。
- **§7.0 範疇聲明**：本指引之主管機關**只有國民健康署一個**；勞工健檢項目係依該規則附表
  建立之**結構化表達**，**非另立勞工健檢規範，亦未受勞動部職業安全衛生署委任或授權**。
  `index.md` §2.2 摘要一句。
- **§7.2 之 Level 1 逐列清單**：自 `VS-CoreUploadSet` 逐列展開核對後，**與各處所載之
  「21 列」差 3 項**；隨後取得主管機關上傳欄位原案（完整編碼附件 v7.6〈Core 主管機關最小集(21)〉），
  查明**兩個數字都對、計的不是同一件事**——群組值集多了 BMI `39156-5`（原案未收，
  係 `VS-TWHAVitalSigns` 成員被一併帶入），少了嚼檳量 `30907X-2` 與嚼檳月數 `30907X-3`
  （原案各為獨立一列，本指引以 `component` 承載）。`20 − 1 ＋ 2 = 21`。
  §7.2 已改寫為**原案之 21 列**（以健保醫令為鍵值），`VS-CoreUploadSet.fsh` 亦加註三處差異。
  ⚠️ **仍待國健署確認之三項實質差異**：① BMI 是否納入；② 第 11 列「嚼檳月數」指
  **戒檳**月數或**嚼食持續**期間（**兩者語意相反**，兩個 component 皆已備妥）；
  ③ 嚼檳量單位原案記 `{個}/d`，本指引用 `{quid}/d`（UCUM annotation 僅接受 ASCII）。
  已列為 [`docs/drafts/HPA-CONFIRMATION-JOB-30.md`](docs/drafts/HPA-CONFIRMATION-JOB-30.md) 第 4 項。
- **權責標籤**：101 個定義型 artifact 之 `Description` 起首標示內容依據——
  `【主管機關：國民健康署】` **24**／`【依據：勞工健康保護規則附表】` **50**／`【技術規格】` **27**。
  導入 HL7 `structuredefinition-standards-status`（**Level 1 之 24 件標 `trial-use`；
  Level 2 與共用技術結構不標**），**IG 層 `status` 不動**——FHIR IG 一次只能發一個版本，
  分軌無法靠版次達成。
- ⚠️ **原訂「勞工區塊標 `draft`」依 CI 實測改為不標**：IG Publisher 交叉檢查
  `standards-status` 與資源之 `status`，本指引 artifact 一律繼承 `status: active`，
  標 `draft` 即自相矛盾——**實測命中 71 件**。要讓 `draft` 成立須改那 71 件之 `status`，
  屬已發佈中繼資料之規範性變更，超出本版範圍，**待裁示**（JOB-30 §7.7）。
- 新增登記表 [`scripts/governance-map.js`](scripts/governance-map.js) 與閘門
  [`scripts/check-governance-tags.js`](scripts/check-governance-tags.js)（七組自我測試，
  其中兩組為**正向對照**），已掛入 `npm run verify`。該閘門並**禁止把職安署寫成本指引之
  治理或主管機關**，且對否定句之豁免**逐行印出**，不靜默。

**A 部｜〈未決事項〉頁分層（不是搬家）**

- 標題由「未決事項」改為「**已知限制與試用須知**」（`pages:` 與 `menu:` 同步），
  **檔名與錨點不動**——站內連結與外部引用全數維持有效。
- 一覽表**一次加兩欄**：「對試用的影響」（A／B／C／D 四級）與「權責歸屬」，**26 項全填**。
  頁首加試用單位總結句：**26 項中真正可能影響欄位內容者為 3 項**（M-5／M-8／M-11）。
- 已結案 6 項移列頁尾〈已結案（存查）〉，**編號與錨點不變**。
- 逐項技術明細移至 [`docs/optimization/open-issues-detail.md`](docs/optimization/open-issues-detail.md)，頁內以單一連結指入。
- ⚠️ **權責歸屬之 T-11 依既有「決定者」欄改列**（JOB-30 初步歸類為「本專案技術決定」，
  與既有之「職醫科／平台端」矛盾），故該群 7→8、本專案技術決定 8→7。

**一併更正之過時數據**（皆屬本頁既載之事實陳述，非新增議題）

- 斷鏈之逐件筆數由「一律 +10」改為**分種類三值**：範例實例 10／CodeSystem・ValueSet 12／
  Profile 18（JOB-29 §D.5.1 實測）。
- 斷鏈總數改記 **v0.4.0 實測 2,321 筆**；`history.html` 子項之 2,026 筆註明係 2026-07-28
  實測、未再重測。

**⚠️ 嚼檳系列之 `experimental` 維持 `true`**：國健署之同意目前僅為口頭／轉述，
**未取得可引用之書面依據前不得變更**（M-5、`experimental`、Level 1 成熟度三者一律不動）。

### v0.4.1（2026-08-20）先行公布供臨床試用之整備評估（JOB-30，未變更任何定義）

> 說明：本版**僅新增評估文件** [`docs/optimization/JOB-30-publish-readiness-and-governance.md`](docs/optimization/JOB-30-publish-readiness-and-governance.md)，
> **未變更任何 Profile／ValueSet／CodeSystem／Extension／範例／頁面內容／頁面檔名／
> `menu`／`pages:`／`dependencies`，不影響 QA 基準線**。對外發佈前仍須以 `_genonce_tx.bat` 重跑 tx 建置。

**緣起（三項輸入）**　(1) 主管指示先行公布本指引供臨床試用，並詢問可否將〈未決事項〉改於 GitHub 維護；
(2) 主管機關為國民健康署（16 主項／21 欄位），該署不希望為勞工相關項目拖延進度；
(3) **國健署表示：只要嚼檳榔一併定案，即同意 21 項上傳項目**。

- **✅ 更正前稿之核心論據**：本文取代 2026-08-20 兩份**未套用**之評估草稿（原擬 v0.3.4／v0.3.5，
  以 `70ba822b` 為基準，**未進入 repo、不佔版次**）。原稿指稱「Core 21 列唯一實質缺口為嚼檳狀態」，
  **該結論已因 v0.4.0 之實作而不成立**：`value[x]` 已約束至 `VS-BetelNutStatus`（與吸菸四碼逐碼對稱）、
  三個 component 由 `1..1` 改為 **`0..1`** 並改以 UCUM `Quantity` 承載、
  `Observation.code` 解耦為 `SCT#698188003`，且 `experimental` 旗標之理由**已重新評估並書面更換**為
  「本地值集皆為 provisional，待 M-5」。
  → **Core 21 列現已全數具備承載**，Level 1 清單可完整列出而無須暫註，A 部與 B 部**得於同一批次執行**。
- **A 部｜〈未決事項〉頁：分層，不是搬家**。v0.4.0 實測耦合度：站內連結 **31 處**
  （具名錨點 **24 處**）、原始碼路徑引用 **40 處**、頁面 **803 行**、條目 **26 項**（已結案 6 項）。
  建議：**改標題不改檔名**（「未決事項」→「**已知限制與試用須知**」，31 處連結與外部引用全數維持有效）、
  一覽表加「對試用的影響」欄（**26 項中僅 M-5／M-8／M-11 三項可能影響欄位內容**）、
  已結案 6 項移頁尾存查（錨點保留）、續辦工項移 `docs/optimization/`（預期 803 → 約 400 行，
  「移到 GitHub 維護」之訴求於此達成）。
- **B 部｜治理分軌**：`conformance.md` 新增 §7 **Level 1｜Core 上傳合規**（國健署）／
  **Level 2｜勞工健檢完整**（職安署），**Level 2 以 Level 1 為前提，Level 1 不以 Level 2 為前提**；
  逐 artifact 標**權責標籤**與 HL7 `structuredefinition-standards-status`（本 repo 實測 **0 處**使用），
  Core 標 `trial-use`、勞工標 `draft`，**IG 層 `status` 不動**
  （FHIR IG 一次只能發一個版本，分軌**無法靠版次**達成）；一覽表併加「**權責歸屬**」欄。
  **不建議拆成兩個 IG**（canonical 未核定，拆後兩個都要等）。
- **⚠️ 本文於定稿前更正一處越權瑕疵**：初稿把**勞動部職安署列為本指引勞工區塊之「治理機關」**，
  惟該署**未參與本案、未委任本指引、亦未對其內容表示意見**。
  **本指引之主管機關只有國民健康署一個**；《勞工健康保護規則》係**內容依據**，不是治理關係。
  更正內容：(1) §3.1 之表格欄位由「主管機關」拆為「本指引之主管機關」與「內容依據」，
  並新增**範疇聲明**（勞工健檢項目係依該規則附表建立之結構化表達，
  **非另立勞工健檢規範，亦未受該署委任或授權**；涉及法定解釋者僅載明規則要素並指向待釋示）；
  (2) Level 2 更名為「勞工健檢**涵蓋**」，其欄位由「治理機關」改為「內容依據」；
  (3) artifact 標籤改為 `【主管機關：國民健康署】`／`【依據：勞工健康保護規則附表】`／`【技術規格】`，
  並以驗收條件禁止「治理：職安署」等表述復現；
  (4) 一覽表欄名由「治理機關」改為「**權責歸屬**」並重新歸類——初稿把 M-8、T-9、T-8 劃給職安署，
  與 `open-issues.md` 既有「決定者」欄（分別為「本專案」「本專案」「主管機關」）不符，
  **僅 M-11 真正觸及該規則之法定解釋**。
  更正後對國健署之引用句更有力：26 項中屬 貴署權責者為 **M-5 一項**，
  其餘為本專案技術決定 8／平台端與跨部會 7／法規解釋 1／政策契約層 3／已結案 6，
  **本指引無第二個主管機關**。
  > 為何是「界定」而非「忽略」：完全不提該署，日後若有人主張本指引在替其訂規範，
  > 文件裡沒有可引用的反證。**明文寫成非治理關係，比默默不提安全**——
  > 與 M-6（保存期限移出範疇）、JOB-27（存取控制移出範疇）採同一手法。
- **§3.4 M-5 結案路徑（因國健署附條件同意而新增）**：本項之處理**不是等待，而是主動送簽**。
  先釐清「定案」係指**技術結構**（本團隊職權，v0.4.0 已完成）或**填報規格**（須該署確認），
  並列出五項確認事項——嚼檳狀態四碼值域（**係本指引自訂之對稱設計，非取自該署原文**）、
  量／年／戒除之 UCUM 承載方式、口腔黏膜檢查表 6 選 1 級距（**取自該署原文**）、
  21 列逐列確認、**生效時點**（內容獲同意 ≠ 已公告）。
  取得書面後始依序處置：M-5 改標「附條件同意，條件已成就（依 ○函）」→ 嚼檳系列 `experimental` 重新評估
  → Level 1 成熟度升級。
  ⚠️ **在取得可引用之書面依據前，上述三項一律不得先行變更**——口頭或轉述之同意不足以支撐規範文件之狀態變更。
- **執行方式**：五個步驟一批完成（合規層級 → 一覽表**一次加兩欄**＋已結案移頁尾 → 標題 → 治理標籤與
  `standards-status` → 續辦工項外移），建議實作版次 **v0.5.0**。

**本版不實作，待裁示後執行。**

### v0.4.0（2026-08-20）嚼檳榔 Profile 解耦與欄位擴充（JOB-29 C-0 ＋ 路徑甲）

> ⚠️ **本版含規範性變更**：`TWHA-SocialHistory-BetelNut` 之 `Observation.code`、
> `value[x]` 與三個 `component` 之型別／基數／綁定均有變動，既有範例已同步改寫。
> 實作端須依新結構調整。

- **C-0**：`Observation.code` 由上游 `sf-ObserBeh#BetelNutChewing` 改為
  **SNOMED `698188003`（Chews betel quid）**。此舉同時消除與
  [`general-exam.md`](input/pagecontent/general-exam.md)／[`datamodel.md`](input/pagecontent/datamodel.md)
  之落差（兩頁在與吸菸相同之欄位早已宣稱該碼），並移除本 Profile 對上游之**最後一處硬綁定**
  ——該欄位為 `1..1` 且固定為上游代碼，不改則其餘解耦做完仍達不到「可切換級」。
- **補既存缺件**：新增 `value[x]` 承載嚼檳狀態，綁定
  [VS-BetelNutStatus](ValueSet-VS-BetelNutStatus.html)（4 碼，與 `CS-SmokingStatus` 逐碼對稱）。
  **不含 `unknown`**——狀態不詳者以 `dataAbsentReason` 表達，使「狀態不詳」與
  「狀態已知但量不詳」得以區分。
- **量／年數／戒除期間改 UCUM `Quantity`**（`{quid}/d`、`a`、`a` 或 `mo`）；
  `component.code` 改用本地 `CS-BetelNutComponent`——**這才是解耦的實際著力點**：
  值改成 Quantity 仍不夠，`component.code` 若續用上游，建置照樣要解析上游 canonical。
  上游級距碼降為可選 component（`amountCoded`，extensible），**移除之不影響任何核心資料**。
  三個 component 由 `1..1` 改為 `0..1`——舊版使「從未嚼食」者仍須填三個哨兵碼，
  其中 `quit#88`（無嚼檳榔）與 `amount#88`（每日 88 顆）同碼異義。
- **依委員意見增列欄位**：是否含菸草、添加物、石灰種類、戒除日期、資料來源（LOINC `48766-0`）。
  添加物與石灰種類**拆為兩個軸**而非四選一——一個人可以「荖葉＋白灰」。
- **panel 化採選項甲**（維持單一 Observation ＋ component）：委員之立論為鏡射菸品 panel，
  惟本指引吸菸 Profile 繼承 TW Core 之單一 Observation，且 [T-10](input/pagecontent/open-issues.md)
  已裁示維持繼承——僅檳榔 panel 化反而造成與吸菸不對稱，與該立論相反。
- **[`terminology.md`](input/pagecontent/terminology.md) §6.2b 全面改寫**：三套來源
  （國健署上傳欄位／口腔黏膜檢查表／TWCR_SF）之界線、上游代碼落點對照、
  跨清單同碼異義之警示。§6.2b 原述之【本地 stub】架構已於 v0.3.0 刪除，該段敘述一併更正。
- **口腔黏膜檢查表之 6 選 1 級距已落地**（`CS-BetelNutHpaCategory`，[T-13](input/pagecontent/open-issues.md) 結案）：
  原文於同日取得，六個級距逐字錄入。原文到手前本案拒絕擬稿，**事後證實該判斷正確**——
  實際級距是「嚼食年數 × 每日顆數」之 2×2 交叉（如「嚼超過 10 年，每天 20 顆及以上」），
  與一般會憑空擬出的單維分段形狀完全不同。**可導出界限，但不得取區間中點**（假精確會污染
  dose-response 分析）。⚠️ 該表在其來源文件中標為【附表九】（國民健康署），
  與《勞工健康保護規則》**附表九**分屬不同法規、內容全然無關。
- **附錄 B.8 #1 作廢**：以 CI `$lookup` 實測，`8663-7` 之 `EXAMPLE_UCUM_UNITS`
  **官方即為 `{#}/d`**，委員係逐字引用；本案原由「全名含 pack per day」推論應為 `{pack}/d`，
  該推論方法本身即 JOB-18 所戒之「以名稱推單位」。詳見 JOB-29 §B.8.1。

### v0.3.3（2026-08-20）JOB-29 評估之內部一致性修訂（仍不實作）

> 說明：本版**僅修訂評估文件**，未變更任何 Profile、值集、CodeSystem、Extension、範例、
> 頁面檔名或 `dependencies`。另加入一次性 CI 診斷步驟以實證附錄 B.5 之主張，**取得結果後移除**。

- **§2.4 之查證狀態敘述更正**：初稿據修訂案 v2.1 之「無國際碼」推論 SNOMED `698188003`
  「屬未驗證對照」，惟 [`terminology.md`](input/pagecontent/terminology.md) §4.1 已明列其為
  「**✅ 已驗證 2026-07-26**」（`tx.fhir.org`、`$validate-code`），§4.2 之免責語亦明確將其排除，
  **該推論不成立**。尚待補者為以 **`$lookup`** 取官方 FSN 並確認其作為 `Observation.code` 之
  **語意適切性**——依 [CLAUDE.md](CLAUDE.md) §2.2，「代碼有效」與「語意正確」不可互相取代
  （2026-07-26 查出並移除之 16 個錯碼，全部都通過了代碼有效性檢查）。
- **驗收標準之載具與單位更正**：#6 由 `display-verification-report.csv` 改為
  `terminology.md` §4.1——前者為 **LOINC 專用**產物（324 列、無任何 SNOMED 碼），字面上無法滿足；
  #3 之戒除期間單位隨 §3.2／§A.6 更正為「`a` 或 `mo`，以原始採集粒度為準」（原寫「一律 `mo`」）。
- **新增 §2.1.1：同一支 Profile 之第二處落差**。`Observation.code` 固定為上游
  `sf-ObserBeh#BetelNutChewing`，而 [`general-exam.md`](input/pagecontent/general-exam.md) 與
  [`datamodel.md`](input/pagecontent/datamodel.md) 在**與吸菸相同之欄位**（吸菸列填的正是其實際
  code `LNC#72166-2`）均宣稱嚼檳之 code 為 SNOMED `698188003`。該欄位為 **1..1** 且固定為上游代碼，
  是本 Profile 對上游**最後一處硬綁定**——不改則 C-1／C-2 做完仍達不到「可切換級」。
  故 §5 **增列 C-0 並排序於 C-1 之前**，與 §A.1 原本之寫法一致。
- **附錄 B.2 之 display 裁定回頭套用至文件自身**：B.2 判定 `"Betel nut chewer"` 應為
  `"Chews betel quid"`，但 §A.1 之 FSH 骨架與 §A.2 之 JSON 範例仍寫著錯誤 display——
  而那兩處正是實作者複製貼上的來源。已就地更正。**repo 內之敘述頁本來就是對的**
  （`terminology.md` §4.1、`datamodel.md`、`general-exam.md`、`VS-CoreUploadSet.fsh` 均已用
  `Chews betel quid`），錯誤僅存在於評估文件與對外之修訂案 v2.1。
- **新增附錄 C**：套用時之 repo 逐項核對結果（9 項屬實、2 項須更正、4 項因 proxy 限制未能複驗）。

### v0.3.2（2026-08-20）委員意見之逐項處置（JOB-29 附錄 B，未變更任何定義）

> 說明：本版**僅於 JOB-29 補入附錄 B**，未變更任何 Profile、值集、CodeSystem、Extension、範例、
> 頁面檔名或 `dependencies`，**不影響 QA 基準線**。對外發佈前仍須以 `_genonce_tx.bat` 重跑。
> 緣起：委員就菸品在 FHIR 之標準表達、檳榔標準碼現況（Ontoserver SNOMED CT 2026-07-31 版展開）
> 與建議之 IG 設計提出完整方案。

**[JOB-29 附錄 B](docs/optimization/JOB-29-betelnut-terminology-and-upstream-coupling.md)｜委員意見（2026-08-20）之逐項處置**

- **直接採認 7 項**：SNOMED 全部 betel 相關概念僅 6 個且**無 ex-chewer／never-chewer、無 duration／amount observable**
  （此查證直接補上本評估 §2.4 之缺口）；不可挪用菸品 LOINC（`88029-4` 等）記檳榔年數，否則造成菸品暴露之假陽性；
  自建 CodeSystem／ValueSet 並鏡射菸品結構（與本案獨立得出之結論一致）；戒除以 `bq-quit-date`（dateTime）
  為原始事實優先於期間；`bq-with-tobacco`（IARC 對含／不含菸草分開評估）；資料來源 LOINC `48766-0`；
  原始勾選保留為 coded Observation 且**不換算成中位數**（與 T-9「保留原始 coding」同一原則）。
- **據以更正本案一處 display**：`698188003` 之官方詞條為 **`Chews betel quid`**，本評估 §A.1 與
  《建議修訂案 v2.1》第 9 列均寫 `Betel nut chewer`，屬 JOB-01 所稽核之 `Wrong Display Name` 類別。
- **附條件同意 3 項**：(1) 狀態值集**維持 4 碼**——`unknown` 應走 `dataAbsentReason`，放進值集即是委員自己
  在檢視上游時所批評的「哨兵值混編」，且會使「狀態不詳」與「狀態已知但量不詳」無法區分；
  (2) 派生值改用 **`valueQuantity` + `comparator`** 而非 `valueRange`——R4 之 `value-quantity` expression 為
  `(Observation.value as Quantity) | (Observation.value as SampledData)`，**不含 `Range`**，
  故 `valueRange` 反而**不可**搜尋，與委員第一節「一律用 valueQuantity 保證可 search」之主張自相衝突
  （本容器連不到 hl7.org，附錄 B.5 附本機一行複核指令，**不採信本文陳述**）；
  (3) `bq-type` 之「荖花／荖葉／紅灰／白灰」實為**兩個軸**（添加物／石灰種類），一人可「荖葉＋白灰」，
  應拆分或改 `0..*`。
- **不同意 2 項（技術與事實）**：CodeSystem canonical 不得置於 `hpa.gov.tw` 命名空間
  （`check-dependencies.js` **D-2** 即為此設，俟 M-1 核定後再議）；**TW Core 現行版本為 v1.0.0 而非 v0.3.2**
  （JOB-23 實測、本案 `dependencies` 即為 `1.0.0`），所引 `tw-core-7`／`tw-core-8` invariant 是否存續於 v1.0.0
  須複核後再引用。
- **列管 1 項（須 PI 裁示）**：改為 **panel + `hasMember`** 之多 Observation 結構。本指引之吸菸 Profile
  `Parent` 為 `TWCoreSmokingStatus`（單一 Observation），而 JOB-26 已裁示 **T-10 維持 TW Core 繼承**，
  故吸菸不能 panel 化；**若僅檳榔 panel 化，結果是檳榔與吸菸在本指引內結構不對稱——正好與委員
  「鏡射菸品」之立論相反**。附錄 B.7 列甲／乙／丙三選項，建議**甲**：維持 component 結構但完整採納
  委員之欄位清單，取得內容價值而不付結構重構成本。
- **另指出委員方案四處技術細節須更正**：`8663-7` 單位應為 `{pack}/d`（其 LOINC 全名即 "pack per day"）
  而非所標之 `{#}/d`，**與 JOB-18 所修正之事故完全同型**；三-D 範例之 `hasMember` 掛在 `bq-duration` 上
  並指向 `bq-status`，應掛於 panel（與其自身 A 表矛盾）；`valueRange` 可搜尋之陳述（見上）；
  `{quid}.a` 與 `a` 在 UCUM 下**同量綱**（註記不影響可換算性），查詢 `value-quantity=gt10||a`
  會同時命中嚼食年數與累積顆-年，故搜尋**必須併帶 `code=`**。
- **範疇提醒**：現有**三套來源**不可混為一談——國健署健檢上傳欄位（無編碼，本案 Core 之對標對象，M-5）、
  口腔黏膜檢查表（6 選 1 bucket，癌症篩檢用表，委員 `bq-hpa-category` 所本）、TWCR_SF（逐顆逐年列舉碼，
  現行綁定來源）。三者對照關係應於 `terminology.md` 以一張表明列。
- **委員提議產出 FSH／JSON 草稿**：建議俟 panel 選項題裁示後再行產出，避免依甲／乙／丙不同結構重工。

### v0.3.1（2026-08-20）嚼檳榔術語之權責界線與上游耦合度（JOB-29 評估，未變更任何定義）

> 說明：本版**僅新增評估文件**，未變更任何 Profile、值集、CodeSystem、Extension、範例或頁面檔名，
> 亦未變更 `dependencies`，**不影響 QA 基準線**。對外發佈前仍須以 `_genonce_tx.bat` 重跑。
> 緣起：(1) 國民健康署上傳欄位文件之嚼檳榔欄位無編碼，詢問可否比照吸菸自訂值集；
> (2) 取得 TWCR_SF 上游 `package.tgz` 後，發現封裝內含 `file://C:\Users\Lily\TWCR_SF\output`
> 之開發者本機路徑。

**[JOB-29](docs/optimization/JOB-29-betelnut-terminology-and-upstream-coupling.md)｜嚼檳榔術語之權責界線，與 TWCR_SF 相依之耦合度調整（評估）**

- **兩個問題必須分開答。** 「檳榔沒有碼，是不是我們自己定？」混合了術語治理（誰有權在哪個命名空間定義代碼）
  與相依治理（建置的可重現性）兩個層次，答案不同：**狀態欄位應自訂；量／年／戒除不應自行複製上游代碼，
  而應降低耦合度。**
- **查出一項既存缺件**：《建議修訂案 v2.1》第 9 列載明嚼檳狀態「建 `CS-BetelNutStatus`」，
  但該 CodeSystem 於 repo 內**並不存在**，且 `TWHA-SocialHistory-BetelNut` 未約束 `value[x]`、
  亦無 status component——**「嚼檳狀態」在指引中沒有承載位置**。此性質與 JOB-18 之 UCUM 落差同型，
  但更嚴重（那是單位標錯，這是欄位缺件）：若外部依修訂案第 9 列實作，送出之資源無法通過本指引之 Profile。
- **自訂沒有治理障礙**：建議之 canonical 位於本指引自己的命名空間，與 `check-dependencies.js` **D-2**
  所禁止的情形（在他方命名空間下發佈定義）正好相反；上游 TWCR_SF 為 **CC0-1.0**，亦無授權障礙。
  依 `CS-HealthMgmtLevel` 之既有格式標 `experimental = true` 並載明 provisional 即可。
- **量／年／戒除的問題不在「誰的碼」，在「不該是碼」**：以 94 個代碼列舉「每日 N 顆」係把數值編碼化，
  與同指引之吸菸建模（`64218-1` + UCUM `/d`）不對稱，且 `required` 綁定使建置成為單點相依。
  建議主軸改 `Quantity`（`{quid}/d`／`a`／`mo`），上游級距碼降為可選 component（`extensible`）。
- **上游封裝瑕疵**：`file://` 本機路徑之嚴重度取決於落點——落在 `canonical`／資源 `.url` 為**致命**，
  落在建置參數則非致命。本容器之 proxy 封鎖上游站台無法複驗，故 JOB-29 §4.2 提供三行定位指令，
  §4.3 給出分級表，**不預先斷言**。無論落點為何，「未上架 registry ＋ CI 須抓 static file ＋
  封裝含本機路徑」三者合起來，對國家 IG 報備審查構成**可重現性**風險：審查方無法以標準工具鏈重建本指引。
- **明確不建議**：退回本地 stub（D-4 即為此設，且屬治理倒退）、把上游 90 餘碼複製進本命名空間
  （製造第二套權威來源，JOB-10 §7.3 已否決）、等上游修復（v0.1.1 為 2024-08-01 建置，無時程可依）。
- **路徑 C（解耦而非切斷）**：C-1 主軸改 Quantity、C-2 上游碼降為 `extensible` 可選 component、
  C-3 保留正式相依不推翻 JOB-28、C-4 新增閘門 **D-5**（套件內不得含 `file:` scheme、canonical 須為 https，
  自帶負向測試）、C-5 由工研院轉知上游並請其上架 registry（**本案不等待**）。
  重點在 C-2：**把單點相依從「建置阻斷級」降為「可切換級」**。
- **另查出一項單位錯誤**：修訂案 v2.1 將嚼檳量之 UCUM 標為 `{個}/d`，惟 UCUM 註記僅允許可列印 ASCII 字元，
  中文不在其列，**`{個}/d` 並非合法 UCUM code**。應為 `Quantity.code = {quid}/d`、`Quantity.unit = 顆/日`。
  與 JOB-18／19 之 `{pack}/d` 同型。**repo 內未出現此字串（已全庫檢索），僅影響對外文件。**
- **附錄 A（改版後之完整範例）**：給出建議之 Profile 骨架、四種臨床情形之 FSH 與 JSON 範例
  （已戒／目前每日嚼食／從未嚼食／有嚼但量不詳）、同一位受檢者之新舊對照，以及上游代碼之落點對照表。
  **逐碼檢視上游三個清單後另查出兩項語意風險**：(1) 數值與哨兵值混編於同一代碼軸——
  `sf-BetNutChewAmount` 之 `01`–`89` 是數量、`90` 是設限值（≧90）、**`91` 其實是狀態**（偶爾嚼、無定量）、
  `98`／`99` 是缺值原因，接收端把代碼當數字用即誤讀；(2) **跨清單同碼異義**——`#88` 在量的清單是
  「每日 88 顆」、在戒除清單是「無嚼檳榔」，實作端錯置代碼系統會產生反向誤讀，
  **且 `required` 綁定攔不住**（兩個綁定各自都通過，只是綁錯 component），
  性質同修訂案 v2.1 第 1 項（22326-3 誤用）之送審阻斷級語意風險。
- **附錄 A.6 修正本評估自身之一項寫法**：§3.2 原寫戒除期間 UCUM「一律 `mo`」，
  經逐碼檢視改為 **`a` 或 `mo` 並行**，以原始採集粒度為準——上游以「年」收集，
  強制乘 12 會**偽造精度**；且吸菸之 `63632-4` 官方例示單位本即 `d`／`wk`／`mo`／`a` 四者並列。
- **本版不實作。** 綁定強度變更屬規範性變更，且會影響既有範例 `obs-betelnut`，
  依既定慣例（評估與實作分兩個版次）待核准後於下一版執行。

### v0.3.0（2026-08-20）未決事項收斂、存取控制範疇界定、TWCR_SF 改正式相依

> 說明：本次**未變更任何 Profile 綁定、值集成員、範例或頁面檔名**。變更集中於治理層（未決事項之定案與範疇界定）、文件層（範疇聲明）與相依層（外部套件）。
> 緣起：2026-08-20 國民健康署來函詢問定案時程與「定案前可否提供健保署及醫療院所應用」，據以全面盤點未決事項。

**（一）[JOB-26](docs/optimization/JOB-26-open-issues-convergence.md) 未決事項收斂**

- **目標不是清空清單，而是逐項標示「本項是否影響主管機關現在就要公告的內容」。** 經查證，[US Core v9.0.0](https://hl7.org/fhir/us/core/toc.html) 與 TW Core IG v1.0.0 **均無 known issues 專頁**，故本指引之〈未決事項〉頁並非國際慣例，而是受託研製中草案之誠實揭露；其價值在於可被逐項回答。
- **A 類逕行定案 6 項**：M-8（情境資料集**分期落地規則**，T-1 已結案故相依解除）、M-9（**預設 `transaction`**，`batch` 為可選；因範例 entry 結構兩者通用，定案不影響已發佈範例）、T-3（SNOMED 未驗證對照之三條處置規則，**本版即生效不待 T-4**）、T-9（未結構化項目**保留原始 coding、接收端不得拒收**）、T-10（**維持 TW Core 繼承**，不為單一議題脫離母規範）、T-6（見下）。
- **範疇界定 2 項**：**M-6《勞工健康保護規則》第 19 條保存期限 → 不列入本指引範疇**。保存期限係各事業單位與醫療機構**依法自行辦理之行政義務**，與資料如何交換無涉；且起算點（檢查日／報告日／離職日）尚無定論，**在法律解釋確定前結構化進欄位等於把未定解釋寫死進規範**。M-7 隨之關閉，`ext-retention-period` 自 backlog 移除。**兩者均保留編號並改標狀態，未刪除條目**（依「編號一經公開即不變更」之規則；悄悄消失會被解讀為掩蓋）。
- **T-6 逐項補列理由**，並分兩類：**【A】應長期保留 1 個**——`VS-UnfitDiseases` 之定義為 `include codes from system ICD10CM`，即**意向式引用整個 ICD-10-CM**，須由 tx 端展開整個外部代碼系統，**這是 `no-validate` 的正當用途**；**【B】具備移除條件 5 個**——均為逐碼列舉清單且已通過 JOB-01／19／20 稽核。**本版不逕行移除【B】**：移除後可能一次浮出大量訊息，依既定原則**不預先猜測 QA 數字**，改於 CI 提供 `drop-no-validate` 實驗開關取得實測值後再行移除。
- **文件一致性修正**：`open-issues.md` 之 P-1 記「每新增一個 artifact 增加 **12** 筆」，與 `qa-baseline.json` 之實測註記（**+10**，5 種渲染變體 × 2 層）不一致，**依實測更正**。
- **結果**：標「待決」之項目由 18 項降為 **8 項**；其中**僅 2 項**（Core 欄位清單本身、事業單位識別碼）涉及主管機關擬公告之欄位內容。

**（二）[JOB-27](docs/optimization/JOB-27-access-control-scope.md) 存取控制範疇界定**

- **`security.md` 新增 §0 範疇聲明**：**本指引不規定「誰可以看病歷」**。何人得以存取屬法規、主管機關函釋與機構政策範疇。依據為 TW Core IG〈安全性〉頁原文——「系統**可以（MAY）**透過加密和相關存取控制來保護資料的機密性。**所使用的策略和方法不在此規範的範圍內**」、「系統建議應該（SHOULD）**依據國家、地方和機構政策**實作同意要求」。
- **但「封包裡放什麼」是本指引職責，且已定案**：§0.1 以對照表區分 **(a) 存取控制**（不在範圍）與 **(b) 交換內容組成**（本指引職責）。以雇主端為例——本指引不規定雇主有無權限存取，但**明確規定**雇主端封包之 `section` 採 **closed slicing**，**結構上不含檢驗 section**；此為**驗證器會擋下來的結構約束，非原則宣示**。
- **[M-10](input/pagecontent/open-issues.md) 改名**為「**稽核與同意機制之選型**」。原標題「雇主端資料隔離之實作機制」讀起來像揭露範圍未定，實則範圍已定案，未定的僅為 `Consent`／`Provenance`／`AuditEvent`／SMART scope 之機制選型。內文明列揭露範圍與存取控制政策**均不在本項範圍內**；技術建議標明為**技術設計建議，非本指引之政策認定**。
- 本項與 JOB-26 之 M-6 採**同一原則**：法規與機構政策層面之決定不納入資料規格。

**（三）[JOB-28](docs/optimization/JOB-28-twcrsf-upstream-dependency.md) TWCR_SF 改為正式相依**

- **先前判定不成立**。[JOB-10](docs/optimization/JOB-10-twcrsf-dependency-governance.md)（2026-07-28）探測三個 package registry 與 `hapi.fhir.tw` canonical 皆 404，據以走路徑 B（本地 stub）。該判定**就其探測範圍而言正確，惟未涵蓋 IG 站台本身**——**canonical 是識別碼，不是下載位址，FHIR 不要求其可解析**。
- **2026-08-20 重新查證**：上游站台為 `https://mitw.dicom.org.tw/IG/TWCR_SF/`，**v0.1.1**，`package.tgz` **HTTP 200（734 KB）**，`packageId = fhir.TWCRSF`，`status = active`、`experimental = false`、`content = complete`，授權 **CC0-1.0**；`sf-BetNutChewAmount` 上游 **94 碼，與本地 stub 94 碼完全一致**。套件本身仍未上架任何 registry（大小寫皆 404）。
- **變更**：新增 `fhir.TWCRSF: 0.1.1` 正式相依；**刪除 `TWCRSF-mocks.fsh`（5 CodeSystem ＋ 4 ValueSet）**；**移除 `special-url` 之 9 條例外**；G-5 結案。**`aliases.fsh` 與 `TWHA-SocialHistory.fsh` 均無須修改**——別名以 canonical 表達，而 canonical 在 stub 與上游之間是同一字串，這是本次切換成本低的主因。
- **CI 新增 `Fetch TWCR_SF package` 步驟**：自 IG 站台取得 `package.tgz` 解入 `~/.fhir/packages/fhir.TWCRSF#0.1.1`，並**驗證 `package.json` 之 name／version 與預期相符**（避免取到錯誤頁或改版內容而不自知）；置於 `Cache FHIR packages` 之後，快取命中時為 no-op。
- **新增 [`scripts/check-dependencies.js`](scripts/check-dependencies.js) 外部相依閘門**：**D-1** 相依須宣告／**D-2** FSH 不得以 `^url` 自行定義他方命名空間／**D-3** `special-url` 不得復現／**D-4** 已刪除之 9 個 stub id 不得復現。**設此閘門之理由**：CI 若抓不到套件，最容易發生的「修法」是把 stub 貼回來讓 CI 轉綠——**那是還原成舊的權宜作法而非修復，且不會有任何錯誤訊息**。內建負向測試 4 組 ＋ **正向對照 1 組**（乾淨狀態不得誤報）；**對 0.2.5 舊狀態實跑攔下 11 筆**（D-1 一筆、D-2 九筆、D-3 一筆）。
  - ⚠️ D-3 首版以單一正則取 `special-url` 區塊，因 `\s` 跨行吃掉換行而誤判邊界，**負向測試當場抓到靜默放行**，已改為明確的行狀態機。這正是負向測試存在的理由。
- **附帶修正**：`VS-CoreUploadSet` 描述原載「嚼檳量／嚼檳月數屬本地 Extension（`ext-betelnut-quantity`）」，**兩處皆誤**——該 extension **不存在**，且實際由 TWCR_SF 之 component ＋ 值集承載（required 綁定）。已改寫，並註明**上游以「年」計，與吸菸之戒除「月數」（`LNC#63632-4`）單位不同**。此類錯誤 `check-pagecontent-refs.js` 抓不到（只掃 pagecontent 不掃 FSH `Description`），屬已知缺口。

**（四）版次與待驗證事項**

- `sushi-config.yaml` `0.2.5` → `0.3.0`；`package-list.json` 新增條目；`npm run verify` 納入 `check:deps`。
- ⚠️ **本容器 proxy 封鎖 `packages.fhir.org`／`packages2.fhir.org`／`mitw.dicom.org.tw`，無法執行 SUSHI 或 IG Publisher。** 已完成之驗證：`check:refs`、`check:menu`（7 組負向測試）、`check:deps`（5 組負向測試＋對舊狀態之回歸佐證）、CI workflow YAML 解析、T-6 實驗開關腳本實跑（正確移除 5 項、保留 `VS-UnfitDiseases`）。
- **待 CI 首次執行確認**（JOB-28 §6）：套件下載與 name／version 驗證、SUSHI 解析 9 個 canonical、`Reference to experimental` 之實際降幅（現為 15 筆，**不預先承諾數字**）、移除 `special-url` 後無新增未解析訊息、`err = 0` 維持。**若 SUSHI 解析失敗，正確處置是修取得步驟，不得還原 stub（D-4 會擋）。**
- **對外發佈前一律以 `_genonce_tx.bat` 重建並檢視 `output/qa.html`**；`qa-baseline.json` 須依 CI 實測更新並具名說明。

### v0.2.5（2026-08-17）頁面標題中文化（JOB-25）＋ 已發佈站台對標查閱

> 說明：本次為**呈現層變更**，未變更任何 Profile、ValueSet、CodeSystem、Extension 或範例之定義，亦**未變更任何頁面檔名**。
> 緣起：2026-08-14 工業技術研究院生醫所李建儒經理反映「格式可能還是要對標一下 TW Core IG，風格不大一樣，提案有要求一致性」。

**（一）已發佈站台查閱結果（2026-08-17，<https://kunjulin.github.io/occupationIG/> v0.2.4）**

- ✅ 網址為 `/zh-TW/`、`<html lang="zh-TW">`；導覽列頂層 **8 項、純中文、文件類型導向**——[JOB-23](docs/optimization/JOB-23-navigation-alignment-twcore.md) 確認生效。
- ✅ 頁尾為「IG © 2026+ …／套件 `mohw.tw.twha#0.2.4`，基於 FHIR 4.0.1。／產生日期 2026-08-17／連結: 目錄 | QA 報告」——[JOB-24](docs/optimization/JOB-24-zh-tw-template-strings.md) 確認生效。
- ❌ **新發現**：全站每一頁之 `<title>`、頁首 H1 與麵包屑仍為英文——`Home`、`Table of Contents`、`Artifacts Summary`、`Examples`、`Security`、`Open Issues`、`General Exam`…；TW Core 對應位置為「應用說明」「目錄」「規範文件」「範例」「安全性」。

**（二）本次修正（JOB-25）**

- **根因**：`sushi-config.yaml` 未宣告 `pages:` 時，**SUSHI 會自動收錄 `input/pagecontent/*.md` 全部檔案，並以「檔名去副檔名後轉 Title Case」推導頁面標題**（`index.md` → `Home`、`general-exam.md` → `General Exam`），寫入 `ImplementationGuide.definition.page.title`，再由模板填入 `<title>`／H1／麵包屑。
  - ⚠️ **與 JOB-24 為不同來源**：JOB-24 補的是模板介面字串（`stringsBase.json`）。同一個 `TableOfContents` 鍵在頁尾已正確顯示「目錄」，麵包屑卻仍是英文，即可證兩者機制不同。
- **新增 `sushi-config.yaml` 之 `pages:` 區塊**，逐頁指定中文標題（19 頁全數列入）。排列順序**同時決定 `toc.html` 之章節順序**，故刻意排成與導覽列一致，使兩者互相對應。
- **`scripts/check-menu.js` 新增 R-6 閘門**：
  - **R-6a** 每個 `input/pagecontent/*.md` 均須列於 `pages:`；**R-6b** `pages:` 條目須有對應實體檔案；**R-6c** `title` 不得為空（三者失敗即 `exit 1`）；**R-6d** `title` 不得等於 SUSHI 依檔名推導之預設值；**R-6e** `index.md` 須為第一項（後二者警告）。
  - **設此閘門之理由**：**宣告 `pages:` 後 SUSHI 即停止自動收錄——未列於其中的頁面會從建置產出中靜默消失，且不會有任何錯誤訊息**。與 JOB-23 之位移型錨點、JOB-24 之缺語系字串同屬「靜默失效」型缺陷。
  - 負向測試由 3 組增為 **7 組**（新增 R-6a／R-6b／R-6c／R-6d），CI 中仍先跑負向測試再跑實檢。
- **`sushi-config.yaml`**：`version` 由 `0.2.4` 調整為 `0.2.5`。**`package-list.json`**：新增 0.2.5 條目。

**（三）建置後複核結果（2026-08-17，已發佈站台 v0.2.5）**

- ✅ **N-1 確認生效**：線上實測 `index.html` → `應用說明`、`examples.html` → `範例`、`security.html` → `安全與個資保護`、`open-issues.html` → `未決事項`、`general-exam.html` → `一般健康檢查`。
- ⏸ **N-2 結案——`toc.html` 自身標題為 SUSHI 上游限制，不予 workaround**。已自實際產出逐層回溯確定來源：模板字串已譯且於頁尾生效（排除）→ 模板 XSLT 之**輸入**檔即已含該值（排除模板）→ SUSHI 產出之 `ImplementationGuide.definition.page` 根節點即為 `{nameUrl: toc.html, title: "Table of Contents"}`。SUSHI `dist/ig/IGExporter.js` 將此值**寫死**，`pages:` 之條目全數推入子節點 `definition.page.page`，根節點 title 不被覆寫，且 `definition` 區塊僅讀取 `extension`——故**無法自 `sushi-config.yaml` 設定**。為改一個字而覆寫 SUSHI 產出之 IG 資源會使整份定義脫離工具鏈管理，代價高於效益；實際影響僅 `toc.html` 一頁之分頁標題，該頁**內容之 19 個章節名稱已全數中文**。詳見 [JOB-25 §4.1](docs/optimization/JOB-25-page-titles-zh-tw.md)。
- ⚠️ 本次於本機容器完成之驗證：`npm run check:refs`、`npm run check:menu`（7 組負向測試全過；實檢 OK：頂層 8 項、入口 20 個、`pages:` 19 頁雙向對應且均有中文標題）。**tx 建置仍須於本機或 CI 執行**；`pages:` 之宣告可能使頁面順序變動而影響 QA 訊息數，須依 `qa-baseline.json` 之既定例外程序以 CI 實測值處理。**對外發佈前一律以 `_genonce_tx.bat` 重建並檢視 `output/qa.html`。**

**（四）對標盤點總表**見 [JOB-25 §5](docs/optimization/JOB-25-page-titles-zh-tw.md)。刻意不比照之三項（MOHW header logo／配色、`TWCDI.html`、刪除〈快速入門〉〈未決事項〉）之理由見 [JOB-23 §2.2](docs/optimization/JOB-23-navigation-alignment-twcore.md)。

### v0.2.4（2026-08-17）補齊模板 zh-TW 字串，修復全站空白標籤（JOB-24）

> 說明：本次為**呈現層修復**，未變更任何 Profile、ValueSet、CodeSystem、Extension 或範例之定義，亦未變更任何頁面檔名。

- **問題**：頁尾之 `Links: Table of Contents | QA Report` 一列只剩 `: |`，`IG © …`／`套件 …`／`產生日期 …` 三行亦消失；profile 頁之〈正式網址〉〈版本〉〈機器可讀名稱〉等標籤同樣空白。**全站每一頁都受影響。**
- **根因**：模板 `fhir2.base.template` 隨附之 `translations/stringsBase.json` **只含 `en` 一種語言**（其餘語系僅以 `.po` 形式存在，未編入該 JSON）。本 IG 依 JOB-02 宣告 `language: zh-TW`，頁面模板以 `site.data.stringsBase['zh-TW']['<Key>']` 取字時查無此語系，Liquid 回傳空字串。模板 `scripts/ant.xml` 之複製區塊自留 TODO：「Replace this copy with something that will default missing translations to English」——上游明知缺語系不會退回英文。
- ⚠️ **非 v0.2.3（JOB-23）引入**：自 `gh-pages` 取 JOB-23 之前那一版已發佈站台（`781a6566`）之 `zh-TW/index.html`，其頁尾與修復前**逐字相同**。此缺陷早於 JOB-23，自 JOB-02 宣告 zh-TW 起即存在。
- **新增 [`input/data/stringsBase.json`](input/data/stringsBase.json)**：含 `en`（逐字複製自模板）與 `zh-TW`（126 鍵全數翻譯）。IG Publisher 會將 `input/data` 併入 Jekyll 之 `_data`。已於本機建置實測確認生效——頁尾恢復為「連結: 目錄 | QA 報告」。
- **新增 [`scripts/check-translations.js`](scripts/check-translations.js) 翻譯字串閘門**並掛入 `npm run verify` 與 CI：
  - **T-1** 模板 `en` 之每個鍵，我方 `en` 與 `zh-TW` 均須存在；**T-2** 我方 `en` 須與模板逐字相同；**T-3** `%PLACEHOLDER%` 集合須一致；**T-4** `zh-TW` 不得為空字串；**T-5** 我方多出之鍵（警告）。
  - 內建 `--self-test` **負向測試四組**，CI 中先跑負向測試再跑實檢（比照 JOB-20～23）。
  - **CI 步驟必須排在 IG Publisher 之後**——T-1／T-2 需與解壓後之模板比對；排在前面會靜默跳過而假性通過。
  - 設此閘門之理由：自備字串檔即與上游脫鉤，模板日後新增鍵時我方不會自動跟上，那些新鍵會在 `en` 與 `zh-TW` **兩邊都變空白且不報錯**——與 JOB-23 之位移型錨點屬同型的靜默失效。
- **不採行之替代方案**：不把 `language` 改回 `en`（那會讓中文內容重新被標為 `lang="en"` 並輸出至 `en/`，正是 JOB-02 修掉的問題）；不直接改 repo 根目錄之 `template/`（該目錄是每次建置解壓的產物，會被覆蓋，CI 更是重新下載）。
- **`sushi-config.yaml`**：`version` 由 `0.2.3` 調整為 `0.2.4`。**`package-list.json`**：新增 0.2.4 條目。`input/assets/fsh-source.zip` 因版次變更一併重建。
- 詳見 [`docs/optimization/JOB-24-zh-tw-template-strings.md`](docs/optimization/JOB-24-zh-tw-template-strings.md)。

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

