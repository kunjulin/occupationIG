Profile: TWHAQuestionnaireResponseHTProfile
Parent: TWCoreQuestionnaireResponse
Id: TWHA-QuestionnaireResponse-HT
Title: "成人預防保健問卷回覆 Profile"
Description: "用於記錄成人預防保健（國健署成人預防保健服務）之自覺症狀與生活習慣問卷回覆，繼承自 TW Core QuestionnaireResponse。"
* ^experimental = false
* status = #completed
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* source only Reference(TWHAPatientProfile)
* author only Reference(TWHAPatientProfile or TWHAPractitionerProfile)

Instance: adult-preventive-care-questionnaire
InstanceOf: TWHAQuestionnaireProfile
Title: "國健署成人預防保健生活習慣與既往病史問卷定義"
Description: "用於記錄國民健康署成人預防保健服務之健康行為、生活習慣與個人及家族病史自填問卷項目。"
* url = "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/adult-preventive-care-questionnaire"
* status = #active
* item[0].linkId = "smoking"
* item[0].text = "您過去一個月內是否吸菸？"
* item[0].type = #boolean
* item[1].linkId = "drinking"
* item[1].text = "您過去一個月內是否飲酒？"
* item[1].type = #boolean
* item[2].linkId = "betelnut"
* item[2].text = "您過去一個月內是否嚼食檳榔？"
* item[2].type = #boolean
* item[3].linkId = "exercise"
* item[3].text = "您平均每週是否進行 150 分鐘以上之中等強度運動？"
* item[3].type = #boolean
* item[4].linkId = "past-history"
* item[4].text = "您過去是否曾被診斷患有高血壓、糖尿病、高血脂或心血管疾病？"
* item[4].type = #boolean
* item[5].linkId = "family-history"
* item[5].text = "您的直系親屬（父母、手足）中是否有腦中風、心臟病或糖尿病史？"
* item[5].type = #boolean
* item[6].linkId = "medication-history"
* item[6].text = "您目前是否因高血壓、糖尿病、高血脂症或心血管疾病等而長期服藥？"
* item[6].type = #boolean
* item[7].linkId = "depression-interest"
* item[7].text = "過去兩星期，您是否經常感覺做事提不起勁或沒有樂趣？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)"
* item[7].type = #integer
* item[8].linkId = "depression-mood"
* item[8].text = "過去兩星期，您是否經常感覺心情低落、沮喪或絕望？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)"
* item[8].type = #integer

