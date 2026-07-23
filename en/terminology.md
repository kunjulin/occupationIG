# Terminology - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Terminology

# 術語與代碼系統 (Terminology & CodeSystems)

本指引在國際術語標準（LOINC, SNOMED CT, ICD-10-CM）與臺灣本地化行政代碼之間建立映射，以實現數據的高級互操作性。

> **命名說明**：本指引之正式名稱為「臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG)」；`twha` 為本指引 Canonical URL 與 Profile/ValueSet/CodeSystem 前綴所使用之技術命名空間 token（沿用初版 draft 命名），非對外正式英文名稱之縮寫。

## 1. 國際臨床術語遵循

* **LOINC (Logical Observation Identifiers Names and Codes)**： 
* 用於所有一般檢驗、生理功能檢查（肺功能、心電圖、聽力測試）及生理測量（身高、體重、血壓）的 Observation.code 定義。
* 本指引所使用的 LOINC 代碼集已彙整至 [VS-CoreDataset](ValueSet-VS-CoreDataset.md) 與 [VS-ExtendedDataset](ValueSet-VS-ExtendedDataset.md)。
 
* **SNOMED CT (Systematized Nomenclature of Medicine - Clinical Terms)**： 
* 用於生活習慣（如嚼檳榔狀態 `698188003`）、臨場服務現場發現之職業危害（`278486003`）、改善建議諮詢（`315640000`）等臨床發現與程序代碼。
 
* **ICD-10-CM (Clinical Modification)**： 
* 用於記錄勞工既往病史（`TWHA-Condition`）以及附表十二所列之不適合從事特定危害作業疾病。
 

-------

## 2. 本地化行政代碼系統 (CodeSystems Defined in this IG)

為滿足臺灣職業安全衛生與健康服務之行政申報需求，本指引定義了以下代碼系統：

* **[CS-ExamType](CodeSystem-CS-ExamType.md) (檢查類型代碼系統)**： 
* 定義 `general-physical` (一般體格)、`general-health` (一般健康)、`special-physical` (特殊體格) 與 `special-health` (特殊健康)。
 
* **[CS-HazardType](CodeSystem-CS-HazardType.md) (危害作業類別代碼系統)**： 
* 定義高溫、噪音、輻射、異常氣壓、鉛、粉塵、有機溶劑、特定化學物質等 12 大類危害作業之代碼。（家族層）附表十（115.06.26 修正）逐號之 35 項具名作業另見 [CS-Appendix10Operation](CodeSystem-CS-Appendix10Operation.md)，家族 ↔ 具名作業對映見 [ConceptMap Appendix10-to-HazardType](ConceptMap-Appendix10-to-HazardType.md)。
 
* **[CS-SmokingStatus](CodeSystem-CS-SmokingStatus.md) (吸菸狀態代碼系統)**： 
* 定義從未、偶爾、每日與已戒之狀態。
 
* **[CS-HealthMgmtLevel](CodeSystem-CS-HealthMgmtLevel.md) (健康管理分級代碼系統)**： 
* 定義第一級至第四級健康管理分級。
 
* **[CS-FitnessForWork](CodeSystem-CS-FitnessForWork.md) (適性配工建議代碼系統)**： 
* 定義變更場所、換工作、縮短工時、醫療限制等工作調整項目。
 
* **[CS-LaborReportCode](CodeSystem-CS-LaborReportCode.md) (勞動部通報報告代碼系統)**： 
* 定義通報勞動部系統所需之大類通報報告代碼（如 `30901X` ~ `30905X`）。
 
* **[CS-ServiceActivityType](CodeSystem-CS-ServiceActivityType.md) (臨場健康服務辦理事項代碼系統)**： 
* 定義附表八申報時所需之 8 大類臨場服務活動類別。
 
* **[CS-HealthCounseling](CodeSystem-CS-HealthCounseling.md) (健康諮詢與衛教指導項目代碼系統)**： 
* 定義成人預防保健服務之 10 項法定衛教指導與諮詢事項。
 

-------

## 3. 三層式 LOINC 術語管理機制 (3-Layer LOINC Terminology Strategy)

由於各醫療院所檢驗資訊系統 (LIS) 的歷史代碼與檢驗方法存在差異（例如白血球計數可能使用自動計數或手動計數），本指引針對健康檢查核心檢驗項目採用**三層式術語值集與對應機制**，以提升互操作性並降低院所端系統對接成本。

### 3.1 三層架構定義

* **Layer 1: Preferred Code (優先代碼)**： 
* 每個檢驗項目指定一個最優先推薦使用的標準 LOINC 代碼。例如 WBC 優先使用 `6690-2`。
 
