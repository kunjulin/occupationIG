# 健康諮詢與衛教指導 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康諮詢與衛教指導 Profile 

 
用於記錄成人預防保健服務及一般健康檢查中，醫師或醫護團隊提供之健康諮詢、衛教指導與預防教育活動（如戒菸、節酒、腎病識能指導等），繼承自 TW Core Procedure。 

**Usages:**

* Examples for this Profile: [Procedure/example-procedure-counseling](Procedure-example-procedure-counseling.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Procedure-Counseling.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Procedure-Counseling.csv), [Excel](../StructureDefinition-TWHA-Procedure-Counseling.xlsx), [Schematron](../StructureDefinition-TWHA-Procedure-Counseling.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Procedure-Counseling",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-Counseling",
  "version" : "0.1.0",
  "name" : "TWHAProcedureCounselingProfile",
  "title" : "健康諮詢與衛教指導 Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T10:07:44+08:00",
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
  "description" : "用於記錄成人預防保健服務及一般健康檢查中，醫師或醫護團隊提供之健康諮詢、衛教指導與預防教育活動（如戒菸、節酒、腎病識能指導等），繼承自 TW Core Procedure。",
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
