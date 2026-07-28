// ==========================================
// 1. 基礎資源範例（病人、組織、醫事人員）
// ==========================================

Instance: example-worker
InstanceOf: TWHAPatientProfile
Title: "受檢勞工範例 - 王大同"
Description: "一名在電子公司化學處理課工作的勞工王大同之基本資料與雇主資訊。"
* identifier[0].use = #official
* identifier[0].type = http://terminology.hl7.org/CodeSystem/v2-0203#MR "Medical record number"
* identifier[0].system = "https://www.cgmh.org.tw/tw/patient-id"
* identifier[0].value = "MR-98765"
* name[0].use = #official
* name[0].text = "王大同"
* gender = #male
* birthDate = "1985-05-15"
* active = true
* extension[employerInfo].valueReference = Reference(example-employer)
* extension[employmentDate].valueDate = "2020-03-01"
* extension[department].valueString = "化學處理課"

Instance: example-employer
InstanceOf: TWHAOrganizationEmployerProfile
Title: "雇主事業單位範例 - 大同電子"
Description: "受檢勞工王大同所屬之事業單位組織資料。"
* identifier[0].use = #official
* identifier[0].system = "https://gcis.nat.gov.tw"
* identifier[0].value = "12345678" // 統一編號
* name = "大同電子股份有限公司"

Instance: example-hospital
InstanceOf: TWHAOrganizationFacilityProfile
Title: "實施健檢之醫療機構範例 - 航空醫務中心"
Description: "實施體格檢查及健康檢查之交通部民用航空局航空醫務中心。"
* identifier[0].use = #official
* identifier[0].system = "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw"
* identifier[0].value = "2701010024" // 醫事機構代碼
* name = "交通部民用航空局航空醫務中心"

Instance: example-doctor
InstanceOf: TWHAPractitionerProfile
Title: "執業醫護人員範例 - 林職醫"
Description: "實施勞工體格及健康檢查評估並判定分級之林職醫師。"
* identifier[0].use = #official
// ⚠️ 佔位命名空間，**不是可實作的值**——醫事人員證書字號之命名空間尚未定案。
//    詳見 JOB-06 §8.3。實作端不得沿用此值。
//
// 2026-07-27 以 scripts/inspect-package.js 盤點 tw.gov.mohw.twcore#1.0.0 實測：
//   - 原用之 CodeSystem `practitioner-license-tw` **不存在**
//     （TW Core 僅 30 個 CodeSystem，無此項）；
//   - TWCorePractitioner 固定之 identifier.system 只有 http://www.moi.gov.tw、
//     http://www.immigration.gov.tw、http://hl7.org/fhir/sid/passport-TWN 三者，
//     皆為「人別」識別碼，並非專業證書字號。
//   即**上游未提供醫事人員證書字號之命名空間**。
//
// 曾試「暫時留空」，SUSHI 直接報錯：
//   Element Practitioner.identifier.system has minimum cardinality 1 but occurs 0 time(s)
// TWCorePractitioner 要求 identifier.system 必填，留空不可行。
//
// 故改用 example.org 佔位（FHIR 慣例之範例命名空間）。理由：
//   - 不佔用政府命名空間——證書字號之發放機關為衛福部，命名空間應由主管機關
//     或 TW Core 決定，本 IG 片面另定會造成同一識別碼兩個 canonical；
//   - 不指向一個解析不到的 CodeSystem，讀者不會誤以為那是真實可用的值。
* identifier[0].system = "http://example.org/fhir/sid/tw-practitioner-license"
* identifier[0].value = "MD-88888" // 醫師證書字號（命名空間待主管機關核定）
* name[0].use = #official
* name[0].text = "林職醫"

// ==========================================
// 2. 檢查事件範例（Encounter）
// ==========================================

Instance: example-encounter-general
InstanceOf: TWHAEncounterProfile
Title: "健檢就醫事件範例 - 一般定期健康檢查"
Description: "受檢勞工王大同於115年6月12日進行的一般定期健康檢查事件。"
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* subject = Reference(example-worker)
* period.start = "2026-06-12T08:00:00+08:00"
* period.end = "2026-06-12T11:30:00+08:00"
* participant[0].individual = Reference(example-doctor)
* serviceProvider = Reference(example-hospital)
* extension[examType].valueCodeableConcept = CS_ExamType#general-health "一般健康檢查"
* extension[examInterval].valueQuantity = 3 'a' "years"
* extension[department].valueString = "化學處理課"
