# 職業健康急診友善摘要 Composition Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 職業健康急診友善摘要 Composition Profile 

 
職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用，形成可驗證、可交換的摘要文件。 

**Usages:**

* Examples for this Profile: [Composition/composition-emergency-summary](Composition-composition-emergency-summary.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition-EmergencySummary.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-Composition-EmergencySummary.csv), [Excel](../StructureDefinition-TWHA-Composition-EmergencySummary.xlsx), [Schematron](../StructureDefinition-TWHA-Composition-EmergencySummary.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition-EmergencySummary",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmergencySummary",
  "version" : "0.1.0",
  "name" : "TWHACompositionEmergencySummaryProfile",
  "title" : "職業健康急診友善摘要 Composition Profile",
  "status" : "active",
  "experimental" : false,
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
  "description" : "職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用，形成可驗證、可交換的摘要文件。",
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
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "fhirdocumentreference",
    "uri" : "http://hl7.org/fhir/documentreference",
    "name" : "FHIR DocumentReference"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Composition",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Composition-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Composition",
      "path" : "Composition"
    },
    {
      "id" : "Composition.status",
      "path" : "Composition.status",
      "patternCode" : "final"
    },
    {
      "id" : "Composition.type",
      "path" : "Composition.type",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "60591-5",
          "display" : "Patient summary Document"
        }]
      }
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Composition.author",
      "path" : "Composition.author",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Composition.section",
      "path" : "Composition.section",
      "slicing" : {
        "discriminator" : [{
          "type" : "pattern",
          "path" : "code"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "Composition.section:exposureHistory",
      "path" : "Composition.section",
      "sliceName" : "exposureHistory",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:exposureHistory.title",
      "path" : "Composition.section.title",
      "patternString" : "作業與暴露史"
    },
    {
      "id" : "Composition.section:exposureHistory.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11341-5"
        }]
      }
    },
    {
      "id" : "Composition.section:exposureHistory.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:vitalSigns",
      "path" : "Composition.section",
      "sliceName" : "vitalSigns",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:vitalSigns.title",
      "path" : "Composition.section.title",
      "patternString" : "生命徵象"
    },
    {
      "id" : "Composition.section:vitalSigns.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "8716-3"
        }]
      }
    },
    {
      "id" : "Composition.section:vitalSigns.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:keyLabs",
      "path" : "Composition.section",
      "sliceName" : "keyLabs",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:keyLabs.title",
      "path" : "Composition.section.title",
      "patternString" : "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）"
    },
    {
      "id" : "Composition.section:keyLabs.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "30954-2"
        }]
      }
    },
    {
      "id" : "Composition.section:keyLabs.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/DiagnosticReport"]
      }]
    },
    {
      "id" : "Composition.section:assessment",
      "path" : "Composition.section",
      "sliceName" : "assessment",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:assessment.title",
      "path" : "Composition.section.title",
      "patternString" : "健康管理分級與急診注意事項"
    },
    {
      "id" : "Composition.section:assessment.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "51848-0"
        }]
      }
    },
    {
      "id" : "Composition.section:assessment.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/ClinicalImpression",
        "http://hl7.org/fhir/StructureDefinition/CarePlan"]
      }]
    }]
  }
}

```
