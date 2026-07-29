ValueSet: VS_ExtendedDataset
Id: VS-ExtendedDataset
Title: "健康檢查進階與領域擴充項目值集"
Description: "包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。"
* ^experimental = false

// =================================================================
// 1. 勞工特殊健康檢查項目 (Occupational Special Health Checks)
// =================================================================

// 1.1 高溫作業 (high-temp) — 心血管、腎功能、電解質、尿液
// 附表十高溫作業另需飯前血糖、BUN、Cr、Hb（共用項目，收錄於 VS-CoreDataset）
* LNC#11524-6 "EKG study"                                        // 心電圖
* LNC#2951-2 "Sodium [Moles/volume] in Serum or Plasma"          // 鈉
* LNC#2823-3 "Potassium [Moles/volume] in Serum or Plasma"       // 鉀
* LNC#2075-0 "Chloride [Moles/volume] in Serum or Plasma"        // 氯（v1.1 補齊電解質三項）
* LNC#3094-0 "Urea nitrogen [Mass/volume] in Serum or Plasma"    // BUN（腎功能/脫水評估）
* LNC#5810-7 "Specific gravity of Urine by Refractometry"                         // 尿比重（脫水評估）

// 1.2 噪音作業 (noise) — 純音氣導聽閾個別頻率代碼
// v1.1 修正：更正 v3 之錯置代碼並補齊 3/6/8 kHz，使全部代碼與 LOINC 89015-2 panel 成員一致，
//            涵蓋《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率（7 頻率 × 左右耳 = 14 碼）。
// Panel code 89015-2 收錄於 VS-CoreDataset，本 VS 收錄個別頻率/耳別代碼。
* LNC#89015-2 "Pure tone air conduction threshold audiometry panel"              // Panel (重複收錄供查詢)
// 左耳 (Left ear) 0.5–8 kHz
* LNC#89024-4 "Hearing threshold Ear - left --500 Hz"
* LNC#89016-0 "Hearing threshold Ear - left --1000 Hz"
* LNC#89018-6 "Hearing threshold Ear - left --2000 Hz"
* LNC#89020-2 "Hearing threshold Ear - left --3000 Hz"
* LNC#89022-8 "Hearing threshold Ear - left --4000 Hz"
* LNC#89026-9 "Hearing threshold Ear - left --6000 Hz"
* LNC#89028-5 "Hearing threshold Ear - left --8000 Hz"
// 右耳 (Right ear) 0.5–8 kHz
* LNC#89025-1 "Hearing threshold Ear - right --500 Hz"
* LNC#89017-8 "Hearing threshold Ear - right --1000 Hz"
* LNC#89019-4 "Hearing threshold Ear - right --2000 Hz"
* LNC#89021-0 "Hearing threshold Ear - right --3000 Hz"
* LNC#89023-6 "Hearing threshold Ear - right --4000 Hz"
* LNC#89027-7 "Hearing threshold Ear - right --6000 Hz"
* LNC#89029-3 "Hearing threshold Ear - right --8000 Hz"

// (-確定無合適碼) 聽力 acceptable 變異碼：原列 21104-5 等 15 碼，經 tx.fhir.org $lookup 逐碼查證，
//   其真實語意為過敏原 RAST 檢測、Borrelia 抗體、酵素與重金屬等項目（多數為 LOINC DEPRECATED），
//   與純音聽力完全無關，已於 v20260726 全數移除。聽力代碼以 89015-2 panel 及其 14 個頻率成員碼為準。
//   治理紀錄：此類錯誤不被 IG Publisher 攔截（僅驗代碼存在，不驗 ValueSet 內顯示名語意）。

// 1.3 游離輻射作業 (radiation) — CBC 與白血球分類、甲狀腺功能、皮膚/眼晶體（理學檢查）
// v1.1 補齊：附表十游離輻射作業另需甲狀腺功能監測（TSH、Free T4）
* LNC#789-8 "Erythrocytes [#/volume] in Blood by Automated count"
* LNC#6690-2 "Leukocytes [#/volume] in Blood by Automated count"
* LNC#777-3 "Platelets [#/volume] in Blood by Automated count"
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood"
* LNC#4544-3 "Hematocrit [Volume Fraction] of Blood by Automated count"
* LNC#770-8 "Neutrophils/Leukocytes in Blood by Automated count"
* LNC#736-9 "Lymphocytes/Leukocytes in Blood by Automated count"
* LNC#11580-8 "Thyrotropin [Units/volume] in Serum or Plasma by Detection limit <= 0.005 mIU/L"    // TSH（輻射甲狀腺監測）
* LNC#3024-7 "Thyroxine (T4) free [Mass/volume] in Serum or Plasma" // Free T4（輻射甲狀腺監測）

