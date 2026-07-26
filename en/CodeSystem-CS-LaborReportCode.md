# 勞動部通報報告代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## CodeSystem: 勞動部通報報告代碼系統 

 
勞工健檢結果通報勞動部（LABOR）系統時所使用之報告類別代碼。 

This Code system is referenced in the definition of the following value sets:

* [VS_LaborReportCode](ValueSet-VS-LaborReportCode.md)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-LaborReportCode",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-LaborReportCode",
  "version" : "0.1.0",
  "name" : "CS_LaborReportCode",
  "title" : "勞動部通報報告代碼系統",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T10:07:44+08:00",
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
  "description" : "勞工健檢結果通報勞動部（LABOR）系統時所使用之報告類別代碼。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 5,
  "concept" : [{
    "code" : "30901X",
    "display" : "一般檢查通報",
    "definition" : "一般體格及健康檢查結果通報。"
  },
  {
    "code" : "30902X",
    "display" : "噪音作業特殊健檢通報",
    "definition" : "從事噪音作業勞工之特殊健檢結果通報。"
  },
  {
    "code" : "30903X",
    "display" : "粉塵作業特殊健檢通報",
    "definition" : "從事粉塵作業勞工之特殊健檢結果通報。"
  },
  {
    "code" : "30904X",
    "display" : "鉛作業特殊健檢通報",
    "definition" : "從事鉛作業勞工之特殊健檢結果通報。"
  },
  {
    "code" : "30905X",
    "display" : "其他特殊危害健康作業通報",
    "definition" : "其他特別危害作業勞工之特殊健檢結果通報。"
  }]
}

```
