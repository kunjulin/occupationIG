# 健康檢查資料上傳封包 (Transaction Bundle) Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## 資源 Profile: 健康檢查資料上傳封包 (Transaction Bundle) Profile 

 
【技術規格】用於健檢系統或醫療院所向主管機關平台進行批次上傳/新增資料之 Transaction Bundle，其型態 (type) 必須為 transaction，且 entry 必須包含 HTTP 請求方法資訊。去重與冪等重傳之契約見 conformance.html「上傳介接契約」；整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，若定案採 batch，本 profile 之 type 固定值需隨之調整。範例：UC-008（首次上傳）、UC-009（含缺值與冪等重傳）。 

**Usages:**

* Examples for this Profile: [Bundle/UC-008](Bundle-UC-008.md) and [Bundle/UC-009](Bundle-UC-009.md)
* CapabilityStatements using this Profile: [健康檢查資料交換平台服務宣告](CapabilityStatement-TWHA-CapabilityStatement.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Bundle-Transaction.json)

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

Mandatory: 3 elements

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Terminology Bindings (Differential)

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 3 elements

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Bundle-Transaction.csv), [Excel](../StructureDefinition-TWHA-Bundle-Transaction.xlsx), [Schematron](../StructureDefinition-TWHA-Bundle-Transaction.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Bundle-Transaction",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction",
  "version" : "0.8.5",
  "name" : "TWHABundleTransactionProfile",
  "title" : "健康檢查資料上傳封包 (Transaction Bundle) Profile",
  "status" : "active",
  "date" : "2026-08-21T12:32:47+00:00",
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
  "description" : "【技術規格】用於健檢系統或醫療院所向主管機關平台進行批次上傳/新增資料之 Transaction Bundle，其型態 (type) 必須為 transaction，且 entry 必須包含 HTTP 請求方法資訊。去重與冪等重傳之契約見 conformance.html「上傳介接契約」；整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，若定案採 batch，本 profile 之 type 固定值需隨之調整。範例：UC-008（首次上傳）、UC-009（含缺值與冪等重傳）。",
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
      "path" : "Bundle"
    },
    {
      "id" : "Bundle.type",
      "path" : "Bundle.type",
      "patternCode" : "transaction"
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
    },
    {
      "id" : "Bundle.entry.request",
      "path" : "Bundle.entry.request",
      "min" : 1
    },
    {
      "id" : "Bundle.entry.request.method",
      "path" : "Bundle.entry.request.method",
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://hl7.org/fhir/ValueSet/http-verb"
      }
    }]
  }
}

```
