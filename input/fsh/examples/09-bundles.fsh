// ==========================================
// 使用情境封包（UC-001 ~ UC-007 Document Bundle）
// ==========================================

// 6 大實用範例 (UC-001 ~ UC-006) Bundle Definitions

Instance: UC-001
InstanceOf: TWHABundleDocumentProfile
Title: "UC-001 一般健康檢查報告封包"
Description: "一般健康檢查結果 Document Bundle 打包範例。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-001"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc001"
* entry[0].resource = composition-uc001
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-general"
* entry[4].resource = example-encounter-general
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-height"
* entry[5].resource = obs-height
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-weight"
* entry[6].resource = obs-weight
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-waist"
* entry[7].resource = obs-waist
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bloodpressure"
* entry[8].resource = obs-bloodpressure
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-physical"
* entry[9].resource = obs-physical
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-glucose"
* entry[10].resource = obs-lab-glucose
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[11].resource = example-clinical-impression
* entry[12].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse"
* entry[12].resource = example-nurse

Instance: UC-002
InstanceOf: TWHABundleDocumentProfile
Title: "UC-002 勞工一般體格與健康檢查報告封包"
Description: "勞工一般健康檢查結果 Document Bundle 打包範例。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-002"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc002"
* entry[0].resource = composition-uc002
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-general"
* entry[4].resource = example-encounter-general
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-height"
* entry[5].resource = obs-height
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-weight"
* entry[6].resource = obs-weight
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-waist"
* entry[7].resource = obs-waist
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bloodpressure"
* entry[8].resource = obs-bloodpressure
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-vision"
* entry[9].resource = obs-vision
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-hearing"
* entry[10].resource = obs-hearing
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-physical"
* entry[11].resource = obs-physical
* entry[12].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-glucose"
* entry[12].resource = obs-lab-glucose
* entry[13].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[13].resource = example-clinical-impression
* entry[14].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse"
* entry[14].resource = example-nurse

Instance: UC-003
InstanceOf: TWHABundleDocumentProfile
Title: "UC-003 特殊危害健康作業檢查報告封包"
Description: "噪音/鉛/粉塵等特殊危害健康作業檢查報告封包。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-003"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
// ⚠️ UC-003 為特殊危害健康作業檢查，就醫事件為 example-encounter-special。
// example-encounter-general 已於本版移除：它既非本次情境之就醫事件，
// 留在封包內也不會被 Composition 走訪到（R4 §3.3.1）。
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc003"
* entry[0].resource = composition-uc003
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-hearing"
* entry[4].resource = obs-hearing
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-pulmonary"
* entry[5].resource = obs-pulmonary
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[6].resource = example-clinical-impression
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-special"
* entry[7].resource = example-encounter-special
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-occupation"
* entry[8].resource = obs-occupation
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-ecg"
* entry[9].resource = obs-ecg
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ImagingStudy/example-imaging-chest-xray"
* entry[10].resource = example-imaging-chest-xray
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/DiagnosticReport/example-diagnostic-report"
* entry[11].resource = example-diagnostic-report
* entry[12].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-health-mgmt-level"
* entry[12].resource = obs-health-mgmt-level
* entry[13].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/CarePlan/example-careplan-fitness"
* entry[13].resource = example-careplan-fitness
* entry[14].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ServiceRequest/example-servicerequest-followup"
* entry[14].resource = example-servicerequest-followup
* entry[15].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse"
* entry[15].resource = example-nurse
* entry[16].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-alcohol"
* entry[16].resource = obs-alcohol
* entry[17].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-smoking-former"
* entry[17].resource = obs-smoking-former

Instance: UC-004
InstanceOf: TWHABundleDocumentProfile
Title: "UC-004 企業自費健康檢查報告封包"
Description: "企業自費健檢報告封包，包含自費影像檢查及內視鏡檢查項目。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-004"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc004"
* entry[0].resource = composition-uc004
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-general"
* entry[4].resource = example-encounter-general
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-imaging-mammo"
* entry[5].resource = obs-imaging-mammo
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-imaging-brain-mri"
* entry[6].resource = obs-imaging-brain-mri
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-imaging-lung-ct"
* entry[7].resource = obs-imaging-lung-ct
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-imaging-pet"
* entry[8].resource = obs-imaging-pet
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-imaging-cta"
* entry[9].resource = obs-imaging-cta
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-endoscopy-egd"
* entry[10].resource = obs-endoscopy-egd
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-endoscopy-colon"
* entry[11].resource = obs-endoscopy-colon
* entry[12].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[12].resource = example-clinical-impression

Instance: UC-005
InstanceOf: TWHABundleDocumentProfile
Title: "UC-005 成人預防保健檢查報告封包"
Description: "國健署成人預防保健自填問卷與理學生化檢查 Document Bundle 範例。"
* identifier.system = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* identifier.value = "bundle-uc-005"
* type = #document
* timestamp = "2026-06-12T12:00:00+08:00"
* entry[0].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc005"
* entry[0].resource = composition-uc005
* entry[1].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker"
* entry[1].resource = example-worker
* entry[2].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor"
* entry[2].resource = example-doctor
* entry[3].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital"
* entry[3].resource = example-hospital
* entry[4].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-general"
* entry[4].resource = example-encounter-general
* entry[5].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/QuestionnaireResponse/adult-preventive-care-response"
* entry[5].resource = adult-preventive-care-response
* entry[6].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/QuestionnaireResponse/sdoh-questionnaire-response"
* entry[6].resource = sdoh-questionnaire-response
* entry[7].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-height"
* entry[7].resource = obs-height
* entry[8].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-weight"
* entry[8].resource = obs-weight
* entry[9].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bmi"
* entry[9].resource = obs-bmi
* entry[10].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-waist"
* entry[10].resource = obs-waist
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bloodpressure"
* entry[11].resource = obs-bloodpressure
* entry[12].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-glucose"
* entry[12].resource = obs-lab-glucose
* entry[13].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression"
* entry[13].resource = example-clinical-impression
* entry[14].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Procedure/example-procedure-counseling"
* entry[14].resource = example-procedure-counseling
* entry[15].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse"
* entry[15].resource = example-nurse

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
* entry[11].fullUrl = "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse"
* entry[11].resource = example-nurse

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