// 1.4 異常氣壓作業 (abnormal-pressure) — 肺功能、長骨關節 X 光、心電圖
// v1.1 修正：FEV1 之正確 LOINC 為 20150-9（原 19868-9 實為 FVC，已更正）
* LNC#24579-5 "XR Bones.long Survey"                              // 長骨/關節 X 光（減壓性骨壞死）
* LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry"  // FVC (Preferred：方法通用碼)
* LNC#20150-9 "FEV1" // FEV1（正確碼）
* LNC#19926-5 "FEV1/FVC" // FEV1/FVC
// 心電圖 11524-6（潛水/高壓作業心血管評估）已收錄於 1.1 高溫作業，不重複收錄

// 1.5 鉛作業 (lead)
* LNC#77307-7 "Lead [Mass/volume] in Venous blood"                // 血中鉛 Preferred（v20260726 由 5671-3 改列；5671-3 之 LOINC 狀態為 DISCOURAGED）
* LNC#5671-3 "Lead [Mass/volume] in Blood"                        // Acceptable：檢體未指定之舊碼（LOINC DISCOURAGED），經 ConceptMap 歸一至 77307-7
* LNC#5676-2 "Lead [Mass/volume] in Urine"
* LNC#23749-5 "Lead [Mass/volume] in Specimen"
* LNC#11212-8 "Coproporphyrin [Mass/volume] in Urine"
* LNC#11215-1 "Delta aminolevulinate [Mass/volume] in Urine"

// 1.6 四烷基鉛作業 (tetraalkyl-lead) — 與鉛作業共用以下代碼（已收錄於 1.5，此處不重複）
// 另有特有代碼：無（四烷基鉛主要透過皮膚及呼吸道吸收，生物標記與鉛作業相同）

// 1.7 粉塵作業 / 游離二氧化矽 (dust / crystalline silica) — 胸部 X 光、肺功能（FVC/FEV1/比值）
// 塵肺症分級以胸部 X 光判讀；肺功能碼收錄於 1.4。24648-8 為附表九一般胸部 X 光（單張 PA）之對應碼。
* LNC#36643-5 "XR Chest 2 Views"                                 // 胸部 X 光（2 views，塵肺症）
* LNC#24648-8 "XR Chest PA upright"                              // 胸部 X 光（單張 PA，附表九一般大片）

// 1.8 有機溶劑作業 (organic-solvent) — 肝功能、腎功能、CBC、神經學檢查、尿中代謝物
// 附表十有機溶劑作業另需肝功能監測（ALT、γ-GT，收錄於 VS-CoreDataset）；以下為各溶劑之尿中生物偵測代謝物
* LNC#2324-2 "Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma" // γ-GT（肝功能，v1.1 明列）
* LNC#6709-0 "Hippurate [Mass/volume] in Urine"                  // 馬尿酸（甲苯）
* LNC#2725-0 "Para methylhippurate [Mass/volume] in Urine"         // 甲基馬尿酸（二甲苯）
* LNC#13000-5 "Mandelate [Mass/volume] in Urine"                // 扁桃酸（苯乙烯）
* LNC#3041-1 "Trichloroacetate [Mass/volume] in Urine"          // 三氯乙酸（三氯乙烯/四氯乙烯）
* LNC#31170-4 "2,5-Hexanedione [Mass/volume] in Urine"          // 2,5-己二酮（正己烷）
* LNC#2758-1 "Phenol [Mass/volume] in Urine"                    // 酚（苯）
* LNC#12543-5 "Methyl formamide [Mass/volume] in Urine"          // N-甲基甲醯胺（DMF）
* LNC#12533-6 "Thiazolidine-2-Thione-4-Carboxylic acid [Mass/volume] in Urine"                     // TTCA（二硫化碳）
// 二硫化碳作業 (carbon disulfide) 另需心電圖（11524-6，已收錄於 1.1）、血脂（Core）、眼底檢查（理學）

