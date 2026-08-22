# 資料模型 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.1

## 資料模型

# 資料模型與 Resource 映射 (Data Model & Mapping)

本章節提供健康檢查資料交換（包含一般健康檢查、勞工健康檢查及成人預防保健）各欄位對應至 FHIR 資源（Resources）與 Profiles 的總體視圖。

-------

## 1. 資料模型關係圖

本指引以**勞工健康檢查為核心**，並向特殊職類與一般健檢／預防保健兩個方向擴充。以 `TWHA-Bundle` (type=document) 與 `TWHA-Composition` 為核心封裝文件：

```
classDiagram
    class Bundle {
        +type = document
        +timestamp
    }
    class Composition {
        +status = final
        +type = 11502-2 (LOINC)
        +title : "健康檢查報告之對應名稱"
    }
    class Patient {
        +name: 受檢者姓名
        +employerInfo: 雇主公司 (非必要)
    }
    class Encounter {
        +examType: 健檢類型 (一般/勞工/特殊/成人預防)
    }
    class Observation_VitalSigns {
        +Height, Weight, BMI, Waist, BP
    }
    class Observation_Lab {
        +Glucose, Cholesterol, TG, eGFR
    }
    class QuestionnaireResponse_HT {
        +習慣與家屬史自填 (成人預防保健)
    }
    class ClinicalImpression {
        +healthMgmtLevel: 健康分級 (1-4級)
    }

    Bundle *-- Composition : Contains
    Composition --> Patient : subject
    Composition --> Encounter : encounter
    Composition --> Observation_VitalSigns : section.entry
    Composition --> Observation_Lab : section.entry
    Composition --> QuestionnaireResponse_HT : section.entry (成人預防保健)
    Composition --> ClinicalImpression : section.entry (總評)

```

-------

## 2. Core（主管機關最小共通上傳集）欄位映射

**Core 定義（文件一/二 v3.2）**：Core ＝ 主管機關（國健署）制定之**最小共通上傳集**（「勞工/公教健檢上傳欄位原案」16 主項／21 列），對標 USCDI（regulator-defined minimum）；其餘項目一律歸 **Extended**，以維持 Core minimal。

> ⚠️ **Core 之來源與效力（M-5）**：本 Core 係依據國健署上傳欄位之**工作原案**建立，**正式公告版本尚待確認**，得依主管機關正式公告調整。⚠️ **Core ≠ 附表九 ≠ 完整法定檢查集**：Core 為「最小交換集」，非任一法定情境之完整需求。 **不在 Core 者並非不重要，亦非不需 Must Support**——例如附表九法定必驗之 CBC、ALT 等雖歸 Extended， 仍為法規要求執行之項目。三個層次之區辨見[首頁](index.md)之說明。

Core 21 列橫跨三種資料型別，分屬**三個綁定值集**，不集中於單一值集（避免 `LabResult-General.code` 綁到身高等生理量測碼造成語意錯誤）：

| | | |
| :--- | :--- | :--- |
| 檢驗子集（10 項） | [VS-CoreDataset](ValueSet-VS-CoreDataset.md)（`TWHA-LabResult-General.code`，extensible） | 總膽固醇、飯前血糖、TG、HDL、LDL、肌酸酐、尿蛋白定量/定性、B肝、C肝 |
| 生理量測 | [VS-TWHAVitalSigns](ValueSet-VS-TWHAVitalSigns.md)（`TWHA-VitalSigns`／`TWCoreBloodPressure`） | 身高、體重、腰圍、血壓 |
| 社會史 | SocialHistory profiles | 吸菸狀態/量/戒菸月數、嚼檳狀態 |

**Core 全集（21 列）以群組值集 [VS-CoreUploadSet](ValueSet-VS-CoreUploadSet.md) 具體化**（組合上述三者），僅供文件與完整度／覆蓋矩陣參照，不作 Observation.code 綁定。以下為各子集之對應 FHIR 資源及 Profiles：

