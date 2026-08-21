# 適性配工計畫範例 - 第四級管理之工作調整 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

## 範例 CarePlan: 適性配工計畫範例 - 第四級管理之工作調整

依115年6月12日噪音作業特殊健康檢查結果，勞工王大同經判定為第四級健康管理。經職業醫學科醫師與事業單位協商，自115年7月1日起調整如下：

* 變更工作場所：自化學處理課調整至噪音暴露低於85分貝之區域。
* 縮短工作時間：每日噪音作業時間不超過4小時。

三個月後複檢並重新評估分級。



## Resource Content

```json
{
  "resourceType" : "CarePlan",
  "id" : "example-careplan-fitness",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork",
        "code" : "change-workplace",
        "display" : "變更工作場所"
      }]
    }
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork",
        "code" : "reduce-hours",
        "display" : "縮短工作時間"
      }]
    }
  }],
  "status" : "active",
  "intent" : "plan",
  "category" : [{
    "coding" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/careplan-category-tw",
      "code" : "assess-plan"
    }]
  }],
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "period" : {
    "start" : "2026-07-01",
    "end" : "2026-10-01"
  }
}

```
