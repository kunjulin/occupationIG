# CLAUDE.md — 本專案之作業前提

本檔為給 AI 助手與新接手者的索引。**內容摘自 `README.md` 與
`.claude/skills/fhir-tx-audit/SKILL.md`，非新規範**；兩者有出入時以原始文件為準。

---

## 1. 這是什麼專案

**臺灣勞工健康檢查交換實作指引 (TWHA IG)** —— 一份 HL7 FHIR R4 實作指引，
依中華民國《勞工健康保護規則》設計，繼承臺灣核心實作指引 (TW Core IG v1.0.0)。

* 技術 ID：`mohw.tw.twha`｜Canonical：`https://twcore.mohw.gov.tw/ig/twha`（**provisional**）
* 發布者：衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院
* **文件狀態：工業技術研究院委託研擬中之草案，尚未定稿。**

> 這是一份會被政府主管機關與臨床專家審查的規範文件，不是一般應用程式專案。
> 敘述文字的精確性與代碼的正確性同等重要。

### 1.1 現況（2026-08-21，v0.9.2）

| 項目 | 狀態 |
|:--|:--|
| 線上站台 | **v0.9.2**，gh-pages `ddab2cbe`（sourceCommit `114c312a`，15:12Z），已逐項複驗 |
| 版次來源 | `sushi-config.yaml` 之 `version`。⚠️ **本表會過期，動到版次時請一併更新**；有疑義以該檔為準 |
| 嚼檳 `Observation.code` | **`CS-BetelNutObservable#betel-quid-chewing-status`**（v0.9.0 起）。⚠️ 不再是 `SCT#698188003` |
| 送國健署確認單 | `docs/drafts/HPA-CONFIRMATION-JOB-30.md` — **阻擋已解除，可送出**；由 PI 核閱後以正式函文發出，**本團隊不逕行對外發送** |
| M-5 狀態／嚼檳系列 `experimental`／Level 1 成熟度 | **仍全部擋下**，須取得可引用之**書面**依據（口頭／轉述不足） |

**v0.9.0 為 Level 1 破壞性變更**：`SCT#698188003` 是**肯定式 finding**（斷言此人嚼檳），
置於 `Observation.code`（問題位）會使「從未嚼食」之紀錄自相矛盾，且以該碼檢索會把
從未嚼檳者一併撈出。已改為自訂狀態問句碼，結構**對齊 `LNC#72166-2`**（Tobacco smoking
status），**不對齊 `698188003`**。遷移說明見 [conformance.md](input/pagecontent/conformance.md) §8。
⚠️ 上傳欄位（醫令 `30907X-1`）本身**未變更**——變的是 FHIR 表達，不是主管機關的欄位。

---

## 2. 五條鐵則

### 2.1 離線建置不得作為送審依據

| 腳本 | 術語伺服器 | 用途 |
|:--|:--|:--|
| `_genonce.bat` | `-tx n/a`（離線） | 日常快速建置 |
| `_genonce_tx.bat` | `https://tx.fhir.org/r4` | **送審／對外發佈前必跑** |

離線建置**不驗證代碼是否存在、顯示名是否正確**。其 `0 Error` 無意義。

### 2.2 「顯示名不符」可能代表用錯碼，而非顯示名不精確

這是本專案最重要的一條。IG Publisher 只檢查「代碼是否存在於該 CodeSystem」，
**不檢查 `display` 是否與代碼真實語意相符**，且該訊息僅為 INFORMATION 等級。
因此語意完全錯誤的代碼可一路通過 `0 Error` 建置。

實例：`14390-9` 在本 IG 標為「ALT ... by UV with P5P」，
LOINC 官方為 **「Amylase [Enzymatic activity/volume] in Dialysis fluid」**（透析液澱粉酶）。

處理程序見 [`.claude/skills/fhir-tx-audit/SKILL.md`](.claude/skills/fhir-tx-audit/SKILL.md)。
新增或引用代碼時，須以 `$lookup` 取得官方 display 並**逐碼人工確認六軸語意**
（COMPONENT／PROPERTY／TIME／SYSTEM／SCALE／METHOD），不可只比對字串相似度。

