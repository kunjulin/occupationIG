# 附表十特別危害健康作業具名代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## CodeSystem: 附表十特別危害健康作業具名代碼系統 

 
《勞工健康保護規則》附表十（115.06.26 修正）逐號列舉之 35 項特別危害健康作業具名代碼。本代碼系統為「具名作業層」，與 CS-HazardType（12 危害家族層）以 ConceptMap Appendix10-to-HazardType 對映。編號 33/34/35（苯乙烯、甲苯、二甲苯）為 115.06.26 修正新增，狀態為 **draft**：其施行日期與既有勞工銜接安排尚待勞動部職業安全衛生署確認，本 IG 之檢查項目與代碼配置屬暫定。過渡期以本 CodeSystem 之 version（法規版本）表達，個案資料僅記錄實際檢查日期與所採規範版本，不另加自訂旗標。 

* [VS_Appendix10Operation](ValueSet-VS-Appendix10-Operation.md)

-------

 . 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-Appendix10Operation",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-Appendix10Operation",
  "version" : "0.2.0",
  "name" : "CS_Appendix10Operation",
  "title" : "附表十特別危害健康作業具名代碼系統",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-30T14:17:56+00:00",
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
  "description" : "《勞工健康保護規則》附表十（115.06.26 修正）逐號列舉之 35 項特別危害健康作業具名代碼。本代碼系統為「具名作業層」，與 CS-HazardType（12 危害家族層）以 ConceptMap Appendix10-to-HazardType 對映。編號 33/34/35（苯乙烯、甲苯、二甲苯）為 115.06.26 修正新增，狀態為 **draft**：其施行日期與既有勞工銜接安排尚待勞動部職業安全衛生署確認，本 IG 之檢查項目與代碼配置屬暫定。過渡期以本 CodeSystem 之 version（法規版本）表達，個案資料僅記錄實際檢查日期與所採規範版本，不另加自訂旗標。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 35,
  "concept" : [{
    "code" : "app-01",
    "display" : "高溫作業"
  },
  {
    "code" : "app-02",
    "display" : "噪音作業"
  },
  {
    "code" : "app-03",
    "display" : "游離輻射作業"
  },
  {
    "code" : "app-04",
    "display" : "異常氣壓作業"
  },
  {
    "code" : "app-05",
    "display" : "鉛作業"
  },
  {
    "code" : "app-06",
    "display" : "四烷基鉛作業"
  },
  {
    "code" : "app-07",
    "display" : "1,1,2,2-四氯乙烷作業"
  },
  {
    "code" : "app-08",
    "display" : "四氯化碳作業"
  },
  {
    "code" : "app-09",
    "display" : "二硫化碳作業"
  },
  {
    "code" : "app-10",
    "display" : "三氯乙烯作業"
  },
  {
    "code" : "app-11",
    "display" : "二甲基甲醯胺作業"
  },
  {
    "code" : "app-12",
    "display" : "正己烷作業"
  },
  {
    "code" : "app-13",
    "display" : "聯苯胺及其鹽類作業"
  },
  {
    "code" : "app-14",
    "display" : "鈹及其化合物作業"
  },
  {
    "code" : "app-15",
    "display" : "氯乙烯作業"
  },
  {
    "code" : "app-16",
    "display" : "苯作業"
  },
  {
    "code" : "app-17",
    "display" : "2,4-二異氰酸甲苯作業"
  },
  {
    "code" : "app-18",
    "display" : "石綿作業"
  },
  {
    "code" : "app-19",
    "display" : "砷及其化合物作業"
  },
  {
    "code" : "app-20",
    "display" : "錳及其化合物作業"
  },
  {
    "code" : "app-21",
    "display" : "黃磷作業"
  },
  {
    "code" : "app-22",
    "display" : "聯吡啶或巴拉刈作業"
  },
  {
    "code" : "app-23",
    "display" : "粉塵作業"
  },
  {
    "code" : "app-24",
    "display" : "鉻酸及其鹽類作業"
  },
  {
    "code" : "app-25",
    "display" : "鎘及其化合物作業"
  },
  {
    "code" : "app-26",
    "display" : "鎳及其化合物作業"
  },
  {
    "code" : "app-27",
    "display" : "乙基汞化合物作業"
  },
  {
    "code" : "app-28",
    "display" : "溴丙烷作業"
  },
  {
    "code" : "app-29",
    "display" : "1,3-丁二烯作業"
  },
  {
    "code" : "app-30",
    "display" : "甲醛作業"
  },
  {
    "code" : "app-31",
    "display" : "銦及其化合物作業"
  },
  {
    "code" : "app-32",
    "display" : "汞及其無機化合物作業"
  },
  {
    "code" : "app-33",
    "display" : "苯乙烯作業",
    "designation" : [{
      "language" : "zh-TW",
      "value" : "draft：115.06.26 修正新增之具名作業，施行日尚待勞動部職業安全衛生署確認；本 IG 之檢查項目與代碼配置屬暫定"
    }]
  },
  {
    "code" : "app-34",
    "display" : "甲苯作業",
    "designation" : [{
      "language" : "zh-TW",
      "value" : "draft：115.06.26 修正新增之具名作業，施行日尚待勞動部職業安全衛生署確認；本 IG 之檢查項目與代碼配置屬暫定"
    }]
  },
  {
    "code" : "app-35",
    "display" : "二甲苯作業",
    "designation" : [{
      "language" : "zh-TW",
      "value" : "draft：115.06.26 修正新增之具名作業，施行日尚待勞動部職業安全衛生署確認；本 IG 之檢查項目與代碼配置屬暫定"
    }]
  }]
}

```
