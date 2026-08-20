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

// 三個嚼檳榔範例涵蓋 JOB-29 §A.2 之四種臨床情形中的三種（已戒／現嚼／從未），
// 第四種「有嚼但量不詳」以 obs-betelnut-current 之 component 缺值原則說明於
// terminology.md，不另立範例。
//
// ⚠️ 已戒者之戒除期間送 `1 a`（年），**不寫成 `12 mo`**：上游與現行問卷以「年」
// 收集，強制轉換會偽造精度——原始資料並未主張「恰好 12 個月」（JOB-29 §A.6）。
Instance: obs-betelnut
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態與量化資料範例（已戒）"
Description: "受檢勞工王大同的嚼檳榔習慣：過去每日嚼食 5 顆，嚼檳 10 年，目前已戒除 1 年。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = SCT#698188003 "Chews betel quid"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept = CS_BetelNutStatus#3-quit "已戒除"
* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].valueQuantity = 5 '{quid}/d' "顆/日"
* component[durationYears].code = CS_BetelNutComponent#duration-years "嚼食年數"
* component[durationYears].valueQuantity = 10 'a' "年"
* component[cessationDuration].code = CS_BetelNutComponent#cessation-duration "戒除期間"
* component[cessationDuration].valueQuantity = 1 'a' "年"
* component[informationSource].code = LNC#48766-0 "Information source"
* component[informationSource].valueCodeableConcept = CS_BetelNutInfoSource#self-report "受檢者自述"

// 現嚼者：涵蓋委員意見所增之欄位（含菸草、添加物、石灰種類、戒除日期不送），
// 並示範上游級距碼之可選對照（amountCoded，extensible）。
Instance: obs-betelnut-current
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態與量化資料範例（現嚼，含情境欄位）"
Description: "受檢勞工陳美玲：每日嚼食 10 顆（含菸草、荖葉、白灰），嚼檳 20 年，未戒。另附上游 TWCR_SF 級距碼作為對照。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = SCT#698188003 "Chews betel quid"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept = CS_BetelNutStatus#2-daily "每日嚼食"
* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].valueQuantity = 10 '{quid}/d' "顆/日"
* component[durationYears].code = CS_BetelNutComponent#duration-years "嚼食年數"
* component[durationYears].valueQuantity = 20 'a' "年"
* component[withTobacco].code = CS_BetelNutComponent#with-tobacco "是否含菸草"
* component[withTobacco].valueBoolean = true
* component[additive].code = CS_BetelNutComponent#additive "添加物"
* component[additive].valueCodeableConcept = CS_BetelNutAdditive#betel-leaf "荖葉"
* component[lime].code = CS_BetelNutComponent#lime "石灰種類"
* component[lime].valueCodeableConcept = CS_BetelNutLime#white-lime "白灰"
* component[amountCoded].code = CS_BetelNutComponent#amount-coded "每日嚼食量（上游級距碼）"
* component[amountCoded].valueCodeableConcept = TWCRSFBetNutChewAmountCS#10 "每日10顆"
// 口腔黏膜檢查表之原始勾選並存：每日 10 顆（< 20）、嚼 20 年（> 10）⇒ 表列第 5 項。
// 兩者並存不衝突——級距是原始勾選，Quantity 是實測值，前者不由後者導出、亦不換算。
* component[hpaCategory].code = CS_BetelNutComponent#hpa-category "口腔黏膜檢查表級距"
* component[hpaCategory].valueCodeableConcept = CS_BetelNutHpaCategory#4-ge10y-lt20 "嚼超過 10 年，每天少於 20 顆"
* component[informationSource].code = LNC#48766-0 "Information source"
* component[informationSource].valueCodeableConcept = CS_BetelNutInfoSource#self-report "受檢者自述"

// 從未嚼食：三個量化 component 全部不送。
// 舊版三者皆 1..1，此情形仍須填 amount#00 ＋ year#00 ＋ quit#88——其中 #88 之語意
// 是「無嚼檳榔」，卻與 sf-BetNutChewAmount#88（每日 88 顆）同碼異義（JOB-29 §A.5）。
Instance: obs-betelnut-never
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態範例（從未嚼食）"
Description: "受檢勞工林志明：從未嚼食檳榔。三個量化 component 全部不送。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = SCT#698188003 "Chews betel quid"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept = CS_BetelNutStatus#0-never "從未嚼食檳榔"

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
