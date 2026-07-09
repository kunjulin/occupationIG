# 臨場服務執行活動項目範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Procedure: 臨場服務執行活動項目範例

Profile: [臨場服務執行活動項目 Profile](StructureDefinition-TWHA-Procedure-ServiceActivity.md)

**雇主事業單位資訊擴充**: [Organization 大同電子股份有限公司](Organization-example-employer.md)

**status**: Completed

**code**: 健康檢查結果分析

**subject**: [Group 大同電子化學製造課全體勞工](Group-example-group-workers.md)



## Resource Content

```json
{
  "resourceType" : "Procedure",
  "id" : "example-procedure-activity",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-ServiceActivity"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
    "valueReference" : {
      "reference" : "Organization/example-employer"
    }
  }],
  "status" : "completed",
  "code" : {
    "coding" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ServiceActivityType",
      "code" : "exam-analysis",
      "display" : "健康檢查結果分析"
    }]
  },
  "subject" : {
    "reference" : "Group/example-group-workers"
  }
}

```
