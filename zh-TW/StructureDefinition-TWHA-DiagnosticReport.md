# 健康檢查健檢診斷報告 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.2

## 資源 Profile: 健康檢查健檢診斷報告 Profile 

 
【技術規格】本 Profile 用於彙整勞工體格及健康檢查結果之診斷報告，繼承自 TW Core DiagnosticReport。 

**Usages:**

* Examples for this Profile: [DiagnosticReport/example-diagnostic-report](DiagnosticReport-example-diagnostic-report.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-DiagnosticReport.json)

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

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [健康檢查健檢就醫事件 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter)](StructureDefinition-TWHA-Encounter.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-DiagnosticReport.csv), [Excel](../StructureDefinition-TWHA-DiagnosticReport.xlsx), [Schematron](../StructureDefinition-TWHA-DiagnosticReport.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-DiagnosticReport",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-DiagnosticReport",
  "version" : "0.6.2",
  "name" : "TWHADiagnosticReportProfile",
  "title" : "健康檢查健檢診斷報告 Profile",
  "status" : "active",
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
  "description" : "【技術規格】本 Profile 用於彙整勞工體格及健康檢查結果之診斷報告，繼承自 TW Core DiagnosticReport。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
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
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "DiagnosticReport",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/DiagnosticReport-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "DiagnosticReport",
      "path" : "DiagnosticReport"
    },
    {
      "id" : "DiagnosticReport.subject",
      "path" : "DiagnosticReport.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "DiagnosticReport.encounter",
      "path" : "DiagnosticReport.encounter",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
      }]
    },
    {
      "id" : "DiagnosticReport.performer",
      "path" : "DiagnosticReport.performer",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    }]
  }
}

```
