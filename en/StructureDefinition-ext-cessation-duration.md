# 戒除時間（戒菸/戒檳榔月數）擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Extension: 戒除時間（戒菸/戒檳榔月數）擴充 

記錄受檢者已戒菸或已戒檳榔的月數。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-cessation-duration.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-ext-cessation-duration.csv), [Excel](../StructureDefinition-ext-cessation-duration.xlsx), [Schematron](../StructureDefinition-ext-cessation-duration.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-cessation-duration",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration",
  "version" : "0.1.0",
  "name" : "ExtCessationDuration",
  "title" : "戒除時間（戒菸/戒檳榔月數）擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T18:45:10+08:00",
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
  "description" : "記錄受檢者已戒菸或已戒檳榔的月數。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "Observation"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "戒除時間（戒菸/戒檳榔月數）擴充",
      "definition" : "記錄受檢者已戒菸或已戒檳榔的月數。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "integer"
      }]
    }]
  }
}

```
