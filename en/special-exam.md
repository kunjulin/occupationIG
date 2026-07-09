# Special Exam - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Special Exam

# 特殊體格及健康檢查 (Special Physical & Health Examination)

特殊體格及健康檢查適用於從事特別危害健康作業之勞工。本指引依據勞動部《勞工健康保護規則》附表規定，將特別危害健康作業之實驗室與生理功能檢驗項目對應至國際標準 LOINC 代碼，並收錄於 [特殊健康檢查及體格檢查實驗室項目值集](ValueSet-VS-ExtendedDataset.md) 中。

依據實作指引之 **特別危害健康作業類別值集 (VS-HazardType)**，本指引對應並收錄以下 12 大類特別危害健康作業類別之核心檢驗與評估項目：

-------

## 1. 高溫作業 (High Temperature Operations)

* **適用對象**：高溫作業勞工作息時間標準所稱之高溫作業勞工。
* **核心生理與實驗室檢查項目**： 
* **心電圖檢查 (ECG)**：LOINC `11524-6` (EKG study)。
* **血清電解質檢查**：血清鈉 Sodium (LOINC `2951-2`) 與血清鉀 Potassium (LOINC `2823-3`)。
* **尿比重 (Urine Specific Gravity)**：LOINC `5810-7`，用以評估勞工於高溫暴露下之脫水及水分平衡狀態。
 

-------

## 2. 噪音作業 (Noise Operations)

* **適用對象**：連續八小時工作期間之均權音量達八十五分貝以上之作業勞工。
* **核心生理與實驗室檢查項目**： 
* **外耳與鼓膜檢查**：理學檢查 `TWHA-PhysicalExam` 記錄外耳道及鼓膜狀態。
* **純音聽力測試 (Audiometry)**：使用 `TWHA-HearingTest` 記錄。聽力計量測項目代碼為 LOINC `89024-4` (Hearing threshold 500 Hz Ear-L)。包含雙耳在 500Hz、1000Hz、2000Hz、3000Hz、4000Hz、6000Hz 及 8000Hz 等頻率下之氣導聽閾測量。
 

-------

## 3. 游離輻射作業 (Radiation Operations)

* **適用對象**：從事游離輻射防護法所稱之輻射工作勞工。
* **核心生理與實驗室檢查項目**： 
* **皮膚與眼晶體檢查**：以理學檢查記錄皮膚病變、指紋變化及晶體混濁度。
* **血常規與白血球分類計數**： 
* 紅血球數 RBC (LOINC `789-8`)、白血球數 WBC (LOINC `6690-2`)。
* 血小板計數 Platelets (LOINC `777-3`)。
* 血色素 Hb (LOINC `718-7`)、血球比容值 Hct (LOINC `4544-3`)。
* 嗜中性球百分比 (LOINC `770-8`) 與淋巴球百分比 (LOINC `736-9`)，評估輻射對造血系統與免疫系統之早期影響。
 
 

-------

## 4. 異常氣壓作業 (Abnormal Pressure Operations)

* **適用對象**：從事潛水作業或高壓室內作業之勞工。
* **核心生理與實驗室檢查項目**： 
* **心電圖檢查 (ECG Study)**：採用 `TWHA-ECG` 記錄心電圖檢查結果（LOINC `11524-6`）。
* **肺功能檢查 (Spirometry)**：FEV1 (LOINC `19868-9`)、FVC (LOINC `19876-2`) 及 FEV1/FVC 比值 (LOINC `19926-5`)，評估氣壓急遽變化下之呼吸系統耐受力。
* **骨骼 X 光檢查 (Bone X-ray)**：針對肩關節、髖關節及股骨等進行 X 光大骨骼篩檢（LOINC `24579-5`），以評估是否有減壓病引起之無菌性骨壞死（Aseptic Bone Necrosis）。
 

-------

## 5. 鉛作業 (Lead Operations)

