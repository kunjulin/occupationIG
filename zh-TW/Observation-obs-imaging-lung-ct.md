# 自費健檢項目 - 肺部低劑量電腦斷層 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.1

## 範例 Observation: 自費健檢項目 - 肺部低劑量電腦斷層

**status**: Final

**category**: Imaging

**code**: CT Chest Screening WO contr

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 10:30:00+0800

**performer**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)

**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-imaging-lung-ct",
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "imaging"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "79086-5",
      "display" : "CT Chest Screening WO contr"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T10:30:00+08:00",
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
