# 健康檢查適性配工計畫 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## : 健康檢查適性配工計畫 Profile 

 
用於針對第四級健康管理勞工，由醫師、事業單位等共同制定之適性配工計畫（變更場所、工作或縮短工時等），繼承自 TW Core CarePlan。 

**Usages:**

* Refer to this Profile: [雇主端健康管理摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmployerSummary.md)
* Examples for this Profile: [CarePlan/example-careplan-fitness](CarePlan-example-careplan-fitness.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-CarePlan.json)

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

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work](StructureDefinition-ext-fitness-for-work.md)

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work](StructureDefinition-ext-fitness-for-work.md)

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-CarePlan",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan",
  "version" : "0.1.0",
  "name" : "TWHACarePlanProfile",
  "title" : "健康檢查適性配工計畫 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-29T14:03:51+00:00",
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
  "description" : "用於針對第四級健康管理勞工，由醫師、事業單位等共同制定之適性配工計畫（變更場所、工作或縮短工時等），繼承自 TW Core CarePlan。",
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
  "type" : "CarePlan",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/CarePlan-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "CarePlan",
      "path" : "CarePlan"
    },
    {
      "id" : "CarePlan.extension",
      "path" : "CarePlan.extension",
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
      "id" : "CarePlan.extension:fitnessForWork",
      "path" : "CarePlan.extension",
      "sliceName" : "fitnessForWork",
      "min" : 1,
      "max" : "*",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work"]
      }]
    },
    {
      "id" : "CarePlan.status",
      "path" : "CarePlan.status",
      "patternCode" : "active"
    },
    {
      "id" : "CarePlan.intent",
      "path" : "CarePlan.intent",
      "patternCode" : "plan"
    },
    {
      "id" : "CarePlan.subject",
      "path" : "CarePlan.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    }]
  }
}

```
