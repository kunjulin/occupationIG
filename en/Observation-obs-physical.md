# 理學檢查結果範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 理學檢查結果範例

Profile: [身體理學檢查 Profile](StructureDefinition-TWHA-PhysicalExam.md)

**status**: Final

**category**: Exam

**code**: Physical findings Narrative

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:30:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

> **component****code**: 頭頸部**value**: None

> **component****code**: 呼吸系統**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-physical",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-PhysicalExam"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "exam"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "29545-1",
      "display" : "Physical findings Narrative"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:30:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems",
        "code" : "head-neck",
        "display" : "頭頸部"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
        "code" : "N"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems",
        "code" : "respiratory",
        "display" : "呼吸系統"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
        "code" : "N"
      }]
    }
  }]
}

```
