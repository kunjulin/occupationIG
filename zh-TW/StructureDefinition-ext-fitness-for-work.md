# 適性配工建議項目擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.2

## 擴充: 適性配工建議項目擴充 (實驗性) 

【依據：勞工健康保護規則附表】用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查適性配工計畫 Profile](StructureDefinition-TWHA-CarePlan.md)
* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [CarePlan/example-careplan-fitness](CarePlan-example-careplan-fitness.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-fitness-for-work.json)

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

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。

 **差異檢視Differential View** 

#### Terminology Bindings (Differential)

 **快照檢視** 

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-fitness-for-work.csv), [Excel](../StructureDefinition-ext-fitness-for-work.xlsx), [Schematron](../StructureDefinition-ext-fitness-for-work.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-fitness-for-work",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
  "version" : "0.6.2",
  "name" : "ExtFitnessForWork",
  "title" : "適性配工建議項目擴充",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-21T00:14:56+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。",
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
    "expression" : "CarePlan"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "適性配工建議項目擴充",
      "definition" : "【依據：勞工健康保護規則附表】用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-FitnessForWork"
      }
    }]
  }
}

```
