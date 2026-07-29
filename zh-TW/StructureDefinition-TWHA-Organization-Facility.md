# 實施健康檢查之醫療機構 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 實施健康檢查之醫療機構 Profile 

 
本 Profile 用於描述實施勞工體格檢查、健康檢查或提供臨場健康服務之醫療機構，繼承自 TW Core Organization (醫院) 以精確反映醫療機構語義。 

**Usages:**

* Refer to this Profile: [雇主端健康管理摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmployerSummary.md), [健康檢查健康服務執行紀錄組成結構 Profile](StructureDefinition-TWHA-Composition-ServiceRecord.md), [健康檢查健檢診斷報告 Profile](StructureDefinition-TWHA-DiagnosticReport.md), [臨場健康服務事件 Profile](StructureDefinition-TWHA-Encounter-Service.md)... Show 2 more, [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md) and [健康檢查健檢追蹤檢查要求 Profile](StructureDefinition-TWHA-ServiceRequest.md)
* Examples for this Profile: [交通部民用航空局航空醫務中心](Organization-example-hospital.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Organization-Facility.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 1 element

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 1 element

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Organization-Facility",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility",
  "version" : "0.2.0",
  "name" : "TWHAOrganizationFacilityProfile",
  "title" : "實施健康檢查之醫療機構 Profile",
  "status" : "active",
  "date" : "2026-07-29T16:54:28+00:00",
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
  "description" : "本 Profile 用於描述實施勞工體格檢查、健康檢查或提供臨場健康服務之醫療機構，繼承自 TW Core Organization (醫院) 以精確反映醫療機構語義。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
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
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Organization",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-hosp-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Organization",
      "path" : "Organization"
    },
    {
      "id" : "Organization.identifier",
      "path" : "Organization.identifier",
      "min" : 1
    }]
  }
}

```
