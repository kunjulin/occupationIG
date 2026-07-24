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
* LNC#5810-7 "Specific gravity of Urine"                         // 尿比重（脫水評估）

// 1.2 噪音作業 (noise) — 純音氣導聽閾個別頻率代碼
// v1.1 修正：更正 v3 之錯置代碼並補齊 3/6/8 kHz，使全部代碼與 LOINC 89015-2 panel 成員一致，
//            涵蓋《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率（7 頻率 × 左右耳 = 14 碼）。
// Panel code 89015-2 收錄於 VS-CoreDataset，本 VS 收錄個別頻率/耳別代碼。
* LNC#89015-2 "Pure tone threshold audiometry panel"              // Panel (重複收錄供查詢)
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

// v20260723：職業病醫師/院內 LIS 另採 21104-5 純音聽力研究系列；本 IG 維持 89015-2 panel 為 Preferred，以下 21104-5 系列列為 Acceptable 變異碼（供 LIS 對接，非新增結構）。
* LNC#21104-5 "Pure tone audiometry - Audiometry study（panel 變異）"
* LNC#21106-0 "Pure tone audiometry - Left ear 500 Hz"
* LNC#21111-0 "Pure tone audiometry - Left ear 1000 Hz"
* LNC#21113-6 "Pure tone audiometry - Left ear 2000 Hz"
* LNC#21115-1 "Pure tone audiometry - Left ear 3000 Hz"
* LNC#21116-9 "Pure tone audiometry - Left ear 4000 Hz"
* LNC#21117-7 "Pure tone audiometry - Left ear 6000 Hz"
* LNC#21118-5 "Pure tone audiometry - Left ear 8000 Hz"
* LNC#21120-1 "Pure tone audiometry - Right ear 500 Hz"
* LNC#21123-5 "Pure tone audiometry - Right ear 1000 Hz"
* LNC#21125-0 "Pure tone audiometry - Right ear 2000 Hz"
* LNC#21127-6 "Pure tone audiometry - Right ear 3000 Hz"
* LNC#21128-4 "Pure tone audiometry - Right ear 4000 Hz"
* LNC#21129-2 "Pure tone audiometry - Right ear 6000 Hz"
* LNC#21130-0 "Pure tone audiometry - Right ear 8000 Hz"

// 1.3 游離輻射作業 (radiation) — CBC 與白血球分類、甲狀腺功能、皮膚/眼晶體（理學檢查）
// v1.1 補齊：附表十游離輻射作業另需甲狀腺功能監測（TSH、Free T4）
* LNC#789-8 "Erythrocytes [#/volume] in Blood"
* LNC#6690-2 "WBC [#/volume] in Blood"
* LNC#777-3 "Platelets [#/volume] in Blood"
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood"
* LNC#4544-3 "Hematocrit [Volume Fraction] of Blood"
* LNC#770-8 "Neutrophils [Fraction] of WBC"
* LNC#736-9 "Lymphocytes [Fraction] of WBC"
* LNC#11580-8 "Thyrotropin [Units/volume] in Serum or Plasma"    // TSH（輻射甲狀腺監測）
* LNC#3024-7 "Thyroxine (T4) free [Mass/volume] in Serum or Plasma" // Free T4（輻射甲狀腺監測）

// 1.4 異常氣壓作業 (abnormal-pressure) — 肺功能、長骨關節 X 光、心電圖
// v1.1 修正：FEV1 之正確 LOINC 為 20150-9（原 19868-9 實為 FVC，已更正）
* LNC#24579-5 "XR Bones.long Survey"                              // 長骨/關節 X 光（減壓性骨壞死）
* LNC#19876-2 "Forced vital capacity [Volume] in Airways by Spirometry"  // FVC
* LNC#20150-9 "Forced expiratory volume in 1 second [Volume] in Airways by Spirometry" // FEV1（正確碼）
* LNC#19926-5 "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry" // FEV1/FVC
// 心電圖 11524-6（潛水/高壓作業心血管評估）已收錄於 1.1 高溫作業，不重複收錄

// 1.5 鉛作業 (lead)
* LNC#5671-3 "Lead [Mass/volume] in Blood"
* LNC#5676-2 "Lead [Mass/volume] in Urine"
* LNC#23749-5 "Lead [Mass/volume] in Specimen"
* LNC#11212-8 "Coproporphyrin [Mass/volume] in Urine"
* LNC#11215-1 "Aminolevulinic acid [Mass/volume] in Urine"

// 1.6 四烷基鉛作業 (tetraalkyl-lead) — 與鉛作業共用以下代碼（已收錄於 1.5，此處不重複）
// 另有特有代碼：無（四烷基鉛主要透過皮膚及呼吸道吸收，生物標記與鉛作業相同）

// 1.7 粉塵作業 / 游離二氧化矽 (dust / crystalline silica) — 胸部 X 光、肺功能（FVC/FEV1/比值）
// 塵肺症分級以胸部 X 光判讀；肺功能碼收錄於 1.4。24648-8 為附表九一般胸部 X 光（單張 PA）之對應碼。
* LNC#36643-5 "XR Chest 2 Views"                                 // 胸部 X 光（2 views，塵肺症）
* LNC#24648-8 "XR Chest PA upright"                              // 胸部 X 光（單張 PA，附表九一般大片）

