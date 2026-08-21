# 健康檢查健康服務執行紀錄組成結構 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## 資源 Profile: 健康檢查健康服務執行紀錄組成結構 Profile 

 
【依據：勞工健康保護規則附表】本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。 
**subject／custodian 語意界定（回應委員意見）**：本文件之標的為「**一次臨場服務事件與其紀錄**」，故 `subject` 為受服務之事業單位（作業場所），`custodian` 為保管該紀錄之醫療機構。**惟本 IG 並非一律以 Organization 作 subject**：文件內各關聯資源依其性質分別設定——個人健康指導以 Patient 為 subject、群體衛教以 Group 為 subject、事業單位則以 `serviceProvider`／`custodian`／`focus`／`extension[employerInfo]` 表達，詳見各該 Profile。 

**Usages:**

* Examples for this Profile: [Composition/example-composition-service](Composition-example-composition-service.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition-ServiceRecord.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 4 elements(2 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [TW Core Organization (https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore)](https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Organization-twcore.html)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)
* [臨場健康服務事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service)](StructureDefinition-TWHA-Encounter-Service.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 4 elements(2 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [TW Core Organization (https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore)](https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Organization-twcore.html)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)
* [臨場健康服務事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service)](StructureDefinition-TWHA-Encounter-Service.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Composition-ServiceRecord.csv), [Excel](../StructureDefinition-TWHA-Composition-ServiceRecord.xlsx), [Schematron](../StructureDefinition-TWHA-Composition-ServiceRecord.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition-ServiceRecord",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-ServiceRecord",
  "version" : "0.9.3",
  "name" : "TWHACompositionServiceRecordProfile",
  "title" : "健康檢查健康服務執行紀錄組成結構 Profile",
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
  "description" : "【依據：勞工健康保護規則附表】本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。\n\n**subject／custodian 語意界定（回應委員意見）**：本文件之標的為「**一次臨場服務事件與其紀錄**」，故 `subject` 為受服務之事業單位（作業場所），`custodian` 為保管該紀錄之醫療機構。**惟本 IG 並非一律以 Organization 作 subject**：文件內各關聯資源依其性質分別設定——個人健康指導以 Patient 為 subject、群體衛教以 Group 為 subject、事業單位則以 `serviceProvider`／`custodian`／`focus`／`extension[employerInfo]` 表達，詳見各該 Profile。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "fhirdocumentreference",
    "uri" : "http://hl7.org/fhir/documentreference",
    "name" : "FHIR DocumentReference"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Composition",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Composition",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Composition",
      "path" : "Composition"
    },
    {
      "id" : "Composition.status",
      "path" : "Composition.status",
      "patternCode" : "final"
    },
    {
      "id" : "Composition.type",
      "path" : "Composition.type",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "34133-9",
          "display" : "Summary of episode note"
        }]
      }
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore"]
      }]
    },
    {
      "id" : "Composition.author",
      "path" : "Composition.author",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Composition.title",
      "path" : "Composition.title",
      "patternString" : "勞工健康服務執行紀錄表"
    },
    {
      "id" : "Composition.custodian",
      "path" : "Composition.custodian",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    },
    {
      "id" : "Composition.section",
      "path" : "Composition.section",
      "slicing" : {
        "discriminator" : [{
          "type" : "pattern",
          "path" : "code"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 2
    },
    {
      "id" : "Composition.section:workplace",
      "path" : "Composition.section",
      "sliceName" : "workplace",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:workplace.title",
      "path" : "Composition.section.title",
      "patternString" : "作業場所概況"
    },
    {
      "id" : "Composition.section:workplace.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "51847-2"
        }]
      }
    },
    {
      "id" : "Composition.section:workplace.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service"]
      }]
    },
    {
      "id" : "Composition.section:activities",
      "path" : "Composition.section",
      "sliceName" : "activities",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:activities.title",
      "path" : "Composition.section.title",
      "patternString" : "臨場服務執行情形"
    },
    {
      "id" : "Composition.section:activities.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "97726-4"
        }]
      }
    },
    {
      "id" : "Composition.section:activities.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Procedure"]
      }]
    },
    {
      "id" : "Composition.section:findings",
      "path" : "Composition.section",
      "sliceName" : "findings",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:findings.title",
      "path" : "Composition.section.title",
      "patternString" : "現場發現問題"
    },
    {
      "id" : "Composition.section:findings.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "29554-3"
        }]
      }
    },
    {
      "id" : "Composition.section:findings.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:recommendations",
      "path" : "Composition.section",
      "sliceName" : "recommendations",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:recommendations.title",
      "path" : "Composition.section.title",
      "patternString" : "改善建議與追蹤"
    },
    {
      "id" : "Composition.section:recommendations.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "51898-5"
        }]
      }
    },
    {
      "id" : "Composition.section:recommendations.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Task"]
      }]
    }]
  }
}

```
