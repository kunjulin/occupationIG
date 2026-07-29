# 吸菸狀態代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 吸菸狀態代碼系統 

 
勞工健檢生活習慣調查中之吸菸狀態分類。 

* [VS_SmokingStatus](ValueSet-VS-SmokingStatus.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-SmokingStatus",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus",
  "version" : "0.2.0",
  "name" : "CS_SmokingStatus",
  "title" : "吸菸狀態代碼系統",
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
  "description" : "勞工健檢生活習慣調查中之吸菸狀態分類。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "0-never",
    "display" : "從未吸菸",
    "definition" : "受檢勞工從未吸菸。"
  },
  {
    "code" : "1-occasional",
    "display" : "偶爾吸菸",
    "definition" : "受檢勞工偶爾吸菸（非每日）。"
  },
  {
    "code" : "2-daily",
    "display" : "每日吸菸",
    "definition" : "受檢勞工每日吸菸。"
  },
  {
    "code" : "3-quit",
    "display" : "已戒菸",
    "definition" : "受檢勞工過去曾吸菸，目前已戒除。"
  }]
}

```
