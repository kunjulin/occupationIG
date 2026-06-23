CodeSystem: CS_HealthCounseling
Id: CS-HealthCounseling
Title: "健康諮詢與衛教指導項目代碼系統"
Description: "國民健康署成人預防保健服務及一般健康檢查中醫師提供之健康諮詢與衛教指導項目。"
* ^experimental = false
* ^caseSensitive = true
* #counsel-smoking "戒菸諮詢與衛教" "提供戒菸相關諮詢、輔助藥物說明及衛教指導。"
* #counsel-drinking "節酒諮詢與衛教" "提供節制飲酒、危害說明及戒酒相關諮詢。"
* #counsel-betelnut "戒檳榔諮詢與衛教" "提供戒除嚼食檳榔、口腔病變預防相關諮詢。"
* #counsel-exercise "規律運動諮詢與衛教" "提供每週達 150 分鐘中等強度運動之建議及運動指導。"
* #counsel-weight "維持正常體重諮詢與衛教" "提供體重控制、BMI 評估與健康體位管理指導。"
* #counsel-diet "健康飲食諮詢與衛教" "提供健康飲食及「我的餐盤」均衡營養指導。"
* #counsel-accident "事故傷害預防諮詢與衛教" "提供居家安全、防跌與事故傷害預防之衛教。"
* #counsel-oral "口腔保健諮詢與衛教" "提供口腔清潔、牙周病預防及口腔篩檢宣導。"
* #counsel-chronic-risk "慢性疾病風險評估諮詢與衛教" "根據檢查結果進行慢性病（三高）風險評估與諮詢。"
* #counsel-kidney "腎病識能衛教指導" "提供腎臟病預防、早期篩檢指標 (eGFR、尿蛋白) 識能及保健衛教。"

ValueSet: VS_HealthCounseling
Id: VS-HealthCounseling
Title: "健康諮詢與衛教指導項目值集"
Description: "包含成人預防保健與健康檢查中健康諮詢項目代碼之值集。"
* ^experimental = false
* include codes from system CS_HealthCounseling
