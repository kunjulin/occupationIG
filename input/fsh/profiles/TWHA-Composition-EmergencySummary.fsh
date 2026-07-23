Profile: TWHACompositionEmergencySummaryProfile
Parent: TWCoreComposition
Id: TWHA-Composition-EmergencySummary
Title: "職業健康急診友善摘要 Composition Profile"
Description: "職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用，形成可驗證、可交換的摘要文件。"
* ^experimental = false
* status = #final
* type = http://loinc.org#60591-5 "Patient summary Document"
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* author only Reference(TWHAPractitionerProfile)
* title 1..1

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.ordered = false

* section contains
    exposureHistory 1..1 and
    vitalSigns 0..1 and
    keyLabs 0..1 and
    assessment 0..1

* section[exposureHistory].code = http://loinc.org#11341-5
* section[exposureHistory].title = "作業與暴露史"
* section[exposureHistory].entry only Reference(Observation)

* section[vitalSigns].code = http://loinc.org#8716-3
* section[vitalSigns].title = "生命徵象"
* section[vitalSigns].entry only Reference(Observation)

* section[keyLabs].code = http://loinc.org#30954-2
* section[keyLabs].title = "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）"
* section[keyLabs].entry only Reference(Observation or DiagnosticReport)

* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "健康管理分級與急診注意事項"
* section[assessment].entry only Reference(ClinicalImpression or CarePlan)
