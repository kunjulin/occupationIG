# 臨場服務執行活動項目 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 臨場服務執行活動項目 Profile 

 
用於記錄醫護人員在臨場健康服務中實際辦理之活動項目（對應附表八之臨場健康服務執行情形），繼承自 TW Core Procedure。 
**subject 選用規則（回應委員意見）**：**個人健康指導／個案追蹤 → `subject` = Patient**；**群體衛教／全廠宣導 → `subject` = Group**。**事業單位不作為 `subject`**，改以 `extension[employerInfo]` 表達所屬事業單位。 

**Usages:**

* Examples for this Profile: [Procedure/example-procedure-activity](Procedure-example-procedure-activity.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Procedure-ServiceActivity.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Procedure-ServiceActivity.csv), [Excel](../StructureDefinition-TWHA-Procedure-ServiceActivity.xlsx), [Schematron](../StructureDefinition-TWHA-Procedure-ServiceActivity.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Procedure-ServiceActivity",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-ServiceActivity",
  "version" : "0.1.0",
  "name" : "TWHAProcedureServiceActivityProfile",
  "title" : "臨場服務執行活動項目 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T14:28:30+08:00",
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
  "description" : "用於記錄醫護人員在臨場健康服務中實際辦理之活動項目（對應附表八之臨場健康服務執行情形），繼承自 TW Core Procedure。\r\n\r\n**subject 選用規則（回應委員意見）**：**個人健康指導／個案追蹤 → `subject` = Patient**；**群體衛教／全廠宣導 → `subject` = Group**。**事業單位不作為 `subject`**，改以 `extension[employerInfo]` 表達所屬事業單位。",
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
