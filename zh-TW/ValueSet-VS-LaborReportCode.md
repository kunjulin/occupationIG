# 勞動部通報報告代碼值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## ValueSet: 勞動部通報報告代碼值集 (實驗性) 

 
包含勞動部通報報告類別代碼之值集。（provisional，隨 CS-LaborReportCode 待官方確認） 

 **References** 

* [勞動部通報報告代碼擴充](StructureDefinition-ext-labor-report-code.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-LaborReportCode",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-LaborReportCode",
  "version" : "0.4.0",
  "name" : "VS_LaborReportCode",
  "title" : "勞動部通報報告代碼值集",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-20T13:40:11+00:00",
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
  "description" : "包含勞動部通報報告類別代碼之值集。（provisional，隨 CS-LaborReportCode 待官方確認）",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-LaborReportCode"
    }]
  }
}

```