// 1.9 特定化學物質作業 (specific-chemical)
* LNC#5586-3 "Arsenic [Mass/volume] in Urine"
* LNC#5609-3 "Cadmium [Mass/volume] in Blood"
* LNC#5611-9 "Cadmium [Mass/volume] in Urine"
* LNC#13471-8 "Cadmium/Creatinine [Mass Ratio] in Urine"
* LNC#5622-6 "Chromium [Mass/volume] in Serum or Plasma"
* LNC#5623-4 "Chromium [Mass/volume] in Urine"
* LNC#13464-3 "Chromium/Creatinine [Mass Ratio] in Urine"
* LNC#14099-6 "Nickel [Mass/volume] in Urine"
* LNC#5685-3 "Mercury [Mass/volume] in Blood"
* LNC#5689-5 "Mercury [Mass/volume] in Urine"
* LNC#72665-3 "trans,trans-Muconic acid [Mass/volume] in Urine"
* LNC#10913-2 "4,4'-Methylene bis(2-Chloroaniline) [Mass/volume] in Urine"
* LNC#5653-1 "Formaldehyde [Mass/volume] in Urine"
* LNC#10909-0 "Benzidine [Mass/volume] in Urine"
* LNC#5681-2 "Manganese [Mass/volume] in Blood"
* LNC#5683-8 "Manganese [Mass/volume] in Serum or Plasma"
* LNC#42221-2 "Manganese [Moles/volume] in Urine"  // 2026-07-29 JOB-01 批3 Q2-1：官方為莫耳（舊標質量有誤，碼本身為莫耳）；院方以 µg/L 質量報告，質量碼見下 5684-6
* LNC#5684-6 "Manganese [Mass/volume] in Urine"    // 院方所用之質量碼（µg/L, Q2-1）；WebSearch 取自 loinc.org，經 CI $lookup 覆核
* LNC#34304-6 "Fluoride [Moles/volume] in Urine"  // 2026-07-29 JOB-01 批2：官方為莫耳濃度（Q2-2）；質量碼見下 5650-7
* LNC#5650-7 "Fluoride [Mass/volume] in Urine"    // 2026-07-29 JOB-01 批3：批2 誤薦之 5605-7 不存在於 LOINC，正確質量碼為 5650-7（mg/L, Q2-2）；WebSearch 取自 loinc.org，經 CI $lookup 覆核

// 1.10 黃磷作業 (yellow-phosphorus)
* LNC#2777-1 "Phosphate [Mass/volume] in Serum or Plasma"
* LNC#24829-4 "XR Mandible Views"

// 1.11 聯吡啶或巴拉刈作業 (paraquat)
* LNC#9827-7 "Paraquat [Mass/volume] in Urine"

// 1.12 其他指定與農藥作業 (other / pesticides)
* LNC#60090-8 "Indium [Mass/volume] in Serum or Plasma"
* LNC#5665-5 "Indium [Mass/volume] in Blood"
* LNC#5627-5 "Cobalt [Mass/volume] in Serum or Plasma"
* LNC#5625-9 "Cobalt [Mass/volume] in Blood"
* LNC#1984-4 "Bromide [Mass/volume] in Serum or Plasma"
* LNC#1985-1 "Bromide [Mass/volume] in Urine"
* LNC#1709-5 "Acetylcholinesterase [Enzymatic activity/volume] in Red Blood Cells"
* LNC#2098-2 "Cholinesterase [Enzymatic activity/volume] in Serum or Plasma"

// 1.13 微生物培養 (Microbiological Culture) [NEW]
* LNC#43371-4 "Salmonella and Shigella sp identified in Stool by Organism specific culture"  // 2026-07-29 JOB-01 批2：批1 顯示名多轉抄一個「sp」，依 display-verification-report.csv 官方字串更正

// 1.14 尿液毒品篩檢 (Urine Drug Screening)
// v20260726：原列 19266-6/19299-7/19283-1/19501-6/19571-9 經 tx $lookup 查證，均為
//   「cutoff（閾值濃度）」概念碼（[Mass/volume] ... for Screen method，單位 ng/mL），
//   非篩檢「結果」碼；本 IG 用途為記錄篩檢結果，已改列對應之 [Presence] 結果碼。
* LNC#3349-8 "Amphetamines [Presence] in Urine"
* LNC#3879-4 "Opiates [Presence] in Urine"
* LNC#3390-2 "Benzodiazepines [Presence] in Urine"
* LNC#12327-3 "Ketamine [Presence] in Urine"
* LNC#14267-9 "Methylenedioxymethamphetamine [Presence] in Urine"

