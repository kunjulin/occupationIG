# 健康管理分級擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## 擴充: 健康管理分級擴充 (實驗性) 

【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查健檢醫師總評與分級 Profile](StructureDefinition-TWHA-ClinicalImpression.md)
* Examples for this Extension: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 3 more, [Bundle/UC-005](Bundle-UC-005.md), [Bundle/UC-007](Bundle-UC-007.md) and [ClinicalImpression/example-clinical-impression](ClinicalImpression-example-clinical-impression.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-health-mgmt-level.json)

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

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。

 **差異檢視Differential View** 

#### Terminology Bindings (Differential)

 **快照檢視** 

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-health-mgmt-level.csv), [Excel](../StructureDefinition-ext-health-mgmt-level.xlsx), [Schematron](../StructureDefinition-ext-health-mgmt-level.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-health-mgmt-level",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-health-mgmt-level",
  "version" : "0.9.0",
  "name" : "ExtHealthMgmtLevel",
  "title" : "健康管理分級擴充",
  "status" : "draft",
  "experimental" : true,
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
  "description" : "【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。",
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
    "expression" : "ClinicalImpression"
  },
  {
    "type" : "element",
    "expression" : "Observation"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "健康管理分級擴充",
      "definition" : "【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-health-mgmt-level"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HealthMgmtLevel"
      }
    }]
  }
}

```
