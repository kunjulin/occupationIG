# 下載專區 (Downloads)

本指引提供相關技術產出物之包裝下載。

> ⚠️ 本指引為工業技術研究院委託研擬中之草案，尚未定稿。
> 下列檔案內容得隨時變動，引用時請一併註明查閱日期（見[版本歷程](history.html)）。

## 1. 實作指引原始碼

*   [GitHub 原始碼倉庫](https://github.com/kunjulin/occupationIG) — 完整原始碼、FSH 定義、法規對照與優化工作清單。
*   [FSH 定義原始檔 (包含所有 Profiles、Extensions、ValueSets、CodeSystems)](fsh-source.zip) — 可直接以 SUSHI 重新編譯之 FSH 原始碼打包。

---

## 2. 驗證範例檔案 (JSON)

各封包皆為可通過驗證之 `Bundle`，可直接送入 [HL7 FHIR Validator](https://validator.fhir.org/) 檢驗。

| 封包 | 情境 | 下載 |
|:--|:--|:--|
| UC-001 | 一般健康檢查報告 | [JSON](Bundle-UC-001.json) |
| UC-002 | 勞工一般體格與健康檢查報告（附表九、十一） | [JSON](Bundle-UC-002.json) |
| UC-003 | 特殊危害健康作業檢查報告（附表十） | [JSON](Bundle-UC-003.json) |
| UC-004 | 企業自費健康檢查報告 | [JSON](Bundle-UC-004.json) |
| UC-005 | 成人預防保健檢查報告（國健署） | [JSON](Bundle-UC-005.json) |
| UC-006 | 勞工健康服務臨場服務紀錄（附表八） | [JSON](Bundle-UC-006.json) |
| UC-007 | 職業健康急診友善摘要（暴露史 ＋ 摘要 Composition） | [JSON](Bundle-UC-007.json) |
| UC-008 | 一般健檢結果**上傳**（`type=transaction`，條件式建立去重） | [JSON](Bundle-UC-008.json) |
| UC-009 | 特殊健檢結果**上傳**（`type=transaction`，缺值＋冪等重傳） | [JSON](Bundle-UC-009.json) |

> UC-001 ~ UC-007 為報告封包（`document`）、UC-008 ~ UC-009 為上傳封包（`transaction`）。
> 上傳之去重、冪等與錯誤處理契約見[上傳介接契約](conformance.html)；
> 整包處理語意（transaction／batch）為[未決事項 M-9](open-issues.html#m-9)。

---

## 3. 術語對照表與稽核產物

| 檔案 | 內容 | 下載 |
|:--|:--|:--|
| LOINC 映射值集 | 本指引各值集之 LOINC 代碼清單與分層（Core／Extended） | [XLSX](loinc-valuesets.xlsx) |
| SNOMED CT 對照表 | 生活習慣與危害類別之 SNOMED CT 代碼對照 | [XLSX](snomed-mappings.xlsx) |
| SNOMED–LOINC 對照 | SNOMED CT 與 LOINC 之交叉對照（CSV，便於程式處理） | [CSV](snomed-loinc-mappings.csv) |
| **顯示名驗證報告** | 以術語伺服器逐碼比對之 `display` 語意查核結果，為代碼稽核之主要依據 | [CSV](display-verification-report.csv) |
| **UCUM 建議單位對照** | Extended 量值項之 LOINC 官方建議單位對照 | [CSV](extended-ucum-reference.csv) |

> ⚠️ **顯示名驗證報告與 UCUM 對照表均為研製中之工作產物，尚有代碼待覆核。**
> 使用前請先確認對應代碼之稽核狀態，勿逕行作為實作依據；
> 稽核進度見 [JOB-01](https://github.com/kunjulin/occupationIG/blob/main/docs/optimization/JOB-01-terminology-code-audit.md)。

---

## 4. 附表對照

附表十 35 項具名作業與 12 危害家族之對映：

*   [ConceptMap：附表十 → 危害類別](ConceptMap-Appendix10-to-HazardType.html) — 線上檢視，頁內提供 JSON／XML／TTL 下載。
*   [附表十 → 危害類別對照表 (XLSX)](Appendix10-to-HazardType.xlsx) — 同一份對映之試算表格式，由建置工具自 ConceptMap 產生。
*   [特殊危害健康作業](special-exam.html) — 以附表十 35 項為列主鍵之涵蓋度對照表。

法規附表原文（PDF）置於原始碼倉庫之
[`docs/regulations/`](https://github.com/kunjulin/occupationIG/tree/main/docs/regulations)。
