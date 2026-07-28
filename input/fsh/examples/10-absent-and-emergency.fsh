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
* performer = Reference(example-doctor)
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
