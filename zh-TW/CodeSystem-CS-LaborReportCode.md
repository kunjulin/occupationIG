# 勞動部通報報告代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 勞動部通報報告代碼系統 () 

 
勞工健檢結果通報勞動部（LABOR）系統時所使用之報告類別代碼。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。） 

* [VS_LaborReportCode](ValueSet-VS-LaborReportCode.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-LaborReportCode",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-LaborReportCode",
  "version" : "0.2.0",
  "name" : "CS_LaborReportCode",
  "title" : "勞動部通報報告代碼系統",
  "status" : "active",
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
  "description" : "勞工健檢結果通報勞動部（LABOR）系統時所使用之報告類別代碼。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）",
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
