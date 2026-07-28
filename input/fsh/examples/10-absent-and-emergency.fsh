// ==========================================
// 9. 缺值處理與急診友善摘要（Batch 3）
// ==========================================

// 9.1 dataAbsentReason 缺值範例
// 示範治理原則「缺值須以 dataAbsentReason 標明，而非省略該筆 Observation」之實際填法。
Instance: obs-lab-egfr-absent
InstanceOf: TWHALabResultSpecialProfile
Title: "實驗室檢驗缺值範例 - eGFR 未檢測（dataAbsentReason）"
Description: "受檢勞工王大同本次因故未完成腎絲球過濾率 (eGFR) 檢測。示範以 dataAbsentReason = not-performed 標明缺值原因，Observation 仍保留且合乎 twha-obs-1（value 或 dataAbsentReason 或 component 三者擇一）。eGFR 屬成健延伸項目，v3.0 Core 重構後歸 Extended，故綁 TWHA-LabResult-Special（VS-ExtendedDataset）。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = LNC#98979-8 "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* performer = Reference(example-hospital)
* dataAbsentReason = http://terminology.hl7.org/CodeSystem/data-absent-reason#not-performed "Not Performed"

// 9.2 特別危害作業暴露史範例（供急診摘要引用）
Instance: obs-exposure-lead
InstanceOf: TWHAWorkExposureProfile
Title: "特別危害作業暴露史範例 - 鉛作業"
Description: "受檢勞工王大同從事鉛作業之暴露史，暴露年數 8 年，工作性質為電池極板熔鉛作業。"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#87729-0 "History of Occupational hazard"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:00:00+08:00"
* valueCodeableConcept = CS_HazardType#lead "鉛作業"
* component[exposureYears].code = LNC#104905-5 "Duration of exposure"
* component[exposureYears].valueQuantity = 8 'a' "years"
* component[workDetails].code = LNC#21847-9 "Usual occupation Narrative"
* component[workDetails].valueString = "電池極板熔鉛作業"

// 9.3 急診友善摘要 Composition 範例
Instance: composition-emergency-summary
InstanceOf: TWHACompositionEmergencySummaryProfile
Title: "職業健康急診友善摘要範例 (UC-007)"
Description: "整合王大同鉛作業暴露史、生命徵象與關鍵檢驗值之急診友善摘要，供急診醫師快速掌握其職業暴露背景。"
* status = #final
* title = "職業健康急診友善摘要"
* type = http://loinc.org#60591-5 "Patient summary Document"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:50:00+08:00"
* section[exposureHistory].code = http://loinc.org#11341-5
* section[exposureHistory].title = "作業與暴露史"
* section[exposureHistory].entry[0] = Reference(obs-exposure-lead)
* section[vitalSigns].code = http://loinc.org#8716-3
* section[vitalSigns].title = "生命徵象"
* section[vitalSigns].entry[0] = Reference(obs-height)
* section[vitalSigns].entry[1] = Reference(obs-weight)
* section[vitalSigns].entry[2] = Reference(obs-bloodpressure)
* section[keyLabs].code = http://loinc.org#30954-2
* section[keyLabs].title = "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）"
* section[keyLabs].entry[0] = Reference(obs-lab-glucose)
* section[keyLabs].entry[1] = Reference(obs-lab-egfr-absent)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "健康管理分級與急診注意事項"
* section[assessment].entry[0] = Reference(example-clinical-impression)

Instance: UC-007
InstanceOf: TWHABundleDocumentProfile
Title: "UC-007 職業健康急診友善摘要封包"
Description: "急診友善摘要 Composition（含鉛作業暴露史、生命徵象、關鍵檢驗值與缺值示範）之 Document Bundle 範例。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-007"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-emergency-summary"
* entry[0].resource = composition-emergency-summary
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-exposure-lead"
* entry[4].resource = obs-exposure-lead
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-height"
* entry[5].resource = obs-height
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-weight"
* entry[6].resource = obs-weight
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bloodpressure"
* entry[7].resource = obs-bloodpressure
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-glucose"
* entry[8].resource = obs-lab-glucose
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-egfr-absent"
* entry[9].resource = obs-lab-egfr-absent
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[10].resource = example-clinical-impression

Instance: UC-006
InstanceOf: TWHABundleDocumentProfile
Title: "UC-006 勞工健康服務臨場服務紀錄封包"
Description: "臨場服務紀錄 Composition（附表八）與關聯活動資料 Document Bundle 範例。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-006"
* type = #document
* timestamp = "2026-06-10T14:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/example-composition-service"
* entry[0].resource = example-composition-service
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-employer"
* entry[1].resource = example-employer
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-service"
* entry[4].resource = example-encounter-service
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Group/example-group-workers"
* entry[5].resource = example-group-workers
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Procedure/example-procedure-activity"
* entry[6].resource = example-procedure-activity
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/example-service-finding"
* entry[7].resource = example-service-finding
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Task/example-service-task"
* entry[8].resource = example-service-task
