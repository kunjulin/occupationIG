# 嚼檳榔狀態與量化資料範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

##  Observation: 嚼檳榔狀態與量化資料範例

Profile: [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

**status**: Final

**code**: 嚼檳榔行為

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

> **component****code**: 每日嚼檳榔量，以 ”顆” 計算**value**: 每日5顆

> **component****code**: 嚼檳榔年**value**: 嚼10年

> **component****code**: 戒嚼檳榔年**value**: 已戒1年



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-betelnut",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut"]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem",
      "code" : "BetelNutChewing",
      "display" : "嚼檳榔行為"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-nurse"
  }],
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
        "code" : "amount",
        "display" : "每日嚼檳榔量，以 ”顆” 計算"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem",
        "code" : "05",
        "display" : "每日5顆"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
        "code" : "year",
        "display" : "嚼檳榔年"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewYear-codesystem",
        "code" : "10",
        "display" : "嚼10年"
      }]
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
        "code" : "quit",
        "display" : "戒嚼檳榔年"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewQuit-codesystem",
        "code" : "01",
        "display" : "已戒1年"
      }]
    }
  }]
}

```
