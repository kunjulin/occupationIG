# 臨場服務執行活動項目 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.2

## 資源 Profile: 臨場服務執行活動項目 Profile ( 實驗性 ) 

 
【依據：勞工健康保護規則附表】用於記錄醫護人員在臨場健康服務中實際辦理之活動項目（對應附表八之臨場健康服務執行情形），繼承自 TW Core Procedure。 
**subject 選用規則（回應委員意見）**：**個人健康指導／個案追蹤 → `subject` = Patient**；**群體衛教／全廠宣導 → `subject` = Group**。**事業單位不作為 `subject`**，改以 `extension[employerInfo]` 表達所屬事業單位。 

**Usages:**

* Examples for this Profile: [Procedure/example-procedure-activity](Procedure-example-procedure-activity.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Procedure-ServiceActivity.json)

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

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Terminology Bindings (Differential)

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Procedure-ServiceActivity.csv), [Excel](../StructureDefinition-TWHA-Procedure-ServiceActivity.xlsx), [Schematron](../StructureDefinition-TWHA-Procedure-ServiceActivity.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Procedure-ServiceActivity",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-ServiceActivity",
  "version" : "0.9.2",
  "name" : "TWHAProcedureServiceActivityProfile",
  "title" : "臨場服務執行活動項目 Profile",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-21T15:06:05+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】用於記錄醫護人員在臨場健康服務中實際辦理之活動項目（對應附表八之臨場健康服務執行情形），繼承自 TW Core Procedure。\n\n**subject 選用規則（回應委員意見）**：**個人健康指導／個案追蹤 → `subject` = Patient**；**群體衛教／全廠宣導 → `subject` = Group**。**事業單位不作為 `subject`**，改以 `extension[employerInfo]` 表達所屬事業單位。",
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
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Procedure",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Procedure",
      "path" : "Procedure"
    },
    {
      "id" : "Procedure.extension",
      "path" : "Procedure.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "Procedure.extension:employerInfo",
      "path" : "Procedure.extension",
      "sliceName" : "employerInfo",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info"]
      }]
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
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ServiceActivityType"
      }
    },
    {
      "id" : "Procedure.subject",
      "path" : "Procedure.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Group",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    }]
  }
}

```
