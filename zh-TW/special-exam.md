# 特殊危害健康作業 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.2

## 特殊危害健康作業

# 特殊體格及健康檢查 (Special Physical & Health Examination)

特殊體格及健康檢查適用於從事特別危害健康作業之勞工。本指引依據勞動部《勞工健康保護規則》附表規定，將特別危害健康作業之實驗室與生理功能檢驗項目對應至國際標準 LOINC 代碼，並收錄於 [特殊健康檢查及體格檢查實驗室項目值集](ValueSet-VS-ExtendedDataset.md) 中。

依據實作指引之 **特別危害健康作業類別值集 (VS-HazardType)**，本指引對應並收錄以下特別危害健康作業類別之核心檢驗與評估項目。

> **第一期範疇說明（議題 5 / C-04）**：第一期以**噪音／鉛／粉塵**三模組為結構化必驗項目（收錄於 [VS-OccHealthCheck-Required](ValueSet-VS-OccHealthCheck-Required.md) 草案），並以 `TWHA-HearingTest`、`TWHA-LabResult-Special`、`TWHA-PulmonaryFunction` 等 Profile 個別建模。其餘附表十危害作業於第一期以 `TWHA-LabResult-Special` 通用承載（收錄於 `VS-ExtendedDataset`），尚未個別結構化，待後續期別依需求擴充。**共用／專屬解耦**：附表十以作業類別分列，項目高度重疊（多數作業共用 ALT、Creatinine、尿液、CBC 等）。本 IG 以 Core（`VS-CoreDataset`）承載共用項目，危害專屬項目以 `TWHA-LabResult-Special` 及專屬 Profile 承載，並以 `ext-hazard-type` 標記作業類別。

## 附表十 35 項法定作業涵蓋度對照（歸併為 12 危害家族） (Coverage Audit)

下表以《勞工健康保護規則》**附表十（115.06.26 修正）所列 35 項**特別危害健康作業為列主鍵（編號 1–35），逐項標註對應之本 IG `CS-HazardType` **12 危害家族**、代表性專屬檢查項目與承載方式。附表十編號 → 危害家族之完整對映另建置於 [ConceptMap Appendix10-to-HazardType](ConceptMap-Appendix10-to-HazardType.md)；家族代碼集見 [CS-HazardType](CodeSystem-CS-HazardType.md)、附表十作業代碼集見 [CS-Appendix10Operation](CodeSystem-CS-Appendix10Operation.md)。「共用項目」收錄於 Core（`VS-CoreDataset`），「專屬項目」收錄於 `VS-ExtendedDataset`；★ 為第一期已結構化必驗模組。

> **口徑說明（更正）**：本表舊版以「18 類」呈現，係依專屬檢查項目歸併之敘述數，非附表十法定項目數。附表十逐號列舉，115.06.26 修正後為 **35 項**（舊 32 項＋新增 33 苯乙烯／34 甲苯／35 二甲苯）；本版改以 35 項為列主鍵，並保留 12 家族歸併欄，以符法規口徑並回應審查意見（李偉帆委員）。

