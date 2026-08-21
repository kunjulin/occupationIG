# 睡眠狀況測量範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## 範例 Observation: 睡眠狀況測量範例

Profile: [睡眠狀況 Profile](StructureDefinition-TWHA-SocialHistory-Sleep.md)

**status**: Final

**code**: Sleep duration

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 7 hours (Details: UCUM codeh = 'h')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-sleep",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Sleep"]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "93832-4",
      "display" : "Sleep duration"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-nurse"
  }],
  "valueQuantity" : {
    "value" : 7,
    "unit" : "hours",
    "system" : "http://unitsofmeasure.org",
    "code" : "h"
  }
}

```
