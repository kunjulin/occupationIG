# 健康諮詢與衛教指導項目代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## CodeSystem: 健康諮詢與衛教指導項目代碼系統 

 
【技術規格】國民健康署成人預防保健服務及一般健康檢查中醫師提供之健康諮詢與衛教指導項目。 

下列值集之定義引用本代碼系統：

* [VS_HealthCounseling](ValueSet-VS-HealthCounseling.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-HealthCounseling",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling",
  "version" : "0.10.0",
  "name" : "CS_HealthCounseling",
  "title" : "健康諮詢與衛教指導項目代碼系統",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-22T02:14:01+00:00",
  "publisher" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
  "contact" : [{
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  },
  {
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  }],
  "description" : "【技術規格】國民健康署成人預防保健服務及一般健康檢查中醫師提供之健康諮詢與衛教指導項目。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 10,
  "concept" : [{
    "code" : "counsel-smoking",
    "display" : "戒菸諮詢與衛教",
    "definition" : "提供戒菸相關諮詢、輔助藥物說明及衛教指導。"
  },
  {
    "code" : "counsel-drinking",
    "display" : "節酒諮詢與衛教",
    "definition" : "提供節制飲酒、危害說明及戒酒相關諮詢。"
  },
  {
    "code" : "counsel-betelnut",
    "display" : "戒檳榔諮詢與衛教",
    "definition" : "提供戒除嚼食檳榔、口腔病變預防相關諮詢。"
  },
  {
    "code" : "counsel-exercise",
    "display" : "規律運動諮詢與衛教",
    "definition" : "提供每週達 150 分鐘中等強度運動之建議及運動指導。"
  },
  {
    "code" : "counsel-weight",
    "display" : "維持正常體重諮詢與衛教",
    "definition" : "提供體重控制、BMI 評估與健康體位管理指導。"
  },
  {
    "code" : "counsel-diet",
    "display" : "健康飲食諮詢與衛教",
    "definition" : "提供健康飲食及「我的餐盤」均衡營養指導。"
  },
  {
    "code" : "counsel-accident",
    "display" : "事故傷害預防諮詢與衛教",
    "definition" : "提供居家安全、防跌與事故傷害預防之衛教。"
  },
  {
    "code" : "counsel-oral",
    "display" : "口腔保健諮詢與衛教",
    "definition" : "提供口腔清潔、牙周病預防及口腔篩檢宣導。"
  },
  {
    "code" : "counsel-chronic-risk",
    "display" : "慢性疾病風險評估諮詢與衛教",
    "definition" : "根據檢查結果進行慢性病（三高）風險評估與諮詢。"
  },
  {
    "code" : "counsel-kidney",
    "display" : "腎病識能衛教指導",
    "definition" : "提供腎臟病預防、早期篩檢指標 (eGFR、尿蛋白) 識能及保健衛教。"
  }]
}

```
