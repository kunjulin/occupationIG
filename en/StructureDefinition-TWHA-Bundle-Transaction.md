# 健康檢查資料上傳封包 (Transaction Bundle) Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康檢查資料上傳封包 (Transaction Bundle) Profile 

 
用於健檢系統或醫療院所向主管機關平台進行批次上傳/新增資料之 Transaction Bundle，其型態 (type) 必須為 transaction，且 entry 必須包含 HTTP 請求方法資訊。 

**Usages:**

* CapabilityStatements using this Profile: [CapabilityStatement[https://twcore.mohw.gov.tw/ig/twha/CapabilityStatement/TWHA-CapabilityStatement|0.1.0]](CapabilityStatement-TWHA-CapabilityStatement.md)
* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Bundle-Transaction.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Bundle-Transaction.csv), [Excel](../StructureDefinition-TWHA-Bundle-Transaction.xlsx), [Schematron](../StructureDefinition-TWHA-Bundle-Transaction.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Bundle-Transaction",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction",
  "version" : "0.1.0",
  "name" : "TWHABundleTransactionProfile",
  "title" : "健康檢查資料上傳封包 (Transaction Bundle) Profile",
  "status" : "active",
  "date" : "2026-07-23T22:22:27+08:00",
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
  "description" : "用於健檢系統或醫療院所向主管機關平台進行批次上傳/新增資料之 Transaction Bundle，其型態 (type) 必須為 transaction，且 entry 必須包含 HTTP 請求方法資訊。",
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
