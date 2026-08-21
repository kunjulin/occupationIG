# 檳榔添加物代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

## CodeSystem: 檳榔添加物代碼系統 (實驗性) 

 
【主管機關：國民健康署】嚼食檳榔所用之添加物。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。） 

下列值集之定義引用本代碼系統：

* [VS_BetelNutAdditive](ValueSet-VS-BetelNutAdditive.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutAdditive",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutAdditive",
  "version" : "0.8.1",
  "name" : "CS_BetelNutAdditive",
  "title" : "檳榔添加物代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-21T04:20:36+00:00",
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
  "description" : "【主管機關：國民健康署】嚼食檳榔所用之添加物。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "betel-inflorescence",
    "display" : "荖花",
    "definition" : "以荖花（檳榔花）為添加物。"
  },
  {
    "code" : "betel-leaf",
    "display" : "荖葉",
    "definition" : "以荖葉為添加物。"
  },
  {
    "code" : "none",
    "display" : "無添加物",
    "definition" : "未使用荖花或荖葉。"
  }]
}

```
