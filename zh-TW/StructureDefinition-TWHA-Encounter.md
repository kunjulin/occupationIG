# 健康檢查健檢就醫事件 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 健康檢查健檢就醫事件 Profile 

 
本 Profile 用於描述勞工進行一般體格檢查、一般健康檢查或特殊體格/健康檢查的就醫事件，繼承自 TW Core Encounter。 

**Usages:**

* Refer to this Profile: [健康檢查健檢報告組成結構 Profile](StructureDefinition-TWHA-Composition.md), [健康檢查健檢診斷報告 Profile](StructureDefinition-TWHA-DiagnosticReport.md) and [健康諮詢與衛教指導 Profile](StructureDefinition-TWHA-Procedure-Counseling.md)
* Examples for this Profile: [Encounter/example-encounter-general](Encounter-example-encounter-general.md) and [Encounter/example-encounter-special](Encounter-example-encounter-special.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Encounter.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type](StructureDefinition-ext-exam-type.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type](StructureDefinition-ext-hazard-type.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval](StructureDefinition-ext-exam-interval.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department](StructureDefinition-ext-department.md)

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type](StructureDefinition-ext-exam-type.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type](StructureDefinition-ext-hazard-type.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval](StructureDefinition-ext-exam-interval.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department](StructureDefinition-ext-department.md)

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Encounter",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter",
  "version" : "0.2.0",
  "name" : "TWHAEncounterProfile",
  "title" : "健康檢查健檢就醫事件 Profile",
  "status" : "active",
  "date" : "2026-07-29T16:54:28+00:00",
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
  "description" : "本 Profile 用於描述勞工進行一般體格檢查、一般健康檢查或特殊體格/健康檢查的就醫事件，繼承自 TW Core Encounter。",
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
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Encounter",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Encounter-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Encounter",
      "path" : "Encounter"
    },
    {
      "id" : "Encounter.extension",
      "path" : "Encounter.extension",
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
      "id" : "Encounter.extension:examType",
      "path" : "Encounter.extension",
      "sliceName" : "examType",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type"]
      }]
    },
    {
      "id" : "Encounter.extension:hazardType",
      "path" : "Encounter.extension",
      "sliceName" : "hazardType",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type"]
      }]
    },
    {
      "id" : "Encounter.extension:examInterval",
      "path" : "Encounter.extension",
      "sliceName" : "examInterval",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval"]
      }]
    },
    {
      "id" : "Encounter.extension:department",
      "path" : "Encounter.extension",
      "sliceName" : "department",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department"]
      }]
    },
    {
      "id" : "Encounter.class",
      "path" : "Encounter.class",
      "patternCoding" : {
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
        "code" : "AMB"
      }
    },
    {
      "id" : "Encounter.subject",
      "path" : "Encounter.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Encounter.participant.individual",
      "path" : "Encounter.participant.individual",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Encounter.serviceProvider",
      "path" : "Encounter.serviceProvider",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    }]
  }
}

```
