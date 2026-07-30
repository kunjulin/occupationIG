# 特定化學物質種類代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 特定化學物質種類代碼系統 

 
特別危害健康作業中之特定化學物質種類。 

* [VS_SpecificChemicalType](ValueSet-VS-SpecificChemicalType.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-SpecificChemicalType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SpecificChemicalType",
  "version" : "0.2.0",
  "name" : "CS_SpecificChemicalType",
  "title" : "特定化學物質種類代碼系統",
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
  "description" : "特別危害健康作業中之特定化學物質種類。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 12,
  "concept" : [{
    "code" : "benzidine",
    "display" : "聯苯胺"
  },
  {
    "code" : "beta-naphthylamine",
    "display" : "β-萘胺"
  },
  {
    "code" : "beryllium",
    "display" : "鈹"
  },
  {
    "code" : "vinyl-chloride",
    "display" : "氯乙烯"
  },
  {
    "code" : "benzene",
    "display" : "苯"
  },
  {
    "code" : "asbestos",
    "display" : "石綿"
  },
  {
    "code" : "arsenic",
    "display" : "砷"
  },
  {
    "code" : "cadmium",
    "display" : "鎘"
  },
  {
    "code" : "chromium",
    "display" : "鉻"
  },
  {
    "code" : "manganese",
    "display" : "錳"
  },
  {
    "code" : "mercury",
    "display" : "汞"
  },
  {
    "code" : "formaldehyde",
    "display" : "甲醛"
  }]
}

```
