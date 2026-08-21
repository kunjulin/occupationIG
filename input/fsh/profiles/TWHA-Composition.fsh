Profile: TWHACompositionProfile
Parent: TWCoreComposition
Id: TWHA-Composition
Title: "健康檢查健檢報告組成結構 Profile"
Description: "【技術規格】本 Profile 用於定義一般健康檢查、勞工健康檢查及成人預防保健等健康檢查報告的文件組成結構，以 Composition 作為文件核心，並定義各項目的 Section，繼承自 TW Core Composition。"
* ^experimental = false
* status = #final
* type = http://loinc.org#11502-2 "Laboratory report"
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* author only Reference(TWHAPractitionerProfile)
* title 1..1

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.ordered = false

* section contains
    demographics 1..1 and
    workHistory 0..1 and
    pastHistory 0..1 and
    habits 0..1 and
    symptoms 0..1 and
    physicalExams 0..1 and
    labExams 0..1 and
    assessment 1..1

* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry only Reference(TWHAPatientProfile or TWHAEncounterProfile)

* section[workHistory].code = http://loinc.org#11341-5
* section[workHistory].title = "作業經歷"
* section[workHistory].entry only Reference(Observation)

* section[pastHistory].code = http://loinc.org#11348-0
* section[pastHistory].title = "既往病史"
* section[pastHistory].entry only Reference(Condition)

* section[habits].code = http://loinc.org#11338-1
* section[habits].title = "生活習慣"
* section[habits].entry only Reference(Observation)

* section[symptoms].code = http://loinc.org#29554-3
* section[symptoms].title = "自覺症狀"
* section[symptoms].entry only Reference(QuestionnaireResponse)

* section[physicalExams].code = http://loinc.org#29545-1
* section[physicalExams].title = "理學檢查"
* section[physicalExams].entry only Reference(Observation)

* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry only Reference(Observation or DiagnosticReport or ImagingStudy)

// ⚠️ v0.8.5：entry 加入 TWHAHealthManagementLevelProfile。
// 本節標題寫著「分級」，型別卻不收承載分級的那個資源（該 profile 基底為 Observation），
// 致 composition-uc003 無法把 obs-health-mgmt-level 歸入任何 section。
//
// 這不是就個案放寬：TWHA-Composition-EmployerSummary 之 section[healthManagement]
// **使用同一個 LOINC 碼 51848-0**，且明文允許 TWHAHealthManagementLevelProfile。
// section 切片之判別子為 code 之 pattern，故兩者在 FHIR 眼中就是同一個 section——
// 本次係使兩個 profile 對同一個 section 的認定一致，非新增能力。
//
// 屬**放寬**：既有實例全數仍合法，非破壞性變更。加的是 profile 而非裸 Observation，
// 故仍不允許任意 Observation 進入本節。
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry only Reference(ClinicalImpression or CarePlan or ServiceRequest or Procedure or TWHAHealthManagementLevelProfile)
