Profile: TWHATaskServiceTaskProfile
Parent: Task
Id: TWHA-Task-ServiceTask
Title: "臨場健康服務建議與改善任務 Profile"
Description: "用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。"
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
