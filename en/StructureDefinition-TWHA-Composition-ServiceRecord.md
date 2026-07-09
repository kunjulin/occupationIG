# 健康檢查健康服務執行紀錄組成結構 Profile - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Resource Profile: 健康檢查健康服務執行紀錄組成結構 Profile 

 
本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。 

**Usages:**

* Examples for this Profile: [Composition/example-composition-service](Composition-example-composition-service.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition-ServiceRecord.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Composition-ServiceRecord.csv), [Excel](../StructureDefinition-TWHA-Composition-ServiceRecord.xlsx), [Schematron](../StructureDefinition-TWHA-Composition-ServiceRecord.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition-ServiceRecord",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-ServiceRecord",
  "version" : "0.1.0",
  "name" : "TWHACompositionServiceRecordProfile",
  "title" : "健康檢查健康服務執行紀錄組成結構 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-09T21:42:02+08:00",
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
  "description" : "本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。",
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
          "display" : "Summarization of clinical note"
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
