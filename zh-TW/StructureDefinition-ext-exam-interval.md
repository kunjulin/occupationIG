# 健康檢查實施週期擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## 擴充: 健康檢查實施週期擴充 

標註此次健康檢查之實施週期（如每年、每3年、每5年）。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)
* Examples for this Extension: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 2 more, [Bundle/UC-005](Bundle-UC-005.md) and [Encounter/example-encounter-general](Encounter-example-encounter-general.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-exam-interval.json)

### 擴充內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Constraints

** Summary **

Simple Extension with the type Quantity: 標註此次健康檢查之實施週期（如每年、每3年、每5年）。

 **差異檢視Differential View** 

 **快照檢視** 

#### Constraints

** Summary **

Simple Extension with the type Quantity: 標註此次健康檢查之實施週期（如每年、每3年、每5年）。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-exam-interval.csv), [Excel](../StructureDefinition-ext-exam-interval.xlsx), [Schematron](../StructureDefinition-ext-exam-interval.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-exam-interval",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval",
  "version" : "0.4.0",
  "name" : "ExtExamInterval",
  "title" : "健康檢查實施週期擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-20T13:40:11+00:00",
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
  "description" : "標註此次健康檢查之實施週期（如每年、每3年、每5年）。",
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
      "short" : "健康檢查實施週期擴充",
      "definition" : "標註此次健康檢查之實施週期（如每年、每3年、每5年）。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    }]
  }
}

```
