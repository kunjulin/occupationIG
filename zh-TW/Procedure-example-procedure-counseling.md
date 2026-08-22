# 健康諮詢與衛教指導範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## 範例 Procedure: 健康諮詢與衛教指導範例

Profile: [健康諮詢與衛教指導 Profile](StructureDefinition-TWHA-Procedure-Counseling.md)

**status**: Completed

**code**: 規律運動諮詢與衛教

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**encounter**: [Encounter: extension = 一般健康檢查,3 years,化學處理課; status = finished; class = ambulatory (ActCode#AMB); period = 2026-06-12 08:00:00+0800 --> 2026-06-12 11:30:00+0800](Encounter-example-encounter-general.md)



## Resource Content

```json
{
  "resourceType" : "Procedure",
  "id" : "example-procedure-counseling",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-Counseling"]
  },
  "status" : "completed",
  "code" : {
    "coding" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling",
      "code" : "counsel-exercise",
      "display" : "規律運動諮詢與衛教"
    },
    {
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling",
      "code" : "counsel-kidney",
      "display" : "腎病識能衛教指導"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "encounter" : {
    "reference" : "Encounter/example-encounter-general"
  }
}

```
