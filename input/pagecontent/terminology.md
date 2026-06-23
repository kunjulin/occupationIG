# 術語與代碼系統 (Terminology & CodeSystems)

本指引在國際術語標準（LOINC, SNOMED CT, ICD-10-CM）與臺灣本地化行政代碼之間建立映射，以實現數據的高級互操作性。

## 1. 國際臨床術語遵循

*   **LOINC (Logical Observation Identifiers Names and Codes)**：
    - 用於所有一般檢驗、生理功能檢查（肺功能、心電圖、聽力測試）及生理測量（身高、體重、血壓）的 Observation.code 定義。
    - 本指引所使用的 LOINC 代碼集已彙整至 [VS-CoreDataset](ValueSet-VS-CoreDataset.html) 與 [VS-ExtendedDataset](ValueSet-VS-ExtendedDataset.html)。
*   **SNOMED CT (Systematized Nomenclature of Medicine - Clinical Terms)**：
    - 用於生活習慣（如嚼檳榔狀態 `698188003`）、臨場服務現場發現之職業危害（`278486003`）、改善建議諮詢（`315640000`）等臨床發現與程序代碼。
*   **ICD-10-CM (Clinical Modification)**：
    - 用於記錄勞工既往病史（`TWHA-Condition`）以及附表十二所列之不適合從事特定危害作業疾病。

---

## 2. 本地化行政代碼系統 (CodeSystems Defined in this IG)

為滿足臺灣職業安全衛生與健康服務之行政申報需求，本指引定義了以下代碼系統：

*   **[CS-ExamType](CodeSystem-CS-ExamType.html) (檢查類型代碼系統)**：
    - 定義 `general-physical` (一般體格)、`general-health` (一般健康)、`special-physical` (特殊體格) 與 `special-health` (特殊健康)。
*   **[CS-HazardType](CodeSystem-CS-HazardType.html) (危害作業類別代碼系統)**：
    - 定義高溫、噪音、輻射、異常氣壓、鉛、粉塵、有機溶劑、特定化學物質等 12 大類危害作業之代碼。
*   **[CS-SmokingStatus](CodeSystem-CS-SmokingStatus.html) (吸菸狀態代碼系統)**：
    - 定義從未、偶爾、每日與已戒之狀態。
*   **[CS-HealthMgmtLevel](CodeSystem-CS-HealthMgmtLevel.html) (健康管理分級代碼系統)**：
    - 定義第一級至第四級健康管理分級。
*   **[CS-FitnessForWork](CodeSystem-CS-FitnessForWork.html) (適性配工建議代碼系統)**：
    - 定義變更場所、換工作、縮短工時、醫療限制等工作調整項目。
*   **[CS-LaborReportCode](CodeSystem-CS-LaborReportCode.html) (勞動部通報報告代碼系統)**：
    - 定義通報勞動部系統所需之大類通報報告代碼（如 `30901X` ~ `30905X`）。
*   **[CS-ServiceActivityType](CodeSystem-CS-ServiceActivityType.html) (臨場健康服務辦理事項代碼系統)**：
    - 定義附表八申報時所需之 8 大類臨場服務活動類別。
*   **[CS-HealthCounseling](CodeSystem-CS-HealthCounseling.html) (健康諮詢與衛教指導項目代碼系統)**：
    - 定義成人預防保健服務之 10 項法定衛教指導與諮詢事項。

---

## 3. 三層式 LOINC 術語管理機制 (3-Layer LOINC Terminology Strategy)

由於各醫療院所檢驗資訊系統 (LIS) 的歷史代碼與檢驗方法存在差異（例如白血球計數可能使用自動計數或手動計數），本指引針對健康檢查核心檢驗項目採用**三層式術語值集與對應機制**，以提升互操作性並降低院所端系統對接成本。

### 3.1 三層架構定義
*   **Layer 1: Preferred Code (優先代碼)**：
    - 每個檢驗項目指定一個最優先推薦使用的標準 LOINC 代碼。例如 WBC 優先使用 `6690-2`。
*   **Layer 2: Acceptable Codes (可接受值集)**：
    - 建立核心值集 [VS-CoreDataset](ValueSet-VS-CoreDataset.html) (繫結強度為 `extensible`)，容納同義或情境相近之 LOINC 代碼（例如包含 `6690-2`、`804-5`、`26464-8`）。若院所上傳代碼在此範圍內，均視為合法格式。
*   **Layer 3: Exclusion (排除/非範疇)**：
    - 明確排除不適用於一般健康檢查之 LOINC 代碼。例如體液白血球代碼 `12227-5` 排除在一般健檢血常規之外。

### 3.2 代碼映射 ConceptMap
本指引建置了 [TWHealthCheckLaboratoryMap](ConceptMap-TWHealthCheckLaboratoryMap.html) 資源，定義了 Layer 2 可接受代碼至 Layer 1 優先推薦代碼的映射關係，供接收端系統進行標準化資料清洗與歸一化處理。

