# Profiles 與 Extensions - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.1

## Profiles 與 Extensions

# Profiles 與 Extensions

本頁為**導覽用策展頁**，依 FHIR resource 分類列出本指引所定義之 **41 個 Profile** 與 **11 個 Extension**，供實作者依資源類型快速定位。

> **權威清單見[資源總覽 (artifacts.html)](artifacts.md)。** 本頁僅提供分類、用途摘要與入口，不重複資源之完整技術定義； 若兩處有出入，一律以資源總覽及各 StructureDefinition 頁面為準。

-------

## 0. 如何使用本頁

* **「繼承自」欄**標示本 Profile 之直接父規範。標示為 TW Core 者，代表本指引未修改核心、僅加掛職業健康所需之約束與擴充；標示為 FHIR R4 基底者，代表 TW Core 尚無對應 Profile。
* **本頁不區分 Core 與 Extended**——該區辨屬於「資料集」層次而非「資源」層次，見[首頁 §3 三個不同層次的『資料集』概念](index.md)。
* 各 Profile 之範例見[範例 (Examples)](examples.md)；值集與代碼系統見[術語與代碼系統](terminology.md)。

-------

## 1. Resources 之 Profiles

### 1.1 Bundle（2）

交換封包。`Document` 用於報告交換（UC-001～UC-007），`Transaction` 用於向主管機關平台上傳（UC-008／UC-009）。

| | | |
| :--- | :--- | :--- |
| [TWHA-Bundle-Document](StructureDefinition-TWHA-Bundle-Document.md) | FHIR R4 基底（`Bundle`） | 健康檢查報告交換封包 (Document Bundle) |
| [TWHA-Bundle-Transaction](StructureDefinition-TWHA-Bundle-Transaction.md) | FHIR R4 基底（`Bundle`） | 健康檢查資料上傳封包 (Transaction Bundle) |

### 1.2 CarePlan（1）

適性配工計畫。承載健康管理分級後之工作調整建議。

| | | |
| :--- | :--- | :--- |
| [TWHA-CarePlan](StructureDefinition-TWHA-CarePlan.md) | TW Core（`TWCoreCarePlan`） | 健康檢查適性配工計畫 |

### 1.3 ClinicalImpression（1）

健檢醫師之整體總評與分級判定過程。

| | | |
| :--- | :--- | :--- |
| [TWHA-ClinicalImpression](StructureDefinition-TWHA-ClinicalImpression.md) | FHIR R4 基底（`ClinicalImpression`） | 健康檢查健檢醫師總評與分級 |

### 1.4 Composition（4）

各類報告／摘要之文件骨架，決定 Document Bundle 之章節結構。四者揭露範圍不同，**雇主端摘要不含任何檢驗數值**。

| | | |
| :--- | :--- | :--- |
| [TWHA-Composition](StructureDefinition-TWHA-Composition.md) | TW Core（`TWCoreComposition`） | 健康檢查健檢報告組成結構 |
| [TWHA-Composition-EmergencySummary](StructureDefinition-TWHA-Composition-EmergencySummary.md) | TW Core（`TWCoreComposition`） | 職業健康急診友善摘要 Composition |
| [TWHA-Composition-EmployerSummary](StructureDefinition-TWHA-Composition-EmployerSummary.md) | TW Core（`TWCoreComposition`） | 雇主端健康管理摘要 Composition |
| [TWHA-Composition-ServiceRecord](StructureDefinition-TWHA-Composition-ServiceRecord.md) | FHIR R4 基底（`Composition`） | 健康檢查健康服務執行紀錄組成結構 |

### 1.5 Condition（1）

既往病史，以及《勞工健康保護規則》所稱不適從事該作業之疾病。

| | | |
| :--- | :--- | :--- |
| [TWHA-Condition](StructureDefinition-TWHA-Condition.md) | TW Core（`TWCoreCondition`） | 健康檢查既往病史與不適作業疾病 |

