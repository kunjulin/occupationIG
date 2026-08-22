# 嚼檳榔資料來源代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.2

## CodeSystem: 嚼檳榔資料來源代碼系統 (實驗性) 

 
【主管機關：國民健康署】嚼檳榔資訊之取得來源。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。） 

下列值集之定義引用本代碼系統：

* [VS_BetelNutInfoSource](ValueSet-VS-BetelNutInfoSource.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutInfoSource",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutInfoSource",
  "version" : "0.10.2",
  "name" : "CS_BetelNutInfoSource",
  "title" : "嚼檳榔資料來源代碼系統",
  "status" : "active",
  "experimental" : true,
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
  "description" : "【主管機關：國民健康署】嚼檳榔資訊之取得來源。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "self-report",
    "display" : "受檢者自述",
    "definition" : "由受檢者於問診或問卷中自行陳述。"
  },
  {
    "code" : "medical-record",
    "display" : "病歷紀錄",
    "definition" : "自既有病歷紀錄取得。"
  },
  {
    "code" : "screening-form",
    "display" : "篩檢表",
    "definition" : "自口腔黏膜檢查等篩檢表取得。"
  }]
}

```
