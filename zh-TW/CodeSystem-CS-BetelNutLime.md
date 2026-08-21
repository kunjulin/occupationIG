# 檳榔石灰種類代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## CodeSystem: 檳榔石灰種類代碼系統 (實驗性) 

 
【主管機關：國民健康署】嚼食檳榔所用之石灰種類。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。） 

下列值集之定義引用本代碼系統：

* [VS_BetelNutLime](ValueSet-VS-BetelNutLime.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutLime",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutLime",
  "version" : "0.9.0",
  "name" : "CS_BetelNutLime",
  "title" : "檳榔石灰種類代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【主管機關：國民健康署】嚼食檳榔所用之石灰種類。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 2,
  "concept" : [{
    "code" : "red-lime",
    "display" : "紅灰",
    "definition" : "使用紅灰。"
  },
  {
    "code" : "white-lime",
    "display" : "白灰",
    "definition" : "使用白灰。"
  }]
}

```
