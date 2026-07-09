# 吸菸狀態與菸量範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 吸菸狀態與菸量範例

Profile: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)

**status**: Final

**category**: Social History

**code**: Tobacco smoking status

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:05:00+0800

**value**: Never smoked tobacco



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-smoking",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Smoking"]
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
      "system" : "http://loinc.org",
      "code" : "72166-2",
      "display" : "Tobacco smoking status"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
  "valueCodeableConcept" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "266919005",
      "display" : "Never smoked tobacco"
    },
    {
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus",
      "code" : "0-never",
      "display" : "從未吸菸"
    }]
  }
}

```
