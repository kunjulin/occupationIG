# 特別危害作業暴露史範例 - 鉛作業 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

##  Observation: 特別危害作業暴露史範例 - 鉛作業

Profile: [特別危害健康作業危害因子暴露史 Profile](StructureDefinition-TWHA-WorkExposure.md)

**status**: Final

**category**: Social History

**code**: History of Occupational hazard

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:00:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**value**: 鉛作業

> **component****code**: Duration of exposure**value**: 8 years (Details: UCUM codea = 'a')

> **component****code**: Usual occupation Narrative**value**: 電池極板熔鉛作業



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-exposure-lead",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-WorkExposure"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "social-history"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "87729-0",
      "display" : "History of Occupational hazard"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:00:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType",
      "code" : "lead",
      "display" : "鉛作業"
    }]
  },
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "104905-5",
        "display" : "Duration of exposure"
      }]
    },
    "valueQuantity" : {
      "value" : 8,
      "unit" : "years",
      "system" : "http://unitsofmeasure.org",
      "code" : "a"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "21847-9",
        "display" : "Usual occupation Narrative"
      }]
    },
    "valueString" : "電池極板熔鉛作業"
  }]
}

```
