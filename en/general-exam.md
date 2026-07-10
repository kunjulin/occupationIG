# General Exam - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## General Exam

# 一般體格及健康檢查 (General Physical & Health Examination)

一般體格及健康檢查（附表九與附表十一）適用於全體新進及在職勞工。

## 1. 生活習慣與病史對應

本指引定義了社會史（Social History）Observation 子型，以結構化代碼記錄生活習慣：

| | | | |
| :--- | :--- | :--- | :--- |
| **吸菸狀態** | `TWHA-SocialHistory-Smoking` | LOINC`72166-2`(Tobacco smoking status) | 值使用`VS_SmokingStatus`；菸量（每日支數、菸齡）以擴充`ext-smoking-quantity`記錄。 |
| **嚼檳狀態** | `TWHA-SocialHistory-BetelNut` | SNOMED CT`698188003`(Chews betel quid) | 採用與臺灣癌症登記短表實作指引 (TWCR_SF) 相同之元件架構，以`component[amount]`、`component[year]`、`component[quit]`分別記錄每日嚼檳量、嚼檳年數與戒嚼檳年數，值集為 TWCR_SF 之`sf-BetNutChewAmount/Year/Quit`ValueSet（required），以利跨系統整合介接。 |
| **飲酒習慣** | `TWHA-SocialHistory-Alcohol` | LOINC`11331-6`(History of Alcohol use) | 記錄飲酒頻率。 |
| **睡眠時間** | `TWHA-SocialHistory-Sleep` | LOINC`93832-4`(Sleep duration) | 記錄平均每日睡眠時間（單位：小時，UCUM:`h`）。 |
| **既往病史** | `TWHA-Condition` | ICD-10-CM | 記錄高血壓（`I10`）、糖尿病（`E11`）等慢性病既往史。 |

-------

## 2. 生理測量項目與 LOINC 對應

生理測量（Vital Signs）採用 `TWHA-VitalSigns` Profile 記錄，完全符合國際生命徵象標準：

* **身高 (Body Height)**: LOINC `8302-2`，單位：`cm`
* **體重 (Body Weight)**: LOINC `29463-7`，單位：`kg`
* **腰圍 (Waist Circumference)**: LOINC `56086-2`，單位：`cm`
* **血壓 (Blood Pressure)**: 採用 `TWCoreBloodPressure` Profile。包含收縮壓（LOINC `8480-6`，單位：`mmHg`）與舒張壓（LOINC `8462-4`，單位：`mmHg`）之雙 component 結構。
* **視力與辨色力**: 採用 `TWHA-VisionTest` Profile，以 component 結構區分左眼視力（LOINC `70936-0`）、右眼視力（LOINC `70935-2`）及辨色力（LOINC `48024-3`，正常/異常）。
* **聽力**: 採用 `TWHA-HearingTest` Profile，Panel 代碼 LOINC `89015-2` (Pure tone threshold audiometry panel)，以 component 結構記錄左右耳於 0.5–8 kHz 各頻率之氣導聽閾（如左耳 500 Hz `89024-4`、右耳 500 Hz `89025-1`）。

-------

## 3. 理學檢查項目 (Physical Examinations)

各系統理學檢查採用 `TWHA-PhysicalExam` Profile 記錄，其代碼為 LOINC `29545-1` (Physical findings panel)。其細項以 `component` 記錄，包括：

* 頭頸部 (`head-neck`)
* 呼吸系統 (`respiratory`)
* 心臟血管系統 (`cardiovascular`)
* 消化系統 (`digestive`)
* 神經系統 (`neurological`)
* 肌肉骨骼系統 (`musculoskeletal`)
* 皮膚 (`skin`)

值採用 `CodeableConcept` 記錄（正常：`http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N`，異常者需詳述說明於 `text` 欄位）。

-------

## 4. 實驗室檢驗項目 (Laboratory Tests)

一般實驗室檢驗採用 `TWHA-LabResult-General` Profile，檢驗項目代碼綁定至 `VS-CoreDataset` 值集（extensible，即優先使用值集內代碼，值集外之代碼亦可接受但建議回報以利術語治理）。其中依法規應於第一期優先必驗之項目草案子集另收錄於 [VS-OccHealthCheck-Required](ValueSet-VS-OccHealthCheck-Required.md)（草案，範疇待附表九/十逐項法規盤點確認）。主要項目包括：

* **空腹血糖**: LOINC `1558-6`，單位：`mg/dL`
* **血清丙胺酸轉胺酶 (ALT/SGPT)**: LOINC `1742-6`，單位：`U/L`
* **肌酸酐 (Creatinine)**: LOINC `2160-0`，單位：`mg/dL`
* **總膽固醇 (Cholesterol)**: LOINC `2093-3`，單位：`mg/dL`
* **三酸甘油酯 (Triglyceride)**: LOINC `2571-8`，單位：`mg/dL`
* **高密度脂蛋白膽固醇 (HDL-C)**: LOINC `2085-9`，單位：`mg/dL`
* **低密度脂蛋白膽固醇 (LDL-C)**: Preferred LOINC `2089-1`（直接測定法, Direct assay），單位：`mg/dL`；可接受代碼 `13457-7`（計算法, by calculation）、`18262-6`（直接測定法舊碼），經 ConceptMap 歸一至 Preferred 代碼。
* **尿蛋白 (Urine Protein)**: LOINC `5804-0`（定性檢查，如 `-`, `+`, `++`）
* **尿潛血 (Urine Occult Blood)**: LOINC `5794-3`（定性檢查）
* **血色素 (Hemoglobin)**: LOINC `718-7`，單位：`g/dL`
* **白血球數 (WBC)**: LOINC `6690-2`，單位：`/uL`

