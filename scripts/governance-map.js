'use strict';
// ============================================================================
// 權責標籤與合規層級之對照表（JOB-30 步驟 4）
// ============================================================================
//
// 本檔是**人工審定之登記表**，不是推導結果。scripts/check-governance-tags.js
// 依本表核對 FSH 之 Description 標籤與 standards-status，兩者不符即失敗。
//
// ⚠️ 標籤陳述的是**內容依據**與**誰有權決定**，
//    **不是**任何機關已審閱、採認或背書該 artifact（JOB-30 §3.2(2)、風險表第 3 列）。
//
//   hpa  → 【主管機關：國民健康署】
//          內容依據為國民健康署之健檢上傳欄位規範或該署表單
//          （含 Core 最小共通上傳集與成人預防保健相關表單）。欄位範圍待 M-5 公告。
//   reg  → 【依據：勞工健康保護規則附表】
//          項目取自《勞工健康保護規則》附表八～附表十二。
//          ⚠️ 該規則之主管機關為勞動部職業安全衛生署，**惟本指引未受其委任或授權**
//             （JOB-30 §3.1 範疇聲明）。故本標籤寫「依據」，**不得**寫成治理或主管機關。
//   tech → 【技術規格】
//          本團隊之技術決定（資源結構、切片、封包、對照），無外部內容依據。
//
// 合規層級（level）與標籤是**兩個軸**，不可互相推導：
//   1 → Level 1｜Core 上傳合規（16 主項／21 列之 Profile 與值集 ＋ 上傳封包結構）
//   2 → Level 2｜勞工健檢涵蓋
//   0 → 不屬任一合規層級之共用技術結構（兩層皆會用到，但本身不構成合規標的）
//
// standards-status（v0.6.0 起，依 PI 裁示）：
//   level 1 → `trial-use`（＋ 資源 status 維持 active）
//   level 2 → `draft`     （＋ 資源 status **必須併同為 draft**，見下）
//   level 0 → 不標         （共用技術結構，不構成合規標的）
//
// ⚠️ **standards-status = draft 必須與資源自身之 `status = draft` 併同設定。**
//    IG Publisher 會交叉檢查兩者（`draft` ↔ `status = draft`；
//    `trial-use`／`normative` ↔ `status = active`），不一致即發出
//    「The resource status and the standards status are not consistent」。
//
//    v0.5.0 曾單標 standards-status 而未動 status，CI 實測**命中 71 個 artifact**
//    （PR #29 run 32388655444）——每一個被標 draft 者都自相矛盾。當時因該修正屬
//    **已發佈中繼資料之規範性變更**而未逕行為之，改為「Level 2 不標」並登記待裁示。
//
//    PI 已於 2026-08-20 裁示：**勞工區塊要機器可讀地標 draft**。故 v0.6.0 起，
//    Level 2 之 artifact 於 FSH 同時設定 `^status = #draft` 與 standards-status `#draft`，
//    由 check-governance-tags.js 之 G-3 逐件強制兩者一致（缺一即失敗）。
//
// 例：TWHA-Bundle-Transaction 之內容依據是技術決定（tag = tech），
//     但它是 Level 1 之上傳封包結構（level = 1）——這正是兩軸不可互推之實例。

const TAGS = {
  hpa: '【主管機關：國民健康署】',
  reg: '【依據：勞工健康保護規則附表】',
  tech: '【技術規格】',
};

