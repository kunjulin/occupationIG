# 口腔黏膜檢查表嚼檳榔習慣級距代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## CodeSystem: 口腔黏膜檢查表嚼檳榔習慣級距代碼系統 (實驗性) 

 
【主管機關：國民健康署】逐字錄自國民健康署**口腔黏膜檢查表（107 年 7 月修訂）**「菸檳習慣」欄之「1.嚼檳榔習慣」六個選項。**該表為癌症篩檢用表，非健檢上傳欄位**（見 open-issues T-13、術語頁 §6.2b-1）。（**provisional**：選項文字為該表原文，惟「篩檢表級距是否納入健檢交換」之範疇問題尚待主管機關確認，M-5。） 

下列值集之定義引用本代碼系統：

* [VS_BetelNutHpaCategory](ValueSet-VS-BetelNutHpaCategory.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutHpaCategory",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutHpaCategory",
  "version" : "0.6.0",
  "name" : "CS_BetelNutHpaCategory",
  "title" : "口腔黏膜檢查表嚼檳榔習慣級距代碼系統",
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
  "description" : "【主管機關：國民健康署】逐字錄自國民健康署**口腔黏膜檢查表（107 年 7 月修訂）**「菸檳習慣」欄之「1.嚼檳榔習慣」六個選項。**該表為癌症篩檢用表，非健檢上傳欄位**（見 open-issues T-13、術語頁 §6.2b-1）。（**provisional**：選項文字為該表原文，惟「篩檢表級距是否納入健檢交換」之範疇問題尚待主管機關確認，M-5。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 6,
  "concept" : [{
    "code" : "0-none",
    "display" : "無",
    "definition" : "表列第 1 項（⓿）：無嚼檳榔習慣。"
  },
  {
    "code" : "1-quit",
    "display" : "已戒",
    "definition" : "表列第 2 項（❶）：已戒除。"
  },
  {
    "code" : "2-lt10y-lt20",
    "display" : "嚼 10 年以下，每天少於 20 顆",
    "definition" : "表列第 3 項（❷）。可導出：年數 < 10、每日 < 20 顆。"
  },
  {
    "code" : "3-lt10y-ge20",
    "display" : "嚼 10 年以下，每天 20 顆及以上",
    "definition" : "表列第 4 項（❸）。可導出：年數 < 10、每日 ≧ 20 顆。"
  },
  {
    "code" : "4-ge10y-lt20",
    "display" : "嚼超過 10 年，每天少於 20 顆",
    "definition" : "表列第 5 項（❹）。可導出：年數 > 10、每日 < 20 顆。"
  },
  {
    "code" : "5-ge10y-ge20",
    "display" : "嚼超過 10 年，每天 20 顆及以上",
    "definition" : "表列第 6 項（❺）。可導出：年數 > 10、每日 ≧ 20 顆。"
  }]
}

```
