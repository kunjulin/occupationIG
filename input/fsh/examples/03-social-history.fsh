// ==========================================
// 4. 生活習慣與自覺症狀（Observation & QR）
// ==========================================

Instance: obs-smoking
InstanceOf: TWHASocialHistorySmokingProfile
Title: "吸菸狀態與菸量範例"
Description: "受檢勞工王大同的吸菸史（從未吸菸）。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#72166-2 "Tobacco smoking status"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* valueCodeableConcept.coding[0] = http://snomed.info/sct#266919005 "Never smoked tobacco"
* valueCodeableConcept.coding[1] = CS_SmokingStatus#0-never "從未吸菸"

Instance: obs-betelnut
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態與量化資料範例"
Description: "受檢勞工王大同的嚼檳榔習慣，每日嚼食 5 顆，嚼檳 10 年，目前已戒除 1 年（12個月）。"
* status = #final
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* component[amount].valueCodeableConcept = TWCRSFBetNutChewAmountCS#05 "每日5顆"
* component[year].valueCodeableConcept = TWCRSFBetNutChewYearCS#10 "嚼10年"
* component[quit].valueCodeableConcept = TWCRSFBetNutChewQuitCS#01 "已戒1年"

Instance: obs-sleep
InstanceOf: TWHASocialHistorySleepProfile
Title: "睡眠狀況測量範例"
Description: "受檢勞工王大同的平均每日睡眠時間 (7 小時)。"
* status = #final
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* valueQuantity = 7 'h' "hours"

Instance: example-questionnaire
InstanceOf: TWHAQuestionnaireProfile
Title: "自覺症狀問卷定義範例"
Description: "自覺症狀調查問卷結構定義。"
* url = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/example-questionnaire"
* status = #active
* item[0].linkId = "q1"
* item[0].text = "您過去三個月內，是否經常感到呼吸困難或氣喘？"
* item[0].type = #boolean
* item[1].linkId = "q2"
* item[1].text = "您過去三個月內，是否經常感到胸痛或胸悶？"
* item[1].type = #boolean

Instance: example-symptoms-response
InstanceOf: TWHAQuestionnaireResponseProfile
Title: "自覺症狀問卷回覆範例"
Description: "受檢勞工王大同的自覺症狀問卷填寫結果。"
* status = #completed
* authored = "2024-03-01T09:00:00Z"
* questionnaire = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/example-questionnaire"
* subject = Reference(example-worker)
* source = Reference(example-worker)
* author = Reference(example-worker)
* item[0].linkId = "q1"
* item[0].answer[0].valueBoolean = false
* item[1].linkId = "q2"
* item[1].answer[0].valueBoolean = false