// id -> [tag, level]
const MAP = {
  // ── Core 最小共通上傳集（Level 1）────────────────────────────────
  'VS-CoreUploadSet': ['hpa', 1],
  'VS-CoreDataset': ['hpa', 1],
  'VS-TWHAVitalSigns': ['hpa', 1],
  'TWHA-LabResult-General': ['hpa', 1],
  'TWHA-VitalSigns': ['hpa', 1],
  'TWHA-SocialHistory-Smoking': ['hpa', 1],
  'TWHA-SocialHistory-BetelNut': ['hpa', 1],
  'CS-SmokingStatus': ['hpa', 1],
  'VS-SmokingStatus': ['hpa', 1],
  'CS-BetelNutStatus': ['hpa', 1],
  'VS-BetelNutStatus': ['hpa', 1],
  'CS-BetelNutComponent': ['hpa', 1],
  'CS-BetelNutAdditive': ['hpa', 1],
  'VS-BetelNutAdditive': ['hpa', 1],
  'CS-BetelNutLime': ['hpa', 1],
  'VS-BetelNutLime': ['hpa', 1],
  'CS-BetelNutInfoSource': ['hpa', 1],
  'VS-BetelNutInfoSource': ['hpa', 1],
  'CS-BetelNutHpaCategory': ['hpa', 1],
  'VS-BetelNutHpaCategory': ['hpa', 1],
  'VS-TimeUnitYearMonth': ['hpa', 1],
  'ext-smoking-quantity': ['hpa', 1],
  'ext-cessation-duration': ['hpa', 1],
  // 上傳封包結構屬 Level 1，惟其內容為技術決定（M-9 之語意由平台端定）。
  'TWHA-Bundle-Transaction': ['tech', 1],

  // 成人預防保健為國健署業務，惟不在 Core 21 列之內，故 level 0。
  'TWHA-QuestionnaireResponse-HT': ['hpa', 0],

  // ── 勞工健檢涵蓋（Level 2）──────────────────────────────────────
  'VS-Appendix9-RequiredSet': ['reg', 2],
  'VS-Appendix10-RequiredSet': ['reg', 2],
  'VS-Appendix10-Noise-RequiredSet': ['reg', 2],
  'VS-Appendix10-Lead-RequiredSet': ['reg', 2],
  'VS-Appendix10-Dust-RequiredSet': ['reg', 2],
  'VS-Appendix10-OrganicSolvent-RequiredSet': ['reg', 2],
  'CS-Appendix10Operation': ['reg', 2],
  'VS-Appendix10-Operation': ['reg', 2],
  'VS-OccHealthCheck-Required': ['reg', 2],
  'VS-UnfitDiseases': ['reg', 2],
  'CS-HazardType': ['reg', 2],
  'VS-HazardType': ['reg', 2],
  'CS-OrganicSolventType': ['reg', 2],
  'VS-OrganicSolventType': ['reg', 2],
  'CS-SpecificChemicalType': ['reg', 2],
  'VS-SpecificChemicalType': ['reg', 2],
  'CS-PhysicalExamSystems': ['reg', 2],
  'VS-PhysicalExamSystems': ['reg', 2],
  'VS-PulmonaryFunction': ['reg', 2],
  'CS-HealthMgmtLevel': ['reg', 2],
  'VS-HealthMgmtLevel': ['reg', 2],
  'CS-FitnessForWork': ['reg', 2],
  'VS-FitnessForWork': ['reg', 2],
  'CS-LaborReportCode': ['reg', 2],
  'VS-LaborReportCode': ['reg', 2],
  'CS-ServiceActivityType': ['reg', 2],
  'VS-ServiceActivityType': ['reg', 2],
  'TWHA-HealthManagementLevel': ['reg', 2],
  'TWHA-ClinicalImpression': ['reg', 2],
  'TWHA-WorkExposure': ['reg', 2],
  'TWHA-Occupation': ['reg', 2],
  'TWHA-PhysicalExam': ['reg', 2],
  'TWHA-LabResult-Special': ['reg', 2],
  'TWHA-HearingTest': ['reg', 2],
  'TWHA-VisionTest': ['reg', 2],
  'TWHA-PulmonaryFunction': ['reg', 2],
  'TWHA-ECG': ['reg', 2],
  'TWHA-CarePlan': ['reg', 2],
  'TWHA-Composition-ServiceRecord': ['reg', 2],
  'TWHA-Composition-EmployerSummary': ['reg', 2],
  'TWHA-Procedure-ServiceActivity': ['reg', 2],
  'TWHA-Observation-ServiceFinding': ['reg', 2],
  'TWHA-Task-ServiceTask': ['reg', 2],
  'TWHA-Encounter-Service': ['reg', 2],
  'ext-fitness-for-work': ['reg', 2],
  'ext-hazard-type': ['reg', 2],
  'ext-health-mgmt-level': ['reg', 2],
  'ext-labor-report-code': ['reg', 2],
  'ext-exam-interval': ['reg', 2],
  'ext-employment-date': ['reg', 2],

  // ── 共用技術結構（不屬任一合規層級）────────────────────────────
  'TWHA-Bundle-Document': ['tech', 0],
  'TWHA-Composition': ['tech', 0],
  'TWHA-Composition-EmergencySummary': ['tech', 0],
  'TWHA-Condition': ['tech', 0],
  'TWHA-DiagnosticReport': ['tech', 0],
  'TWHA-Encounter': ['tech', 0],
  'TWHA-ImagingStudy': ['tech', 0],
  'TWHA-Organization-Employer': ['tech', 0],
  'TWHA-Organization-Facility': ['tech', 0],
  'TWHA-Patient': ['tech', 0],
  'TWHA-Practitioner': ['tech', 0],
  'TWHA-Procedure-Counseling': ['tech', 0],
  'TWHA-Questionnaire': ['tech', 0],
  'TWHA-QuestionnaireResponse': ['tech', 0],
  'TWHA-SDOH-QuestionnaireResponse': ['tech', 0],
  'TWHA-ServiceRequest': ['tech', 0],
  'TWHA-SocialHistory-Alcohol': ['tech', 0],
  'TWHA-SocialHistory-Sleep': ['tech', 0],
  'VS-ExtendedDataset': ['tech', 0],
  'CS-ExamType': ['tech', 0],
  'VS-ExamType': ['tech', 0],
  'CS-HealthCounseling': ['tech', 0],
  'VS-HealthCounseling': ['tech', 0],
  'ext-department': ['tech', 0],
  'ext-employer-info': ['tech', 0],
  'ext-exam-type': ['tech', 0],
};

const STANDARDS_STATUS_URL =
  'http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status';

// 回傳 null 代表「不得標 standards-status」（level 0 之共用技術結構）。
const statusOf = (level) => (level === 1 ? 'trial-use' : level === 2 ? 'draft' : null);

// standards-status 為 draft 者，資源自身之 status 必須也是 draft（IG Publisher 交叉檢查）。
// 回傳 null 代表「不要求特定 status」（即沿用 sushi-config 之 active）。
const resourceStatusOf = (level) => (statusOf(level) === 'draft' ? 'draft' : null);

module.exports = { TAGS, MAP, STANDARDS_STATUS_URL, statusOf, resourceStatusOf };
