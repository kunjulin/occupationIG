# Betel Nut Chewing Behavior Code System - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## CodeSystem: Betel Nut Chewing Behavior Code System 

 
Betel Nut Chewing Behavior Code System 

This Code system is referenced in the definition of the following value sets:

* [sf-BetNutChewBeh-valueset](ValueSet-sf-BetNutChewBeh-valueset.md)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "sf-BetNutChewBeh-codesystem",
  "url" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
  "version" : "0.1.0",
  "name" : "sf-BetNutChewBeh-codesystem",
  "title" : "Betel Nut Chewing Behavior Code System",
  "status" : "active",
  "date" : "2026-07-26T14:28:30+08:00",
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
  "description" : "Betel Nut Chewing Behavior Code System",
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "amount",
    "display" : "每日嚼檳榔量，以 ”顆” 計算"
  },
  {
    "code" : "year",
    "display" : "嚼檳榔年"
  },
  {
    "code" : "quit",
    "display" : "戒嚼檳榔年"
  }]
}

```
