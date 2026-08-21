# 一般健康檢查 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.1

## 一般健康檢查

# 一般體格及健康檢查 (General Physical & Health Examination)

一般體格及健康檢查（附表九與附表十一）適用於全體新進及在職勞工。

## 1. 生活習慣與病史對應

本指引定義了社會史（Social History）Observation 子型，以結構化代碼記錄生活習慣：

| | | | |
| :--- | :--- | :--- | :--- |
| **吸菸狀態** | `TWHA-SocialHistory-Smoking` | LOINC`72166-2`(Tobacco smoking status) | 值使用`VS_SmokingStatus`；菸量（每日支數、菸齡）以擴充`ext-smoking-quantity`記錄。 |
| **嚼檳狀態** | `TWHA-SocialHistory-BetelNut` | SNOMED CT`698188003`(Chews betel quid) | 狀態值使用`VS-BetelNutStatus`（與吸菸之`VS_SmokingStatus`四碼逐碼對稱）；每日嚼食量、嚼食年數、戒除期間以`component`之`Quantity`記錄（UCUM`{quid}/d`、`a`、`a`／`mo`）。另可記錄戒除日期、是否含菸草、添加物、石灰種類與資料來源。上游 TWCR_SF 之級距碼降為可選 component（`amountCoded`，extensible），供與癌症登記勾稽。建模說明見[術語頁 §6.2b](terminology.md)。 |
| **飲酒習慣** | `TWHA-SocialHistory-Alcohol` | LOINC`11331-6`(History of Alcohol use) | 記錄飲酒頻率。 |
| **睡眠時間** | `TWHA-SocialHistory-Sleep` | LOINC`93832-4`(Sleep duration) | 記錄平均每日睡眠時間（單位：小時，UCUM:`h`）。 |
| **既往病史** | `TWHA-Condition` | ICD-10-CM | 記錄高血壓（`I10`）、糖尿病（`E11`）等慢性病既往史。 |

-------

## 2. 生理測量項目與 LOINC 對應

生理測量（Vital Signs）採用 `TWHA-VitalSigns` Profile 記錄，完全符合國際生命徵象標準：

* **身高 (Body Height)**: LOINC `8302-2`，單位：`cm`
* **體重 (Body Weight)**: LOINC `29463-7`，單位：`kg`
* **腰圍 (Waist Circumference)**: LOINC `8280-0`（臍位皮尺法），單位：`cm`
* **血壓 (Blood Pressure)**: 採用 `TWCoreBloodPressure` Profile。包含收縮壓（LOINC `8480-6`，單位：`mmHg`）與舒張壓（LOINC `8462-4`，單位：`mmHg`）之雙 component 結構。
* **視力與辨色力**: 採用 `TWHA-VisionTest` Profile（Panel `98497-1`），以 component 結構區分左眼裸視視力（LOINC `98498-9`）、右眼裸視視力（LOINC `98499-7`）及辨色力（LOINC `46673-0` Color vision [RFC]，正常/異常；原 `48024-3` 經 tx 驗證為無效碼已更正）。
* **聽力**: 採用 `TWHA-HearingTest` Profile，Panel 代碼 LOINC `89015-2` (Pure tone air conduction threshold audiometry panel)，以 component 結構記錄左右耳於 0.5–8 kHz 各頻率之氣導聽閾（如左耳 500 Hz `89024-4`、右耳 500 Hz `89025-1`）。

-------

## 3. 理學檢查項目 (Physical Examinations)

各系統理學檢查採用 `TWHA-PhysicalExam` Profile 記錄，其代碼為 LOINC `29545-1` (Physical findings note)。其細項以 `component` 記錄，包括：

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

附表九一般實驗室檢驗**橫跨 Core 與 Extended 兩層**（文件一/二 v3.0）：屬**主管機關最小上傳集**之檢驗項（血脂、飯前血糖、肌酸酐、尿蛋白、肝炎）為 **Core**，綁定 [VS-CoreDataset](ValueSet-VS-CoreDataset.md)（`TWHA-LabResult-General`，extensible）；其餘附表九項目（CBC、ALT、尿潛血等**非上傳項**）為 **Extended**，綁定 [VS-ExtendedDataset](ValueSet-VS-ExtendedDataset.md)（`TWHA-LabResult-Special`）。兩者綁定強度皆為 extensible（優先使用值集內代碼，值集外代碼亦可接受但建議回報）。依法規應於第一期優先必驗之項目草案子集另收錄於 [VS-OccHealthCheck-Required](ValueSet-VS-OccHealthCheck-Required.md)（草案）。主要項目包括：

