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
* performer = Reference(example-nurse)
* valueCodeableConcept.coding[0] = http://snomed.info/sct#266919005 "Never smoked tobacco"
* valueCodeableConcept.coding[1] = CS_SmokingStatus#0-never "從未吸菸"

Instance: obs-betelnut
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態與量化資料範例"
Description: "受檢勞工王大同的嚼檳榔習慣，每日嚼食 5 顆，嚼檳 10 年，目前已戒除 1 年（12個月）。"
* status = #final
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
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
* performer = Reference(example-nurse)
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

// ------------------------------------------------------------------
// 已戒菸者（JOB-05）
// 既有之 obs-smoking 為「從未吸菸」，其上填 ext-smoking-quantity（吸菸量）
// 與 ext-cessation-duration（戒除月數）在語意上是錯的，故另立本範例——
// 這兩個 extension 之「範例」即指有宿主資源實際用到它（JOB-05 §3.3）。
Instance: obs-smoking-former
InstanceOf: TWHASocialHistorySmokingProfile
Title: "吸菸狀態與菸量範例 - 已戒菸"
Description: "受檢勞工之吸菸史：曾每日吸菸 20 支、菸齡 15 年，已戒菸 24 個月。用於示範 ext-smoking-quantity 與 ext-cessation-duration 之填法。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#72166-2 "Tobacco smoking status"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept.coding[0] = http://snomed.info/sct#8517006 "Ex-smoker"
* valueCodeableConcept.coding[localSmokingStatus] = CS_SmokingStatus#3-quit "已戒菸"
* extension[smokingQuantity].extension[dailyAmount].valueInteger = 20
* extension[smokingQuantity].extension[durationYears].valueInteger = 15
* extension[cessationDuration].valueInteger = 24

// ------------------------------------------------------------------
// 飲酒歷史（JOB-05：TWHA-SocialHistory-Alcohol 原無任何範例）
// Profile 固定 code = LNC#11331-6 且限定 value[x] 為 CodeableConcept，
// 但未綁定值集——本 IG 目前沒有飲酒狀態的本地代碼系統。
// 此處採 SNOMED CT，與既有 obs-smoking 之作法一致。
Instance: obs-alcohol
InstanceOf: TWHASocialHistoryAlcoholProfile
Title: "飲酒歷史與狀態範例"
Description: "受檢勞工王大同之飲酒習慣：目前有飲酒習慣。"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#11331-6 "History of Alcohol use"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept = http://snomed.info/sct#219006 "Current drinker of alcohol"
