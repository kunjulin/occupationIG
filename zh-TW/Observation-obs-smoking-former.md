# 吸菸狀態與菸量範例 - 已戒菸 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## 範例 Observation: 吸菸狀態與菸量範例 - 已戒菸

Profile: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)

> **吸菸量及菸齡擴充**
* dailyAmount: 20
* durationYears: 15

**戒除時間（戒菸/戒檳榔月數）擴充**: 24

**status**: Final

**category**: Social History

**code**: Tobacco smoking status

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 已戒菸



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-smoking-former",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Smoking"]
  },
  "extension" : [{
    "extension" : [{
      "url" : "dailyAmount",
      "valueInteger" : 20
    },
    {
      "url" : "durationYears",
      "valueInteger" : 15
    }],
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity"
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration",
    "valueInteger" : 24
  }],
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "social-history"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "72166-2",
      "display" : "Tobacco smoking status"
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
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus",
      "code" : "3-quit",
      "display" : "已戒菸"
    }]
  }
}

```
