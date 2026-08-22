# 嚼檳榔狀態範例（從未嚼食） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.3

## 範例 Observation: 嚼檳榔狀態範例（從未嚼食）

Profile: [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

**status**: Final

**category**: Social History

**code**: 嚼檳榔狀態

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 從未嚼食檳榔



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-betelnut-never",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut"]
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
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutObservable",
      "code" : "betel-quid-chewing-status",
      "display" : "嚼檳榔狀態"
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
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutStatus",
      "code" : "0-never",
      "display" : "從未嚼食檳榔"
    }]
  }
}

```
