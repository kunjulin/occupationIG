# 臨場健康服務辦理事項值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## ValueSet: 臨場健康服務辦理事項值集 () 

 
包含臨場健康服務項目活動類別代碼之值集。（provisional，隨 CS-ServiceActivityType 待官方確認） 

 **References** 

* [臨場服務執行活動項目 Profile](StructureDefinition-TWHA-Procedure-ServiceActivity.md)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-ServiceActivityType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ServiceActivityType",
  "version" : "0.2.0",
  "name" : "VS_ServiceActivityType",
  "title" : "臨場健康服務辦理事項值集",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-05T16:28:11+00:00",
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
  "description" : "包含臨場健康服務項目活動類別代碼之值集。（provisional，隨 CS-ServiceActivityType 待官方確認）",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ServiceActivityType"
    }]
  }
}

```
