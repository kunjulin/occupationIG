# 心電圖檢查結果範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.2

## 範例 Observation: 心電圖檢查結果範例

Profile: [心電圖檢查 Profile](StructureDefinition-TWHA-ECG.md)

**status**: Final

**category**: Procedure

**code**: EKG study

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 09:30:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-ecg",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ECG"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "procedure"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "11524-6",
      "display" : "EKG study"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T09:30:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
      "code" : "N"
    }]
  }
}

```
