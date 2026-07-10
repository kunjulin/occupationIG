ValueSet: VS_ExtendedDataset
Id: VS-ExtendedDataset
Title: "健康檢查進階與領域擴充項目值集"
Description: "包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。"
* ^experimental = false

// =================================================================
// 1. 勞工特殊健康檢查項目 (Occupational Special Health Checks)
// =================================================================

// 1.1 高溫作業 (high-temp)
* LNC#11524-6 "EKG study"
* LNC#2951-2 "Sodium [Moles/volume] in Serum or Plasma"
* LNC#2823-3 "Potassium [Moles/volume] in Serum or Plasma"
* LNC#5810-7 "Specific gravity of Urine"

// 1.2 噪音作業 (noise) — 純音聽力個別頻率代碼 (v3 修正：補齊左右耳 4 頻率共 8 個代碼)
// Panel code 89015-2 收錄於 VS-CoreDataset，本 VS 僅收錄個別頻率/耳別代碼
* LNC#89015-2 "Pure tone threshold audiometry panel"              // Panel (重複收錄供查詢)
// 左耳 (Left ear)
* LNC#89024-4 "Hearing threshold Ear-left 500 Hz [dB]"           // L-500Hz (原有，修正 display)
* LNC#89016-0 "Hearing threshold Ear-left 1000 Hz [dB]"          // L-1kHz (修正：原 89023-6 為 1kHz Left，已確認)
* LNC#89017-8 "Hearing threshold Ear-left 2000 Hz [dB]"          // L-2kHz (新增)
* LNC#89018-6 "Hearing threshold Ear-left 4000 Hz [dB]"          // L-4kHz (新增)
// 右耳 (Right ear)
* LNC#89028-5 "Hearing threshold Ear-right 500 Hz [dB]"          // R-500Hz (新增)
* LNC#89020-2 "Hearing threshold Ear-right 1000 Hz [dB]"         // R-1kHz (新增)
* LNC#89019-4 "Hearing threshold Ear-right 2000 Hz [dB]"         // R-2kHz (新增)
* LNC#89022-8 "Hearing threshold Ear-right 4000 Hz [dB]"         // R-4kHz (新增)

// 1.3 游離輻射作業 (radiation)
* LNC#789-8 "Erythrocytes [#/volume] in Blood"
* LNC#6690-2 "WBC [#/volume] in Blood"
* LNC#777-3 "Platelets [#/volume] in Blood"
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood"
* LNC#4544-3 "Hematocrit [Volume Fraction] of Blood"
* LNC#770-8 "Neutrophils [Fraction] of WBC"
* LNC#736-9 "Lymphocytes [Fraction] of WBC"

// 1.4 異常氣壓作業 (abnormal-pressure)
* LNC#24579-5 "XR Bones.long Survey"
* LNC#19868-9 "FEV1 Vol Respiratory Spirometry"
* LNC#19876-2 "FVC Vol Respiratory Spirometry"
* LNC#19926-5 "FEV1% or FEV1/FVC (%)"

// 1.5 鉛作業 (lead)
* LNC#5671-3 "Lead [Mass/volume] in Blood"
* LNC#5676-2 "Lead [Mass/volume] in Urine"
* LNC#23749-5 "Lead [Mass/volume] in Specimen"
* LNC#11212-8 "Coproporphyrin [Mass/volume] in Urine"
* LNC#11215-1 "Aminolevulinic acid [Mass/volume] in Urine"

// 1.6 四烷基鉛作業 (tetraalkyl-lead) — 與鉛作業共用以下代碼（已收錄於 1.5，此處不重複）
// 另有特有代碼：無（四烷基鉛主要透過皮膚及呼吸道吸收，生物標記與鉛作業相同）

// 1.7 粉塵作業 (dust)
* LNC#36643-5 "XR Chest 2V"

// 1.8 有機溶劑作業 (organic-solvent)
* LNC#6709-0 "Hippurate [Mass/volume] in Urine"
* LNC#2725-0 "p-Methylhippurate [Mass/volume] in Urine"
* LNC#13000-5 "Mandelate [Mass/volume] in Urine"
* LNC#3041-1 "Trichloroacetate [Mass/volume] in Urine"
* LNC#31170-4 "2,5-Hexanedione [Mass/volume] in Urine"
* LNC#2758-1 "Phenol [Mass/volume] in Urine"
* LNC#12543-5 "Methylformamide [Mass/volume] in Urine"
* LNC#12533-6 "TTCA [Mass/volume] in Urine"

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
* LNC#19199-9 "Prostate specific Ag [Mass/volume] in Serum or Plasma"   // Layer 2: PSA unspecified method
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
