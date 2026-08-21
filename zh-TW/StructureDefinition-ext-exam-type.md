# 檢查類型擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## 擴充: 檢查類型擴充 

【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)
* Examples for this Extension: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 3 more, [Bundle/UC-005](Bundle-UC-005.md), [Encounter/example-encounter-general](Encounter-example-encounter-general.md) and [Encounter/example-encounter-special](Encounter-example-encounter-special.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-exam-type.json)

### 擴充內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings (Differential)

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。

 **差異檢視Differential View** 

#### Terminology Bindings (Differential)

 **快照檢視** 

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-exam-type.csv), [Excel](../StructureDefinition-ext-exam-type.xlsx), [Schematron](../StructureDefinition-ext-exam-type.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-exam-type",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type",
  "version" : "0.9.0",
  "name" : "ExtExamType",
  "title" : "檢查類型擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。",
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
    "expression" : "Encounter"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "檢查類型擴充",
      "definition" : "【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ExamType"
      }
    }]
  }
}

```
