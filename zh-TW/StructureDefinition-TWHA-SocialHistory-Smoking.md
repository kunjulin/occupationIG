# 吸菸歷史與狀態 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.0

## 資源 Profile: 吸菸歷史與狀態 Profile 

 
【主管機關：國民健康署】用於記錄勞工之吸菸狀態與吸菸量、戒菸時間等資訊，繼承自 TW Core Observation Smoking Status。 

**Usages:**

* Examples for this Profile: [Observation/obs-smoking-former](Observation-obs-smoking-former.md) and [Observation/obs-smoking](Observation-obs-smoking.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-SocialHistory-Smoking.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings (Differential)

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 0 element(1 nested mandatory element)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity](StructureDefinition-ext-smoking-quantity.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration](StructureDefinition-ext-cessation-duration.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.value[x].coding

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Terminology Bindings (Differential)

#### Constraints

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 0 element(1 nested mandatory element)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity](StructureDefinition-ext-smoking-quantity.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration](StructureDefinition-ext-cessation-duration.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.value[x].coding

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-SocialHistory-Smoking.csv), [Excel](../StructureDefinition-TWHA-SocialHistory-Smoking.xlsx), [Schematron](../StructureDefinition-TWHA-SocialHistory-Smoking.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-SocialHistory-Smoking",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Smoking",
  "version" : "0.7.0",
  "name" : "TWHASocialHistorySmokingProfile",
  "title" : "吸菸歷史與狀態 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T00:59:40+00:00",
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
  "description" : "【主管機關：國民健康署】用於記錄勞工之吸菸狀態與吸菸量、戒菸時間等資訊，繼承自 TW Core Observation Smoking Status。",
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
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-smoking-status-twcore",
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
        "source" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Smoking"
      }]
    },
    {
      "id" : "Observation.extension",
      "path" : "Observation.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Observation.extension:smokingQuantity",
      "path" : "Observation.extension",
      "sliceName" : "smokingQuantity",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity"]
      }]
    },
    {
      "id" : "Observation.extension:cessationDuration",
      "path" : "Observation.extension",
      "sliceName" : "cessationDuration",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration"]
      }]
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
      "id" : "Observation.value[x]:valueCodeableConcept",
      "path" : "Observation.value[x]",
      "sliceName" : "valueCodeableConcept",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "Observation.value[x]:valueCodeableConcept.coding",
      "path" : "Observation.value[x].coding",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      }
    },
    {
      "id" : "Observation.value[x]:valueCodeableConcept.coding:localSmokingStatus",
      "path" : "Observation.value[x].coding",
      "sliceName" : "localSmokingStatus",
      "min" : 0,
      "max" : "1",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-SmokingStatus"
      }
    },
    {
      "id" : "Observation.value[x]:valueCodeableConcept.coding:localSmokingStatus.system",
      "path" : "Observation.value[x].coding.system",
      "min" : 1,
      "patternUri" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus"
    }]
  }
}

```
