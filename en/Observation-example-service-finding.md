# 臨場服務現場發現問題範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 臨場服務現場發現問題範例

Profile: [臨場健康服務發現問題/風險 Profile](StructureDefinition-TWHA-Observation-ServiceFinding.md)

**status**: Final

**code**: Occupational health hazard (finding)

**focus**: [Organization 大同電子股份有限公司](Organization-example-employer.md)

**value**: 發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "example-service-finding",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding"]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "278486003",
      "display" : "Occupational health hazard (finding)"
    }]
  },
  "focus" : [{
    "reference" : "Organization/example-employer"
  }],
  "valueString" : "發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。"
}

```
