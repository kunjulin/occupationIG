# 適性配工建議代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## CodeSystem: 適性配工建議代碼系統 (實驗性) 

 
【依據：勞工健康保護規則附表】第四級管理中，醫師針對受檢勞工提出之適性配工或變更作業內容建議。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。） 

下列值集之定義引用本代碼系統：

* [VS_FitnessForWork](ValueSet-VS-FitnessForWork.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-FitnessForWork",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork",
  "version" : "0.8.5",
  "name" : "CS_FitnessForWork",
  "title" : "適性配工建議代碼系統",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-21T12:32:47+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】第四級管理中，醫師針對受檢勞工提出之適性配工或變更作業內容建議。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "change-workplace",
    "display" : "變更工作場所",
    "definition" : "調整勞工之作業場所，避開特定危害因子。"
  },
  {
    "code" : "change-job",
    "display" : "更換工作",
    "definition" : "調換勞工至其他職務或性質不同之工作。"
  },
  {
    "code" : "reduce-hours",
    "display" : "縮短工作時間",
    "definition" : "減少勞工暴露於危害作業之每日或每週工作時間。"
  },
  {
    "code" : "clinical-treatment",
    "display" : "醫療處置與限制",
    "definition" : "限制從事特定性質工作或建議配合臨床治療。"
  }]
}

```