// 1.8 有機溶劑作業 (organic-solvent) — 肝功能、腎功能、CBC、神經學檢查、尿中代謝物
// 附表十有機溶劑作業另需肝功能監測（ALT、γ-GT，收錄於 VS-CoreDataset）；以下為各溶劑之尿中生物偵測代謝物
* LNC#2324-2 "Gamma glutamyltransferase [Enzymatic activity/volume] in Serum or Plasma" // γ-GT（肝功能，v1.1 明列）
* LNC#6709-0 "Hippurate [Mass/volume] in Urine"                  // 馬尿酸（甲苯）
* LNC#2725-0 "p-Methylhippurate [Mass/volume] in Urine"         // 甲基馬尿酸（二甲苯）
* LNC#13000-5 "Mandelate [Mass/volume] in Urine"                // 扁桃酸（苯乙烯）
* LNC#3041-1 "Trichloroacetate [Mass/volume] in Urine"          // 三氯乙酸（三氯乙烯/四氯乙烯）
* LNC#31170-4 "2,5-Hexanedione [Mass/volume] in Urine"          // 2,5-己二酮（正己烷）
* LNC#2758-1 "Phenol [Mass/volume] in Urine"                    // 酚（苯）
* LNC#12543-5 "Methylformamide [Mass/volume] in Urine"          // N-甲基甲醯胺（DMF）
* LNC#12533-6 "TTCA [Mass/volume] in Urine"                     // TTCA（二硫化碳）
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
* LNC#10913-2 "4,4'-Methylenebis(2-chloroaniline) [Mass/volume] in Urine"
* LNC#5653-1 "Formaldehyde [Mass/volume] in Urine"
* LNC#10909-0 "Benzidine [Mass/volume] in Urine"
* LNC#5681-2 "Manganese [Mass/volume] in Blood"
* LNC#5683-8 "Manganese [Mass/volume] in Serum or Plasma"
* LNC#42221-2 "Manganese [Mass/volume] in Urine"
* LNC#34304-6 "Fluoride [Mass/volume] in Urine"

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
* LNC#43371-4 "Salmonella and Shigella [Presence] in Stool by Culture"

// 1.14 尿液毒品篩檢 (Urine Drug Screening) [NEW]
* LNC#19266-6 "Amphetamines [Presence] in Urine by Screening test"
* LNC#19299-7 "Opiates [Presence] in Urine by Screening test"
* LNC#19283-1 "Benzodiazepines [Presence] in Urine by Screening test"
* LNC#19501-6 "Ketamine [Presence] in Urine by Screening test"
* LNC#19571-9 "MDMA [Presence] in Urine by Screening test"

// 1.15 癌症篩檢與 PHI (Cancer Markers/PHI) — v1.1 自 VS-CoreDataset 移入（develop.md §3.2）
* LNC#19177-5 "Alpha-1-fetoprotein [Mass/volume] in Serum or Plasma"
* LNC#2039-6 "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
* LNC#2857-1 "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* LNC#19199-9 "Prostate specific Ag [Mass/volume] in Serum or Plasma"   // Acceptable: PSA unspecified method
* LNC#10886-0 "Prostate specific Ag.free [Mass/volume] in Serum or Plasma"
* LNC#97149-9 "[-2]pro-prostate specific antigen [Mass/volume] in Serum or Plasma"
* LNC#97150-7 "Prostate Health Index in Serum or Plasma"
* LNC#10334-1 "Cancer Ag 125 [Units/volume] in Serum or Plasma"
* LNC#83082-8 "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#83085-1 "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* LNC#24108-3 "Cancer Ag 19-9 [Units/volume] in Serum or Plasma"
* LNC#83084-4 "Cancer Ag 19-9 [Units/volume] in Serum or Plasma by Immunoassay"
* LNC#83083-6 "Cancer Ag 15-3 [Units/volume] in Serum or Plasma"
* LNC#83112-3 "Prostate specific Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* LNC#1834-1 "Alpha-1-fetoprotein [Mass/volume] in Serum or Plasma"
* LNC#9679-2 "Squamous cell carcinoma Ag [Mass/volume] in Serum or Plasma"
* LNC#19113-0 "IgE [Units/volume] in Serum or Plasma"
* LNC#9633-9 "Epstein Barr virus VCA IgA Ab [Presence] in Serum"

// 1.16 進階心血管與自體免疫 (Advanced Cardiac/Autoimmune) — v1.1 自 VS-CoreDataset 移入（develop.md §3.2）
* LNC#10835-7 "Lipoprotein A [Mass/volume] in Serum or Plasma"
* LNC#1869-7 "Apolipoprotein A-I [Mass/volume] in Serum or Plasma"
* LNC#1884-6 "Apolipoprotein B [Mass/volume] in Serum or Plasma"
* LNC#33762-6 "Natriuretic peptide.proB-type N-terminal [Mass/volume] in Serum or Plasma"
* LNC#42254-3 "Nuclear Ab [Presence] in Serum by Immunofluorescence"
* LNC#11572-5 "Rheumatoid factor [Units/volume] in Serum or Plasma"
* LNC#25390-6 "CYFRA 21-1 [Mass/volume] in Serum or Plasma"

// =================================================================
// 2. 自費健康檢查常見之進階影像學及鏡檢項目 (Advanced Imaging & Endoscopy)
// =================================================================

// 2.1 乳房攝影 (Mammography)
* LNC#24606-6 "Mammogram screening views study"
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
* LNC#24558-9 "Ultrasound of abdomen study" // 腹部超音波
* LNC#24616-5 "US Carotid aa" // 頸動脈超音波
* LNC#25010-0 "US Thyroid" // 甲狀腺超音波

// 2.8 骨質密度檢查 (Bone Densitometry)
* LNC#38268-9 "DXA Skeletal Sys Views for BMD" // 雙能量X光骨密度儀(DEXA)