### 2.3 驗證通過 ≠ 品質保證

IG Publisher 驗證通過僅證明**語法正確**且**已被引用之術語**通過代碼有效性檢查；
**不包含臨床適切性、法規符合性與情境完整性**，亦不涵蓋未被任何 profile／ValueSet
引用之對照表代碼。**不得**以驗證結果作為 IG 整體品質之表述。（此即 G-2）

### 2.4 三個層次的「資料集」不可混用

| 層次 | 意義 | 產物 |
|:--|:--|:--|
| **① IG scope** | 本指引能表達什麼＝Core ∪ Extended | `VS-CoreDataset` ∪ `VS-ExtendedDataset` |
| **② Core upload set** | 主管機關（國健署）最小共通上傳集，**16 主項／21 列**；⚠️ `VS-CoreUploadSet` 展開為 **20 碼**，與 21 列差三項（見下） | `VS-CoreUploadSet` |
| **③ 情境資料集** | 某法定情境依法應做什麼 | `VS-Appendix9-RequiredSet`（附表九，完整）／`VS-Appendix10-RequiredSet`（附表十，已落地噪音／鉛／粉塵／有機溶劑四家族，餘待 JOB-01） |

**① ≠ ② ≠ ③。** 不得以「某項目不在 Core（②）」推論該項目不重要或非 Must Support。

> 更新（v0.2.1）：③ 原記為「尚未以值集定義（backlog；見 JOB-07）」，惟該值集已於 0.2.0 落地
> （`input/fsh/valuesets/VS-Appendix9-RequiredSet.fsh`、`VS-Appendix10-RequiredSet.fsh`，
> [index.md](input/pagecontent/index.md) §3 已引用），故更正。**附表十尚有未審家族待補，見未決事項 M-8。**

> ⚠️ **更新（v0.5.0，JOB-30）：21 列是對的，`VS-CoreUploadSet` 展開為 20 碼也是對的
> ——兩者計的不是同一件事。** 差異已依主管機關上傳欄位原案
> （TWHA IG 完整編碼附件 v7.6〈Core 主管機關最小集(21)〉）逐列查明，共三處：
>
> | 差異 | 說明 |
> |:--|:--|
> | 群組值集多了 BMI `39156-5` | **不是 Core 列**；係 `VS-TWHAVitalSigns` 之成員被群組一併帶入。**不得據 `VS-CoreUploadSet` 推論 BMI 屬最小上傳集。** |
> | 群組值集少了嚼檳量（`30907X-2`） | 原案為獨立一列，本 IG 以 `component[amount]` 承載，非獨立 `Observation.code` |
> | 群組值集少了嚼檳月數（`30907X-3`） | 同上，以 `component` 承載 |
>
> 核算 `20 − 1 ＋ 2 = 21`。逐列對照見 [conformance.md §7.2](input/pagecontent/conformance.md)。
> **16 主項／21 列**：主項＝不重複之**健保醫令代碼**；16 項中僅 3 項展開為多列
> （吸菸 `30906X` 3 列、嚼檳 `30907X` 3 列、尿蛋白 `06003C` 2 列），其餘 13 項各 1 列，
> `13 + 3 + 3 + 2 = 21`。⚠️ **血壓不是「1 主項 2 列」**——收縮壓 `30904X` 與舒張壓 `30905X`
> 是兩個獨立醫令、各 1 列；它們在 FHIR 併為一個 Observation 的兩個 component，
> 那是本 IG 的建模方式，**不是原案的計列方式**。
>
> **仍待國健署確認之三項實質差異**（非計數問題，見確認單第 4 項）：
> ① BMI 是否納入；② 第 11 列「嚼檳月數」指**戒檳**月數或**嚼食持續**期間
> （**兩者語意相反，不得臆測**，本 IG 兩個 component 皆已備妥）；
> ③ 嚼檳量單位原案記 `{個}/d`，本 IG 用 `{quid}/d`（UCUM annotation 僅接受 ASCII，
> `{個}` 非合法 UCUM）。

