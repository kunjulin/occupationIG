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
| **② Core upload set** | 主管機關（國健署）最小共通上傳集，21 列 | `VS-CoreUploadSet` |
| **③ 情境資料集** | 某法定情境依法應做什麼 | **尚未以值集定義**（backlog；見 JOB-07） |

**① ≠ ② ≠ ③。** 不得以「某項目不在 Core（②）」推論該項目不重要或非 Must Support。

### 2.5 Preferred（代碼層級）≠ 綁定強度 preferred

本 IG 各值集之綁定強度為 **extensible**。文件中的「Preferred／Acceptable」
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
docs/optimization/    現行優化工作範圍（13 個 JOB）← 待辦事項看這裡
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

---

## 5. 檢查指令

```bash
node scripts/check-pagecontent-refs.js            # pagecontent 與 FSH 是否同步（backlog 標註可通過）
node scripts/check-pagecontent-refs.js --strict    # 連 backlog 標註也視為失敗（釋出前檢查）
npx fsh-sushi .                                   # FSH 與 sushi-config.yaml 語法
_genonce_tx.bat                                   # 送審用完整建置（Windows，需可連外）
```

建置後**必看** `output/qa.html`。目前基準線（2026-07-26）：
`err = 0, warn = 208, info = 257`，明細見
[`docs/optimization/evidence/qa-summary-2026-07-26.md`](docs/optimization/evidence/qa-summary-2026-07-26.md)。
**任一類別筆數不得高於基準線。**

---

## 6. 未決事項

涉及下列事項時**不要臆測**，登記為未決事項（集中頁待建立，見 JOB-13）：

* 正式 canonical namespace 之核定機關與命名（現為 provisional）
* 國健署最小上傳集 21 列之正式公告版本（**M-5**）
* 第 19 條保存期限**起算點**之法定解釋（**M-6**）
* 本 IG 之授權條款（`license`）與著作權歸屬（涉委託契約）
* 臺灣境內 SNOMED CT 之授權管道
* 上傳語意採 `transaction` 或 `batch`（需平台端確認）

---

## 7. 待辦從哪裡看

[`docs/optimization/README.md`](docs/optimization/README.md) —— 13 個 JOB 的優先序、
相依關係與驗收標準。每個 JOB 檔案結尾都有可直接使用的規劃提示。
**一個 JOB → 一次規劃 → 一個 commit。**
