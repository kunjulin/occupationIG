ValueSet: VS_CoreDataset
Id: VS-CoreDataset
Title: "健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集）"
Description: "Core 之檢驗子集（主管機關（國健署）最小共通上傳集之 Observation.code 綁定值集，綁定強度 extensible）。僅收錄 Core 之 10 檢驗項 preferred code 及其 acceptable 變異碼；生理量測（身高/體重/腰圍/血壓）碼分屬 VS-TWHAVitalSigns、社會史（吸菸/嚼檳）碼分屬 SocialHistory profile。Core 全集（21 列）之群組見 VS-CoreUploadSet。acceptable→preferred 歸一見 ConceptMap TWHealthCheckLaboratoryMap。"
* ^experimental = false

// 09001C 總膽固醇 (Total Cholesterol) — Preferred 2093-3
* LNC#2093-3 "Cholesterol [Mass/volume] in Serum or Plasma"
* LNC#35200-5 "Cholesterol [Mass/volume] in Blood"                       // Acceptable: 全血法

// 09005C 飯前血糖 (Fasting Glucose) — Preferred 1558-6
* LNC#1558-6 "Fasting Glucose [Mass/volume] in Serum or Plasma"
* LNC#2339-0 "Glucose [Mass/volume] in Blood"                            // Acceptable: 全血血糖
* LNC#2345-7 "Glucose [Mass/volume] in Serum or Plasma -- post fasting"  // Acceptable: 飯後血糖變異

// 09004C 三酸甘油酯 (Triglyceride) — Preferred 2571-8
* LNC#2571-8 "Triglyceride [Mass/volume] in Serum or Plasma"
* LNC#3043-7 "Triglyceride [Mass/volume] in Blood"                       // Acceptable: 全血法

// 09043C 高密度脂蛋白膽固醇 (HDL-C) — Preferred 2085-9
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
* LNC#3048-6 "Cholesterol in HDL [Mass/volume] in Blood"                 // Acceptable: 全血法

// 09044C 低密度脂蛋白膽固醇 (LDL-C) — Preferred 2089-1（直接測定法）
* LNC#2089-1 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* LNC#13457-7 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation" // Acceptable: 計算法
* LNC#18262-6 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay" // Acceptable: 直接法舊碼

// 09015C 肌酸酐 (Creatinine) — Preferred 2160-0
* LNC#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* LNC#38483-4 "Creatinine [Mass/volume] in Blood"                        // Acceptable: 全血法

// 06003C 尿蛋白定量 (Urine Protein, quantitative) — Preferred 2888-6
* LNC#2888-6 "Protein [Mass/volume] in Urine"

// 06003C 尿蛋白定性 (Urine Protein, qualitative) — Preferred 5804-0
* LNC#5804-0 "Protein [Presence] in Urine by Test strip"
* LNC#57735-3 "Protein [Presence] in Urine by Test strip"                // Acceptable: 試紙變異碼

// 14032C B型肝炎表面抗原 (HBsAg) — Preferred 5196-1
* LNC#5196-1 "Hepatitis B virus surface Ag [Presence] in Serum"
* LNC#22326-3 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma" // Acceptable: 血漿變異
* LNC#63557-3 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay" // Acceptable: 免疫法

// 14051C C型肝炎抗體 (anti-HCV) — Preferred 13955-0
* LNC#13955-0 "Hepatitis C virus Ab [Presence] in Serum or Plasma"
* LNC#47365-2 "Hepatitis C virus Ab [Presence] in Blood"                 // Acceptable: 全血法
