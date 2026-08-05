# 臨場健康服務建議與改善任務 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.1

## : 臨場健康服務建議與改善任務 Profile 

 
用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。 
**for／focus／owner 語意界定（回應委員意見）**：本資源表達「**後續改善工作**」。`focus` 指向所依據之現場發現（ServiceFinding）；`owner` 為負責執行改善之事業單位；若改善事項係針對特定勞工（如個別配工調整），以 `for` 表達該 Patient。**事業單位以 `owner` 表達，不置於 `for`。** 

**Usages:**

* Examples for this Profile: [Task/example-service-task](Task-example-service-task.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Task-ServiceTask.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings (Differential)

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [臨場健康服務發現問題/風險 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding)](StructureDefinition-TWHA-Observation-ServiceFinding.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [TW Core Organization (https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore)](https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Organization-twcore.html)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)

#### Terminology Bindings (Differential)

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [臨場健康服務發現問題/風險 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding)](StructureDefinition-TWHA-Observation-ServiceFinding.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [TW Core Organization (https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore)](https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Organization-twcore.html)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Task-ServiceTask",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Task-ServiceTask",
  "version" : "0.2.1",
  "name" : "TWHATaskServiceTaskProfile",
  "title" : "臨場健康服務建議與改善任務 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-05T16:48:01+00:00",
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
  "description" : "用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。\n\n**for／focus／owner 語意界定（回應委員意見）**：本資源表達「**後續改善工作**」。`focus` 指向所依據之現場發現（ServiceFinding）；`owner` 為負責執行改善之事業單位；若改善事項係針對特定勞工（如個別配工調整），以 `for` 表達該 Patient。**事業單位以 `owner` 表達，不置於 `for`。**",
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
  "type" : "Task",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Task",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Task",
      "path" : "Task"
    },
    {
      "id" : "Task.extension",
      "path" : "Task.extension",
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
      "id" : "Task.extension:employerInfo",
      "path" : "Task.extension",
      "sliceName" : "employerInfo",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info"]
      }]
    },
    {
      "id" : "Task.status",
      "path" : "Task.status",
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://hl7.org/fhir/ValueSet/task-status"
      }
    },
    {
      "id" : "Task.intent",
      "path" : "Task.intent",
      "patternCode" : "plan"
    },
    {
      "id" : "Task.focus",
      "path" : "Task.focus",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding"]
      }]
    },
    {
      "id" : "Task.requester",
      "path" : "Task.requester",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Task.owner",
      "path" : "Task.owner",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore"]
      }]
    }]
  }
}

```
