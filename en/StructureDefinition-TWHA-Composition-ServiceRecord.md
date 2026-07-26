# 健康檢查健康服務執行紀錄組成結構 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康檢查健康服務執行紀錄組成結構 Profile 

 
本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。 
**subject／custodian 語意界定（回應委員意見）**：本文件之標的為「**一次臨場服務事件與其紀錄**」，故 `subject` 為受服務之事業單位（作業場所），`custodian` 為保管該紀錄之醫療機構。**惟本 IG 並非一律以 Organization 作 subject**：文件內各關聯資源依其性質分別設定——個人健康指導以 Patient 為 subject、群體衛教以 Group 為 subject、事業單位則以 `serviceProvider`／`custodian`／`focus`／`extension[employerInfo]` 表達，詳見各該 Profile。 

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
  "date" : "2026-07-26T14:28:30+08:00",
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
  "description" : "本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。\r\n\r\n**subject／custodian 語意界定（回應委員意見）**：本文件之標的為「**一次臨場服務事件與其紀錄**」，故 `subject` 為受服務之事業單位（作業場所），`custodian` 為保管該紀錄之醫療機構。**惟本 IG 並非一律以 Organization 作 subject**：文件內各關聯資源依其性質分別設定——個人健康指導以 Patient 為 subject、群體衛教以 Group 為 subject、事業單位則以 `serviceProvider`／`custodian`／`focus`／`extension[employerInfo]` 表達，詳見各該 Profile。",
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
