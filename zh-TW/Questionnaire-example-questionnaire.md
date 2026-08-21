# 自覺症狀問卷定義範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## Questionnaire: 

*  [樹狀檢視](#tabs-tree) 
*  [範例呈現](#tabs-sample) 
*  [表單邏輯](#tabs-logic) 

### 測試本問卷

### 本問卷之回覆

* [受檢勞工王大同的自覺症狀問卷填寫結果。](QuestionnaireResponse-example-symptoms-response.md)



## Resource Content

```json
{
  "resourceType" : "Questionnaire",
  "id" : "example-questionnaire",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Questionnaire"]
  },
  "url" : "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/example-questionnaire",
  "version" : "0.8.5",
  "status" : "active",
  "date" : "2026-08-21T12:32:47+00:00",
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
  "item" : [{
    "linkId" : "q1",
    "text" : "您過去三個月內，是否經常感到呼吸困難或氣喘？",
    "type" : "boolean"
  },
  {
    "linkId" : "q2",
    "text" : "您過去三個月內，是否經常感到胸痛或胸悶？",
    "type" : "boolean"
  }]
}

```
