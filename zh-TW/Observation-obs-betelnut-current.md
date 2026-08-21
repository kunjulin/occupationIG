# 嚼檳榔狀態與量化資料範例（現嚼，含情境欄位） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## 範例 Observation: 嚼檳榔狀態與量化資料範例（現嚼，含情境欄位）

Profile: [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

**status**: Final

**category**: Social History

**code**: Chews betel quid

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 每日嚼食

> **component****code**: 每日嚼食量**value**: 10 顆/日 (Details: UCUM code{quid}/d = '{quid}/d')

> **component****code**: 嚼食持續期間**value**: 240 月 (Details: UCUM codemo = 'mo')

> **component****code**: 是否含菸草**value**: true

> **component****code**: 添加物**value**: 荖葉

> **component****code**: 石灰種類**value**: 白灰

> **component****code**: 每日嚼食量（上游級距碼）**value**: 每日10顆

> **component****code**: 口腔黏膜檢查表級距**value**: 嚼超過 10 年，每天少於 20 顆

> **component****code**: Information source**value**: 受檢者自述



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-betelnut-current",
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
      "code" : "2-daily",
      "display" : "每日嚼食"
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
      "value" : 10,
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
        "display" : "嚼食持續期間"
      }]
    },
    "valueQuantity" : {
      "value" : 240,
      "unit" : "月",
      "system" : "http://unitsofmeasure.org",
      "code" : "mo"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "with-tobacco",
        "display" : "是否含菸草"
      }]
    },
    "valueBoolean" : true
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "additive",
        "display" : "添加物"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutAdditive",
        "code" : "betel-leaf",
        "display" : "荖葉"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "lime",
        "display" : "石灰種類"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutLime",
        "code" : "white-lime",
        "display" : "白灰"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "amount-coded",
        "display" : "每日嚼食量（上游級距碼）"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem",
        "code" : "10",
        "display" : "每日10顆"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
        "code" : "hpa-category",
        "display" : "口腔黏膜檢查表級距"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutHpaCategory",
        "code" : "4-ge10y-lt20",
        "display" : "嚼超過 10 年，每天少於 20 顆"
      }]
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
