// ==========================================
// 上傳封包範例（UC-008／UC-009 Transaction Bundle，JOB-04）
// ==========================================
//
// 設計要點（對應 JOB-04 §3.1）：
//   1. Transaction 內部參照採 FHIR 標準做法：entry.fullUrl 用 urn:uuid、
//      資源之間以同一 uuid 互相參照。伺服器收單後負責改寫為實際 id。
//      因此本檔的資源是 **Usage #inline 的獨立複本**而非重用 example-worker——
//      具名範例之內部參照為 `Patient/example-worker` 形式，放進 transaction
//      會解析失敗（fullUrl 是 urn:uuid，literal reference 對不上）。
//   2. 去重（idempotent 上傳）以兩個機制示範：
//      - 條件式建立（request.ifNoneExist）：Patient 以病歷號、Organization
//        以醫事機構代碼判重——重複上傳不會產生第二筆資源；
//      - 條件式更新（PUT + 查詢式 URL）：DiagnosticReport 以本 IG 之報告
//        識別碼命名空間（sid/report-id，JOB-06）判重——同一份報告重傳為
//        覆寫而非新增。Practitioner 之判重待證書字號命名空間定案（T-2），
//        本範例暫以一般 POST 處理並於 conformance.md 註明。
//   3. 缺值示範：UC-009 含 dataAbsentReason = not-performed 之檢驗項
//      （與治理原則一致：缺值標明原因，不省略該筆 Observation）。
//   4. 所有代碼沿用本 IG 已驗證之項目（1558-6／98979-8／87729-0），
//      不引入未經 $lookup 之新代碼。
//
// ⚠️ 處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，
//    本範例暫依現行 profile 採 transaction；決策改採 batch 時，
//    僅 Bundle.type 與錯誤處理敘述需改，entry 結構不變。

// ------------------------------------------------------------------
// UC-008 內嵌資源（一般健檢上傳）
// ------------------------------------------------------------------
Instance: tx-patient
InstanceOf: TWHAPatientProfile
Usage: #inline
* identifier[0].use = #official
* identifier[0].type = http://terminology.hl7.org/CodeSystem/v2-0203#MR "Medical record number"
* identifier[0].system = "https://www.cgmh.org.tw/tw/patient-id"
* identifier[0].value = "MR-98765"
* name[0].use = #official
* name[0].text = "王大同"
* gender = #male
* birthDate = "1985-05-15"
* active = true

Instance: tx-org-hospital
InstanceOf: TWHAOrganizationFacilityProfile
Usage: #inline
* identifier[0].use = #official
* identifier[0].system = "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw"
* identifier[0].value = "2701010024"
* name = "交通部民用航空局航空醫務中心"

Instance: tx-obs-glucose
InstanceOf: TWHALabResultGeneralProfile
Usage: #inline
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = LNC#1558-6 "Fasting glucose [Mass/volume] in Serum or Plasma"
* subject.reference = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001"
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* performer[0].reference = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002"
* valueQuantity = 95 'mg/dL' "mg/dL"

Instance: tx-report-general
InstanceOf: TWHADiagnosticReportProfile
Usage: #inline
* identifier[0].system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier[0].value = "RPT-2026-0612-002"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB "Laboratory"
* code.text = "一般健康檢查檢驗報告"
* subject.reference = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001"
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* issued = "2026-06-15T10:00:00+08:00"
* performer[0].reference = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002"
* result[0].reference = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0003"

// ------------------------------------------------------------------
// UC-008：一般健檢結果首次上傳
// ------------------------------------------------------------------
Instance: UC-008
InstanceOf: TWHABundleTransactionProfile
Title: "UC-008 一般健檢結果上傳封包（首次上傳）"
Description: "健檢機構向主管機關平台上傳一般健檢結果之 Transaction Bundle。示範：urn:uuid 內部參照、Patient／Organization 以識別碼條件式建立（ifNoneExist）達成去重、DiagnosticReport 以報告識別碼（sid/report-id）條件式建立。處理語意（transaction／batch）為未決事項 M-9。"
* type = #transaction
* entry[0].fullUrl = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001"
* entry[0].resource = tx-patient
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"
* entry[0].request.ifNoneExist = "identifier=https://www.cgmh.org.tw/tw/patient-id|MR-98765"
* entry[1].fullUrl = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002"
* entry[1].resource = tx-org-hospital
* entry[1].request.method = #POST
* entry[1].request.url = "Organization"
* entry[1].request.ifNoneExist = "identifier=https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw|2701010024"
* entry[2].fullUrl = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0003"
* entry[2].resource = tx-obs-glucose
* entry[2].request.method = #POST
* entry[2].request.url = "Observation"
* entry[3].fullUrl = "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0004"
* entry[3].resource = tx-report-general
* entry[3].request.method = #POST
* entry[3].request.url = "DiagnosticReport"
* entry[3].request.ifNoneExist = "identifier=https://twcore.mohw.gov.tw/ig/twha/sid/report-id|RPT-2026-0612-002"

