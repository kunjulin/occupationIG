# 受檢者 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.0

## 資源 Profile: 受檢者 Profile 

 
【技術規格】本 Profile 用於描述接受健康檢查（含一般健檢、勞工健檢與成人預防保健）之受檢者，繼承自 TW Core Patient，並可選擴充記錄其所屬事業單位、受僱日期與所屬部門。 

**Usages:**

* Refer to this Profile: [健康檢查適性配工計畫 Profile](StructureDefinition-TWHA-CarePlan.md), [健康檢查健檢醫師總評與分級 Profile](StructureDefinition-TWHA-ClinicalImpression.md), [職業健康急診友善摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmergencySummary.md), [雇主端健康管理摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmployerSummary.md)... Show 27 more, [健康檢查健檢報告組成結構 Profile](StructureDefinition-TWHA-Composition.md), [健康檢查既往病史與不適作業疾病 Profile](StructureDefinition-TWHA-Condition.md), [健康檢查健檢診斷報告 Profile](StructureDefinition-TWHA-DiagnosticReport.md), [心電圖檢查 Profile](StructureDefinition-TWHA-ECG.md), [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md), [健康檢查健康管理分級 Observation Profile](StructureDefinition-TWHA-HealthManagementLevel.md), [聽力檢查 Profile](StructureDefinition-TWHA-HearingTest.md), [健康檢查健檢影像檢查 Profile](StructureDefinition-TWHA-ImagingStudy.md), [一般健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-General.md), [特殊健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-Special.md), [臨場健康服務發現問題/風險 Profile](StructureDefinition-TWHA-Observation-ServiceFinding.md), [健康檢查工作經歷與職業別 Profile](StructureDefinition-TWHA-Occupation.md), [身體理學檢查 Profile](StructureDefinition-TWHA-PhysicalExam.md), [健康諮詢與衛教指導 Profile](StructureDefinition-TWHA-Procedure-Counseling.md), [臨場服務執行活動項目 Profile](StructureDefinition-TWHA-Procedure-ServiceActivity.md), [肺功能檢查 Profile](StructureDefinition-TWHA-PulmonaryFunction.md), [成人預防保健問卷回覆 Profile](StructureDefinition-TWHA-QuestionnaireResponse-HT.md), [自覺症狀問卷回覆 Profile](StructureDefinition-TWHA-QuestionnaireResponse.md), [社會決定因素 (SDOH) 問卷回覆 Profile](StructureDefinition-TWHA-SDOH-QuestionnaireResponse.md), [健康檢查健檢追蹤檢查要求 Profile](StructureDefinition-TWHA-ServiceRequest.md), [飲酒歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Alcohol.md), [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md), [睡眠狀況 Profile](StructureDefinition-TWHA-SocialHistory-Sleep.md), [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md), [視力與辨色力檢查 Profile](StructureDefinition-TWHA-VisionTest.md), [職業健檢生命徵象 Profile](StructureDefinition-TWHA-VitalSigns.md) and [特別危害健康作業危害因子暴露史 Profile](StructureDefinition-TWHA-WorkExposure.md)
* Examples for this Profile: [Patient/example-worker](Patient-example-worker.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Patient.json)

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

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employment-date](StructureDefinition-ext-employment-date.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department](StructureDefinition-ext-department.md)

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

**Extensions**

This structure refers to these extensions:

* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info](StructureDefinition-ext-employer-info.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employment-date](StructureDefinition-ext-employment-date.md)
* [https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department](StructureDefinition-ext-department.md)

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-Patient.csv), [Excel](../StructureDefinition-TWHA-Patient.xlsx), [Schematron](../StructureDefinition-TWHA-Patient.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Patient",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient",
  "version" : "0.7.0",
  "name" : "TWHAPatientProfile",
  "title" : "受檢者 Profile",
  "status" : "active",
  "date" : "2026-08-21T00:59:40+00:00",
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
  "description" : "【技術規格】本 Profile 用於描述接受健康檢查（含一般健檢、勞工健檢與成人預防保健）之受檢者，繼承自 TW Core Patient，並可選擴充記錄其所屬事業單位、受僱日期與所屬部門。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "loinc",
    "uri" : "http://loinc.org",
    "name" : "LOINC code for the element"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Patient",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Patient-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Patient",
      "path" : "Patient"
    },
    {
      "id" : "Patient.extension:employerInfo",
      "path" : "Patient.extension",
      "sliceName" : "employerInfo",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info"]
      }]
    },
    {
      "id" : "Patient.extension:employmentDate",
      "path" : "Patient.extension",
      "sliceName" : "employmentDate",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employment-date"]
      }]
    },
    {
      "id" : "Patient.extension:department",
      "path" : "Patient.extension",
      "sliceName" : "department",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department"]
      }]
    }]
  }
}

```
