# 勞動部通報報告代碼擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## 擴充: 勞動部通報報告代碼擴充 (實驗性) 

【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。

**Context of Use**

**Usage info**

**Usages:**

* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [Encounter/example-encounter-special](Encounter-example-encounter-special.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-labor-report-code.json)

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

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。

 **差異檢視Differential View** 

#### Terminology Bindings (Differential)

 **快照檢視** 

#### Terminology Bindings

#### Constraints

** Summary **

Simple Extension with the type CodeableConcept: 【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-labor-report-code.csv), [Excel](../StructureDefinition-ext-labor-report-code.xlsx), [Schematron](../StructureDefinition-ext-labor-report-code.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-labor-report-code",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code",
  "version" : "0.6.0",
  "name" : "ExtLaborReportCode",
  "title" : "勞動部通報報告代碼擴充",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-20T17:39:23+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。",
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
    "expression" : "Observation"
  },
  {
    "type" : "element",
    "expression" : "Encounter"
  },
  {
    "type" : "element",
    "expression" : "Bundle"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "勞動部通報報告代碼擴充",
      "definition" : "【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-LaborReportCode"
      }
    }]
  }
}

```
