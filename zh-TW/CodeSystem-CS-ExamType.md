# 檢查類型代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.2

## CodeSystem: 檢查類型代碼系統 

 
【技術規格】勞工體格及健康檢查之類型，包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查。 

下列值集之定義引用本代碼系統：

* [VS_ExamType](ValueSet-VS-ExamType.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-ExamType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType",
  "version" : "0.10.2",
  "name" : "CS_ExamType",
  "title" : "檢查類型代碼系統",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-22T14:05:28+00:00",
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
  "description" : "【技術規格】勞工體格及健康檢查之類型，包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "general-physical",
    "display" : "一般體格檢查",
    "definition" : "雇主僱用勞工時，為辨識其工作適性，實施之體格檢查。"
  },
  {
    "code" : "general-health",
    "display" : "一般健康檢查",
    "definition" : "雇主對在職勞工，按其年齡及週期實施之定期健康檢查。"
  },
  {
    "code" : "special-physical",
    "display" : "特殊體格檢查",
    "definition" : "雇主使勞工從事特別危害健康作業前，實施之體格檢查。"
  },
  {
    "code" : "special-health",
    "display" : "特殊健康檢查",
    "definition" : "雇主對從事特別危害健康作業在職勞工，每年實施之定期健康檢查。"
  }]
}

```
