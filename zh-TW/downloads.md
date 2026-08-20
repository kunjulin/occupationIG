# 結構定義與範例檔下載 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.1

## 結構定義與範例檔下載

# 下載專區 (Downloads)

本指引提供相關技術產出物之包裝下載。

> ⚠️ 本指引為工業技術研究院委託研擬中之草案，尚未定稿。 下列檔案內容得隨時變動，引用時請一併註明查閱日期（見[版本歷程](history.md)）。

## 1. 實作指引原始碼

* [GitHub 原始碼倉庫](https://github.com/kunjulin/occupationIG) — 完整原始碼、FSH 定義、法規對照與優化工作清單。
* [FSH 定義原始檔 (包含所有 Profiles、Extensions、ValueSets、CodeSystems)](fsh-source.zip) — 可直接以 SUSHI 重新編譯之 FSH 原始碼打包。

-------

## 2. 驗證範例檔案 (JSON)

各封包皆為可通過驗證之 `Bundle`，可直接送入 [HL7 FHIR Validator](https://validator.fhir.org/) 檢驗。

| | | |
| :--- | :--- | :--- |
| UC-001 | 一般健康檢查報告 | [JSON](Bundle-UC-001.json) |
| UC-002 | 勞工一般體格與健康檢查報告（附表九、十一） | [JSON](Bundle-UC-002.json) |
| UC-003 | 特殊危害健康作業檢查報告（附表十） | [JSON](Bundle-UC-003.json) |
| UC-004 | 企業自費健康檢查報告 | [JSON](Bundle-UC-004.json) |
| UC-005 | 成人預防保健檢查報告（國健署） | [JSON](Bundle-UC-005.json) |
| UC-006 | 勞工健康服務臨場服務紀錄（附表八） | [JSON](Bundle-UC-006.json) |
| UC-007 | 職業健康急診友善摘要（暴露史 ＋ 摘要 Composition） | [JSON](Bundle-UC-007.json) |
| UC-008 | 一般健檢結果**上傳**（`type=transaction`，條件式建立去重） | [JSON](Bundle-UC-008.json) |
| UC-009 | 特殊健檢結果**上傳**（`type=transaction`，缺值＋冪等重傳） | [JSON](Bundle-UC-009.json) |

> UC-001 ~ UC-007 為報告封包（`document`）、UC-008 ~ UC-009 為上傳封包（`transaction`）。 上傳之去重、冪等與錯誤處理契約見[上傳介接契約](conformance.md)； 整包處理語意（transaction／batch）為[未決事項 M-9](open-issues.md#m-9)。

-------

## 3. 術語對照表與稽核產物

| | | |
| :--- | :--- | :--- |
| LOINC 映射值集 | 本指引各值集之 LOINC 代碼清單與分層（`VS-CoreDataset`21 碼／`VS-ExtendedDataset`288 碼），含**層級**、**歸一至**、**equivalence**欄，另附`ConceptMap 歸一`分頁（41 組） | [XLSX](loinc-valuesets.xlsx) |
| SNOMED CT 對照表 | 生活習慣與危害類別之 SNOMED CT 代碼對照，及核心資料集之 LOINC–SNOMED 對照 | [XLSX](snomed-mappings.xlsx) |
| SNOMED–LOINC 對照 | SNOMED CT 與 LOINC 之交叉對照（CSV，便於程式處理） | [CSV](snomed-loinc-mappings.csv) |
| **顯示名驗證報告** | 以術語伺服器逐碼比對之`display`語意查核結果，為代碼稽核之主要依據 | [CSV](display-verification-report.csv) |
| **UCUM 建議單位對照** | Extended 量值項之 LOINC 官方建議單位對照 | [CSV](extended-ucum-reference.csv) |

> **`loinc-valuesets.xlsx` 之欄位說明（v20260730 新增，JOB-21）**

| | |
| :--- | :--- |
| `層級 Tier` | `Preferred`＝本指引建議之標準交換碼；`Acceptable`＝可接受之變異碼，可經 ConceptMap 歸一；`（單一碼）`＝該項目無 acceptable 變異碼 |
| `歸一至 Normalizes To` | 該 acceptable 碼經 ConceptMap 歸一之目標 preferred 碼 |
| `equivalence` | 二碼之語意關係（FHIR R4 值，**以 target 為主詞**，見[術語頁 §3.2.1](terminology.md)） |
| `備註 Note` | 該碼於 FSH 之行內註解，載明其何以為 acceptable |

**層級判定以 `ConceptMap` 為準**（結構化資源），非以 FSH 之註解為準；註解與 ConceptMap 之一致性已納入 CI 閘門（對稱差須為 0）。僅「於 ConceptMap 完全未出現之單一項目」才由 Core 區塊註解補判其為 `Preferred`。⚠️ **`equivalence` 之判讀（關乎資料正確性）**：
* `wider`／`narrower`＝二碼為方法特化與通用之包含關係，**數值可直接比較**（`narrower` 者須注意條件差異）。
* **`relatedto`＝二者關聯但屬不同量測方式或需換算，「數值不可直接比較」**。表中已以 `⚠ relatedto（需換算，數值不可直接比較）` 標示。尿沉渣 9 組（/HPF ↔ /µL）、eGFR （MDRD ↔ CKD-EPI 2021）、血中鉛等均屬此類——**逕行比較會導致臨床誤判**。

> ℹ️ `loinc-valuesets.xlsx` 與 `snomed-mappings.xlsx` **由建置流程自值集（`VS-CoreDataset`／`VS-ExtendedDataset`）與 `snomed-loinc-mappings.csv` 自動產生**，內容恆與本頁指引版本（0.2.0）一致；不再手工維護，故無版本落後之虞。`loinc-valuesets.xlsx` 之 `VS-CoreDataset` 分頁自 v3.0 重構為「主管機關（國健署）最小上傳集之檢驗子集」（21 碼），其餘檢驗項目改列 `VS-ExtendedDataset`（288 碼）。若與舊版下載檔比對，將見 Core 由 193 碼大幅縮減，屬正常之分層調整而非刪碼。

> ⚠️ **顯示名驗證報告與 UCUM 對照表均為研製中之工作產物，尚有代碼待覆核。** 使用前請先確認對應代碼之稽核狀態，勿逕行作為實作依據； 稽核進度見 [JOB-01](https://github.com/kunjulin/occupationIG/blob/main/docs/optimization/JOB-01-terminology-code-audit.md)。

-------

## 4. 附表對照

附表十 35 項具名作業與 12 危害家族之對映：

* [ConceptMap：附表十 → 危害類別](ConceptMap-Appendix10-to-HazardType.md) — 線上檢視，頁內提供 JSON／XML／TTL 下載。
* [附表十 → 危害類別對照表 (XLSX)](Appendix10-to-HazardType.xlsx) — 同一份對映之試算表格式，由建置工具自 ConceptMap 產生。
* [特殊危害健康作業](special-exam.md) — 以附表十 35 項為列主鍵之涵蓋度對照表。

法規附表原文（PDF）置於原始碼倉庫之 [`docs/regulations/`](https://github.com/kunjulin/occupationIG/tree/main/docs/regulations)。

