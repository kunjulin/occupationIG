# 國健署成人預防保健生活習慣與既往病史問卷定義 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## Questionnaire: 

*   
*   
*   

### 

### 

* [王大同的成人預防保健生活習慣自填問卷回覆結果。](QuestionnaireResponse-adult-preventive-care-response.md)



## Resource Content

```json
{
  "resourceType" : "Questionnaire",
  "id" : "adult-preventive-care-questionnaire",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Questionnaire"]
  },
  "url" : "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/adult-preventive-care-questionnaire",
  "version" : "0.2.0",
  "status" : "active",
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
  "item" : [{
    "linkId" : "smoking",
    "text" : "您過去一個月內是否吸菸？",
    "type" : "boolean"
  },
  {
    "linkId" : "drinking",
    "text" : "您過去一個月內是否飲酒？",
    "type" : "boolean"
  },
  {
    "linkId" : "betelnut",
    "text" : "您過去一個月內是否嚼食檳榔？",
    "type" : "boolean"
  },
  {
    "linkId" : "exercise",
    "text" : "您平均每週是否進行 150 分鐘以上之中等強度運動？",
    "type" : "boolean"
  },
  {
    "linkId" : "past-history",
    "text" : "您過去是否曾被診斷患有高血壓、糖尿病、高血脂或心血管疾病？",
    "type" : "boolean"
  },
  {
    "linkId" : "family-history",
    "text" : "您的直系親屬（父母、手足）中是否有腦中風、心臟病或糖尿病史？",
    "type" : "boolean"
  },
  {
    "linkId" : "medication-history",
    "text" : "您目前是否因高血壓、糖尿病、高血脂症或心血管疾病等而長期服藥？",
    "type" : "boolean"
  },
  {
    "linkId" : "depression-interest",
    "text" : "過去兩星期，您是否經常感覺做事提不起勁或沒有樂趣？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)",
    "type" : "integer"
  },
  {
    "linkId" : "depression-mood",
    "text" : "過去兩星期，您是否經常感覺心情低落、沮喪或絕望？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)",
    "type" : "integer"
  }]
}

```