// 1.15 癌症篩檢與 PHI (Cancer Markers/PHI) — v1.1 自 VS-CoreDataset 移入（develop.md §3.2）
* LNC#19177-5 "Alpha-1-Fetoprotein [Moles/volume] in Serum or Plasma"  // 2026-07-29 JOB-01 批2：官方為莫耳濃度（Q2-3）；院內以 ng/mL 質量報告，質量碼見 1834-1（通用）與 53962-7（免疫分析法）
* LNC#53962-7 "Alpha-1-fetoprotein.tumor marker [Mass/volume] in Serum or Plasma"  // 檢驗醫學部所用之質量碼（ng/mL, Q2-3）；CI 查證官方為腫瘤標記型 AFP 質量碼，適用於本節癌症篩檢情境，顯示名已依官方更正
* LNC#2039-6 "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
* LNC#2857-1 "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* LNC#10886-0 "Prostate Specific Ag Free [Mass/volume] in Serum or Plasma"
* LNC#97149-9 "proPSA isoform 2 [Mass/volume] in Serum or Plasma by Immunoassay"
* LNC#97150-7 "Prostate health index in Serum or Plasma by calculation"
* LNC#10334-1 "Cancer Ag 125 [Units/volume] in Serum or Plasma"
* LNC#83082-8 "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#83085-1 "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* LNC#24108-3 "Cancer Ag 19-9 [Units/volume] in Serum or Plasma"
* LNC#83084-4 "Cancer Ag 19-9 [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#83083-6 "Cancer Ag 15-3 [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#83112-3 "Prostate specific Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* LNC#1834-1 "Alpha-1-fetoprotein [Mass/volume] in Serum or Plasma"
* LNC#9679-2 "Squamous cell carcinoma Ag [Mass/volume] in Serum or Plasma"
* LNC#19113-0 "IgE [Units/volume] in Serum or Plasma"
* LNC#9633-9 "Epstein Barr virus capsid IgA Ab [Titer] in Serum by Immunofluorescence"  // 2026-07-29 JOB-01 批3 Q4-2：顯示名改官方（原標 [Presence] 有誤）。⚠️ 院方實以 EIA 報 U/mL 定量，惟 LOINC 無 capsid IgA [Units/volume] by Immunoassay 碼（僅 IgG 5157-3／IgM 5159-9 有），本碼為 IFA 效價；方法/量表落差為 LOINC 缺口，待裁示（open-issues T-1）

// 1.16 進階心血管與自體免疫 (Advanced Cardiac/Autoimmune) — v1.1 自 VS-CoreDataset 移入（develop.md §3.2）
* LNC#10835-7 "Lipoprotein A [Mass/volume] in Serum or Plasma"
* LNC#1869-7 "Apolipoprotein A-I [Mass/volume] in Serum or Plasma"
* LNC#1884-6 "Apolipoprotein B [Mass/volume] in Serum or Plasma"
* LNC#33762-6 "Natriuretic peptide.B prohormone N-Terminal [Mass/volume] in Serum or Plasma"
* LNC#42254-3 "Nuclear Ab [Presence] in Serum by Immunofluorescence"
* LNC#11572-5 "Rheumatoid factor [Units/volume] in Serum or Plasma"
* LNC#25390-6 "Cytokeratin 19 [Mass/volume] in Serum or Plasma"

// =================================================================
// 2. 自費健康檢查常見之進階影像學及鏡檢項目 (Advanced Imaging & Endoscopy)
// =================================================================

// 2.1 乳房攝影 (Mammography)
* LNC#24606-6 "MG Breast Screening"
* LNC#103892-6 "DBT Brst Screening" // 3D乳房斷層攝影

// 2.2 腦部核磁共振造影 (Brain MRI)
* LNC#24590-2 "MR Brain"

// 2.3 肺部低劑量電腦斷層 (Lung LDCT)
* LNC#79086-5 "CT Chest Screening WO contr"
* LNC#87279-6 "CT Chest Screening"

// 2.4 全身正子造影 (Whole body FDG PET/CT)
* LNC#81555-5 "PT+CT Whole body Tum loc W 18F-FDG IV"

// 2.5 心臟冠狀動脈電腦斷層血管攝影 (Cardiac CTA)
* LNC#79073-3 "CTA Hrt+CA W contr IV"

// 2.6 內視鏡檢查 (GI Endoscopy)
* LNC#28014-9 "EGD Study" // 胃鏡檢查
* LNC#28023-0 "Colonoscopy Study" // 大腸鏡檢查

