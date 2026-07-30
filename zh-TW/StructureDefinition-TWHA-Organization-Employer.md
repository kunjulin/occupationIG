# 健康檢查所屬事業單位（雇主公司） Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 健康檢查所屬事業單位（雇主公司） Profile 

 
本 Profile 用於描述受檢勞工所屬之事業單位或公司，繼承自 TW Core Organization (公司) 以精確反映公司法人組織語義。其中統一編號以 identifier 表示。 

**Usages:**

* Examples for this Profile: [大同電子股份有限公司](Organization-example-employer.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Organization-Employer.json)

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
  "id" : "TWHA-Organization-Employer",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Employer",
  "version" : "0.2.0",
  "name" : "TWHAOrganizationEmployerProfile",
  "title" : "健康檢查所屬事業單位（雇主公司） Profile",
  "status" : "active",
  "date" : "2026-07-30T14:46:31+00:00",
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
  "description" : "本 Profile 用於描述受檢勞工所屬之事業單位或公司，繼承自 TW Core Organization (公司) 以精確反映公司法人組織語義。其中統一編號以 identifier 表示。",
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
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-co-twcore",
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
