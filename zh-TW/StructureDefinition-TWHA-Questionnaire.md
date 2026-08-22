# 健康檢查自覺症狀問卷定義 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## 資源 Profile: 健康檢查自覺症狀問卷定義 Profile 

 
【技術規格】用於定義勞工體格或健康檢查中，自覺症狀調查（附表十一之自覺症狀部分）的問卷結構 Profile。 

**Usages:**

* Examples for this Profile: [Questionnaire/adult-preventive-care-questionnaire](Questionnaire-adult-preventive-care-questionnaire.md), [Questionnaire/example-questionnaire](Questionnaire-example-questionnaire.md) and [Questionnaire/twha-sdoh-questionnaire](Questionnaire-twha-sdoh-questionnaire.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Questionnaire.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 1 element

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 1 element

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Questionnaire.csv), [Excel](../StructureDefinition-TWHA-Questionnaire.xlsx), [Schematron](../StructureDefinition-TWHA-Questionnaire.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Questionnaire",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Questionnaire",
  "version" : "0.10.0",
  "name" : "TWHAQuestionnaireProfile",
  "title" : "健康檢查自覺症狀問卷定義 Profile",
  "status" : "active",
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
  "description" : "【技術規格】用於定義勞工體格或健康檢查中，自覺症狀調查（附表十一之自覺症狀部分）的問卷結構 Profile。",
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
    "identity" : "objimpl",
    "uri" : "http://hl7.org/fhir/object-implementation",
    "name" : "Object Implementation Information"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Questionnaire",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Questionnaire",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Questionnaire",
      "path" : "Questionnaire"
    },
    {
      "id" : "Questionnaire.status",
      "path" : "Questionnaire.status",
      "patternCode" : "active"
    },
    {
      "id" : "Questionnaire.item",
      "path" : "Questionnaire.item",
      "min" : 1
    }]
  }
}

```
