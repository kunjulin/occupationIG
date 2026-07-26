Profile: TWHATaskServiceTaskProfile
Parent: Task
Id: TWHA-Task-ServiceTask
Title: "臨場健康服務建議與改善任務 Profile"
Description: "用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。

**for／focus／owner 語意界定（回應委員意見）**：本資源表達「**後續改善工作**」。`focus` 指向所依據之現場發現（ServiceFinding）；`owner` 為負責執行改善之事業單位；若改善事項係針對特定勞工（如個別配工調整），以 `for` 表達該 Patient。**事業單位以 `owner` 表達，不置於 `for`。**"
* ^experimental = false
* status from http://hl7.org/fhir/ValueSet/task-status (required)
* intent = #plan
// (-) 任務類別代碼從缺：原 SCT#315640000 經 tx 驗證實為「Influenza vaccination declined」，
//     與「職業健康諮詢／改善建議」語意不符，已移除；SNOMED 現無對應之職業健康諮詢 procedure 代碼。
//     Task.code 暫不固定，實作端可依需要以 CS-ServiceActivityType 本地碼標註。
* requester only Reference(TWHAPractitionerProfile)
* owner only Reference(TWCoreOrganization) // 主管或改善單位
* focus only Reference(TWHAObservationServiceFindingProfile) // 指向發現的問題/風險
* extension contains ExtEmployerInfo named employerInfo 1..1
