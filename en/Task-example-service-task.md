# 臨場服務建議改善措施與追蹤任務範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Task: 臨場服務建議改善措施與追蹤任務範例

Profile: [臨場健康服務建議與改善任務 Profile](StructureDefinition-TWHA-Task-ServiceTask.md)

**雇主事業單位資訊擴充**: [Organization 大同電子股份有限公司](Organization-example-employer.md)

**status**: Requested

**intent**: plan

**description**: 大同電子應於兩週內委託專業廠商維修化學製造現場之局部排氣系統，並落實每日作業前防護具配戴檢查機制。

**focus**: [Observation Occupational health hazard (finding)](Observation-example-service-finding.md)

**requester**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**owner**: [Organization 大同電子股份有限公司](Organization-example-employer.md)



## Resource Content

```json
{
  "resourceType" : "Task",
  "id" : "example-service-task",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Task-ServiceTask"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
    "valueReference" : {
      "reference" : "Organization/example-employer"
    }
  }],
  "status" : "requested",
  "intent" : "plan",
  "description" : "大同電子應於兩週內委託專業廠商維修化學製造現場之局部排氣系統，並落實每日作業前防護具配戴檢查機制。",
  "focus" : {
    "reference" : "Observation/example-service-finding"
  },
  "requester" : {
    "reference" : "Practitioner/example-doctor"
  },
  "owner" : {
    "reference" : "Organization/example-employer"
  }
}

```
