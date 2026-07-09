# 自費健檢項目 - 心臟冠狀動脈電腦斷層血管攝影 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 自費健檢項目 - 心臟冠狀動脈電腦斷層血管攝影

**status**: Final

**category**: Imaging

**code**: CTA Hrt+CA W contr IV

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 11:00:00+0800

**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-imaging-cta",
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
      "code" : "79073-3",
      "display" : "CTA Hrt+CA W contr IV"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T11:00:00+08:00",
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
      "code" : "N"
    }]
  }
}

```
