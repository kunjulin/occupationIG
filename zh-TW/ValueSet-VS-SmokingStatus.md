# 吸菸狀態值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.5

## ValueSet: 吸菸狀態值集 

 
包含吸菸狀態代碼的值集。 

 **References** 

* [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-SmokingStatus",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-SmokingStatus",
  "version" : "0.2.5",
  "name" : "VS_SmokingStatus",
  "title" : "吸菸狀態值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-17T06:57:01+00:00",
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
  "description" : "包含吸菸狀態代碼的值集。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus"
    }]
  }
}

```
