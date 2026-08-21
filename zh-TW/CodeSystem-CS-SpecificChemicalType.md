# 特定化學物質種類代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## CodeSystem: 特定化學物質種類代碼系統 

 
【依據：勞工健康保護規則附表】特別危害健康作業中之特定化學物質種類。 

下列值集之定義引用本代碼系統：

* [VS_SpecificChemicalType](ValueSet-VS-SpecificChemicalType.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-SpecificChemicalType",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SpecificChemicalType",
  "version" : "0.9.3",
  "name" : "CS_SpecificChemicalType",
  "title" : "特定化學物質種類代碼系統",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-21T16:05:47+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】特別危害健康作業中之特定化學物質種類。",
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