* **適用對象**：從事鉛及其化合物之作業勞工（不含四烷基鉛）。
* **核心生理與實驗室檢查項目**： 
* **血中鉛含量 (Blood Lead)**：代碼為 LOINC `5671-3` (Lead in Blood)，單位：`ug/dL`。
* **尿中鉛含量 (Urine Lead)**：代碼為 LOINC `5676-2` (Lead in Urine)，單位：`ug/L`。
* **尿中紅血球生成素/共聚卟啉 (Urine Coproporphyrin)**：代碼為 LOINC `11212-8` (Copro in Urine)。
* **尿中 δ-胺基酮戊酸 (Urine delta-ALA)**：代碼為 LOINC `11215-1` (D-ALA in Urine)。
* **造血指標**：RBC (LOINC `789-8`)、Hematocrit (LOINC `4544-3`) 與 Hemoglobin (LOINC `718-7`)，評估鉛暴露引起之貧血與造血毒性。
 

-------

## 6. 四烷基鉛作業 (Tetraalkyl-lead Operations)

* **適用對象**：從事四烷基鉛中毒預防規則所定義之四烷基鉛作業勞工。
* **核心生理與實驗室檢查項目**： 
* **神經精神症狀評估**：針對失眠、易怒、震顫等精神症狀進行評估。
* **鉛暴露生物監測**：尿中鉛 (LOINC `5676-2`)、尿中共聚卟啉 (LOINC `11212-8`) 及尿中 δ-胺基酮戊酸 (LOINC `11215-1`)，用以間接監測體內鉛負荷。
 

-------

## 7. 粉塵作業 (Dust Operations)

* **適用對象**：從事粉塵危害預防標準所定義之粉塵作業勞工。
* **核心生理與實驗室檢查項目**： 
* **胸部 X 光檢查 (Chest X-ray)**：採用 `TWHA-ImagingStudy` 記錄影像，並以 `TWHA-DiagnosticReport` 記錄 X 光大片攝影診斷報告（LOINC `36643-5`），評估塵肺症（Pneumoconiosis）之分期。
* **肺功能檢查 (Spirometry)**：採用 `TWHA-PulmonaryFunction`。記錄 FEV1 (LOINC `19868-9`)、FVC (LOINC `19876-2`) 及 FEV1/FVC 比值 (LOINC `19926-5`)。
 

-------

## 8. 有機溶劑作業 (Organic Solvent Operations)

* **適用對象**：從事有機溶劑中毒預防規則所定義之有機溶劑作業勞工（如甲苯、二甲苯、苯等）。
* **核心生理與實驗室檢查項目 (生物監測指標)**： 
* **尿中馬尿酸 (Hippuric acid)**：甲苯（Toluene）之代謝物，LOINC `6709-0`。
* **尿中甲基馬尿酸 (Methylhippuric acid)**：二甲苯（Xylene）之代謝物，LOINC `2725-0`。
* **尿中扁桃酸 (Mandelic acid)**：苯乙烯（Styrene）之代謝物，LOINC `13000-5`。
* **尿中三氯乙酸 (Trichloroacetic acid)**：三氯乙烯之代謝物，LOINC `3041-1`。
* **尿中 2,5-己二酮 (2,5-Hexanedione)**：正己烷（n-Hexane）之代謝物，LOINC `31170-4`。
* **尿中酚 (Phenol)**：苯（Benzene）之代謝物，LOINC `2758-1`。
* **尿中二甲基甲醯胺代謝物 (N-Methylformamide)**：DMF 之代謝物，LOINC `12543-5`。
* **尿中二硫化碳代謝物 (TTCA)**：二硫化碳之代謝物，LOINC `12533-6`。
 

-------

## 9. 特定化學物質作業 (Specific Chemical Operations)