// ------------------------------------------------------------------
// UC-009 內嵌資源（特殊健檢上傳＋缺值＋冪等重傳）
// ------------------------------------------------------------------
Instance: tx9-patient
InstanceOf: TWHAPatientProfile
Usage: #inline
* identifier[0].use = #official
* identifier[0].type = http://terminology.hl7.org/CodeSystem/v2-0203#MR "Medical record number"
* identifier[0].system = "https://www.cgmh.org.tw/tw/patient-id"
* identifier[0].value = "MR-98765"
* name[0].use = #official
* name[0].text = "王大同"
* gender = #male
* birthDate = "1985-05-15"
* active = true

Instance: tx9-org-hospital
InstanceOf: TWHAOrganizationFacilityProfile
Usage: #inline
* identifier[0].use = #official
* identifier[0].system = "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw"
* identifier[0].value = "2701010024"
* name = "交通部民用航空局航空醫務中心"

Instance: tx9-practitioner
InstanceOf: TWHAPractitionerProfile
Usage: #inline
* identifier[0].use = #official
// 佔位命名空間，理由與 example-doctor 相同（T-2）；證書字號命名空間定案前
// 無從以 ifNoneExist 對 Practitioner 判重，故 UC-009 對其採一般 POST。
* identifier[0].system = "http://example.org/fhir/sid/tw-practitioner-license"
* identifier[0].value = "MD-88888"
* name[0].use = #official
* name[0].text = "林職醫"

Instance: tx9-obs-exposure
InstanceOf: TWHAWorkExposureProfile
Usage: #inline
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#87729-0 "History of Occupational hazard"
* subject.reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0001"
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* performer[0].reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0003"
* valueCodeableConcept = CS_HazardType#lead "鉛作業"
* component[exposureYears].code = LNC#104905-5 "Duration of exposure"
* component[exposureYears].valueQuantity = 8 'a' "years"

Instance: tx9-obs-egfr-absent
InstanceOf: TWHALabResultSpecialProfile
Usage: #inline
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = LNC#98979-8 "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* subject.reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0001"
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* performer[0].reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0002"
* dataAbsentReason = http://terminology.hl7.org/CodeSystem/data-absent-reason#not-performed "Not Performed"

Instance: tx9-report-special
InstanceOf: TWHADiagnosticReportProfile
Usage: #inline
* identifier[0].system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier[0].value = "RPT-2026-0612-003"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB "Laboratory"
* code.text = "特殊危害健康作業（鉛作業）檢查報告"
* subject.reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0001"
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* issued = "2026-06-15T10:00:00+08:00"
* performer[0].reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0003"
// result 僅收檢驗類 Observation（上游限縮，T-10）；暴露史屬 social-history，
// 不置於 result，由平台端另以查詢取得。
* result[0].reference = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0005"

// ------------------------------------------------------------------
// UC-009：特殊健檢結果上傳（冪等重傳）
// ------------------------------------------------------------------
Instance: UC-009
InstanceOf: TWHABundleTransactionProfile
Title: "UC-009 特殊健檢結果上傳封包（含缺值與冪等重傳）"
Description: "健檢機構上傳特殊危害健康作業（鉛作業）檢查結果之 Transaction Bundle。示範：DiagnosticReport 以報告識別碼（sid/report-id）做**條件式更新（PUT）**——同一份報告重傳為覆寫而非新增，達成冪等；檢驗缺值以 dataAbsentReason 標明；暴露史因 result 之上游限縮（T-10）不置於 report.result。處理語意（transaction／batch）為未決事項 M-9。"
* type = #transaction
* entry[0].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0001"
* entry[0].resource = tx9-patient
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"
* entry[0].request.ifNoneExist = "identifier=https://www.cgmh.org.tw/tw/patient-id|MR-98765"
* entry[1].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0002"
* entry[1].resource = tx9-org-hospital
* entry[1].request.method = #POST
* entry[1].request.url = "Organization"
* entry[1].request.ifNoneExist = "identifier=https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw|2701010024"
* entry[2].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0003"
* entry[2].resource = tx9-practitioner
* entry[2].request.method = #POST
* entry[2].request.url = "Practitioner"
* entry[3].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0004"
* entry[3].resource = tx9-obs-exposure
* entry[3].request.method = #POST
* entry[3].request.url = "Observation"
* entry[4].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0005"
* entry[4].resource = tx9-obs-egfr-absent
* entry[4].request.method = #POST
* entry[4].request.url = "Observation"
* entry[5].fullUrl = "urn:uuid:8f7a0002-1a2b-4c3d-9e4f-5a6b7c8d0006"
* entry[5].resource = tx9-report-special
* entry[5].request.method = #PUT
* entry[5].request.url = "DiagnosticReport?identifier=https%3A%2F%2Ftwcore.mohw.gov.tw%2Fig%2Ftwha%2Fsid%2Freport-id%7CRPT-2026-0612-003"