### 1.6 DiagnosticReport（1）

彙整單次健檢各項結果之診斷報告。

| | | |
| :--- | :--- | :--- |
| [TWHA-DiagnosticReport](StructureDefinition-TWHA-DiagnosticReport.md) | TW Core（`TWCoreDiagnosticReport`） | 健康檢查健檢診斷報告 |

### 1.7 Encounter（2）

就醫／服務事件。一般與特殊健檢共用 `TWHA-Encounter`，臨場服務另立 `TWHA-Encounter-Service`。

| | | |
| :--- | :--- | :--- |
| [TWHA-Encounter](StructureDefinition-TWHA-Encounter.md) | TW Core（`TWCoreEncounter`） | 健康檢查健檢就醫事件 |
| [TWHA-Encounter-Service](StructureDefinition-TWHA-Encounter-Service.md) | TW Core（`TWCoreEncounter`） | 臨場健康服務事件 |

### 1.8 ImagingStudy（1）

健檢影像檢查之 DICOM 層級中繼資料（如胸部 X 光）。

| | | |
| :--- | :--- | :--- |
| [TWHA-ImagingStudy](StructureDefinition-TWHA-ImagingStudy.md) | TW Core（`TWCoreImagingStudy`） | 健康檢查健檢影像檢查 |

### 1.9 Observation（16）

本指引之主要資料承載者，佔全部 Profile 之 39%。以下依檢查性質再分五組。

#### 生命徵象與理學檢查

| | | |
| :--- | :--- | :--- |
| [TWHA-VitalSigns](StructureDefinition-TWHA-VitalSigns.md) | TW Core（`TWCoreVitalSigns`） | 職業健檢生命徵象 |
| [TWHA-PhysicalExam](StructureDefinition-TWHA-PhysicalExam.md) | TW Core（`TWCoreClinicalResult`） | 身體理學檢查 |

#### 生理功能檢查

| | | |
| :--- | :--- | :--- |
| [TWHA-HearingTest](StructureDefinition-TWHA-HearingTest.md) | TW Core（`TWCoreClinicalResult`） | 聽力檢查 |
| [TWHA-VisionTest](StructureDefinition-TWHA-VisionTest.md) | TW Core（`TWCoreClinicalResult`） | 視力與辨色力檢查 |
| [TWHA-PulmonaryFunction](StructureDefinition-TWHA-PulmonaryFunction.md) | TW Core（`TWCoreClinicalResult`） | 肺功能檢查 |
| [TWHA-ECG](StructureDefinition-TWHA-ECG.md) | TW Core（`TWCoreECG`） | 心電圖檢查 |

#### 實驗室檢驗

| | | |
| :--- | :--- | :--- |
| [TWHA-LabResult-General](StructureDefinition-TWHA-LabResult-General.md) | TW Core（`TWCoreLabResult`） | 一般健檢實驗室檢驗 |
| [TWHA-LabResult-Special](StructureDefinition-TWHA-LabResult-Special.md) | TW Core（`TWCoreLabResult`） | 特殊健檢實驗室檢驗 |

#### 生活習慣 (Social History)

| | | |
| :--- | :--- | :--- |
| [TWHA-SocialHistory-Smoking](StructureDefinition-TWHA-SocialHistory-Smoking.md) | TW Core（`TWCoreSmokingStatus`） | 吸菸歷史與狀態 |
| [TWHA-SocialHistory-BetelNut](StructureDefinition-TWHA-SocialHistory-BetelNut.md) | FHIR R4 基底（`Observation`） | 嚼檳榔歷史與狀態 |
| [TWHA-SocialHistory-Alcohol](StructureDefinition-TWHA-SocialHistory-Alcohol.md) | FHIR R4 基底（`Observation`） | 飲酒歷史與狀態 |
| [TWHA-SocialHistory-Sleep](StructureDefinition-TWHA-SocialHistory-Sleep.md) | FHIR R4 基底（`Observation`） | 睡眠狀況 |

