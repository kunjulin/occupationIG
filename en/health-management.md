# Health Management - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Health Management

# 健康管理分級與適性配工 (Health Management & Fitness for Work)

依據《勞工健康保護規則》第 21 條及第 23 條，健康管理分級與適性配工是健檢後續最關鍵的業務閉環。

## 1. 健康管理分級 (Health Management Classification)

醫師綜合分析勞工檢查結果後，應判定其健康管理分級：

* **第一級管理 (Level 1)**: 健檢項目全部正常，或有異常但經評估與工作無關。
* **第二級管理 (Level 2)**: 健檢有異常，但經評估與工作無關，需進行個人健康指導者。
* **第三級管理 (Level 3)**: 健檢有異常，且無法確定與工作之相關性，需進行追蹤重檢或作業現場暴露評估。
* **第四級管理 (Level 4)**: 健檢有異常，且經評估與工作相關，屬健康危害顯著，需立即醫療處置與工作調整。

### FHIR 建模表達：

* 使用 **`TWHA-ClinicalImpression`** Profile 記錄醫師總評。
* 在 ClinicalImpression 中，以 **`ext-health-mgmt-level`** 擴充欄位記錄 `level-1` 至 `level-4` 的代碼。
* 亦可在打包的 Bundle 中，以獨立的 `TWHA-HealthManagementLevel` Observation 資源記錄此判定分級。

-------

## 2. 適性配工流程 (Fitness for Work Flow)

對於判定為 **第四級管理** 之勞工，雇主依法必須採取適性配工與職務調整措施。

### FHIR 建模表達：

* **適性配工計畫 (`TWHA-CarePlan`)**： 
* `subject` 指向受影響之勞工。
* `intent` 設為 `plan`。
* 使用 **`ext-fitness-for-work`** 擴充欄位標註具體建議項目： 
* `change-workplace` (變更工作場所)
* `change-job` (更換工作/調職)
* `reduce-hours` (縮短工時)
* `clinical-treatment` (醫療限制)
 
* 計畫的具體執行目標可利用 `Goal` 資源記錄，執行進度可使用 `Task` 資源追蹤。
 

-------

## 3. 追蹤檢查要求 (ServiceRequest for Follow-up)

對於判定為 **第三級管理** 之勞工，通常需要開立追蹤重檢或排程現場暴露危害調查。

### FHIR 建模表達：

* 使用 **`TWHA-ServiceRequest`** Profile（繼承自 `TWCoreServiceRequest`）開立追蹤要求。
* `requester` 為判定醫師或健檢醫院。
* `occurrenceDateTime` 標註預定進行追蹤重檢之日期。
* `reasonReference` 關聯至導致第三級管理判定之異常檢查項目（例如：聽力異常 `TWHA-HearingTest` 實例）。

