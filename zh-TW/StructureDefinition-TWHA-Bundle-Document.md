# 健康檢查報告交換封包 (Document Bundle) Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## 資源 Profile: 健康檢查報告交換封包 (Document Bundle) Profile 

 
【技術規格】用於健檢報告交換的 Document Bundle，其第一個 entry 必須為 Composition（以 twha-bnd-1 不變條件驗證），且型態 (type) 必須為 document。 

**Usages:**

* Examples for this Profile: [Bundle/UC-001](Bundle-UC-001.md), [Bundle/UC-002](Bundle-UC-002.md), [Bundle/UC-003](Bundle-UC-003.md), [Bundle/UC-004](Bundle-UC-004.md)... Show 3 more, [Bundle/UC-005](Bundle-UC-005.md), [Bundle/UC-006](Bundle-UC-006.md) and [Bundle/UC-007](Bundle-UC-007.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Bundle-Document.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Constraints

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 2 elements

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Bundle-Document.csv), [Excel](../StructureDefinition-TWHA-Bundle-Document.xlsx), [Schematron](../StructureDefinition-TWHA-Bundle-Document.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Bundle-Document",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document",
  "version" : "0.6.0",
  "name" : "TWHABundleDocumentProfile",
  "title" : "健康檢查報告交換封包 (Document Bundle) Profile",
  "status" : "active",
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
  "description" : "【技術規格】用於健檢報告交換的 Document Bundle，其第一個 entry 必須為 Composition（以 twha-bnd-1 不變條件驗證），且型態 (type) 必須為 document。",
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
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Bundle",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Bundle",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Bundle",
      "path" : "Bundle",
      "constraint" : [{
        "key" : "twha-bnd-1",
        "severity" : "error",
        "human" : "Document Bundle 之第一個 entry 必須為 Composition",
        "expression" : "entry.first().resource.is(Composition)",
        "source" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"
      }]
    },
    {
      "id" : "Bundle.type",
      "path" : "Bundle.type",
      "patternCode" : "document"
    },
    {
      "id" : "Bundle.entry",
      "path" : "Bundle.entry",
      "min" : 1
    },
    {
      "id" : "Bundle.entry.resource",
      "path" : "Bundle.entry.resource",
      "min" : 1
    }]
  }
}

```
