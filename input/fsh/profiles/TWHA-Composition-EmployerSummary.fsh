// 雇主端健康管理摘要（JOB-11：把「雇主不得看檢驗細項」由文字承諾變成可驗證機制）。
//
// 為什麼是 Composition 而非 SMART scope：security.md 要求職安人員／雇主僅得取得
// 健康管理分級、適性配工與臨場服務發現，**不得**取得檢驗數值（血糖、肝功能等）。
// SMART scope 之顆粒度到「資源型別」為止，難以乾淨表達「同一 Observation 的部分
// 欄位可見」（JOB-11 §3.1）。故本 IG 之欄位級隔離改由**產出不同的 Composition**
// 達成：雇主端拿到的是本 Profile，其 section 為 **closed slicing**，
// 結構上**無法**容納檢驗／影像 section；各 section 之 entry 亦以 profile 限定，
// 檢驗類 Observation／DiagnosticReport 無從放入。此即「雇主版摘要」。
//
// 稽核方式：雇主端封包若符合本 Profile，即可由驗證器證明其不含檢驗細項——
// 這是文字宣示做不到、而 profile 能做到的。
//
// 定位：與 TWHA-Composition-EmergencySummary 同為按需產生之摘要原型；
// 其對應之存取控制機制（Consent／scope／端點）屬平台端決定，登記於未決事項 M-10。

Profile: TWHACompositionEmployerSummaryProfile
Parent: TWCoreComposition
Id: TWHA-Composition-EmployerSummary
Title: "雇主端健康管理摘要 Composition Profile"
Description: "【依據：勞工健康保護規則附表】雇主端／職安人員健康管理摘要（Employer Health Management Summary）。落實 security.md 之角色存取控制：雇主僅得取得**健康管理分級、適性配工建議與臨場服務發現**，**不得**取得檢驗數值。以 **closed section slicing** 結構性保證本摘要不含檢驗／影像 section；各 section 之 entry 以 profile 限定，檢驗類 Observation／DiagnosticReport 無從置入。此為欄位級隔離之可驗證機制，取代僅以文字宣示之做法（SMART scope 難達欄位級隔離，見 security.md §2）。存取控制之實作機制（scope／Consent／端點）屬平台端決定，見未決事項 M-10。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* status = #final
* type 1..1
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* author only Reference(TWHAPractitionerProfile or TWHAOrganizationFacilityProfile)
* title 1..1

// closed：本摘要**只能**有下列兩個 section，不得再加任何 section——
// 這正是「雇主看不到檢驗值」之結構保證。
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #closed
* section ^slicing.ordered = false
* section contains
    healthManagement 1..1 and
    serviceFindings 0..*

// 分級與適性配工。entry 限定為分級 Observation／總評／配工計畫——
// **不含**任何檢驗 Observation 或 DiagnosticReport。
* section[healthManagement].code = http://loinc.org#51848-0
* section[healthManagement].title = "健康管理分級與適性配工建議"
* section[healthManagement].entry 1..*
* section[healthManagement].entry only Reference(TWHAHealthManagementLevelProfile or TWHAClinicalImpressionProfile or TWHACarePlanProfile)

// 臨場服務現場發現。entry 限定為服務發現 Observation（危害因子等場所層級發現，
// 非個人檢驗結果）。
* section[serviceFindings].code = http://loinc.org#29554-3
* section[serviceFindings].title = "臨場服務發現問題"
* section[serviceFindings].entry only Reference(TWHAObservationServiceFindingProfile)