// 2.7 超音波檢查 (Ultrasounds)
* LNC#24558-9 "US Abdomen" // 腹部超音波
* LNC#24616-5 "US Carotid aa" // 頸動脈超音波
* LNC#25010-0 "US Thyroid" // 甲狀腺超音波

// 2.8 骨質密度檢查 (Bone Densitometry)
* LNC#38268-9 "DXA Skeletal Sys Views for BMD" // 雙能量X光骨密度儀(DEXA)

// =================================================================
// 3. 原 VS-CoreDataset 非上傳檢驗碼（Wave 2 甲案自 Core 移入；依「不刪碼只移層」）
//    文件一/二 v3.1：Core = 主管機關最小上傳集(21列)。以下依原 Core 臨床分組排列，
//    與《完整編碼附件》Extended 分頁之『區段/家族』欄一致。
// =================================================================

// 3-x 血液學
* LNC#13046-8 "Variant lymphocytes/Leukocytes in Blood"
* LNC#13047-6 "Plasma cells/Leukocytes in Blood"
* LNC#19048-8 "Nucleated erythrocytes/Leukocytes [Ratio] in Blood"
* LNC#26446-5 "Blasts/Leukocytes in Blood"
* LNC#26450-7 "Eosinophils/Leukocytes in Blood"
* LNC#26464-8 "Leukocytes [#/volume] in Blood"                          // Acceptable: WBC unspecified
* LNC#26478-8 "Lymphocytes/Leukocytes in Blood"
* LNC#26485-3 "Monocytes/Leukocytes in Blood"
* LNC#26498-6 "Myelocytes/Leukocytes in Blood"
* LNC#26505-8 "Segmented neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標 Hypersegmented）；⚠️ 待確認：如確需「過度分葉核」項目應另加 30450-1
* LNC#26508-2 "Band form neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標為總嗜中性球手工計數）
* LNC#26511-6 "Neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標 segmented）；⚠️ 待確認：如確需「手工計數」版本應另加 23761-0
* LNC#26515-7 "Platelets [#/volume] in Blood" // Acceptable: Plt Automated
* LNC#26524-9 "Promyelocytes/Leukocytes in Blood"
* LNC#28539-5 "MCH [Entitic mass]"            // Acceptable: MCH (full name)
* LNC#28541-1 "Metamyelocytes/Leukocytes in Blood"
* LNC#30180-4 "Basophils/Leukocytes in Blood"
* LNC#30413-9 "Abnormal lymphocytes/Leukocytes in Blood"
* LNC#30428-7 "MCV [Entitic mean volume] in Red Blood Cells"              // Acceptable: MCV calculation
* LNC#30441-0 "Monocytes Abnormal/Leukocytes in Blood"
* LNC#30466-7 "Promonocytes/Leukocytes in Blood"
* LNC#34921-7 "Lymphocytes Plasmacytoid/Leukocytes in Blood"
* LNC#5905-5 "Monocytes/Leukocytes in Blood by Automated count"
* LNC#19252-6 "Megakaryocytes/100 leukocytes in Blood"  // 2026-07-29 JOB-01 批3 Q7：完整巨核細胞/100 白血球碼（本即 IG 原欲表達者）；批2 之 70028-6=Megakaryocytic nuclei（細胞核）、62858-6=Micromegakaryocytes（微小巨核細胞）均非完整巨核細胞，故換用 19252-6；WebSearch 取自 loinc.org，經 CI $lookup 覆核
* LNC#706-2 "Basophils/Leukocytes in Blood by Automated count"
* LNC#713-8 "Eosinophils/Leukocytes in Blood by Automated count"
* LNC#731-0 "Lymphocytes [#/volume] in Blood by Automated count"
* LNC#751-8 "Neutrophils [#/volume] in Blood by Automated count"
* LNC#785-6 "MCH [Entitic mass] by Automated count"
* LNC#786-4 "MCHC [Entitic Mass/volume] in Red Blood Cells by Automated count"
* LNC#787-2 "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
* LNC#788-0 "Erythrocyte [DistWidth] in Blood by Automated count"
* LNC#804-5 "Leukocytes [#/volume] in Blood by Manual count"            // Acceptable: WBC Manual