> **情境值集（③）落地狀態**：附表十各家族之**專屬應執行項目**已開始以機器可讀值集定義， 供法定完整性稽核（用法同[一般體格及健康檢查 §4.2](general-exam.md)）。 grouping：[VS-Appendix10-RequiredSet](ValueSet-VS-Appendix10-RequiredSet.md)。 **目前僅含臨床審查狀態為「已審／已驗」之四家族**—— [噪音](ValueSet-VS-Appendix10-Noise-RequiredSet.md)、 [鉛](ValueSet-VS-Appendix10-Lead-RequiredSet.md)、 [粉塵](ValueSet-VS-Appendix10-Dust-RequiredSet.md)、 [有機溶劑](ValueSet-VS-Appendix10-OrganicSolvent-RequiredSet.md)。 下表「臨床審查狀態」欄仍為「未審」之家族，其專屬代碼**刻意尚未納入值集**—— 未經臨床確認之代碼不寫進法定必驗值集（見[未決事項 M-8](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#m-8)）。 任一家族之完整情境需求 ＝ 對應家族值集 ∪ [VS-Appendix9-RequiredSet](ValueSet-VS-Appendix9-RequiredSet.md)。

| | | | | | | |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 高溫作業 | `high-temp` | 心電圖`11524-6`、電解質 Na/K/Cl、BUN`3094-0`、eGFR`98979-8`、尿比重`5810-7` | ✓ | 未審 | 部分驗證 |
| 2 ★ | 噪音作業 | `noise` | 純音聽力 Panel`89015-2`（0.5–8 kHz 雙耳 14 碼）/`TWHA-HearingTest` | ✓ | 已審 | 已驗 |
| 3 | 游離輻射作業 | `radiation` | CBC＋白血球分類、TSH`11580-8`／Free T4`3024-7`、皮膚/眼晶體（理學） | ✓ | 未審 | 部分驗證 |
| 4 | 異常氣壓作業 | `abnormal-pressure` | 肺功能`19868-9`/`20150-9`/`19926-5`、長骨 X 光`24579-5`、心電圖`11524-6`、聽力 | ✓ | 未審 | 部分驗證 |
| 5 ★ | 鉛作業 | `lead` | 血中鉛`77307-7`（Acc`5671-3`／`23749-5`）、尿中鉛`5676-2`、Copro`11212-8`、ALA`11215-1`、CBC | ✓ | 已審 | 已驗 |
| 6 | 四烷基鉛作業 | `tetraalkyl-lead` | 尿中鉛/Copro/ALA、神經精神（理學） | ✓ | 未審 | 部分驗證 |
| 7 | 1,1,2,2-四氯乙烷作業 | `organic-solvent` | 肝功能 ALT/γ-GT`2324-2`、腎功能 | ✓ | 已審 | 已驗 |
| 8 | 四氯化碳作業 | `organic-solvent` | 肝腎功能 | ✓ | 已審 | 已驗 |
| 9 | 二硫化碳作業 | `organic-solvent` | 尿中 TTCA`12533-6`、心電圖`11524-6`、眼底（理學）、血脂 | ✓ | 已審 | 已驗 |
| 10 | 三氯乙烯作業 | `organic-solvent` | 尿中三氯乙酸`3041-1`、肝功能 | ✓ | 已審 | 已驗 |
| 11 | 二甲基甲醯胺（DMF）作業 | `organic-solvent` | 尿中 N-甲基甲醯胺`12543-5`、肝功能 | ✓ | 已審 | 已驗 |
| 12 | 正己烷作業 | `organic-solvent` | 尿中 2,5-己二酮`31170-4`、神經學 | ✓ | 已審 | 已驗 |
| 13 | 聯苯胺及其鹽類作業 | `specific-chemical` | 尿中聯苯胺`10909-0`、尿液細胞學/尿潛血 | 部分（尿液細胞學待補） | 未審 | 部分驗證 |
| 14 | 鈹及其化合物作業 | `specific-chemical` | 胸部 X 光`36643-5`、肺功能、皮膚（理學） | ✓（鈹無定量 LOINC） | 未審 | 部分驗證 |
| 15 | 氯乙烯作業 | `specific-chemical` | 肝功能、腹部超音波`24558-9`、手部 X 光 | 部分（手部 X 光待補） | 未審 | 部分驗證 |
| 16 | 苯作業 | `specific-chemical` | CBC＋分類、尿中酚`2758-1`、尿中 t,t-黏康酸`72665-3` | ✓ | 未審 | 部分驗證 |
| 17 | 2,4-二異氰酸甲苯（TDI）作業 | `specific-chemical` | 肺功能、胸部 X 光`36643-5`、呼吸道（理學） | ✓ | 未審 | 部分驗證 |
| 18 | 石綿作業 | `specific-chemical` | 胸部 X 光`36643-5`（胸膜）、肺功能 | ✓ | 未審 | 部分驗證 |
| 19 | 砷及其化合物作業 | `specific-chemical` | 尿中無機砷`5586-3`、皮膚/鼻中膈（理學） | ✓ | 未審 | 部分驗證 |
| 20 | 錳及其化合物作業 | `specific-chemical` | 血錳`5681-2`/尿錳`42221-2`、神經學 | ✓ | 未審 | 部分驗證 |
| 21 | 黃磷作業 | `yellow-phosphorus` | 下顎骨 X 光`24829-4`、血清磷`2777-1`、肝功能 | ✓ | 未審 | 部分驗證 |
| 22 | 聯吡啶或巴拉刈作業 | `paraquat` | 尿中巴拉刈`9827-7`、肺功能、胸部 X 光`36643-5` | ✓ | 未審 | 部分驗證 |
| 23 ★ | 粉塵作業 | `dust` | 胸部 X 光`36643-5`、肺功能 FVC/FEV1 | ✓ | 已審 | 已驗 |
| 24 | 鉻酸及其鹽類作業 | `specific-chemical` | 血鉻`5622-6`/尿鉻`5623-4`、鼻中膈（理學） | ✓ | 未審 | 部分驗證 |
| 25 | 鎘及其化合物作業 | `specific-chemical` | 血鎘`5609-3`/尿鎘`5611-9`、腎功能、肺功能 | ✓ | 未審 | 部分驗證 |
| 26 | 鎳及其化合物作業 | `specific-chemical` | 尿中鎳`14099-6`、eGFR`98979-8`、呼吸道（理學） | ✓ | 未審 | 部分驗證 |
| 27 | 乙基汞化合物作業 | `specific-chemical` | 血汞`5685-3`、eGFR`98979-8`、神經學 | ✓ | 未審 | 部分驗證 |
| 28 | 溴丙烷作業 | `specific-chemical` | 神經學、CBC、肌肉骨骼（理學） | ✓ | 未審 | 部分驗證 |
| 29 | 1,3-丁二烯作業 | `specific-chemical` | CBC＋白血球分類 | ✓ | 未審 | 部分驗證 |
| 30 | 甲醛作業 | `specific-chemical` | 尿中甲醛`5653-1`、CBC、呼吸道/皮膚（理學） | ✓ | 未審 | 部分驗證 |
| 31 | 銦及其化合物作業 | `specific-chemical` | 血清銦`60090-8`/血中銦`5665-5`、肺功能 | ✓ | 未審 | 部分驗證 |
| 32 | 汞及其無機化合物作業 | `specific-chemical` | 血汞`5685-3`/尿汞`5689-5`、eGFR`98979-8`、神經學 | ✓ | 未審 | 部分驗證 |
| 33 | 苯乙烯作業 | `organic-solvent` | 尿中扁桃酸`13000-5`、肝腎功能 | ✓（115.06.26 新增・**過渡期**） | 已審 | 已驗 |
| 34 | 甲苯作業 | `organic-solvent` | 尿中馬尿酸`6709-0`、肝腎功能 | ✓（115.06.26 新增・**過渡期**） | 已審 | 已驗 |
| 35 | 二甲苯作業 | `organic-solvent` | 尿中甲基馬尿酸`2725-0`、eGFR`98979-8` | ✓（115.06.26 新增・**過渡期**） | 已審 | 已驗 |

> **臨床適當性註記**：(1) 噪音純音聽力圖為 0.5–8 kHz 雙耳 14 個氣導聽閾 LOINC 代碼（`89015-2` panel 成員）；院內/職醫另用之 `21104-5` 系列列為 Acceptable 變異碼。(2) FEV1 正確 LOINC 為 `20150-9`。(3) **eGFR（腎絲球過濾率）**：115.06.26 修正於高溫、鎳、乙基汞、汞及其無機化合物、二甲苯等類別新增，本 IG 以 `98979-8`（CKD-EPI 2021，Core 已收）承載，MDRD `33914-3` 為 Acceptable。(4) 手部 X 光（氯乙烯）、尿液細胞學（聯苯胺類）目前以通用承載，代碼結構化待後續期別補齊。(5) 鈹之生物偵測無公認定量 LOINC，以定性/理學評估記錄。

> **⚠️ 過渡期聲明（附表十編號 33 苯乙烯／34 甲苯／35 二甲苯）**：本三項為《勞工健康保護規則》115.06.26 修正新增之具名作業。其**施行日期、既有勞工銜接適用與過渡期安排，尚待向勞動部職業安全衛生署確認**。本 IG 已先行建立對應代碼（苯乙烯：尿中扁桃酸 `13000-5`；甲苯：尿中馬尿酸 `6709-0`；二甲苯：尿中甲基馬尿酸 `2725-0`）與家族歸併（`organic-solvent`），惟均屬**過渡期之暫定配置**；正式施行辦法公告後，應據以覆核檢查項目、週期與代碼配置。（對應文件一 v3.2 §4.3、文件二 v3.2 §3、附件 v5.3）

-------

## 1. 高溫作業 (High Temperature Operations)

* **適用對象**：高溫作業勞工作息時間標準所稱之高溫作業勞工。
* **核心生理與實驗室檢查項目**： 
* **心電圖檢查 (ECG)**：LOINC `11524-6` (EKG study)。
* **血清電解質檢查**：血清鈉 Sodium (LOINC `2951-2`)、血清鉀 Potassium (LOINC `2823-3`) 與血清氯 Chloride (LOINC `2075-0`)。
* **腎功能與造血**：尿素氮 BUN (LOINC `3094-0`)、肌酸酐 Creatinine (LOINC `2160-0`)、血色素 Hb (LOINC `718-7`)（共用項目，收錄於 Core）。
* **尿比重 (Urine Specific Gravity)**：LOINC `5810-7`，用以評估勞工於高溫暴露下之脫水及水分平衡狀態。
 

-------

## 2. 噪音作業 (Noise Operations)

* **適用對象**：連續八小時工作期間之均權音量達八十五分貝以上之作業勞工。
* **核心生理與實驗室檢查項目**： 
* **外耳與鼓膜檢查**：理學檢查 `TWHA-PhysicalExam` 記錄外耳道及鼓膜狀態。
* **純音聽力測試 (Audiometry)**：使用 `TWHA-HearingTest` 記錄，Panel 代碼為 LOINC `89015-2` (Pure tone threshold audiometry panel)。以 `component` 切片記錄雙耳在 500、1000、2000、3000、4000、6000、8000 Hz 等 7 個頻率之氣導聽閾（左右耳共 14 個 LOINC 代碼，如左耳 500 Hz `89024-4`、右耳 500 Hz `89025-1` 等，均為 89015-2 panel 之成員）。單位為 dB HL，依 ISO 1999 判定各頻率閾值。
 

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
 
* **甲狀腺功能檢查**：甲狀腺刺激素 TSH (LOINC `11580-8`) 與游離甲狀腺素 Free T4 (LOINC `3024-7`)，評估游離輻射對甲狀腺之影響（附表十游離輻射作業要求項目）。
 

-------

## 4. 異常氣壓作業 (Abnormal Pressure Operations)

* **適用對象**：從事潛水作業或高壓室內作業之勞工。
* **核心生理與實驗室檢查項目**： 
* **心電圖檢查 (ECG Study)**：採用 `TWHA-ECG` 記錄心電圖檢查結果（LOINC `11524-6`）。
* **肺功能檢查 (Spirometry)**：FVC (LOINC `19868-9`)、FEV1 (LOINC `20150-9`) 及 FEV1/FVC 比值 (LOINC `19926-5`)，評估氣壓急遽變化下之呼吸系統耐受力。
* **骨骼 X 光檢查 (Bone X-ray)**：針對肩關節、髖關節及股骨等進行 X 光大骨骼篩檢（LOINC `24579-5`），以評估是否有減壓病引起之無菌性骨壞死（Aseptic Bone Necrosis）。
* **聽力檢查**：以 `TWHA-HearingTest`（Panel `89015-2`）評估氣壓變化對中耳/內耳之影響。
 

-------

## 5. 鉛作業 (Lead Operations)

* **適用對象**：從事鉛及其化合物之作業勞工（不含四烷基鉛）。
* **核心生理與實驗室檢查項目**： 
* **血中鉛含量 (Blood Lead)**：Preferred 代碼為 LOINC `77307-7` (Lead in Venous blood；v20260726 由 `5671-3` 改列，該碼 LOINC 狀態為 DISCOURAGED)，單位：`ug/dL`；院內 LIS（如林口長庚）常以 `23749-5` (Lead in Specimen) 報告，列為 Acceptable 對應碼。
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
* **肺功能檢查 (Spirometry)**：採用 `TWHA-PulmonaryFunction`。記錄 FVC (LOINC `19868-9`)、FEV1 (LOINC `20150-9`) 及 FEV1/FVC 比值 (LOINC `19926-5`)。
 

-------

## 8. 有機溶劑作業 (Organic Solvent Operations)

* **適用對象**：從事有機溶劑中毒預防規則所定義之有機溶劑作業勞工（如甲苯、二甲苯、苯等）。
* **肝腎功能與血液 (共用項目)**：肝功能 ALT (LOINC `1742-6`)、γ-GT (LOINC `2324-2`)，腎功能 Creatinine (LOINC `2160-0`)，及 CBC（收錄於 Core），並輔以神經學理學檢查。二硫化碳作業另需心電圖 (LOINC `11524-6`)、血脂與眼底檢查。
* **各溶劑之尿中生物監測代謝物**： 
* **尿中馬尿酸 (Hippuric acid)**：甲苯（Toluene）之代謝物，LOINC `6709-0`。〔附表十 34 甲苯作業，115.06.26 新增，**過渡期暫定配置**〕
* **尿中甲基馬尿酸 (Methylhippuric acid)**：二甲苯（Xylene）之代謝物，LOINC `2725-0`。〔附表十 35 二甲苯作業，115.06.26 新增，**過渡期暫定配置**〕
* **尿中扁桃酸 (Mandelic acid)**：苯乙烯（Styrene）之代謝物，LOINC `13000-5`。〔附表十 33 苯乙烯作業，115.06.26 新增，**過渡期暫定配置**；第 19 條另定苯乙烯相關紀錄保存 30 年〕
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
* 血中錳 (LOINC `5681-2`) 與尿中錳 (LOINC `42221-2` 莫耳／`5684-6` 質量)。
 
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
* 肺功能檢查：FVC (LOINC `19868-9`)、FEV1 (LOINC `20150-9`) 及 FEV1/FVC 比值 (LOINC `19926-5`)，藉以監測巴拉刈引起的肺部纖維化早期病變。
 
* **肝腎功能評估**：AST (`1920-8`)、ALT (`1742-6`)、Creatinine (`2160-0`) 與 BUN (`3094-0`)。
 

-------

## 12. 其他指定作業 (Other Operations)

* **適用對象**：銦作業、鈷作業、甲基溴作業、有機磷農藥暴露作業等其他指定特別危害作業勞工。
* **核心生理與實驗室檢查項目**： 
* **銦作業 (Indium)**：血中銦 (LOINC `5665-5`) 及血清銦 (LOINC `60090-8`)。
* **鈷作業 (Cobalt)**：血中鈷 (LOINC `5625-9`) 及血清鈷 (LOINC `5627-5`)。
* **甲基溴作業 (Methyl Bromide)**：血清溴 (LOINC `1984-4`) 及尿溴 (LOINC `1985-1`)。
* **有機磷農藥暴露 (Pesticides)**：血球乙醯膽鹼酯酶 RBC AChE (LOINC `1709-5`) 與血清膽鹼酯酶 Serum Cholinesterase (LOINC `2098-2`)。
 

