# 健康檢查健檢報告組成結構 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.1

## 資源 Profile: 健康檢查健檢報告組成結構 Profile 

 
【技術規格】本 Profile 用於定義一般健康檢查、勞工健康檢查及成人預防保健等健康檢查報告的文件組成結構，以 Composition 作為文件核心，並定義各項目的 Section，繼承自 TW Core Composition。 

**Usages:**

* Examples for this Profile: [Composition/composition-uc001](Composition-composition-uc001.md), [Composition/composition-uc002](Composition-composition-uc002.md), [Composition/composition-uc003](Composition-composition-uc003.md), [Composition/composition-uc004](Composition-composition-uc004.md) and [Composition/composition-uc005](Composition-composition-uc005.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition.json)

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

Mandatory: 5 elements(6 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)
* [健康檢查健康管理分級 Observation Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel)](StructureDefinition-TWHA-HealthManagementLevel.md)

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

Mandatory: 5 elements(6 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)
* [健康檢查健康管理分級 Observation Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel)](StructureDefinition-TWHA-HealthManagementLevel.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Composition.csv), [Excel](../StructureDefinition-TWHA-Composition.xlsx), [Schematron](../StructureDefinition-TWHA-Composition.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition",
  "version" : "0.10.1",
  "name" : "TWHACompositionProfile",
  "title" : "健康檢查健檢報告組成結構 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-22T08:31:54+00:00",
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
  "description" : "【技術規格】本 Profile 用於定義一般健康檢查、勞工健康檢查及成人預防保健等健康檢查報告的文件組成結構，以 Composition 作為文件核心，並定義各項目的 Section，繼承自 TW Core Composition。",
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
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Composition-twcore",
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
          "code" : "11502-2",
          "display" : "Laboratory report"
        }]
      }
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
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
      "id" : "Composition.section:demographics",
      "path" : "Composition.section",
      "sliceName" : "demographics",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:demographics.title",
      "path" : "Composition.section.title",
      "patternString" : "基本資料與行政資訊"
    },
    {
      "id" : "Composition.section:demographics.code",
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
      "id" : "Composition.section:demographics.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
      }]
    },
    {
      "id" : "Composition.section:workHistory",
      "path" : "Composition.section",
      "sliceName" : "workHistory",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:workHistory.title",
      "path" : "Composition.section.title",
      "patternString" : "作業經歷"
    },
    {
      "id" : "Composition.section:workHistory.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11341-5"
        }]
      }
    },
    {
      "id" : "Composition.section:workHistory.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:pastHistory",
      "path" : "Composition.section",
      "sliceName" : "pastHistory",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:pastHistory.title",
      "path" : "Composition.section.title",
      "patternString" : "既往病史"
    },
    {
      "id" : "Composition.section:pastHistory.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11348-0"
        }]
      }
    },
    {
      "id" : "Composition.section:pastHistory.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Condition"]
      }]
    },
    {
      "id" : "Composition.section:habits",
      "path" : "Composition.section",
      "sliceName" : "habits",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:habits.title",
      "path" : "Composition.section.title",
      "patternString" : "生活習慣"
    },
    {
      "id" : "Composition.section:habits.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11338-1"
        }]
      }
    },
    {
      "id" : "Composition.section:habits.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:symptoms",
      "path" : "Composition.section",
      "sliceName" : "symptoms",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:symptoms.title",
      "path" : "Composition.section.title",
      "patternString" : "自覺症狀"
    },
    {
      "id" : "Composition.section:symptoms.code",
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
      "id" : "Composition.section:symptoms.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/QuestionnaireResponse"]
      }]
    },
    {
      "id" : "Composition.section:physicalExams",
      "path" : "Composition.section",
      "sliceName" : "physicalExams",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:physicalExams.title",
      "path" : "Composition.section.title",
      "patternString" : "理學檢查"
    },
    {
      "id" : "Composition.section:physicalExams.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "29545-1"
        }]
      }
    },
    {
      "id" : "Composition.section:physicalExams.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:labExams",
      "path" : "Composition.section",
      "sliceName" : "labExams",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:labExams.title",
      "path" : "Composition.section.title",
      "patternString" : "檢驗與影像檢查"
    },
    {
      "id" : "Composition.section:labExams.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "30954-2"
        }]
      }
    },
    {
      "id" : "Composition.section:labExams.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/DiagnosticReport",
        "http://hl7.org/fhir/StructureDefinition/ImagingStudy"]
      }]
    },
    {
      "id" : "Composition.section:assessment",
      "path" : "Composition.section",
      "sliceName" : "assessment",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:assessment.title",
      "path" : "Composition.section.title",
      "patternString" : "醫師總評、分級與建議"
    },
    {
      "id" : "Composition.section:assessment.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "51848-0"
        }]
      }
    },
    {
      "id" : "Composition.section:assessment.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/ClinicalImpression",
        "http://hl7.org/fhir/StructureDefinition/CarePlan",
        "http://hl7.org/fhir/StructureDefinition/ServiceRequest",
        "http://hl7.org/fhir/StructureDefinition/Procedure",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel"]
      }]
    }]
  }
}

```