### 2.5 Preferred（代碼層級）≠ 綁定強度 preferred

本 IG **檢驗／量測三大資料集值集**（`VS-CoreDataset`／`VS-ExtendedDataset`／`VS-TWHAVitalSigns`）之綁定強度為 **extensible**——本節所談者即此。（分類型值集如 `VS-HealthMgmtLevel`、`VS-BetelNutStatus` 則為 `required`；全 IG 實測 required 11 處、extensible 3 處。）文件中的「Preferred／Acceptable」
指的是**同一檢驗項目的多個候選代碼中，哪一個優先採用**，
與 FHIR 的 `binding.strength = preferred` 是兩件不同的事，不可混稱。

---

## 3. 目錄結構

```
input/fsh/            FSH 原始碼（profiles / extensions / valuesets / codesystems / examples）
input/pagecontent/    敘述性頁面（.md）；新增頁面務必同步 sushi-config.yaml 的 menu
input/assets/         下載用資產；會被複製到輸出根目錄，可由 downloads.md 以相對路徑連結
sushi-config.yaml     IG metadata、dependencies、parameters、menu
ig.ini                IG Publisher 設定（template 目前為 #current，未釘版）
package-list.json     版本歷程（供 publish box 與發佈流程使用）
docs/optimization/    現行優化工作範圍（JOB-01～JOB-30）← 待辦事項看這裡
docs/regulations/     法規附表 PDF 原文（對照表之權威來源）
docs/history/         已被取代之歷史規劃文件（非現行規範）
docs/drafts/          未接入建置的資源草稿
scripts/              檢查與一次性工具
template/             IG 模板之本機複本（角色待釐清，見 JOB-09）
```

---

## 4. 常犯錯誤

