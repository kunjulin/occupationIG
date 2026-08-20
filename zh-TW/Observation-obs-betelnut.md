# 嚼檳榔狀態與量化資料範例（已戒） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## 範例 Observation: 嚼檳榔狀態與量化資料範例（已戒）

Profile: [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

**status**: Final

**category**: Social History

**code**: Chews betel quid

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 已戒除

> **component****code**: 每日嚼食量**value**: 5 顆/日 (Details: UCUM code{quid}/d = '{quid}/d')

> **component****code**: 嚼食年數**value**: 10 年 (Details: UCUM codea = 'a')

> **component****code**: 戒除期間**value**: 1 年 (Details: UCUM codea = 'a')

> **component****code**: Information source**value**: 受檢者自述



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-betelnut",
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
      "system" : "http://snomed.info/sct",
      "code" : "698188003",
      "display" : "Chews betel quid"
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
      "code" : "3-quit",
      "display" : "已戒除"
    }]
  },
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "amount",
        "display" : "每日嚼食量"
      }]
    },
    "valueQuantity" : {
      "value" : 5,
      "unit" : "顆/日",
      "system" : "http://unitsofmeasure.org",
      "code" : "{quid}/d"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "duration-years",
        "display" : "嚼食年數"
      }]
    },
    "valueQuantity" : {
      "value" : 10,
      "unit" : "年",
      "system" : "http://unitsofmeasure.org",
      "code" : "a"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "cessation-duration",
        "display" : "戒除期間"
      }]
    },
    "valueQuantity" : {
      "value" : 1,
      "unit" : "年",
      "system" : "http://unitsofmeasure.org",
      "code" : "a"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "48766-0",
        "display" : "Information source"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutInfoSource",
        "code" : "self-report",
        "display" : "受檢者自述"
      }]
    }
  }]
}

```