// 3-x 生化、腎功能與心血管風險
* LNC#17861-6 "Calcium [Mass/volume] in Serum or Plasma"
* LNC#20448-7 "Insulin [Units/volume] in Serum or Plasma"
* LNC#2428-1 "Homocysteine [Mass/volume] in Serum or Plasma"  // 2026-07-29 JOB-01 批2：官方為質量濃度（Q2-4）；院內以 µmol/L 莫耳報告，莫耳碼 13965-9 為檢驗醫學部建議優先
* LNC#13965-9 "Homocysteine [Moles/volume] in Serum or Plasma"  // 檢驗醫學部建議優先之莫耳碼（µmol/L, Q2-4）；CI 已覆核六軸相符
* LNC#30522-7 "C reactive protein [Mass/volume] in Serum or Plasma by High sensitivity method"
* LNC#3084-1 "Urate [Mass/volume] in Serum or Plasma"
// (-確定無合適碼) 尿酸 acceptable：原列 49154-8 經 tx 查證實為 Rickettsia conorii IgG Ab [Titer]（地中海斑疹熱抗體），
//   非尿酸全血法，已於 v20260726 移除；如確有全血法需求，須經 $lookup 查證後再新增。
* LNC#33863-2 "Cystatin C [Mass/volume] in Serum or Plasma"
* LNC#33914-3 "Glomerular filtration rate [Volume Rate/Area] in Serum or Plasma by Creatinine-based formula (MDRD)/1.73 sq M"  // 2026-07-29 JOB-01 批2：批1 誤用舊式長名，依 display-verification-report.csv 官方字串更正（注意檢體軸為 Serum or Plasma，與 98979-8 之 Serum, Plasma or Blood 不同）
* LNC#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* LNC#47214-2 "Homeostasis model assessment"
* LNC#59261-8 "Hemoglobin A1c/Hemoglobin.total standardized per IFCC-RMP for CDT in Blood" // Acceptable: HbA1c IFCC
* LNC#98979-8 "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"

// 3-x 肝膽、胰臟與心肌功能
* LNC#10834-0 "Globulin [Mass/volume] in Serum by calculation"
* LNC#1743-4 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P"  // Acceptable: ALT with P-5'-P（2026-07-26 換碼，原 14390-9 實為透析液澱粉酶）
* LNC#30239-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P" // Acceptable: AST with P-5'-P（2026-07-26 換碼，原 14409-7 檢體為胸膜液）
* LNC#1742-6 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1744-2 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* LNC#1751-7 "Albumin [Mass/volume] in Serum or Plasma"
* LNC#1759-0 "Albumin/Globulin [Mass Ratio] in Serum or Plasma"
* LNC#1798-8 "Amylase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1920-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1968-7 "Bilirubin.direct [Mass/volume] in Serum or Plasma"
* LNC#1975-2 "Bilirubin.total [Mass/volume] in Serum or Plasma"
* LNC#2532-0 "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#2885-2 "Protein [Mass/volume] in Serum or Plasma"
* LNC#3040-3 "Lipase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#6768-6 "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#88112-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"

// 3-x 脂質分析
* LNC#13458-5 "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"  // 2026-07-26 換碼，原 46986-6 實為 VLDL 3 次分群
* LNC#9830-1 "Cholesterol.total/Cholesterol in HDL [Mass Ratio] in Serum or Plasma"

// 3-x 甲狀腺與營養指標
* LNC#2132-9 "Cobalamin (Vitamin B12) [Mass/volume] in Serum or Plasma"
* LNC#2284-8 "Folate [Mass/volume] in Serum or Plasma"
* LNC#3016-3 "Thyrotropin [Units/volume] in Serum or Plasma"  // Acceptable: TSH 3rd gen
* LNC#3026-2 "Thyroxine (T4) [Mass/volume] in Serum or Plasma"
* LNC#3051-0 "Triiodothyronine (T3) free [Mass/volume] in Serum or Plasma"
* LNC#3053-6 "Triiodothyronine (T3) [Mass/volume] in Serum or Plasma"
* LNC#62292-8 "25-Hydroxyvitamin D3+25-Hydroxyvitamin D2 [Mass/volume] in Serum or Plasma"
* LNC#8099-4 "Thyroperoxidase Ab [Units/volume] in Serum or Plasma"