* **Layer 2: Acceptable Codes (可接受值集)**： 
* 建立核心值集 [VS-CoreDataset](ValueSet-VS-CoreDataset.md) (繫結強度為 `extensible`)，容納同義或情境相近之 LOINC 代碼（例如包含 `6690-2`、`804-5`、`26464-8`）。若院所上傳代碼在此範圍內，均視為合法格式。
 
* **Layer 3: Exclusion (排除/非範疇)**： 
* 明確排除不適用於一般健康檢查之 LOINC 代碼。例如體液白血球代碼 `12227-5` 排除在一般健檢血常規之外。
 

> **用語澄清（綁定強度 vs. Preferred 代碼）**：本節「Layer 1 Preferred（優先代碼）」係指三層術語中的**指定代碼層級**，與 FHIR 值集**綁定強度（binding strength）之 `preferred`** 為不同概念。本 IG 之 `VS-CoreDataset` 綁定強度為 **`extensible`**（與文件一 §6.3、實際建置一致），非 FHIR 之 `preferred` 綁定。

### 3.2 代碼映射 ConceptMap

本指引建置了 [TWHealthCheckLaboratoryMap](ConceptMap-TWHealthCheckLaboratoryMap.md) 資源，定義了 Layer 2 可接受代碼至 Layer 1 優先推薦代碼的映射關係，供接收端系統進行標準化資料清洗與歸一化處理。目前已涵蓋 **29 組映射**，包含血液學（WBC、血小板、MCV、MCH、嗜中性球%）、肝功能（AST、ALT、ALP，含無 P-5'-P 之 AST/ALT 變異法）、生化代謝（血糖、肌酸酐、尿酸、eGFR、飯後血糖）、脂質（總膽固醇、TG、HDL-C、LDL-C，Preferred 已修正為直接測定法 `2089-1`）、肝炎（HBsAg、anti-HCV）以及內分泌與癌標（HbA1c、TSH、PSA、CA-125、CEA）等群組。 另建置 [Appendix10-to-HazardType](ConceptMap-Appendix10-to-HazardType.md)，對映附表十 35 項法定作業至 12 危害家族（family），供由法定作業編號歸併家族。

-------

## 4. 核心檢驗項目 LOINC–SNOMED CT 跨術語對照表

本節提供健康檢查核心資料集中各主要項目的跨術語標準對照，整合 LOINC（Layer 1 優先 / Layer 2 可接受）、SNOMED CT 概念、UCUM 計量單位及法規欄位參照，供審查委員、實作廠商與術語標準對接使用。所有 SNOMED CT 代碼均已透過 SNOMED International Browser（2026-06-01 版）人工逐一確認。

