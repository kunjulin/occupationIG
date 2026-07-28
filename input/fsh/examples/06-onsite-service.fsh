// ==========================================
// 7. 臨場健康服務紀錄範例（附表八）
// ==========================================

Instance: example-encounter-service
InstanceOf: TWHAEncounterServiceProfile
Title: "臨場服務事件範例"
Description: "林職醫師與護理師於115年6月10日前往大同電子股份有限公司進行現場臨場服務。"
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#FLD "field"
* period.start = "2026-06-10T09:00:00+08:00"
* period.end = "2026-06-10T12:00:00+08:00"
* participant[0].individual = Reference(example-doctor)
* serviceProvider = Reference(example-hospital)
* extension[employerInfo].valueReference = Reference(example-employer)
* extension[department].valueString = "化學製造現場"

Instance: example-group-workers
InstanceOf: Group
Title: "服務對象勞工群組範例"
Description: "大同電子現場化學製造部門之作業勞工群組。"
* type = #person
* actual = true
* name = "大同電子化學製造課全體勞工"

Instance: example-procedure-activity
InstanceOf: TWHAProcedureServiceActivityProfile
Title: "臨場服務執行活動項目範例"
Description: "在臨場服務中辦理「健康檢查結果分析」的執行紀錄。"
* status = #completed
* code = CS_ServiceActivityType#exam-analysis "健康檢查結果分析"
* subject = Reference(example-group-workers)
* extension[employerInfo].valueReference = Reference(example-employer)

Instance: example-procedure-counseling
InstanceOf: TWHAProcedureCounselingProfile
Title: "健康諮詢與衛教指導範例"
Description: "針對受檢者王大同進行之「規律運動諮詢與衛教」與「腎病識能衛教指導」的紀錄。"
* status = #completed
* code.coding[0] = CS_HealthCounseling#counsel-exercise "規律運動諮詢與衛教"
* code.coding[1] = CS_HealthCounseling#counsel-kidney "腎病識能衛教指導"
* subject = Reference(example-worker)
* encounter = Reference(example-encounter-general)


Instance: example-service-finding
InstanceOf: TWHAObservationServiceFindingProfile
Title: "臨場服務現場發現問題範例"
Description: "臨場服務中發現作業現場危害因子及問題。"
* status = #final
* code = SCT#17458004 "Occupational hazard"
* focus = Reference(example-employer)
* valueString = "發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。"

Instance: example-service-task
InstanceOf: TWHATaskServiceTaskProfile
Title: "臨場服務建議改善措施與追蹤任務範例"
Description: "林職醫師針對現場發現問題提出之改善建議，交由雇主大同電子執行改善。"
* status = #requested
* intent = #plan
* requester = Reference(example-doctor)
* owner = Reference(example-employer)
* focus = Reference(example-service-finding)
* description = "大同電子應於兩週內委託專業廠商維修化學製造現場之局部排氣系統，並落實每日作業前防護具配戴檢查機制。"
* extension[employerInfo].valueReference = Reference(example-employer)
