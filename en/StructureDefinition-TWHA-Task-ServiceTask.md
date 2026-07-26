# 臨場健康服務建議與改善任務 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 臨場健康服務建議與改善任務 Profile 

 
用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。 
**for／focus／owner 語意界定（回應委員意見）**：本資源表達「**後續改善工作**」。`focus` 指向所依據之現場發現（ServiceFinding）；`owner` 為負責執行改善之事業單位；若改善事項係針對特定勞工（如個別配工調整），以 `for` 表達該 Patient。**事業單位以 `owner` 表達，不置於 `for`。** 

**Usages:**

* Examples for this Profile: [Task/example-service-task](Task-example-service-task.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Task-ServiceTask.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Task-ServiceTask.csv), [Excel](../StructureDefinition-TWHA-Task-ServiceTask.xlsx), [Schematron](../StructureDefinition-TWHA-Task-ServiceTask.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Task-ServiceTask",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Task-ServiceTask",
  "version" : "0.1.0",
  "name" : "TWHATaskServiceTaskProfile",
  "title" : "臨場健康服務建議與改善任務 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T16:11:18+08:00",
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
  "description" : "用於記錄臨場服務中針對發現問題所提出之改善建議措施，以及追蹤前次改善事項之落實情形（對應附表八）。\r\n\r\n**for／focus／owner 語意界定（回應委員意見）**：本資源表達「**後續改善工作**」。`focus` 指向所依據之現場發現（ServiceFinding）；`owner` 為負責執行改善之事業單位；若改善事項係針對特定勞工（如個別配工調整），以 `for` 表達該 Patient。**事業單位以 `owner` 表達，不置於 `for`。**",
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
