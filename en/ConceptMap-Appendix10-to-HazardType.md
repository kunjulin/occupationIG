# 附表十 35 項法定作業 對 12 危害家族 對照 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ConceptMap: 附表十 35 項法定作業 對 12 危害家族 對照 

 
將 CS-Appendix10Operation（附表十 35 項具名作業）對映至 CS-HazardType（12 危害家族）。每一具名作業（source）相對於其對應之危害家族（target）在語意上較窄，故 equivalence = narrower（家族涵蓋範圍較廣）。供接收端由法定作業編號歸併至危害家族，回應審查意見之逐號可追溯性需求。 



## Resource Content

```json
{
  "resourceType" : "ConceptMap",
  "id" : "Appendix10-to-HazardType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ConceptMap/Appendix10-to-HazardType",
  "version" : "0.1.0",
  "name" : "Appendix10ToHazardType",
  "title" : "附表十 35 項法定作業 對 12 危害家族 對照",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T15:21:49+08:00",
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
  "description" : "將 CS-Appendix10Operation（附表十 35 項具名作業）對映至 CS-HazardType（12 危害家族）。每一具名作業（source）相對於其對應之危害家族（target）在語意上較窄，故 equivalence = narrower（家族涵蓋範圍較廣）。供接收端由法定作業編號歸併至危害家族，回應審查意見之逐號可追溯性需求。",
  "sourceCanonical" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Operation",
  "targetCanonical" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HazardType",
  "group" : [{
    "source" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-Appendix10Operation",
    "target" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType",
    "element" : [{
      "code" : "app-01",
      "display" : "高溫作業",
      "target" : [{
        "code" : "high-temp",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-02",
      "display" : "噪音作業",
      "target" : [{
        "code" : "noise",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-03",
      "display" : "游離輻射作業",
      "target" : [{
        "code" : "radiation",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-04",
      "display" : "異常氣壓作業",
      "target" : [{
        "code" : "abnormal-pressure",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-05",
      "display" : "鉛作業",
      "target" : [{
        "code" : "lead",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-06",
      "display" : "四烷基鉛作業",
      "target" : [{
        "code" : "tetraalkyl-lead",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-07",
      "display" : "1,1,2,2-四氯乙烷作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-08",
      "display" : "四氯化碳作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-09",
      "display" : "二硫化碳作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-10",
      "display" : "三氯乙烯作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-11",
      "display" : "二甲基甲醯胺作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-12",
      "display" : "正己烷作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-13",
      "display" : "聯苯胺及其鹽類作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-14",
      "display" : "鈹及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-15",
      "display" : "氯乙烯作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-16",
      "display" : "苯作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-17",
      "display" : "2,4-二異氰酸甲苯作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-18",
      "display" : "石綿作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-19",
      "display" : "砷及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-20",
      "display" : "錳及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-21",
      "display" : "黃磷作業",
      "target" : [{
        "code" : "yellow-phosphorus",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-22",
      "display" : "聯吡啶或巴拉刈作業",
      "target" : [{
        "code" : "paraquat",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-23",
      "display" : "粉塵作業",
      "target" : [{
        "code" : "dust",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-24",
      "display" : "鉻酸及其鹽類作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-25",
      "display" : "鎘及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-26",
      "display" : "鎳及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-27",
      "display" : "乙基汞化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-28",
      "display" : "溴丙烷作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-29",
      "display" : "1,3-丁二烯作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-30",
      "display" : "甲醛作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-31",
      "display" : "銦及其化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-32",
      "display" : "汞及其無機化合物作業",
      "target" : [{
        "code" : "specific-chemical",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-33",
      "display" : "苯乙烯作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-34",
      "display" : "甲苯作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    },
    {
      "code" : "app-35",
      "display" : "二甲苯作業",
      "target" : [{
        "code" : "organic-solvent",
        "equivalence" : "narrower",
        "comment" : "具名作業為該危害家族之特定成員，家族涵蓋範圍較廣（narrower：source 較 target 窄）。"
      }]
    }]
  }]
}

```
