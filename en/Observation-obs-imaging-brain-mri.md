# 自費健檢項目 - 腦部核磁共振造影 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 自費健檢項目 - 腦部核磁共振造影

**status**: Final

**category**: Imaging

**code**: MR Brain

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 10:15:00+0800

**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-imaging-brain-mri",
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
      "code" : "24590-2",
      "display" : "MR Brain"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T10:15:00+08:00",
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
      "code" : "N"
    }]
  }
}

```
