# 特別危害健康作業類別代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

## CodeSystem: 特別危害健康作業類別代碼系統 

 
【依據：勞工健康保護規則附表】勞工健康保護規則所定義之特別危害健康作業，歸併為 12 危害家族（家族層）。附表十（115.06.26 修正）逐號列舉之 35 項法定具名作業另以 CS-Appendix10Operation 表示，家族 ↔ 具名作業之對映見 ConceptMap Appendix10-to-HazardType。 

下列值集之定義引用本代碼系統：

* [VS_HazardType](ValueSet-VS-HazardType.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-HazardType",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType",
  "version" : "0.8.1",
  "name" : "CS_HazardType",
  "title" : "特別危害健康作業類別代碼系統",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-21T04:20:36+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】勞工健康保護規則所定義之特別危害健康作業，歸併為 12 危害家族（家族層）。附表十（115.06.26 修正）逐號列舉之 35 項法定具名作業另以 CS-Appendix10Operation 表示，家族 ↔ 具名作業之對映見 ConceptMap Appendix10-to-HazardType。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 12,
  "concept" : [{
    "code" : "high-temp",
    "display" : "高溫作業",
    "definition" : "高溫作業勞工作息時間標準所稱之高溫作業。"
  },
  {
    "code" : "noise",
    "display" : "噪音作業",
    "definition" : "連續八小時工作期間之均權音量達八十五分貝以上之作業。"
  },
  {
    "code" : "radiation",
    "display" : "游離輻射作業",
    "definition" : "從事游離輻射防護法所稱之輻射工作。"
  },
  {
    "code" : "abnormal-pressure",
    "display" : "異常氣壓作業",
    "definition" : "從事高壓室內作業或潛水作業。"
  },
  {
    "code" : "lead",
    "display" : "鉛作業",
    "definition" : "從事鉛中毒預防規則所定義之鉛作業。"
  },
  {
    "code" : "tetraalkyl-lead",
    "display" : "四烷基鉛作業",
    "definition" : "從事四烷基鉛中毒預防規則所定義之四烷基鉛作業。"
  },
  {
    "code" : "dust",
    "display" : "粉塵作業",
    "definition" : "從事粉塵危害預防標準所定義之粉塵作業。"
  },
  {
    "code" : "organic-solvent",
    "display" : "有機溶劑作業",
    "definition" : "從事有機溶劑中毒預防規則所定義之有機溶劑作業。"
  },
  {
    "code" : "specific-chemical",
    "display" : "特定化學物質作業",
    "definition" : "從事特定化學物質危害預防標準所定義之特定化學物質作業，涵蓋苯、氯乙烯單體、石綿、鉻、鎘、鈹、砷、汞、錳、聯苯胺類等物質作業；細分類對應請見 VS-SpecificChemicalType（呼應文件一之 18 類特定化學物質展開）。"
  },
  {
    "code" : "yellow-phosphorus",
    "display" : "黃磷作業",
    "definition" : "製造、處置或使用黃磷之作業。"
  },
  {
    "code" : "paraquat",
    "display" : "聯吡啶或巴拉刈作業",
    "definition" : "製造、處置或使用聯吡啶或巴拉刈之作業。"
  },
  {
    "code" : "other",
    "display" : "其他指定作業",
    "definition" : "其他經中央主管機關公告指定之作業。"
  }]
}

```