#### 職業暴露、健康管理與臨場服務

| | | |
| :--- | :--- | :--- |
| [TWHA-Occupation](StructureDefinition-TWHA-Occupation.md) | TW Core（`TWCoreOccupation`） | 健康檢查工作經歷與職業別 |
| [TWHA-WorkExposure](StructureDefinition-TWHA-WorkExposure.md) | FHIR R4 基底（`Observation`） | 特別危害健康作業危害因子暴露史 |
| [TWHA-HealthManagementLevel](StructureDefinition-TWHA-HealthManagementLevel.md) | FHIR R4 基底（`Observation`） | 健康檢查健康管理分級 Observation |
| [TWHA-Observation-ServiceFinding](StructureDefinition-TWHA-Observation-ServiceFinding.md) | FHIR R4 基底（`Observation`） | 臨場健康服務發現問題/風險 |

### 1.10 Organization（2）

事業單位（雇主）與實施健檢之醫療機構，二者角色不同故分立。

| | | |
| :--- | :--- | :--- |
| [TWHA-Organization-Employer](StructureDefinition-TWHA-Organization-Employer.md) | TW Core（`TWCoreOrganizationCo`） | 健康檢查所屬事業單位（雇主公司） |
| [TWHA-Organization-Facility](StructureDefinition-TWHA-Organization-Facility.md) | TW Core（`TWCoreOrganizationHosp`） | 實施健康檢查之醫療機構 |

### 1.11 Patient（1）

受檢勞工。含部門、受僱日期、所屬事業單位等職業健康所需之擴充。

| | | |
| :--- | :--- | :--- |
| [TWHA-Patient](StructureDefinition-TWHA-Patient.md) | TW Core（`TWCorePatient`） | 受檢者 |

### 1.12 Practitioner（1）

健檢醫師、護理師與臨場服務人員。

| | | |
| :--- | :--- | :--- |
| [TWHA-Practitioner](StructureDefinition-TWHA-Practitioner.md) | TW Core（`TWCorePractitioner`） | 執業/健檢醫護與服務人員 |

### 1.13 Procedure（2）

臨場服務之執行活動項目，以及健康諮詢與衛教指導。

| | | |
| :--- | :--- | :--- |
| [TWHA-Procedure-Counseling](StructureDefinition-TWHA-Procedure-Counseling.md) | TW Core（`TWCoreProcedure`） | 健康諮詢與衛教指導 |
| [TWHA-Procedure-ServiceActivity](StructureDefinition-TWHA-Procedure-ServiceActivity.md) | FHIR R4 基底（`Procedure`） | 臨場服務執行活動項目 |

### 1.14 Questionnaire（1）

自覺症狀問卷之結構定義（題目本身）。

| | | |
| :--- | :--- | :--- |
| [TWHA-Questionnaire](StructureDefinition-TWHA-Questionnaire.md) | FHIR R4 基底（`Questionnaire`） | 健康檢查自覺症狀問卷定義 |

### 1.15 QuestionnaireResponse（3）

問卷填答結果。分為自覺症狀、成人預防保健、SDOH 社會決定因素三種。

| | | |
| :--- | :--- | :--- |
| [TWHA-QuestionnaireResponse](StructureDefinition-TWHA-QuestionnaireResponse.md) | TW Core（`TWCoreQuestionnaireResponse`） | 自覺症狀問卷回覆 |
| [TWHA-QuestionnaireResponse-HT](StructureDefinition-TWHA-QuestionnaireResponse-HT.md) | TW Core（`TWCoreQuestionnaireResponse`） | 成人預防保健問卷回覆 |
| [TWHA-SDOH-QuestionnaireResponse](StructureDefinition-TWHA-SDOH-QuestionnaireResponse.md) | TW Core（`TWCoreQuestionnaireResponse`） | 社會決定因素 (SDOH) 問卷回覆 |

