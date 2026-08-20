# 嚼檳榔狀態代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## CodeSystem: 嚼檳榔狀態代碼系統 (實驗性) 

 
【主管機關：國民健康署】勞工健檢生活習慣調查中之嚼檳榔狀態分類，與吸菸狀態（CS-SmokingStatus）逐碼對稱。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待主管機關確認官方代碼與定義（M-5）**；不得表述為已對接官方申報系統。） 

下列值集之定義引用本代碼系統：

* [VS_BetelNutStatus](ValueSet-VS-BetelNutStatus.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutStatus",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutStatus",
  "version" : "0.6.0",
  "name" : "CS_BetelNutStatus",
  "title" : "嚼檳榔狀態代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-20T17:39:23+00:00",
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
  "description" : "【主管機關：國民健康署】勞工健檢生活習慣調查中之嚼檳榔狀態分類，與吸菸狀態（CS-SmokingStatus）逐碼對稱。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待主管機關確認官方代碼與定義（M-5）**；不得表述為已對接官方申報系統。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "0-never",
    "display" : "從未嚼食檳榔",
    "definition" : "受檢勞工從未嚼食檳榔。"
  },
  {
    "code" : "1-occasional",
    "display" : "偶爾嚼食",
    "definition" : "受檢勞工偶爾嚼食檳榔（非每日，且無固定量）。"
  },
  {
    "code" : "2-daily",
    "display" : "每日嚼食",
    "definition" : "受檢勞工每日嚼食檳榔。"
  },
  {
    "code" : "3-quit",
    "display" : "已戒除",
    "definition" : "受檢勞工過去曾嚼食檳榔，目前已戒除。"
  }]
}

```
