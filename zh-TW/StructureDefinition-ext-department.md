# 部門/課別擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 部門/課別擴充 

記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [臨場健康服務事件 Profile](StructureDefinition-TWHA-Encounter-Service.md), [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md) and [受檢者 Profile](StructureDefinition-TWHA-Patient.md)
* Examples for this Extension: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 7 more, [Bundle/UC-005](Bundle-UC-005.md), [Bundle/UC-006](Bundle-UC-006.md), [Bundle/UC-007](Bundle-UC-007.md), [Encounter/example-encounter-general](Encounter-example-encounter-general.md), [Encounter/example-encounter-service](Encounter-example-encounter-service.md), [Encounter/example-encounter-special](Encounter-example-encounter-special.md) and [Patient/example-worker](Patient-example-worker.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-department.json)

### 

 . 

*   
*   
*   
*   

#### Constraints

** Summary **

Simple Extension with the type string: 記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。

 **Differential View** 

#### Constraints

** Summary **

Simple Extension with the type string: 記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。

 

 , ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-department",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department",
  "version" : "0.2.0",
  "name" : "ExtDepartment",
  "title" : "部門/課別擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-30T07:25:13+00:00",
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
  "description" : "記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。",
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
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "部門/課別擴充",
      "definition" : "記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    }]
  }
}

```