// 3-x 傳染病、HPV與胃部篩檢
* LNC#13950-1 "Hepatitis A virus IgM Ab [Presence] in Serum or Plasma by Immunoassay"
* LNC#13952-7 "Hepatitis B virus core Ab [Presence] in Serum or Plasma by Immunoassay"
* LNC#17780-8 "Helicobacter pylori Ag [Presence] in Stool by Immunoassay"
* LNC#20507-0 "Reagin Ab [Presence] in Serum by RPR"
* LNC#21440-3 "Human papilloma virus 16+18+31+33+35+45+51+52+56 DNA [Presence] in Cervix by Probe"
* LNC#22322-2 "Hepatitis B virus surface Ab [Presence] in Serum"  // 2026-07-29 JOB-01 批2：官方為定性（Q3 回覆定量+定性併報，須將對調之標示改回正確位置）
* LNC#24110-9 "Treponema pallidum Ab [Presence] in Serum by Immunoassay"
* LNC#29771-3 "Hemoglobin [Presence] in Stool from gastrointestinal lower by Immunoassay"  // 糞便免疫化學法潛血(FIT)
* LNC#31147-2 "Reagin Ab [Titer] in Serum by RPR"
* LNC#5176-3 "Helicobacter pylori IgG Ab [Units/volume] in Serum by Immunoassay"  // 2026-07-29 JOB-01 Q4-1 裁示（使用者提供 LOINC 官方查詢）：本碼官方為定量（Scale Qn、Method IA），舊標 [Presence] 有誤；本院未執行此項故無臨床背書，惟採 LOINC 官方定量顯示名保留（open-issues T-1 選項 b）
* LNC#51913-2 "Hepatitis A virus IgG+IgM Ab [Presence] in Serum"
* LNC#5193-8 "Hepatitis B virus surface Ab [Units/volume] in Serum or Plasma by Immunoassay"  // 2026-07-29 JOB-01 批2：官方為定量（Q3，標示對調回正確位置）——本碼即定量 Anti-HBs；臨床建議之 65633-0 經 CI 查證實為 HBsAg（表面「抗原」）確認法、非 Anti-HBs（抗體），已剔除
* LNC#5334-8 "Rubella virus IgG Ab [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#5403-1 "Varicella zoster virus IgG Ab [Units/volume] in Serum by Immunoassay"
* LNC#56888-1 "HIV 1+2 Ab+HIV1 p24 Ag [Presence] in Serum or Plasma by Immunoassay"
* LNC#7962-4 "Measles virus IgG Ab [Units/volume] in Serum"

