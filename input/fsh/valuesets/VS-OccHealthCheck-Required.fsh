// draft v0.1 — 附表九／附表十第一期法定必驗項目子集 (required binding)
// 依 develop.md §1.4：文件二 §1.1/§7 明列「OHC 法規子集 = required」，但 IG 初稿原缺對應 required ValueSet。
// 本值集為初版草案，僅收錄第一期已結構化必驗之通用項目與噪音/鉛/粉塵三模組（議題5 選項A之範疇），
// 待附表九/十法規逐項盤點與座談會確認後，應再擴充或調整為正式法定必驗子集，並評估是否將
// TWHA-VitalSigns / TWHA-LabResult-General / TWHA-LabResult-Special 之對應欄位由 extensible 改為
// required/Must Support + min=1（此為未來變更，尚未在本次變更中調整既有 Profile 綁定，以免影響既有 16 個 examples）。
ValueSet: VS_OccHealthCheckRequired
Id: VS-OccHealthCheck-Required
Title: "勞工健康檢查法定必驗項目值集（第一期草案）"
Description: "第一期法定必驗之勞工健康檢查項目草案子集，涵蓋附表九一般必驗生理量測與實驗室項目，以及噪音／鉛／粉塵三模組之核心必驗代碼。此為初版草案，範疇待附表九/十逐項法規盤點確認後修訂。"
* ^experimental = true

// 一般健檢必驗項目 (附表九)
* LNC#8302-2 "Body height" // 身高
* LNC#29463-7 "Body weight" // 體重
* LNC#55284-4 "Blood pressure systolic and diastolic" // 血壓
* LNC#1558-6 "Fasting glucose [Mass/volume] in Serum or Plasma" // 空腹血糖
* LNC#2093-3 "Cholesterol [Mass/volume] in Serum or Plasma" // 總膽固醇
* LNC#2571-8 "Triglyceride [Mass/volume] in Serum or Plasma" // 三酸甘油酯
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma" // HDL-C
* LNC#2089-1 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay" // LDL-C (Preferred)
* LNC#1742-6 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma" // ALT
* LNC#2160-0 "Creatinine [Mass/volume] in Serum or Plasma" // 肌酸酐
* LNC#5804-0 "Protein [Presence] in Urine by Test strip" // 尿蛋白
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood" // 血色素
* LNC#6690-2 "Leukocytes [#/volume] in Blood" // WBC
* LNC#789-8 "Erythrocytes [#/volume] in Blood" // 紅血球數 RBC（附表九 115.06.26 修正新增）
* LNC#787-2 "MCV [Entitic volume] by Automated count" // 平均紅血球容積 MCV（附表九 115.06.26 修正新增）

// 第一期結構化必驗特殊職類模組 (議題5 選項A：噪音／鉛／粉塵)
* LNC#89015-2 "Pure tone air conduction threshold audiometry panel" // 噪音：純音聽力 Panel（0.5–8 kHz 各頻率以 TWHA-HearingTest component 承載）
* LNC#5671-3 "Lead [Mass/volume] in Blood" // 鉛：血中鉛（Preferred；院內 LIS 常以 23749-5 Specimen 報告，列為 Acceptable）
* LNC#23749-5 "Lead [Mass/volume] in Specimen" // 鉛：血中鉛（林口長庚 LIS 實際報告碼）
* LNC#19876-2 "Forced vital capacity [Volume] in Airways by Spirometry" // 粉塵：FVC
* LNC#20150-9 "Forced expiratory volume in 1 second [Volume] in Airways by Spirometry" // 粉塵：FEV1（正確碼，v1.1 更正）
* LNC#19926-5 "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry" // 粉塵：FEV1/FVC
* LNC#36643-5 "XR Chest 2 Views" // 粉塵：胸部 X 光（2 views，塵肺症）