| | | | | | | |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 血液學 | 白血球計數 | `6690-2` | `{804-5, 26464-8}` | 767002 | 10*3/uL | 附表九 |
| 血液學 | 紅血球計數 RBC | `789-8` | — | 41653003 | 10*6/uL | 附表九（115.06.26 新增） |
| 血液學 | 血紅素 | `718-7` | — | 38082009 | g/dL | 附表九 |
| 血液學 | 血小板 | `777-3` | `{26515-7}` | 61928009 | 10*3/uL | 附表九 |
| 血液學 | MCV | `787-2` | `{30428-7}` | 104133003 | fL | 附表九 |
| 血液學 | MCH | `785-6` | `{28539-5}` | 85505000 | pg | 附表九 |
| 血液學 | MCHC | `786-4` | — | 37254006 | g/dL | 附表九 |
| 血液學 | 嗜中性球% | `770-8` | `{26508-2}` | 271036002 | % | 附表九 |
| 生化/腎 | 空腹血糖 | `1558-6` | `{2339-0}` | 33747003 | mg/dL | 附表九/成健 |
| 生化/腎 | 肌酸酐 | `2160-0` | `{38483-4}` | 15373003 | mg/dL | 附表九 |
| 生化/腎 | eGFR | `88293-6` | `{33914-3}` | 80274001 | mL/min/{1.73_m2} | 成健 |
| 生化/腎 | 尿酸 | `3084-1` | `{49154-8}` | 86228006 | mg/dL | 附表九 |
| 肝功能 | AST (GOT) | `1920-8` | `{14409-7}` | 45896001 | U/L | 附表九/成健 |
| 肝功能 | ALT (GPT) | `1742-6` | `{14390-9}` | 34608000 | U/L | 附表九/成健 |
| 肝功能 | ALP | `6768-6` | `{1783-0}` | 88810008 | U/L | 附表九 |
| 脂質 | 總膽固醇 | `2093-3` | `{35200-5}` | 77068002 | mg/dL | 成健 |
| 脂質 | 三酸甘油酯 | `2571-8` | `{3043-7}` | 14740000 | mg/dL | 成健 |
| 脂質 | HDL-C | `2085-9` | `{3048-6}` | 17888004 | mg/dL | 成健 |
| 脂質 | LDL-C (直接測定法) | `2089-1` | `{13457-7, 18262-6}` | 113079009 | mg/dL | 成健 |
| 內分泌 | HbA1c (NGSP) | `4548-4` | `{59261-8}` | 43396009 | % | 成健/進階 |
| 內分泌 | TSH | `11580-8` | `{3016-3}` | 61167004 | mIU/L | 進階 |
| 癌標 | PSA | `2857-1` | `{19199-9}` | 63476009 | ng/mL | 進階 |
| 癌標 | CA-125 | `10334-1` | `{83082-8}` | 50610001 | U/mL | 進階 |
| 癌標 | CEA | `2039-6` | `{83085-1}` | 60267001 | ng/mL | 進階 |
| 肝炎 | HBsAg | `5196-1` | `{22326-3}` | 39082004 | — | 成健 |
| 肝炎 | anti-HCV | `13955-0` | `{47365-2}` | 32218006 | — | 成健 |
| 尿液 | 尿蛋白 (試紙) | `5804-0` | `{2888-6}` | 167273002 | — | 附表九/成健 |
| 生理 | BMI | `39156-5` | — | 60621009 | kg/m2 | 成健 |
| 生理 | 腰臀比 WHR | `73708-3` | — | 248362002 | {ratio} | 成健 |
| 生理 | 血壓 Panel | `55284-4` | — | 75367002 | — | 成健 |
| 生理 | 腰圍 | `8280-0` | `{56086-2}` | 276361009 | cm | 附表九/成健 |
| 肺功能 | FVC | `19876-2` | `{19868-9, 19870-5}` | 50834005 | L | 職業 |
| 肺功能 | FEV1 | `20150-9` | — | 59328004 | L | 職業 |
| 視力 | 視力 Panel | `79880-1` | — | 363983007 | — | 職業 |
| 聽力 | 純音聽力 Panel | `89015-2` | — | 406081008 | dB | 職業 |

-------

## 5. 術語資源下載與補充說明

### 5.1 術語對照表下載

完整的 LOINC–SNOMED CT–UCUM 跨術語對照表（CSV 格式）可從以下連結下載：

* [snomed-loinc-mappings.csv](snomed-loinc-mappings.csv)

CSV 欄位說明：`category`（類別）、`item_name_zh`（中文名）、`item_name_en`（英文名）、`loinc_preferred`（Layer 1）、`loinc_acceptable`（Layer 2 集合）、`snomed_ct`（代碼）、`snomed_display`（顯示名稱）、`snomed_status`（驗證狀態）、`ucum_unit`（UCUM 單位）、`regulatory_ref`（法規欄位）。

### 5.2 肺功能代碼雙 ValueSet 說明

本指引中，肺功能代碼（`19876-2` FVC、`19868-9` FEV1、`19926-5` FEV1/FVC 比值）同時收錄於兩個不同的 ValueSet，用途各異：

* **[VS-PulmonaryFunction](ValueSet-VS-PulmonaryFunction.md)**：供 `TWHAPulmonaryFunctionProfile` 完整代碼集查詢使用，包含所有肺功能相關代碼（含 TLC、RV、DLCO 等）。
* **[VS-CoreDataset](ValueSet-VS-CoreDataset.md)**：供術語查詢與跨資料集完整性核對使用，僅收錄最核心的三個代碼。

兩者並非重複，而是服務不同的查詢情境。`TWHAPulmonaryFunctionProfile` 的 `Observation.code` 為固定值（`= LNC#19876-2`），不受 VS 繫結直接限制，但兩個 VS 均供文件與術語服務查詢使用。

### 5.3 聽力頻率代碼設計說明

聽力測試使用三層代碼架構：

1. **Panel（`89015-2`）**：記錄整場聽力測試，進入`VS-CoreDataset`作為 Observation.code
1. **個別頻率/耳別代碼（`89024-4` 等 8 個）**：作為`component.code`由`TWHAHearingTestProfile`的 8 個 component 切片處理，收錄於`VS-ExtendedDataset`
1. **結果解釋**：臨床人員依 ISO 1999 標準判定各頻率閾值是否超過 25 dB HL
1. **院內/職醫變異碼（Acceptable）**：部分院所 LIS 與職業病醫師建議採用`21104-5`（Audiometry study）及`21106-0`等頻率系列碼；本 IG 維持`89015-2`panel 為 Preferred，`21104-5`系列列為 Acceptable 變異（收錄於`VS-ExtendedDataset`），供 LIS 對接。