// 3-x 尿液常規
* LNC#11218-5 "Microalbumin [Mass/volume] in Urine by Test strip"
* LNC#11277-1 "Epithelial cells.squamous [#/area] in Urine sediment by Microscopy high power field"
* LNC#12453-7 "Phosphate crystals amorphous [Presence] in Urine sediment by Light microscopy"
* LNC#12454-5 "Urate crystals amorphous [Presence] in Urine sediment by Light microscopy"
* LNC#13658-0 "Urobilinogen [Presence] in Urine"
* LNC#13945-1 "Erythrocytes [#/area] in Urine sediment by Microscopy high power field"
* LNC#20456-0 "Fungi.yeastlike [Presence] in Urine sediment by Light microscopy"
* LNC#20621-9 "Albumin/Creatinine [Mass Ratio] in Urine by Test strip"
* LNC#5778-6 "Color of Urine"  // 2026-07-26 換碼，原 20627-6 實為尿液濁度 (Turbidity)
* LNC#25145-4 "Bacteria [Presence] in Urine sediment by Light microscopy"
* LNC#30004-6 "Creatinine [Mass/volume] in Urine by Test strip"
* LNC#32356-8 "Yeast [Presence] in Urine sediment by Light microscopy"
// 尿沉渣自動計數 — 2026-07-29 JOB-01 批3 Q1：院方 Sysmex UF-5000/UD-10 報「每 µL」（體積）。
//   原列 [#/area] in Urine sediment（每面積、鏡檢沉渣）碼全數用錯（display 標體積、code 卻是面積），
//   整批換為 [#/volume] in Urine by Automated count（每體積、全尿自動計數）碼。
//   候選碼由 WebSearch 取自 loinc.org，經 CI $lookup 覆核；同屬 LOINC 50554-5 全尿鏡檢定量套組。
* LNC#51480-2 "Bacteria [#/volume] in Urine by Automated count"                       // ← 33218-9
* LNC#51486-9 "Epithelial cells.squamous [#/volume] in Urine by Automated count"      // ← 33219-7
* LNC#51484-4 "Hyaline casts [#/volume] in Urine by Automated count"                  // ← 33223-9
* LNC#87926-2 "Epithelial cells [#/volume] in Urine by Automated"                     // ← 33342-7（通用上皮細胞）
* LNC#51483-6 "Casts [#/volume] in Urine by Automated count"                          // ← 43755-8
* LNC#798-9 "Erythrocytes [#/volume] in Urine by Automated count"                     // ← 46419-8
* LNC#51487-7 "Leukocytes [#/volume] in Urine by Automated count"                     // ← 46702-7
* LNC#51478-6 "Mucus [#/volume] in Urine by Automated count"                          // ← 50235-1
* LNC#50551-1 "Bilirubin.total [Presence] in Urine by Automated test strip"
* LNC#50555-2 "Glucose [Presence] in Urine by Automated test strip"
* LNC#50558-6 "Nitrite [Presence] in Urine by Automated test strip"
* LNC#50560-2 "pH of Urine by Automated test strip"
* LNC#50562-8 "Specific gravity of Urine by Refractometry automated"
* LNC#53324-0 "Spermatozoa [#/area] in Urine sediment by Automated count"  // JOB-01 批3 Q1：LOINC 無「[#/volume] in Urine by Automated count」之精子碼（僅 [Presence] 或鏡檢），無法比照其餘 8 項換體積碼；保留本碼、顯示名改回官方每面積，體積量化為 LOINC 缺口，待裁示（open-issues T-1）
* LNC#53975-9 "Drug crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5766-1 "Ammonium urate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5770-3 "Bilirubin.total [Presence] in Urine by Test strip"
* LNC#5771-1 "Bilirubin crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5773-7 "Calcium carbonate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#57734-6 "Ketones [Presence] in Urine by Automated test strip"
* LNC#5774-5 "Calcium oxalate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5775-2 "Calcium phosphate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#57751-0 "Hemoglobin [Presence] in Urine by Automated test strip"
* LNC#5777-8 "Cholesterol crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5784-4 "Cystine crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5787-7 "Epithelial cells [#/area] in Urine sediment by Microscopy high power field"
* LNC#5788-5 "Oval fat bodies (globules) [#/area] in Urine sediment by Microscopy high power field"
* LNC#5792-7 "Glucose [Mass/volume] in Urine by Test strip"
* LNC#5794-3 "Hemoglobin [Presence] in Urine by Test strip"
* LNC#5796-8 "Hyaline casts [#/area] in Urine sediment by Microscopy low power field"
* LNC#5797-6 "Ketones [Mass/volume] in Urine by Test strip"
* LNC#5799-2 "Leukocyte esterase [Presence] in Urine by Test strip"
* LNC#5802-4 "Nitrite [Presence] in Urine by Test strip"
* LNC#5803-2 "pH of Urine by Test strip"
* LNC#5813-1 "Trichomonas vaginalis [Presence] in Urine sediment by Light microscopy"
* LNC#5814-9 "Triple phosphate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5817-2 "Urate crystals [Presence] in Urine sediment by Light microscopy"
* LNC#5821-4 "Leukocytes [#/area] in Urine sediment by Microscopy high power field"
* LNC#60026-2 "Leukocyte esterase [Presence] in Urine by Automated test strip"
* LNC#62487-4 "Urobilinogen [Presence] in Urine by Automated test strip"

// 3-x 一般心血管與腎臟篩檢
* LNC#9318-7 "Albumin/Creatinine [Mass Ratio] in Urine"  // 2026-07-26 換碼，原 13705-9 檢體為 24 小時尿；⚠️ 待確認：健檢 ACR 若驗微白蛋白應改用 14959-1（Microalbumin/Creatinine）
* LNC#14957-5 "Microalbumin [Mass/volume] in Urine"
* LNC#1988-5 "C reactive protein [Mass/volume] in Serum or Plasma"
* LNC#2161-8 "Creatinine [Mass/volume] in Urine"
* LNC#4588-0 "Hemoglobin H/Hemoglobin.total in Blood"

// 3-x 糞便檢查
* LNC#10701-1 "Ova and parasites identified in Stool by Concentration"
* LNC#10704-5 "Ova and parasites identified in Stool by Light microscopy"
* LNC#13655-6 "Leukocytes [Presence] in Stool by Light microscopy"
* LNC#2335-8 "Hemoglobin [Presence] in Stool from gastrointestinal"
* LNC#33668-5 "Erythrocytes [Presence] in Stool"
* LNC#42524-9 "Mucus [Presence] in Stool by Light microscopy"
* LNC#9397-1 "Color of Stool"

// 3-x 肺功能檢查核心代碼
* LNC#19876-2 "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation" // FVC (Acceptable：支氣管擴張劑前特定碼)

// 3-x 視力檢查
* LNC#98497-1 "Visual acuity panel"