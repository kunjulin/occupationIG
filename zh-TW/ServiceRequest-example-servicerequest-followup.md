# 追蹤檢查要求範例 - 三個月後聽力複檢 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## 範例 ServiceRequest: 追蹤檢查要求範例 - 三個月後聽力複檢

Profile: [健康檢查健檢追蹤檢查要求 Profile](StructureDefinition-TWHA-ServiceRequest.md)

**status**: Active

**intent**: Order

**code**: 純音聽力檢查（複檢）

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**occurrence**: 2026-10-01 09:00:00+0800

**authoredOn**: 2026-06-15 10:30:00+0800

**requester**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)



## Resource Content

```json
{
  "resourceType" : "ServiceRequest",
  "id" : "example-servicerequest-followup",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ServiceRequest"]
  },
  "status" : "active",
  "intent" : "order",
  "code" : {
    "text" : "純音聽力檢查（複檢）"
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "occurrenceDateTime" : "2026-10-01T09:00:00+08:00",
  "authoredOn" : "2026-06-15T10:30:00+08:00",
  "requester" : {
    "reference" : "Practitioner/example-doctor"
  }
}

```