| | | | |
| :--- | :--- | :--- | :--- |
| **Social History**(生活習慣) | 吸菸狀態 | `TWHASocialHistorySmokingProfile` | LOINC`72166-2`(Tobacco smoking status) |
|   | 飲酒習慣 | `TWHASocialHistoryAlcoholProfile` | LOINC`11331-6`(History of Alcohol use) |
|   | 嚼檳榔習慣 | `TWHASocialHistoryBetelNutProfile` | `CS-BetelNutObservable#betel-quid-chewing-status`「嚼檳榔狀態」（問題碼，v0.9.0 起；原為 SNOMED`698188003`）；狀態值`VS-BetelNutStatus`，量／年數／戒除期間為 UCUM`Quantity`（[§6.2b](terminology.md)） |
|   | 睡眠時間 | `TWHASocialHistorySleepProfile` | LOINC`93832-4`(Sleep duration) |
| **Vital Signs**(生理量測) | 身高 / 體重 | `TWHAVitalSignsProfile` | LOINC`8302-2`(Height), LOINC`29463-7`(Weight) |
|   | 舒張壓 / 收縮壓 | `TWCoreBloodPressure` | LOINC`85354-9`(BP panel) |
|   | 腰圍 | `TWHAVitalSignsProfile` | LOINC`8280-0`(Waist Circumference at umbilicus by Tape measure)；`56086-2`為 PhenX protocol 碼，不列入值集，經 ConceptMap 歸一 |
| **Laboratory**(實驗室檢驗) | 空腹血糖 | `TWHALabResultGeneralProfile` | LOINC`1558-6`(Fasting Glucose) |
|   | 總膽固醇 / 三酸甘油酯 | `TWHALabResultGeneralProfile` | LOINC`2093-3`(TC), LOINC`2571-8`(TG) |
|   | HDL-C / LDL-C | `TWHALabResultGeneralProfile` | LOINC`2085-9`(HDL-C), LOINC`2089-1`(LDL-C, Preferred：方法通用碼) |
|   | 尿蛋白定性 | `TWHALabResultGeneralProfile` | LOINC`5804-0`(Urine Protein) |
| **Screening**(篩檢與生理功能) | 視力及辨色力 | `TWHAVisionTestProfile` | LOINC`98497-1`(Visual acuity panel) |
|   | 聽力篩檢 | `TWHAHearingTestProfile` | LOINC`89015-2`(Pure tone air conduction threshold audiometry panel) |

-------

## 3. 擴充（Extensions）欄位映射

本指引以不修改 Core 為前提，向兩個方向擴充：**特殊職類**（附表十危害作業，開放式擴充，新增職類僅需新增值集／Profile）與**一般健檢／預防保健**（重用 Core 之共通臨床項目）。

### 3.1 特殊職類擴充：勞工特殊健康檢查 (Special Occupational Health Check)

* **作業經歷與現職暴露**：使用 `TWHAOccupationProfile` 記錄職業別；使用 `TWHAWorkExposure` 記錄特別危害作業暴露年數。
* **理學檢查**：使用 `TWHAPhysicalExamProfile` 記錄頭頸部、呼吸、心血管等七大系統醫師判定。
* **特殊健檢指標**：使用 `TWHAPulmonaryFunctionProfile` 記錄肺功能檢驗值（FVC, FEV1）；使用 `TWHAECGProfile` 記錄心電圖；使用 `TWHALabResultSpecialProfile` 記錄血中鉛等特殊檢驗（依 `CS-HazardType` 危害作業分類，附表十 35 項法定作業（歸併 12 家族）之完整涵蓋度對照見[特殊危害健康作業](special-exam.md)）。
* **自覺症狀**：使用 `TWHAQuestionnaireResponseProfile` 記錄附表十一所規定之勞工自覺症狀問卷。
* **健康管理與配工**：使用 `TWHAClinicalImpressionProfile` 記錄醫師總評與 1-4 級分級；使用 `TWHACarePlanProfile` 與 `TWHAServiceRequestProfile` 記錄適性配工計畫與追蹤檢查開立。

### 3.2 一般健檢／預防保健擴充：成人預防保健 (Adult Preventive Care)

* **個人與家族生活史自填問卷**：使用 `TWHAQuestionnaireResponseHTProfile` 記錄受檢者自填的吸菸、飲酒、嚼檳、規律運動、慢性病既往史（高血壓、糖尿病、高血脂、心血管疾病）與直系親屬家族史。
* **SDOH 社會風險評估**：使用 `TWHASDOHQuestionnaireResponseProfile` (PRAPARE 問卷) 記錄受檢者之社會決定因素（如教育、就業、住房安全與財務狀況）。
* **實驗室功能指標**：除基礎項目外，特別包含 **腎絲球過濾率 (eGFR)** 評估慢性腎臟病風險。

