# 健康檢查健檢報告組成結構 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康檢查健檢報告組成結構 Profile 

 
本 Profile 用於定義一般健康檢查、勞工健康檢查及成人預防保健等健康檢查報告的文件組成結構，以 Composition 作為文件核心，並定義各項目的 Section，繼承自 TW Core Composition。 

**Usages:**

* Examples for this Profile: [Composition/composition-uc001](Composition-composition-uc001.md), [Composition/composition-uc002](Composition-composition-uc002.md), [Composition/composition-uc003](Composition-composition-uc003.md), [Composition/composition-uc004](Composition-composition-uc004.md) and [Composition/composition-uc005](Composition-composition-uc005.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Composition.csv), [Excel](../StructureDefinition-TWHA-Composition.xlsx), [Schematron](../StructureDefinition-TWHA-Composition.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition",
  "version" : "0.1.0",
  "name" : "TWHACompositionProfile",
  "title" : "健康檢查健檢報告組成結構 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T15:21:49+08:00",
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
  "description" : "本 Profile 用於定義一般健康檢查、勞工健康檢查及成人預防保健等健康檢查報告的文件組成結構，以 Composition 作為文件核心，並定義各項目的 Section，繼承自 TW Core Composition。",
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
        "http://hl7.org/fhir/StructureDefinition/Procedure"]
      }]
    }]
  }
}

```
