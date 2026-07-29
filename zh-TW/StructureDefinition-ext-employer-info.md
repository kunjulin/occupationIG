# 雇主事業單位資訊擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 雇主事業單位資訊擴充 

關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [臨場健康服務事件 Profile](StructureDefinition-TWHA-Encounter-Service.md), [受檢者 Profile](StructureDefinition-TWHA-Patient.md), [臨場服務執行活動項目 Profile](StructureDefinition-TWHA-Procedure-ServiceActivity.md) and [臨場健康服務建議與改善任務 Profile](StructureDefinition-TWHA-Task-ServiceTask.md)
* Examples for this Extension: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 7 more, [Bundle/UC-005](Bundle-UC-005.md), [Bundle/UC-006](Bundle-UC-006.md), [Bundle/UC-007](Bundle-UC-007.md), [Encounter/example-encounter-service](Encounter-example-encounter-service.md), [Patient/example-worker](Patient-example-worker.md), [Procedure/example-procedure-activity](Procedure-example-procedure-activity.md) and [Task/example-service-task](Task-example-service-task.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-employer-info.json)

### 

 . 

*   
*   
*   
*   

#### Constraints

** Summary **

Simple Extension with the type Reference: 關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。

 **Differential View** 

#### Constraints

** Summary **

Simple Extension with the type Reference: 關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。

 

 , ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-employer-info",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
  "version" : "0.2.0",
  "name" : "ExtEmployerInfo",
  "title" : "雇主事業單位資訊擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-29T16:26:07+00:00",
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
  "description" : "關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "Patient"
  },
  {
    "type" : "element",
    "expression" : "Encounter"
  },
  {
    "type" : "element",
    "expression" : "Procedure"
  },
  {
    "type" : "element",
    "expression" : "Task"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "雇主事業單位資訊擴充",
      "definition" : "關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-twcore"]
      }]
    }]
  }
}

```
