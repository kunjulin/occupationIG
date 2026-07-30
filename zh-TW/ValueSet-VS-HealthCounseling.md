# 健康諮詢與衛教指導項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## ValueSet: 健康諮詢與衛教指導項目值集 

 
包含成人預防保健與健康檢查中健康諮詢項目代碼之值集。 

 **References** 

* [健康諮詢與衛教指導 Profile](StructureDefinition-TWHA-Procedure-Counseling.md)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-HealthCounseling",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HealthCounseling",
  "version" : "0.2.0",
  "name" : "VS_HealthCounseling",
  "title" : "健康諮詢與衛教指導項目值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-30T12:17:12+00:00",
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
  "description" : "包含成人預防保健與健康檢查中健康諮詢項目代碼之值集。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling"
    }]
  }
}

```
