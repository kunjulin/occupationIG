# 特別危害健康作業類別擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 特別危害健康作業類別擴充 

標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)
* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [Encounter/example-encounter-special](Encounter-example-encounter-special.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-hazard-type.json)

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

Simple Extension with the type CodeableConcept: 標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

 **Differential View** 

#### Terminology Bindings (Differential)

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。

 

 , ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-hazard-type",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type",
  "version" : "0.2.0",
  "name" : "ExtHazardType",
  "title" : "特別危害健康作業類別擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-05T16:28:11+00:00",
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
  "description" : "標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。",
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
      "definition" : "標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。"
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
