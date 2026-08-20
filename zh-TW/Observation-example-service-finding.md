# 臨場服務現場發現問題範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## 範例 Observation: 臨場服務現場發現問題範例

Profile: [臨場健康服務發現問題/風險 Profile](StructureDefinition-TWHA-Observation-ServiceFinding.md)

**status**: Final

**code**: Occupational hazard

**focus**: [Organization 大同電子股份有限公司](Organization-example-employer.md)

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

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
      "code" : "17458004",
      "display" : "Occupational hazard"
    }]
  },
  "focus" : [{
    "reference" : "Organization/example-employer"
  }],
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueString" : "發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。"
}

```
