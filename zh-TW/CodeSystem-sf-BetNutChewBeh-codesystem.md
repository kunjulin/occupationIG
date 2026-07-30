# 【本地 stub】Betel Nut Chewing Behavior Code System（非權威定義） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 【本地 stub】Betel Nut Chewing Behavior Code System（非權威定義） () 

 
Betel Nut Chewing Behavior Code System 

* [SFBetNutChewBehValueSet](ValueSet-sf-BetNutChewBeh-valueset.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "sf-BetNutChewBeh-codesystem",
  "url" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem",
  "version" : "0.2.0",
  "name" : "sf-BetNutChewBeh-codesystem",
  "title" : "【本地 stub】Betel Nut Chewing Behavior Code System（非權威定義）",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-07-30T14:46:31+00:00",
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
  "description" : "Betel Nut Chewing Behavior Code System",
  "copyright" : "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。",
  "content" : "fragment",
  "concept" : [{
    "code" : "amount",
    "display" : "每日嚼檳榔量，以 ”顆” 計算"
  },
  {
    "code" : "year",
    "display" : "嚼檳榔年"
  },
  {
    "code" : "quit",
    "display" : "戒嚼檳榔年"
  }]
}

```
