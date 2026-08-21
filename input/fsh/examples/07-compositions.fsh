// ==========================================
// 8. 附表八與附表十一之文件組成與打包（Composition）
// ==========================================

Instance: composition-uc001
InstanceOf: TWHACompositionProfile
Title: "一般健檢報告組成文件範例 (UC-001)"
Description: "整合王大同一般健康檢查所有關聯項目的 Composition 臨床文件範例。"
* status = #final
* title = "一般健康檢查報告"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:45:00+08:00"
* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry[0] = Reference(example-worker)
* section[demographics].entry[1] = Reference(example-encounter-general)
* section[physicalExams].code = http://loinc.org#29545-1
* section[physicalExams].title = "理學檢查"
* section[physicalExams].entry[0] = Reference(obs-height)
* section[physicalExams].entry[1] = Reference(obs-weight)
* section[physicalExams].entry[2] = Reference(obs-waist)
* section[physicalExams].entry[3] = Reference(obs-bloodpressure)
* section[physicalExams].entry[4] = Reference(obs-physical)
* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry[0] = Reference(obs-lab-glucose)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry[0] = Reference(example-clinical-impression)

Instance: composition-uc002
InstanceOf: TWHACompositionProfile
Title: "勞工一般體格與健康檢查報告組成文件範例 (UC-002)"
Description: "整合王大同勞工一般健康檢查關聯項目的 Composition 臨床文件範例。"
* status = #final
* title = "勞工一般體格及健康檢查紀錄"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:45:00+08:00"
* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry[0] = Reference(example-worker)
* section[demographics].entry[1] = Reference(example-encounter-general)
* section[physicalExams].code = http://loinc.org#29545-1
* section[physicalExams].title = "理學檢查"
* section[physicalExams].entry[0] = Reference(obs-height)
* section[physicalExams].entry[1] = Reference(obs-weight)
* section[physicalExams].entry[2] = Reference(obs-waist)
* section[physicalExams].entry[3] = Reference(obs-bloodpressure)
* section[physicalExams].entry[4] = Reference(obs-vision)
* section[physicalExams].entry[5] = Reference(obs-hearing)
* section[physicalExams].entry[6] = Reference(obs-physical)
* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry[0] = Reference(obs-lab-glucose)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry[0] = Reference(example-clinical-impression)

Instance: composition-uc003
InstanceOf: TWHACompositionProfile
Title: "特殊危害健康作業檢查報告組成文件範例 (UC-003)"
Description: "整合王大同噪音/鉛/粉塵特殊危害作業檢查項目的 Composition 臨床文件範例。"
* status = #final
* title = "特殊危害健康作業檢查報告"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:45:00+08:00"
// ⚠️ 本文件為**特殊危害健康作業**檢查報告，故 demographics 收 example-encounter-special
// 而非 example-encounter-general——UC-003 描述的是特殊危害那一次就醫。
* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry[0] = Reference(example-worker)
* section[demographics].entry[1] = Reference(example-encounter-special)
* section[workHistory].code = http://loinc.org#11341-5
* section[workHistory].title = "作業經歷"
* section[workHistory].entry[0] = Reference(obs-occupation)
* section[habits].code = http://loinc.org#11338-1
* section[habits].title = "生活習慣"
* section[habits].entry[0] = Reference(obs-alcohol)
* section[habits].entry[1] = Reference(obs-smoking-former)
* section[physicalExams].code = http://loinc.org#29545-1
* section[physicalExams].title = "理學檢查"
* section[physicalExams].entry[0] = Reference(obs-hearing)
* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry[0] = Reference(obs-pulmonary)
* section[labExams].entry[1] = Reference(obs-ecg)
* section[labExams].entry[2] = Reference(example-imaging-chest-xray)
* section[labExams].entry[3] = Reference(example-diagnostic-report)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry[0] = Reference(example-clinical-impression)
* section[assessment].entry[1] = Reference(example-careplan-fitness)
* section[assessment].entry[2] = Reference(example-servicerequest-followup)

Instance: composition-uc004
InstanceOf: TWHACompositionProfile
Title: "自費健康檢查與進階影像鏡檢報告組成文件範例 (UC-004)"
Description: "整合王大同自費影像造影與內視鏡檢查項目的 Composition 臨床文件範例。"
* status = #final
* title = "自費健康檢查報告"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:45:00+08:00"
* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry[0] = Reference(example-worker)
* section[demographics].entry[1] = Reference(example-encounter-general)
* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry[0] = Reference(obs-imaging-mammo)
* section[labExams].entry[1] = Reference(obs-imaging-brain-mri)
* section[labExams].entry[2] = Reference(obs-imaging-lung-ct)
* section[labExams].entry[3] = Reference(obs-imaging-pet)
* section[labExams].entry[4] = Reference(obs-imaging-cta)
* section[labExams].entry[5] = Reference(obs-endoscopy-egd)
* section[labExams].entry[6] = Reference(obs-endoscopy-colon)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry[0] = Reference(example-clinical-impression)

