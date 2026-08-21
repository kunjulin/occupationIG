# 有機溶劑種類代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## CodeSystem: 有機溶劑種類代碼系統 

 
【依據：勞工健康保護規則附表】特別危害健康作業中之有機溶劑種類（主要 7 種）。 

下列值集之定義引用本代碼系統：

* [VS_OrganicSolventType](ValueSet-VS-OrganicSolventType.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-OrganicSolventType",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-OrganicSolventType",
  "version" : "0.9.0",
  "name" : "CS_OrganicSolventType",
  "title" : "有機溶劑種類代碼系統",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】特別危害健康作業中之有機溶劑種類（主要 7 種）。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 7,
  "concept" : [{
    "code" : "tetrachloroethane",
    "display" : "四氯乙烷"
  },
  {
    "code" : "carbon-tetrachloride",
    "display" : "四氯化碳"
  },
  {
    "code" : "carbon-disulfide",
    "display" : "二硫化碳"
  },
  {
    "code" : "trichloroethylene",
    "display" : "三氯乙烯"
  },
  {
    "code" : "tetrachloroethylene",
    "display" : "四氯乙烯"
  },
  {
    "code" : "dimethylformamide",
    "display" : "二甲基甲醯胺"
  },
  {
    "code" : "n-hexane",
    "display" : "正己烷"
  }]
}

```
