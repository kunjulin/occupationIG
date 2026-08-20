# 精簡版 PRAPARE 社會風險問卷定義 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## Questionnaire: 

*  [樹狀檢視](#tabs-tree) 
*  [範例呈現](#tabs-sample) 
*  [表單邏輯](#tabs-logic) 

### 測試本問卷

### 本問卷之回覆

* [王大同的精簡版 PRAPARE 社會風險問卷回覆結果。](QuestionnaireResponse-sdoh-questionnaire-response.md)



## Resource Content

```json
{
  "resourceType" : "Questionnaire",
  "id" : "twha-sdoh-questionnaire",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Questionnaire"]
  },
  "url" : "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/twha-sdoh-questionnaire",
  "version" : "0.3.3",
  "status" : "active",
  "date" : "2026-08-20T12:04:33+00:00",
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
    "linkId" : "education",
    "text" : "您的最高學歷為何？",
    "type" : "string"
  },
  {
    "linkId" : "employment",
    "text" : "您目前的工作就業狀態為何？",
    "type" : "string"
  },
  {
    "linkId" : "housing-security",
    "text" : "您是否覺得目前居住的環境或房屋不夠安全？",
    "type" : "boolean"
  },
  {
    "linkId" : "caregiver-stress",
    "text" : "您目前是否有照顧家人（如老人或幼童）的巨大精神或體力壓力？",
    "type" : "boolean"
  },
  {
    "linkId" : "financial-hardship",
    "text" : "在過去一年中，您是否曾因為經濟困難而無法支付足夠的食物、醫療費用或房租？",
    "type" : "boolean"
  }]
}

```