| 錯誤 | 正確做法 |
|:--|:--|
| 為了消掉 `Wrong Display Name` 而直接改 `display` | 先判斷是**用錯碼**還是 display 漂移（§2.2） |
| 改了值集卻沒改 ConceptMap 與 `terminology.md` | 換碼須同步值集 ＋ ConceptMap ＋ 對照表 ＋ 受影響範例 |
| 新增 pagecontent 頁面但沒加進 `menu` | 會變成孤兒頁（`conformance.html` 曾如此） |
| 在 `input/pagecontent` 引用不存在的 FSH 物件 | 跑 `node scripts/check-pagecontent-refs.js`；刻意的待辦須在**同一行**標註 `backlog` |
| 宣告 Must Support 卻不在範例中填該欄位 | MS 欄位至少要有一個範例實際填值，或以 `dataAbsentReason` 示範缺值 |
| 以泛用字串抑制警告 | `input/ignoreWarnings.txt` 須用精確訊息並附理由；勿抑制術語伺服器連線失敗 |
| 憑既有 markdown 表格轉抄法規項目 | 以 `docs/regulations/` 之 PDF 原文逐項核對 |
| 沿用文件所載之數字（如「21 列」「24 處錨點」） | **自原始碼逐項數出來，並回頭核對權威來源**。JOB-30 實測：`VS-CoreUploadSet` 展開 **20 碼**（非 21）、具名錨點 **23 處**（非 24）。⚠️ 但「20 碼」**不代表 21 列是錯的**——回查原案後查明兩者計的不是同一件事（見 §2.4）。**數不符時先找權威來源，不要急著改文件數字，也不要急著補足差額。** |
| 以「每新增一個 artifact 即 +10 筆斷鏈」推算 QA 增量 | 依**種類**：範例實例 **10**／CodeSystem・ValueSet **12**／Profile **18**（皆已含根層與 `zh-TW` 兩層）。舊的「一律 +10」是 JOB-05 以範例實例量得後被過度推廣（JOB-29 §D.5.1） |
| 標 `standards-status` 卻不管資源自身的 `status` | IG Publisher 會交叉檢查：`draft` ↔ `status = draft`、`trial-use`／`normative` ↔ `status = active`。本 repo 全部 artifact 繼承 `sushi-config.yaml` 之 `status: active`，**標 `draft` 即自相矛盾**（JOB-30 實測命中 71 件）。故現行僅 Level 1 標 `trial-use`，其餘不標（JOB-30 §7.7） |
| 新增 artifact 卻沒登記權責歸屬 | `scripts/governance-map.js` 須先登記（標籤＋合規層級），否則 `npm run check:gov` 失敗 |
| 改了登記表卻沒改 [conformance.md](input/pagecontent/conformance.md) §7.4 的件數 | 該處**兩張表**（標籤件數／成熟度件數）與「現值」摘要句共 7 個數字已由 **G-5** 看管（`npm run check:gov`），自登記表動態算出。⚠️ 兩張表的合計相同純屬邊際巧合，**分類軸不同**，須分別更新——v0.9.0 手動更正時就只改了其中一張 |
| 在 `concept.definition`／`display` 裡寫 `**粗體**` 或反引號 | 那兩個欄位於 FHIR 為 **string** 型而非 markdown，記號**不會被算繪**，會逐字顯示給讀者（v0.9.0 線上實證 6 處，累積自 v0.4.0）。改用語序與 ⚠️ 表達強調，代碼字面以「」框住。由 `npm run check:plaintext` 看管。⚠️ **`Description:` 不受此限**——該欄確為 markdown 型，線上實證會算繪成 `<strong>`／`<code>`，**不要順手一起改掉** |
| 寫好閘門卻沒接到 CI | 閘門只進 `npm run verify`（本機）＝**沒人會跑**。`check:gov`／`check:intref` 曾如此長期存在，導致 v0.9.1 新增的 G-5 在 PR 上根本不執行。新增閘門時**同時**改 `package.json` 與 `.github/workflows/build-ig.yml`，並回頭確認該步驟在 CI 是 `success` 而非 `skipped` |
| 閘門有在跑，但**看的範圍不對** | 比「沒接 CI」更難發現，因為它每輪都亮綠燈。實例：`check:translations` 自 JOB-24 起只比對 `stringsBase.json`，而模板另有 `stringsArtifacts.json`，導致 `artifacts.html` 之 9 個分類標題與目錄連結**全空白四個多月**而閘門全綠（v0.9.3 修）。**訂範圍時要問「這一類東西有幾個」，不要只處理眼前踩到的那一個**；能資料驅動就不要寫死檔名，並加一條「上游有、我方沒有 → 失敗」 |

---

## 5. 檢查指令

```bash
npm run verify                                    # 全部閘門（各閘門均先跑 --self-test 負向案例）
node scripts/check-pagecontent-refs.js            # pagecontent 與 FSH 是否同步（backlog 標註可通過）
node scripts/check-pagecontent-refs.js --strict    # 連 backlog 標註也視為失敗（釋出前檢查）
npm run check:gov                                 # 權責標籤／合規層級／§7.4 件數（G-5）／不得越權表述
npm run check:plaintext                           # concept 之 display／definition 不得含不會算繪之 markdown
npm run check:intref                              # 對外產出不得殘留內部工作痕跡
npx fsh-sushi .                                   # FSH 與 sushi-config.yaml 語法
_genonce_tx.bat                                   # 送審用完整建置（Windows，需可連外）
```

> ⚠️ **本容器（Claude Code 遠端環境）跑不了 SUSHI 與 tx 建置**：proxy 封鎖
> `packages.fhir.org`、`tx.fhir.org`、`loinc.org`、`hl7.org`。故 FSH 語法與所有 QA 數字
> **一律以 CI 為準**；本機只能跑上列 node 閘門。`qa-baseline.json` **不得憑推算調整**。
>
> ⚠️ **`npm run verify` ≠ CI 會跑的東西。** 兩者是各自維護的清單，會漂開——
> `check:gov` 與 `check:intref` 就曾只在 `verify` 裡、從未進 CI。新增閘門時兩處都要加。

