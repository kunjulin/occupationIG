# 檢查類型值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## ValueSet: 檢查類型值集 

 
包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查之代碼。 

 **References** 

* [檢查類型擴充](StructureDefinition-ext-exam-type.md)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-ExamType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ExamType",
  "version" : "0.2.0",
  "name" : "VS_ExamType",
  "title" : "檢查類型值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-29T16:54:28+00:00",
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
  "description" : "包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查之代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType"
    }]
  }
}

```
