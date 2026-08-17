# 自費健檢項目 - 胃鏡檢查 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.4

## 範例 Observation: 自費健檢項目 - 胃鏡檢查

**status**: Final

**category**: Exam

**code**: EGD Study

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 11:15:00+0800

**performer**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)

**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-endoscopy-egd",
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
      "code" : "28014-9",
      "display" : "EGD Study"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T11:15:00+08:00",
  "performer" : [{
    "reference" : "Organization/example-hospital"
  }],
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
      "code" : "N"
    }]
  }
}

```