> 📌 **CI 亦不自動發佈。** 合併至 `main` 只更新版控，線上網站不動；
> 發佈須另以 Actions → Run workflow 勾選 `publish`（會**全量覆蓋** gh-pages）。
> 流程與各閘門之判讀見 [`docs/RELEASE.md`](docs/RELEASE.md)。

建置後**必看** `output/qa.html`。
**基準線之唯一權威來源是 [`qa-baseline.json`](qa-baseline.json)**，由 `scripts/qa-gate.js` 逐類別比對；
**任一類別筆數不得高於基準線**，上調必須具名說明多出來的是什麼（見該檔之 `_*Note`）。

> 歷史起點為 2026-07-26 之 `err = 0, warn = 208, info = 257`
> （[明細](docs/optimization/evidence/qa-summary-2026-07-26.md)），
> **該數字早已不是現值，勿引用**——v0.4.0 實測為 `err = 0, warn 上限 152, info 上限 459`。
> 要引用現值請直接讀 `qa-baseline.json`。

---

## 6. 未決事項

涉及下列事項時**不要臆測**，登記至
[`input/pagecontent/open-issues.md`](input/pagecontent/open-issues.md)（未決事項登記簿）。

**維護慣例**：後續工作若遇到需外部決策之事項，一律回填該頁，不要只寫在該頁面的引用區塊裡。
新增時須填齊「現況／待決／所需輸入／影響範圍／若決策不同」五項——**「若決策不同」不可省略**，
那是審查者判斷可否先行採用的關鍵資訊。已解決者保留編號並改標狀態，不刪除、不重用編號。

目前登記在案者（摘要，明細以該頁為準）：

* 正式 canonical namespace 之核定機關與命名（現為 provisional）
* 國健署最小上傳集之正式公告版本（**M-5**）。逐列組成已由原案 v7.6 查明（§2.4），
  尚待確認者為三項實質差異：BMI 是否納入、「嚼檳月數」之語意、嚼檳量單位標記。
  確認單於 `docs/drafts/HPA-CONFIRMATION-JOB-30.md` 第 4 項。
  **狀態（2026-08-21）：送出阻擋已解除，已交 PI 核閱。** 原阻擋條件為 JOB-32 §5.2
  （§0 之 `Observation.code` 尚為 `698188003` 時不得送出，否則將發生
  「送簽 → 貴署據以同意 → 本團隊隨即改同一欄位」），該條件已於 v0.9.0 成就並線上複驗。
  ⚠️ 送出方式：**由 PI 核閱後改以正式函文格式發出，本團隊不逕行對外發送。**
  ⚠️ **解除的只有「送出」。** 國健署「嚼檳定案即同意 21 項」目前**僅為口頭／轉述**；
  **取得可引用之書面依據前，M-5 狀態、嚼檳系列 `experimental`、Level 1 成熟度三者一律不得變更。**
* **勞工區塊之 artifact 是否要標 `standards-status = draft`（JOB-30 §7.7）**——
  要標就必須把 71 個 artifact 之 `status` 由 `active` 改為 `draft`，
  屬**已發佈中繼資料之規範性變更**，須 PI 裁示，本團隊不逕行為之。
* 第 19 條保存期限**起算點**之法定解釋（**M-6**）
* 本 IG 之授權條款（`license`）與著作權歸屬（涉委託契約）
* 臺灣境內 SNOMED CT 之授權管道
* 上傳語意採 `transaction` 或 `batch`（需平台端確認）

---

## 7. 待辦從哪裡看

[`docs/optimization/README.md`](docs/optimization/README.md) —— 各 JOB（現至 **JOB-30**）的優先序、
相依關係與驗收標準。每個 JOB 檔案結尾都有可直接使用的規劃提示。
**一個 JOB → 一次規劃 → 一個 commit。**
