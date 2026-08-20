# 健康管理分級判定範例 - 第四級管理 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## 範例 Observation: 健康管理分級判定範例 - 第四級管理

Profile: [健康檢查健康管理分級 Observation Profile](StructureDefinition-TWHA-HealthManagementLevel.md)

**status**: Final

**code**: Health status

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-15 10:00:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**value**: 第四級管理



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-health-mgmt-level",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel"]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "406221003",
      "display" : "Health status"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-15T10:00:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel",
      "code" : "level-4",
      "display" : "第四級管理"
    }]
  }
}

```
