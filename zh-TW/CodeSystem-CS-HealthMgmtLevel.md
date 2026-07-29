# 健康管理分級代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 健康管理分級代碼系統 () 

 
依據勞工健康保護規則第 21 條規定，醫師依健康檢查結果判定之健康管理分級。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。） 

* [VS_HealthMgmtLevel](ValueSet-VS-HealthMgmtLevel.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-HealthMgmtLevel",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel",
  "version" : "0.2.0",
  "name" : "CS_HealthMgmtLevel",
  "title" : "健康管理分級代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-07-29T16:54:28+00:00",
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
  "description" : "依據勞工健康保護規則第 21 條規定，醫師依健康檢查結果判定之健康管理分級。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "level-1",
    "display" : "第一級管理",
    "definition" : "健康檢查結果無異常，或有部分異常但經醫師評估與工作無關，屬大致正常者。"
  },
  {
    "code" : "level-2",
    "display" : "第二級管理",
    "definition" : "健康檢查結果異常，但經醫師評估與工作無關，需進行個人健康指導者。"
  },
  {
    "code" : "level-3",
    "display" : "第三級管理",
    "definition" : "健康檢查結果異常，且無法確定其異常與工作之相關性，需進行追蹤檢查或工作場所危害暴露評估者。"
  },
  {
    "code" : "level-4",
    "display" : "第四級管理",
    "definition" : "健康檢查結果異常，且經醫師評估與工作相關，屬健康危害顯著，需進行適性配工與治療者。"
  }]
}

```