Instance: composition-uc005
InstanceOf: TWHACompositionProfile
Title: "成人預防保健檢查報告組成文件範例 (UC-005)"
Description: "整合王大同成人預防保健與生活習慣問卷項目的 Composition 臨床文件範例。"
* status = #final
* title = "成人預防保健檢查報告"
* subject = Reference(example-worker)
* author = Reference(example-doctor)
* date = "2026-06-12T11:45:00+08:00"
* section[demographics].code = http://loinc.org#51847-2
* section[demographics].title = "基本資料與行政資訊"
* section[demographics].entry[0] = Reference(example-worker)
* section[demographics].entry[1] = Reference(example-encounter-general)
* section[symptoms].code = http://loinc.org#29554-3
* section[symptoms].title = "自覺症狀"
* section[symptoms].entry[0] = Reference(adult-preventive-care-response)
* section[symptoms].entry[1] = Reference(sdoh-questionnaire-response)
* section[physicalExams].code = http://loinc.org#29545-1
* section[physicalExams].title = "理學檢查"
* section[physicalExams].entry[0] = Reference(obs-height)
* section[physicalExams].entry[1] = Reference(obs-weight)
* section[physicalExams].entry[2] = Reference(obs-bmi)
* section[physicalExams].entry[3] = Reference(obs-waist)
* section[physicalExams].entry[4] = Reference(obs-bloodpressure)
* section[labExams].code = http://loinc.org#30954-2
* section[labExams].title = "檢驗與影像檢查"
* section[labExams].entry[0] = Reference(obs-lab-glucose)
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry[0] = Reference(example-clinical-impression)
* section[assessment].entry[1] = Reference(example-procedure-counseling)


Instance: example-composition-service
InstanceOf: TWHACompositionServiceRecordProfile
Title: "臨場服務紀錄組成文件範例 (UC-006)"
Description: "整合大同電子 115年6月份臨場服務紀錄（附表八）的 Composition 臨床文件範例。"
* status = #final
* subject = Reference(example-employer)
* author = Reference(example-doctor)
* date = "2026-06-10T14:00:00+08:00"
* section[workplace].code = http://loinc.org#51847-2
* section[workplace].title = "作業場所概況"
* section[workplace].entry[0] = Reference(example-encounter-service)
* section[activities].code = http://loinc.org#97726-4
* section[activities].title = "臨場服務執行情形"
* section[activities].entry[0] = Reference(example-procedure-activity)
* section[findings].code = http://loinc.org#29554-3
* section[findings].title = "現場發現問題"
* section[findings].entry[0] = Reference(example-service-finding)
* section[recommendations].code = http://loinc.org#51898-5
* section[recommendations].title = "改善建議與追蹤"
* section[recommendations].entry[0] = Reference(example-service-task)

Instance: adult-preventive-care-response
InstanceOf: TWHAQuestionnaireResponseHTProfile
Title: "成人預防保健問卷回覆實例"
Description: "王大同的成人預防保健生活習慣自填問卷回覆結果。"
* status = #completed
* authored = "2026-06-12T08:10:00+08:00"
* questionnaire = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/adult-preventive-care-questionnaire"
* subject = Reference(example-worker)
* source = Reference(example-worker)
* author = Reference(example-worker)
* item[0].linkId = "smoking"
* item[0].answer[0].valueBoolean = false
* item[1].linkId = "drinking"
* item[1].answer[0].valueBoolean = false
* item[2].linkId = "betelnut"
* item[2].answer[0].valueBoolean = false
* item[3].linkId = "exercise"
* item[3].answer[0].valueBoolean = true
* item[4].linkId = "past-history"
* item[4].answer[0].valueBoolean = false
* item[5].linkId = "family-history"
* item[5].answer[0].valueBoolean = true
* item[6].linkId = "medication-history"
* item[6].answer[0].valueBoolean = false
* item[7].linkId = "depression-interest"
* item[7].answer[0].valueInteger = 0
* item[8].linkId = "depression-mood"
* item[8].answer[0].valueInteger = 0


Instance: sdoh-questionnaire-response
InstanceOf: TWHASDOHQuestionnaireResponseProfile
Title: "SDOH 社會決定因素問卷回覆實例"
Description: "王大同的精簡版 PRAPARE 社會風險問卷回覆結果。"
* status = #completed
* authored = "2026-06-12T08:10:00+08:00"
* questionnaire = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/twha-sdoh-questionnaire"
* subject = Reference(example-worker)
* source = Reference(example-worker)
* author = Reference(example-worker)
* item[0].linkId = "education"
* item[0].answer[0].valueString = "大學畢業"
* item[1].linkId = "employment"
* item[1].answer[0].valueString = "全職就業"
* item[2].linkId = "housing-security"
* item[2].answer[0].valueBoolean = false
* item[3].linkId = "caregiver-stress"
* item[3].answer[0].valueBoolean = false
* item[4].linkId = "financial-hardship"
* item[4].answer[0].valueBoolean = false
