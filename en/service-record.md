# Service Record - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Service Record

# 臨場健康服務執行紀錄 (On-site Occupational Health Service Record)

臨場健康服務紀錄（附表八）為醫護團隊前往事業單位提供職業健康服務時之法規紀錄。

## 1. 資料文件結構 (Document Composition)

本指引採用 **FHIR Composition Document** 結構來封裝整張附表八：

1. **文件核心 (`TWHA-Composition-ServiceRecord`)**：
* `subject` 指向受僱之事業單位組織 (`TWHA-Organization-Employer`)。
* `author` 為執行服務之醫師或護理人員 (`TWHA-Practitioner`)。
* 包含四個主要 Section：`workplace` (作業場所)、`activities` (執行情形)、`findings` (現場發現)、`recommendations` (改善建議)。

-------

## 2. 作業場所概況 (Workplace & Encounter Service)

臨場就醫/服務事件採用 `TWHA-Encounter-Service` Profile 記錄：

* **時間起迄**：於 `period` 中記錄臨場服務的具體日期與起迄時間。
* **部門課別**：以 `ext-department` 擴充欄位記錄服務之特定廠區或部門（如：生產線 A 區）。
* **參與人員**：在 `participant` 中記錄隨行之職醫、職護、安全衛生管理人員。
* **場所特徵**：在 `Encounter.text` 中描述現場工作流程（製程）、工作型態及暴露特性。

-------

## 3. 辦理事項執行情形 (Service Activities)

每一項執行的服務活動（如健康檢查結果分析、異常追蹤管理、健康教育指導等），以 `TWHA-Procedure-ServiceActivity` Profile 進行單獨實例記錄：

* **項目分類**：`Procedure.code` 綁定至 `VS_ServiceActivityType` 值集。
* **對象群組**：`Procedure.subject` 指向受服務之勞工群組 (`Group`) 或個案勞工。
* **關聯雇主**：使用 `ext-employer-info` 關聯至雇主事業單位。

-------

## 4. 發現問題與改善建議 (Findings & Tasks)

附表八的核心為「發現問題」與「改善建議」之連動：

1. **發現問題 (`TWHA-Observation-ServiceFinding`)**：
* 記錄臨場服務中發現之具體危害。
* `code` 為 SNOMED CT `278486003` "Occupational health hazard"。
* 危害詳情描述於 `valueString`（例如：局部排氣風速不足，有化學品暴露風險）。
* `focus` 指向事業單位。

1. **建議採行措施 (`TWHA-Task-ServiceTask`)**：
* 針對發現問題所提出之具體改善任務。
* `focus` 指向對應的 `TWHA-Observation-ServiceFinding`。
* `owner` 為必須落實改善之事業單位主管。
* `requester` 為提出建議之醫護人員。
* 改善任務內容記錄於 `description`。

1. **前次改善事項追蹤**：
* 使用另一個 `TWHA-Task-ServiceTask` 實例，其 `status` 標註追蹤結果（如已完成 `completed`、未完成 `failed`），並於 `description` 描述追蹤情形。
* 透過 Composition 封裝，達成「本次改善建議」與「前次建議追蹤」的歷史關聯性。

