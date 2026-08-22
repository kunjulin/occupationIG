# 特別危害健康作業類別擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## 擴充: 特別危害健康作業類別擴充 

【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)
* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [Encounter/example-encounter-special](Encounter-example-encounter-special.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-hazard-type.json)

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

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

 **差異檢視Differential View** 

#### Terminology Bindings (Differential)

 **快照檢視** 

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-hazard-type.csv), [Excel](../StructureDefinition-ext-hazard-type.xlsx), [Schematron](../StructureDefinition-ext-hazard-type.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-hazard-type",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type",
  "version" : "0.10.0",
  "name" : "ExtHazardType",
  "title" : "特別危害健康作業類別擴充",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-22T04:25:10+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。",
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
      "short" : "特別危害健康作業類別擴充",
      "definition" : "【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HazardType"
      }
    }]
  }
}

```