* **（Core）空腹血糖**: LOINC `1558-6`，單位：`mg/dL`
* **（Core）肌酸酐 (Creatinine)**: LOINC `2160-0`，單位：`mg/dL`
* **（Core）總膽固醇 (Cholesterol)**: LOINC `2093-3`，單位：`mg/dL`
* **（Core）三酸甘油酯 (Triglyceride)**: LOINC `2571-8`，單位：`mg/dL`
* **（Core）高密度脂蛋白膽固醇 (HDL-C)**: LOINC `2085-9`，單位：`mg/dL`
* **（Core）低密度脂蛋白膽固醇 (LDL-C)**: Preferred LOINC `2089-1`（**方法通用碼**，未指定測定方法，可相容各院所），單位：`mg/dL`；可接受代碼 `13457-7`（計算法, by calculation）、`18262-6`（直接測定法, Direct assay），經 ConceptMap 歸一至 Preferred 代碼。
* **（Core）尿蛋白 (Urine Protein)**: LOINC `5804-0`（定性檢查，如 `-`, `+`, `++`）
* **（Extended）血清丙胺酸轉胺酶 (ALT/SGPT)**: LOINC `1742-6`，單位：`U/L`
* **（Extended）尿潛血 (Urine Occult Blood)**: LOINC `5794-3`（定性檢查）
* **（Extended）血色素 (Hemoglobin)**: LOINC `718-7`，單位：`g/dL`
* **（Extended）白血球數 (WBC)**: LOINC `6690-2`，單位：`/uL`
* **（Extended）紅血球數 (RBC)**: LOINC `789-8`，單位：`/uL`（附表九 115.06.26 修正新增）
* **（Extended）平均紅血球容積 (MCV)**: LOINC `787-2`，單位：`fL`（附表九 115.06.26 修正新增）

### 4.1 附表九法定項目 → Core／Extended 對照（implementation note）

下表說明附表九各法定檢查項目**如何由 Core ＋ Extended 組合滿足**。 **「歸屬層」僅表示該項目落在哪一個交換值集，與其法定必要性無關**——凡附表九所列者均為法規要求執行之項目。

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| 1–3 | 作業經歷、既往病史、生活習慣 | Extended | `TWHA-Occupation`／`TWHA-Condition`／SocialHistory | `72166-2`等 |
| 4 | 自覺症狀及身體檢查 | Extended | `TWHA-PhysicalExam` | `29545-1` |
| 5 | 身高、體重、腰圍、視力、辨色力、聽力、血壓 | **Core**（腰圍/血壓/身高/體重）＋ Extended（視力/辨色力/聽力） | `VS-TWHAVitalSigns`／`TWHA-VisionTest`／`TWHA-HearingTest` | `8302-2`,`29463-7`,`8280-0`,`85354-9`,`98497-1`,`89015-2` |
| 5 | 血色素、紅血球數、MCV、白血球數 | Extended | `TWHA-LabResult-Special`（`VS-ExtendedDataset`） | `718-7`,`789-8`,`787-2`,`6690-2` |
| 6 | 空腹血糖、ALT、肌酸酐、膽固醇、TG、HDL（健檢另含 LDL） | **Core**（血糖/肌酸酐/血脂）＋ Extended（ALT） | `VS-CoreDataset`／`VS-ExtendedDataset` | `1558-6`,`2160-0`,`2093-3`,`2571-8`,`2085-9`,`2089-1`／ALT`1742-6` |
| 6 | 尿蛋白、尿潛血 | **Core**（尿蛋白）＋ Extended（尿潛血） | `VS-CoreDataset`／`VS-ExtendedDataset` | `5804-0`／`5794-3` |
| 7 | 胸部 X 光 | Extended | `TWHA-ImagingStudy`／`TWHA-DiagnosticReport` | `24648-8`（單張 PA） |

> ⚠️ **本表為 implementation note（承載對照）**，說明各法定項目由哪個 profile／值集承載。 附表九之**檢驗與量測**項目另以機器可讀之情境值集 [VS-Appendix9-RequiredSet](ValueSet-VS-Appendix9-RequiredSet.md) 定義， 供法定完整性稽核（見下方 §4.2）。非檢驗項目（作業經歷、既往病史、生活習慣、自覺症狀、身體各系統理學檢查） 不列為該值集成員，仍以本表所列 profile 承載。**不得**逕以 `VS-CoreDataset` 或 `VS-CoreUploadSet` 作為附表九之完整需求。

### 4.2 法定完整性稽核示範（附表九）

「這次一般健檢是否做齊附表九法定檢驗項目？」可用 [VS-Appendix9-RequiredSet](ValueSet-VS-Appendix9-RequiredSet.md) 以程式判定。 以一份健檢報告 Bundle 為輸入，逐一比對其 `Observation.code` 是否涵蓋該值集之每一成員：

```
// 缺漏項 ＝ 法定值集成員中，未出現於本次健檢任一 Observation.code 者
missing =
  VS-Appendix9-RequiredSet.members.where(
    %bundle.entry.resource.ofType(Observation).code.coding.code
      .contains($this.code).not()
  )
// missing 為空 ⇒ 檢驗與量測項目齊備；否則 missing 即為缺漏之法定項目清單

```

非檢驗項目（病史、理學檢查等）之完整性須另檢對應 profile 是否存在（例如 `Bundle.entry.resource.ofType(Observation).where(meta.profile.contains('.../TWHA-PhysicalExam'))`）， 因其不以 `Observation.code` 之值集成員表達。此區隔即 §4.1 之承載對照所載。

