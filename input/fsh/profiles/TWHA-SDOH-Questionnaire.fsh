Profile: TWHASDOHQuestionnaireResponseProfile
Parent: TWCoreQuestionnaireResponse
Id: TWHA-SDOH-QuestionnaireResponse
Title: "社會決定因素 (SDOH) 問卷回覆 Profile"
Description: "【技術規格】用於記錄受檢者之社會決定因素問卷結果（基於精簡版 PRAPARE 社會風險問卷），繼承自 TW Core QuestionnaireResponse。"
* ^experimental = false
* status = #completed
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* source only Reference(TWHAPatientProfile)
* author only Reference(TWHAPatientProfile or TWHAPractitionerProfile)

Instance: twha-sdoh-questionnaire
InstanceOf: TWHAQuestionnaireProfile
Title: "精簡版 PRAPARE 社會風險問卷定義"
Description: "包含教育程度、就業狀態、居住環境安全、主要照顧壓力與經濟困難等 5 個核心社會決定因素 (SDOH) 欄位之問卷。"
* url = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/twha-sdoh-questionnaire"
* status = #active
* item[0].linkId = "education"
* item[0].text = "您的最高學歷為何？"
* item[0].type = #string
* item[1].linkId = "employment"
* item[1].text = "您目前的工作就業狀態為何？"
* item[1].type = #string
* item[2].linkId = "housing-security"
* item[2].text = "您是否覺得目前居住的環境或房屋不夠安全？"
* item[2].type = #boolean
* item[3].linkId = "caregiver-stress"
* item[3].text = "您目前是否有照顧家人（如老人或幼童）的巨大精神或體力壓力？"
* item[3].type = #boolean
* item[4].linkId = "financial-hardship"
* item[4].text = "在過去一年中，您是否曾因為經濟困難而無法支付足夠的食物、醫療費用或房租？"
* item[4].type = #boolean
