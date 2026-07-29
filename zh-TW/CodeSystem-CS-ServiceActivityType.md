# 臨場健康服務辦理事項代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 臨場健康服務辦理事項代碼系統 () 

 
附表八中醫護人員辦理之臨場健康服務項目活動類別代碼系統。（**provisional**：本地代碼配置，尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）。另因 SNOMED 現無適切之職業健康諮詢 procedure 代碼，改善建議諮詢暫以本代碼系統承載，該用法列為本地碼治理事項。） 

* [VS_ServiceActivityType](ValueSet-VS-ServiceActivityType.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-ServiceActivityType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ServiceActivityType",
  "version" : "0.2.0",
  "name" : "CS_ServiceActivityType",
  "title" : "臨場健康服務辦理事項代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-07-29T16:26:07+00:00",
  "publisher" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
  "contact" : [{
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  },
  {
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  }],
  "description" : "附表八中醫護人員辦理之臨場健康服務項目活動類別代碼系統。（**provisional**：本地代碼配置，尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）。另因 SNOMED 現無適切之職業健康諮詢 procedure 代碼，改善建議諮詢暫以本代碼系統承載，該用法列為本地碼治理事項。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 8,
  "concept" : [{
    "code" : "exam-analysis",
    "display" : "健康檢查結果分析",
    "definition" : "辦理健康檢查結果分析、評估、管理與保存。"
  },
  {
    "code" : "abnormal-followup",
    "display" : "異常追蹤管理",
    "definition" : "針對健檢異常勞工辦理個案追蹤與健康指導。"
  },
  {
    "code" : "health-education",
    "display" : "健康教育指導",
    "definition" : "辦理勞工健康教育、衛生指導、健康促進等活動。"
  },
  {
    "code" : "injury-prevention",
    "display" : "工作相關傷病預防",
    "definition" : "規劃與執行重複性作業等工作相關傷病預防措施。"
  },
  {
    "code" : "exposure-evaluation",
    "display" : "作業環境危害暴露評估",
    "definition" : "配合職業安全衛生人員進行危害暴露評估與現場巡視。"
  },
  {
    "code" : "maternity-protection",
    "display" : "母性健康保護",
    "definition" : "規劃與辦理妊娠、分娩後勞工之母性健康保護。"
  },
  {
    "code" : "unfit-assessment",
    "display" : "配工與復工評估",
    "definition" : "辦理勞工適性配工、工作限制或復工評估。"
  },
  {
    "code" : "emergency-response",
    "display" : "緊急醫療規劃",
    "definition" : "規劃與辦理工作場所緊急醫療與急救計畫。"
  }]
}

```
