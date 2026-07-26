# 健康檢查健檢醫師總評與分級 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康檢查健檢醫師總評與分級 Profile 

 
用於記錄健檢判定醫師針對勞工檢查結果進行之總體臨床評估、健康管理分級（1-4級）及處置建議。 

**Usages:**

* Examples for this Profile: [ClinicalImpression/example-clinical-impression](ClinicalImpression-example-clinical-impression.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-ClinicalImpression.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-ClinicalImpression.csv), [Excel](../StructureDefinition-TWHA-ClinicalImpression.xlsx), [Schematron](../StructureDefinition-TWHA-ClinicalImpression.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-ClinicalImpression",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression",
  "version" : "0.1.0",
  "name" : "TWHAClinicalImpressionProfile",
  "title" : "健康檢查健檢醫師總評與分級 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T10:07:44+08:00",
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
  "description" : "用於記錄健檢判定醫師針對勞工檢查結果進行之總體臨床評估、健康管理分級（1-4級）及處置建議。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ClinicalImpression",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/ClinicalImpression",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "ClinicalImpression",
      "path" : "ClinicalImpression"
    },
    {
      "id" : "ClinicalImpression.extension",
      "path" : "ClinicalImpression.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "ClinicalImpression.extension:healthMgmtLevel",
      "path" : "ClinicalImpression.extension",
      "sliceName" : "healthMgmtLevel",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-health-mgmt-level"]
      }]
    },
    {
      "id" : "ClinicalImpression.status",
      "path" : "ClinicalImpression.status",
      "patternCode" : "completed"
    },
    {
      "id" : "ClinicalImpression.subject",
      "path" : "ClinicalImpression.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "ClinicalImpression.assessor",
      "path" : "ClinicalImpression.assessor",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "ClinicalImpression.summary",
      "path" : "ClinicalImpression.summary",
      "min" : 1
    }]
  }
}

```
