# 嚼檳榔歷史與狀態 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 嚼檳榔歷史與狀態 Profile 

 
用於記錄勞工之嚼檳榔習慣與量化資料。本 Profile 基於 Observation 資源，採用與臺灣癌症登記短表實作指引 (TWCR_SF) 相同之元件架構及值集，以便進行跨系統之整合介接。 

**Usages:**

* Examples for this Profile: [Observation/obs-betelnut](Observation-obs-betelnut.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-SocialHistory-BetelNut.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-SocialHistory-BetelNut.csv), [Excel](../StructureDefinition-TWHA-SocialHistory-BetelNut.xlsx), [Schematron](../StructureDefinition-TWHA-SocialHistory-BetelNut.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-SocialHistory-BetelNut",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut",
  "version" : "0.1.0",
  "name" : "TWHASocialHistoryBetelNutProfile",
  "title" : "嚼檳榔歷史與狀態 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T12:18:37+08:00",
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
  "description" : "用於記錄勞工之嚼檳榔習慣與量化資料。本 Profile 基於 Observation 資源，採用與臺灣癌症登記短表實作指引 (TWCR_SF) 相同之元件架構及值集，以便進行跨系統之整合介接。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "sct-concept",
    "uri" : "http://snomed.info/conceptdomain",
    "name" : "SNOMED CT Concept Domain Binding"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "sct-attr",
    "uri" : "http://snomed.org/attributebinding",
    "name" : "SNOMED CT Attribute Binding"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Observation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Observation",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Observation",
      "path" : "Observation",
      "constraint" : [{
        "key" : "twha-obs-1",
        "severity" : "error",
        "human" : "Observation 必須包含測量值 (value) 或資料缺失原因 (dataAbsentReason) 或分項測量值 (component)",
        "expression" : "value.exists() or dataAbsentReason.exists() or component.exists()",
        "source" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut"
      }]
    },
    {
      "id" : "Observation.status",
      "path" : "Observation.status",
      "patternCode" : "final"
    },
    {
      "id" : "Observation.category",
      "path" : "Observation.category",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "social-history"
        }]
      }
    },
    {
      "id" : "Observation.code",
      "path" : "Observation.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem",
          "code" : "BetelNutChewing",
          "display" : "嚼檳榔行為"
        }]
      }
    },
    {
      "id" : "Observation.subject",
      "path" : "Observation.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Observation.performer",
      "path" : "Observation.performer",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Observation.component",
      "path" : "Observation.component",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "code"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 3
    },
    {
      "id" : "Observation.component:amount",
      "path" : "Observation.component",
      "sliceName" : "amount",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Observation.component:amount.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
          "code" : "amount",
          "display" : "每日嚼檳榔量，以 ”顆” 計算"
        }]
      }
    },
    {
      "id" : "Observation.component:amount.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewAmount-valueset"
      }
    },
    {
      "id" : "Observation.component:year",
      "path" : "Observation.component",
      "sliceName" : "year",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Observation.component:year.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
          "code" : "year",
          "display" : "嚼檳榔年"
        }]
      }
    },
    {
      "id" : "Observation.component:year.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewYear-valueset"
      }
    },
    {
      "id" : "Observation.component:quit",
      "path" : "Observation.component",
      "sliceName" : "quit",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Observation.component:quit.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
          "code" : "quit",
          "display" : "戒嚼檳榔年"
        }]
      }
    },
    {
      "id" : "Observation.component:quit.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewQuit-valueset"
      }
    }]
  }
}

```
