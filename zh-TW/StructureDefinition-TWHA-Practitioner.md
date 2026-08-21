# 執業/健檢醫護與服務人員 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

## 資源 Profile: 執業/健檢醫護與服務人員 Profile 

 
【技術規格】本 Profile 用於描述實施勞工體格檢查、健康檢查或臨場健康服務之醫師、護理人員、職安人員等，繼承自 TW Core Practitioner。 

**Usages:**

* Refer to this Profile: [健康檢查健檢醫師總評與分級 Profile](StructureDefinition-TWHA-ClinicalImpression.md), [職業健康急診友善摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmergencySummary.md), [雇主端健康管理摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmployerSummary.md), [健康檢查健康服務執行紀錄組成結構 Profile](StructureDefinition-TWHA-Composition-ServiceRecord.md)... Show 18 more, [健康檢查健檢報告組成結構 Profile](StructureDefinition-TWHA-Composition.md), [健康檢查健檢診斷報告 Profile](StructureDefinition-TWHA-DiagnosticReport.md), [心電圖檢查 Profile](StructureDefinition-TWHA-ECG.md), [臨場健康服務事件 Profile](StructureDefinition-TWHA-Encounter-Service.md), [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md), [聽力檢查 Profile](StructureDefinition-TWHA-HearingTest.md), [身體理學檢查 Profile](StructureDefinition-TWHA-PhysicalExam.md), [肺功能檢查 Profile](StructureDefinition-TWHA-PulmonaryFunction.md), [成人預防保健問卷回覆 Profile](StructureDefinition-TWHA-QuestionnaireResponse-HT.md), [自覺症狀問卷回覆 Profile](StructureDefinition-TWHA-QuestionnaireResponse.md), [社會決定因素 (SDOH) 問卷回覆 Profile](StructureDefinition-TWHA-SDOH-QuestionnaireResponse.md), [健康檢查健檢追蹤檢查要求 Profile](StructureDefinition-TWHA-ServiceRequest.md), [飲酒歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Alcohol.md), [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md), [睡眠狀況 Profile](StructureDefinition-TWHA-SocialHistory-Sleep.md), [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md), [臨場健康服務建議與改善任務 Profile](StructureDefinition-TWHA-Task-ServiceTask.md) and [視力與辨色力檢查 Profile](StructureDefinition-TWHA-VisionTest.md)
* Examples for this Profile: [Practitioner/example-doctor](Practitioner-example-doctor.md) and [Practitioner/example-nurse](Practitioner-example-nurse.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Practitioner.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Practitioner.csv), [Excel](../StructureDefinition-TWHA-Practitioner.xlsx), [Schematron](../StructureDefinition-TWHA-Practitioner.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Practitioner",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner",
  "version" : "0.8.1",
  "name" : "TWHAPractitionerProfile",
  "title" : "執業/健檢醫護與服務人員 Profile",
  "status" : "active",
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
  "description" : "【技術規格】本 Profile 用於描述實施勞工體格檢查、健康檢查或臨場健康服務之醫師、護理人員、職安人員等，繼承自 TW Core Practitioner。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Practitioner",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Practitioner-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Practitioner",
      "path" : "Practitioner"
    }]
  }
}

```
