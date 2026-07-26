# 臨場健康服務事件 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 臨場健康服務事件 Profile 

 
本 Profile 用於描述醫護團隊到事業單位提供臨場健康服務之就醫/諮詢事件（對應附表八）。 
**語意界定（回應委員意見）**：本資源表達「**一次臨場服務事件**」。`serviceProvider` 為提供服務之醫療機構；受服務之事業單位以 `extension[employerInfo]` 表達，**不置於 subject**。 

**Usages:**

* Refer to this Profile: [健康檢查健康服務執行紀錄組成結構 Profile](StructureDefinition-TWHA-Composition-ServiceRecord.md)
* Examples for this Profile: [Encounter/example-encounter-service](Encounter-example-encounter-service.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Encounter-Service.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Encounter-Service.csv), [Excel](../StructureDefinition-TWHA-Encounter-Service.xlsx), [Schematron](../StructureDefinition-TWHA-Encounter-Service.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Encounter-Service",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service",
  "version" : "0.1.0",
  "name" : "TWHAEncounterServiceProfile",
  "title" : "臨場健康服務事件 Profile",
  "status" : "active",
  "date" : "2026-07-26T16:11:18+08:00",
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
  "description" : "本 Profile 用於描述醫護團隊到事業單位提供臨場健康服務之就醫/諮詢事件（對應附表八）。\r\n\r\n**語意界定（回應委員意見）**：本資源表達「**一次臨場服務事件**」。`serviceProvider` 為提供服務之醫療機構；受服務之事業單位以 `extension[employerInfo]` 表達，**不置於 subject**。",
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
  "type" : "Encounter",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Encounter-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Encounter",
      "path" : "Encounter"
    },
    {
      "id" : "Encounter.extension",
      "path" : "Encounter.extension",
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
      "id" : "Encounter.extension:employerInfo",
      "path" : "Encounter.extension",
      "sliceName" : "employerInfo",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info"]
      }]
    },
    {
      "id" : "Encounter.extension:department",
      "path" : "Encounter.extension",
      "sliceName" : "department",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department"]
      }]
    },
    {
      "id" : "Encounter.class",
      "path" : "Encounter.class",
      "patternCoding" : {
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
        "code" : "FLD"
      }
    },
    {
      "id" : "Encounter.participant.individual",
      "path" : "Encounter.participant.individual",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Encounter.serviceProvider",
      "path" : "Encounter.serviceProvider",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    }]
  }
}

```
