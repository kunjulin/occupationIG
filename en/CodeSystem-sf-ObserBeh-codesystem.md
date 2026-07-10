# 相關行為代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## CodeSystem: 相關行為代碼系統 

 
Observation Behavior Code System 

This Code system is referenced in the definition of the following value sets:

* This CodeSystem is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "sf-ObserBeh-codesystem",
  "url" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem",
  "version" : "0.1.0",
  "name" : "sf-ObserBeh-codesystem",
  "title" : "相關行為代碼系統",
  "status" : "active",
  "date" : "2026-07-10T21:30:50+08:00",
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
  "description" : "Observation Behavior Code System",
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "Smoking",
    "display" : "吸菸行為"
  },
  {
    "code" : "BetelNutChewing",
    "display" : "嚼檳榔行為"
  },
  {
    "code" : "Drinking",
    "display" : "喝酒行為"
  }]
}

```