### 1.16 ServiceRequest（1）

健檢後之追蹤檢查要求（如三個月後聽力複檢）。

| | | |
| :--- | :--- | :--- |
| [TWHA-ServiceRequest](StructureDefinition-TWHA-ServiceRequest.md) | TW Core（`TWCoreServiceRequest`） | 健康檢查健檢追蹤檢查要求 |

### 1.17 Task（1）

臨場服務之改善建議與追蹤任務，承載雇主端應辦事項之狀態。

| | | |
| :--- | :--- | :--- |
| [TWHA-Task-ServiceTask](StructureDefinition-TWHA-Task-ServiceTask.md) | FHIR R4 基底（`Task`） | 臨場健康服務建議與改善任務 |

-------

## 2. Extensions

本指引定義 11 個 Extension。凡 TW Core 或 FHIR R4 已有對應元素者一律不另立擴充；下列為職業健康領域特有、核心規範未涵蓋之資訊。

### 2.1 事業單位與受僱關係

描述受檢勞工與其事業單位之關係。此組為職業健康檢查有別於一般健檢之根本差異——一般健檢無雇主角色。

| | |
| :--- | :--- |
| [ext-employer-info](StructureDefinition-ext-employer-info.md) | 關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件／活動所針對之事業單位 |
| [ext-department](StructureDefinition-ext-department.md) | 受檢勞工於事業單位中所屬之部門、課別或課室名稱 |
| [ext-employment-date](StructureDefinition-ext-employment-date.md) | 受檢勞工於事業單位之受僱日期 |

### 2.2 檢查作業屬性

標註該次檢查之法定性質。此組決定該筆資料應適用附表九（一般）或附表十（特殊）之哪一組項目。

| | |
| :--- | :--- |
| [ext-exam-type](StructureDefinition-ext-exam-type.md) | 標註 Encounter 屬一般體格、一般健康、特殊體格或特殊健康檢查 |
| [ext-hazard-type](StructureDefinition-ext-hazard-type.md) | 標註特殊體格／健康檢查所針對之危害作業種類 |
| [ext-exam-interval](StructureDefinition-ext-exam-interval.md) | 標註本次健康檢查之實施週期（如每年、每 3 年、每 5 年） |
| [ext-labor-report-code](StructureDefinition-ext-labor-report-code.md) | 標註結果通報至勞動部時所採用之報告大類代碼 |

### 2.3 生活習慣量化

承載生活習慣之數量與時序資訊。此類資訊在 FHIR 基底之 Social History Observation 僅能表達狀態（有／無／曾經），量化部分須以擴充承載。

| | |
| :--- | :--- |
| [ext-smoking-quantity](StructureDefinition-ext-smoking-quantity.md) | 每日吸菸支數與吸菸年數 |
| [ext-cessation-duration](StructureDefinition-ext-cessation-duration.md) | 已戒菸或已戒檳榔之月數 |

### 2.4 健康管理與適性配工

承載醫師判定結果及其後續處置。此組為《勞工健康保護規則》所定之法定產出。

| | |
| :--- | :--- |
| [ext-health-mgmt-level](StructureDefinition-ext-health-mgmt-level.md) | 醫師判定之健康管理分級（1–4 級） |
| [ext-fitness-for-work](StructureDefinition-ext-fitness-for-work.md) | CarePlan 中之具體適性配工或變更作業場所等建議項目 |

-------

## 3. 涵蓋度與相依

* 本指引所有 Profile 之相依關係、TW Core 版本釘定與全域規範，見[遵從性與依賴 (conformance.html)](conformance.md)。
* 各 Profile 之 Must Support 設定原則見[首頁 §4.2 資料治理原則](index.md)。
* 尚未定案之建模議題（含仍待主管機關確認者）見[未決事項 (open-issues.html)](open-issues.md)。

