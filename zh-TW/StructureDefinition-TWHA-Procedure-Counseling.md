# 健康諮詢與衛教指導 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.1

## 資源 Profile: 健康諮詢與衛教指導 Profile 

 
【技術規格】用於記錄成人預防保健服務及一般健康檢查中，醫師或醫護團隊提供之健康諮詢、衛教指導與預防教育活動（如戒菸、節酒、腎病識能指導等），繼承自 TW Core Procedure。 

**Usages:**

* Examples for this Profile: [Procedure/example-procedure-counseling](Procedure-example-procedure-counseling.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Procedure-Counseling.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings (Differential)

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Terminology Bindings (Differential)

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Procedure-Counseling.csv), [Excel](../StructureDefinition-TWHA-Procedure-Counseling.xlsx), [Schematron](../StructureDefinition-TWHA-Procedure-Counseling.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Procedure-Counseling",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-Counseling",
  "version" : "0.10.1",
  "name" : "TWHAProcedureCounselingProfile",
  "title" : "健康諮詢與衛教指導 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-22T08:31:54+00:00",
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
  "description" : "【技術規格】用於記錄成人預防保健服務及一般健康檢查中，醫師或醫護團隊提供之健康諮詢、衛教指導與預防教育活動（如戒菸、節酒、腎病識能指導等），繼承自 TW Core Procedure。",
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
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Procedure",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Procedure-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Procedure",
      "path" : "Procedure"
    },
    {
      "id" : "Procedure.status",
      "path" : "Procedure.status",
      "patternCode" : "completed"
    },
    {
      "id" : "Procedure.code",
      "path" : "Procedure.code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HealthCounseling"
      }
    },
    {
      "id" : "Procedure.subject",
      "path" : "Procedure.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Procedure.encounter",
      "path" : "Procedure.encounter",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
      }]
    }]
  }
}

```
