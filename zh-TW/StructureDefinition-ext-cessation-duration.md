# 戒除時間（戒菸/戒檳榔月數）擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## 擴充: 戒除時間（戒菸/戒檳榔月數）擴充 

記錄受檢者已戒菸或已戒檳榔的月數。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)
* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [Observation/obs-smoking-former](Observation-obs-smoking-former.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-cessation-duration.json)

### 擴充內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Constraints

** Summary **

Simple Extension with the type integer: 記錄受檢者已戒菸或已戒檳榔的月數。

 **差異檢視Differential View** 

 **快照檢視** 

#### Constraints

** Summary **

Simple Extension with the type integer: 記錄受檢者已戒菸或已戒檳榔的月數。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-cessation-duration.csv), [Excel](../StructureDefinition-ext-cessation-duration.xlsx), [Schematron](../StructureDefinition-ext-cessation-duration.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-cessation-duration",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration",
  "version" : "0.4.0",
  "name" : "ExtCessationDuration",
  "title" : "戒除時間（戒菸/戒檳榔月數）擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-20T13:40:11+00:00",
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
