# 特殊體格及健康檢查 (Special Physical & Health Examination)

特殊體格及健康檢查適用於從事特別危害健康作業之勞工。本指引依據勞動部《勞工健康保護規則》附表規定，將特別危害健康作業之實驗室與生理功能檢驗項目對應至國際標準 LOINC 代碼，並收錄於 [特殊健康檢查及體格檢查實驗室項目值集](ValueSet-VS-SpecialLabTests.html) 中。

本指引涵蓋以下主要危害作業類別之核心檢驗與評估項目：

---

## 1. 噪音作業 (Noise Operations)

*   **適用對象**：連續八小時工作期間之均權音量達八十五分貝以上之作業勞工。
*   **核心檢查項目**：
    - **耳道與鼓膜檢查**：以理學檢查 `OHE-PhysicalExam` 記錄外耳及鼓膜狀態。
    - **純音聽力測試 (Audiometry)**：使用 `OHE-HearingTest` Profile 記錄。聽力計量測項目代碼為 LOINC `89024-4` (Audiometry panel)。
    - **細項要求**：必須進行雙耳在 500Hz、1000Hz、2000Hz、3000Hz、4000Hz、6000Hz 及 8000Hz 等頻率下之氣導聽閾測量。

---

## 2. 鉛作業 (Lead Operations)

*   **適用對象**：從事製造、處置或使用鉛及其化合物之作業勞工。
*   **核心檢查項目**：
    - **血中鉛含量 (Blood Lead)**：代碼為 LOINC `5671-3` (Lead in Blood)，單位：`ug/dL`。
    - **尿中鉛含量 (Urine Lead)**：代碼為 LOINC `5676-2` (Lead in Urine)，單位：`ug/L`。
    - **尿中紅血球生成素/共聚卟啉 (Urine Coproporphyrin)**：代碼為 LOINC `11212-8` (Copro in Urine)。
    - **尿中 δ-胺基酮戊酸 (Urine delta-ALA)**：代碼為 LOINC `11215-1` (D-ALA in Urine)。
    - **紅血球數與血球比容值**：RBC (`789-8`) 及 Hematocrit (`4544-3`)。

---

## 3. 粉塵作業 (Dust Operations)

*   **適用對象**：從事粉塵危害預防標準所定義之粉塵作業勞工。
*   **核心檢查項目**：
    - **胸部 X 光檢查 (Chest X-ray)**：採用 `OHE-ImagingStudy` 記錄影像元數據，並以 `OHE-DiagnosticReport` 記錄 X 光大片攝影診斷報告（LOINC `36643-5`），評估是否有塵肺症（Pneumoconiosis）表現及分期。
    - **肺功能檢查 (Spirometry)**：採用 `OHE-PulmonaryFunction` Profile。記錄第一秒用力呼氣量 FEV1 (LOINC `19868-9`)、用力肺活量 FVC (LOINC `19876-2`) 及 FEV1/FVC 比值 (LOINC `19926-5`)。

---

## 4. 異常氣壓作業 (Abnormal Pressure Operations)

*   **適用對象**：從事潛水作業或高壓室內作業之勞工。
*   **核心檢查項目**：
    - **心電圖檢查 (ECG Study)**：採用 `OHE-ECG` Profile 記錄心電圖檢查結果（LOINC `11524-6`）。
    - **骨骼 X 光檢查 (Bone X-ray)**：針對肩關節、髖關節及股骨等進行 X 光大骨骼篩檢（LOINC `24579-5`），以評估是否有減壓病引起之無菌性骨壞死（Aseptic Bone Necrosis）。

---

## 5. 高溫作業 (High Temperature Operations)

*   **適用對象**：高溫作業勞工作息時間標準所稱之高溫作業勞工。
*   **核心檢查項目**：
    - **心電圖檢查 (ECG)**：LOINC `11524-6`。
    - **血清電解質檢查**：血清鈉 Sodium (LOINC `2951-2`) 與血清鉀 Potassium (LOINC `2823-3`)。

---

## 6. 有機溶劑作業 (Organic Solvent Operations)

*   **適用對象**：從事有機溶劑中毒預防規則所定義之有機溶劑作業勞工（如甲苯、二甲苯、苯等）。
*   **生物監測指標 (Biomonitoring)**：
    - **尿中馬尿酸 (Hippuric acid)**：甲苯（Toluene）之代謝物，LOINC `6709-0`。
    - **尿中甲基馬尿酸 (Methylhippuric acid)**：二甲苯（Xylene）之代謝物，LOINC `2725-0`。
    - **尿中扁桃酸 (Mandelic acid)**：苯乙烯（Styrene）之代謝物，LOINC `13000-5`。
    - **尿中三氯乙酸 (Trichloroacetic acid)**：三氯乙烯之代謝物，LOINC `3041-1`。
    - **尿中 2,5-己二酮 (2,5-Hexanedione)**：正己烷（n-Hexane）之代謝物，LOINC `31170-4`。
    - **尿中酚 (Phenol)**：苯（Benzene）之代謝物，LOINC `2758-1`。
    - **尿中二甲基甲醯胺代謝物 (N-Methylformamide)**：DMF 之代謝物，LOINC `12543-5`。
    - **尿中二硫化碳代謝物 (TTCA)**：二硫化碳之代謝物，LOINC `12533-6`。

---

## 7. 特定化學物質作業 (Specific Chemical Operations)

*   **適用對象**：從事特定化學物質危害預防標準所定義之物質作業勞工。
*   **生物監測與實驗室檢查**：
    - **尿中無機砷 (Arsenic in Urine)**：LOINC `5586-3`。
    - **血中鎘/尿中鎘 (Cadmium)**：血中鎘 LOINC `5609-3`，尿中鎘 LOINC `5611-9`。
    - **尿中鉻 (Chromium in Urine)**：LOINC `5623-4`。
    - **尿中鎳 (Nickel in Urine)**：LOINC `14099-6`。
    - **血中汞/尿中汞 (Mercury)**：血中汞 LOINC `5685-3`，尿中汞 LOINC `5689-5`。
    - **尿中 t,t-黏康酸 (t,t-Muconic acid)**：苯之代謝指標，LOINC `72665-3`。
    - **尿中 MOCA (4,4'-Methylenebis(2-chloroaniline))**：LOINC `10913-2`。
    - **尿中甲醛 (Formaldehyde)**：LOINC `5653-1`。
    - **尿中聯苯胺 (Benzidine)**：LOINC `10909-0`。

---

## 8. 巴拉刈或聯吡啶作業與其它 (Paraquat & Others)

*   **適用對象**：製造、處置或使用巴拉刈或聯吡啶，以及有機磷農藥暴露之勞工。
*   **核心檢查項目**：
    - **尿中巴拉刈 (Paraquat in Urine)**：LOINC `9827-7`。
    - **血球乙醯膽鹼酯酶 (RBC AChE)**：有機磷農藥中毒指標，LOINC `1709-5`。
    - **血清膽鹼酯酶 (Serum Cholinesterase)**：有機磷農藥中毒指標，LOINC `2098-2`。