* **適用對象**：從事特定化學物質危害預防標準所定義之化學物質作業勞工（如砷、鎘、鉻、汞、鎳、聯苯胺等）。
* **核心生理與實驗室檢查項目**： 
* **重金屬監測**： 
* 尿中無機砷 (LOINC `5586-3`)。
* 血中鎘 (LOINC `5609-3`) 與尿中鎘 (LOINC `5611-9`)。
* 尿中鉻 (LOINC `5623-4`)。
* 尿中鎳 (LOINC `14099-6`)。
* 血中汞 (LOINC `5685-3`) 與尿中汞 (LOINC `5689-5`)。
* 血中錳 (LOINC `5681-2`) 與尿中錳 (LOINC `42221-2`)。
 
* **有機特定化學物質代謝指標**： 
* 尿中 t,t-黏康酸 (t,t-Muconic acid，苯代謝物)：LOINC `72665-3`。
* 尿中 MOCA (4,4'-Methylenebis(2-chloroaniline))：LOINC `10913-2`。
* 尿中甲醛 (Formaldehyde)：LOINC `5653-1`。
* 尿中聯苯胺 (Benzidine)：LOINC `10909-0`。
 
* **氟化氫作業指標**：尿中氟化物 Fluoride (LOINC `34304-6`)。
 

-------

## 10. 黃磷作業 (Yellow Phosphorus Operations)

* **適用對象**：製造、處置或使用黃磷之作業勞工。
* **核心生理與實驗室檢查項目**： 
* **下顎骨 X 光檢查 (Mandible X-ray)**：LOINC `24829-4` (XR Mandible Views)，以評估黃磷暴露所引起之黃磷性下顎骨壞死 (Phossy Jaw)。
* **磷代謝監測**：血清無機磷 Phosphate (LOINC `2777-1`)。
* **肝腎功能評估**： 
* 肝功能：AST (LOINC `1920-8`)、ALT (LOINC `1742-6`) 與總膽紅素 Total Bilirubin (LOINC `1975-2`)。
* 腎功能：Creatinine (LOINC `2160-0`) 與尿素氮 BUN (LOINC `3094-0`)。
 
 

-------

## 11. 聯吡啶或巴拉刈作業 (Paraquat Operations)

* **適用對象**：製造、處置或使用聯吡啶或巴拉刈之作業勞工。
* **核心生理與實驗室檢查項目**： 
* **巴拉刈生物監測**：尿中巴拉刈 Paraquat (LOINC `9827-7`)，用以檢測急性或慢性巴拉刈暴露。
* **呼吸系統與胸部評估**： 
* 胸部 X 光檢查 (LOINC `36643-5`)。
* 肺功能檢查：FEV1 (LOINC `19868-9`)、FVC (LOINC `19876-2`) 及 FEV1/FVC 比值 (LOINC `19926-5`)，藉以監測巴拉刈引起的肺部纖維化早期病變。
 
* **肝腎功能評估**：AST (`1920-8`)、ALT (`1742-6`)、Creatinine (`2160-0`) 與 BUN (`3094-0`)。
 

-------

## 12. 其他指定作業 (Other Operations)

* **適用對象**：銦作業、鈷作業、甲基溴作業、有機磷農藥暴露作業等其他指定特別危害作業勞工。
* **核心生理與實驗室檢查項目**： 
* **銦作業 (Indium)**：血中銦 (LOINC `5665-5`) 及血清銦 (LOINC `60090-8`)。
* **鈷作業 (Cobalt)**：血中鈷 (LOINC `5625-9`) 及血清鈷 (LOINC `5627-5`)。
* **甲基溴作業 (Methyl Bromide)**：血清溴 (LOINC `1984-4`) 及尿溴 (LOINC `1985-1`)。
* **有機磷農藥暴露 (Pesticides)**：血球乙醯膽鹼酯酶 RBC AChE (LOINC `1709-5`) 與血清膽鹼酯酶 Serum Cholinesterase (LOINC `2098-2`)。
 

