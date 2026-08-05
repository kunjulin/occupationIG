# 飲酒歷史與狀態範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.1

##  Observation: 飲酒歷史與狀態範例

Profile: [飲酒歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Alcohol.md)

**status**: Final

**category**: Social History

**code**: History of Alcohol use

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: Current drinker of alcohol



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-alcohol",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Alcohol"]
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
      "code" : "11331-6",
      "display" : "History of Alcohol use"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-nurse"
  }],
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "219006",
      "display" : "Current drinker of alcohol"
    }]
  }
}

```
