ValueSet: VS_CoreDataset
Id: VS-CoreDataset
Title: "健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集）"
Description: "Core 之檢驗子集（主管機關（國健署）最小共通上傳集之 Observation.code 綁定值集，綁定強度 extensible）。僅收錄 Core 之 10 檢驗項 preferred code 及其 acceptable 變異碼；生理量測（身高/體重/腰圍/血壓）碼分屬 VS-TWHAVitalSigns、社會史（吸菸/嚼檳）碼分屬 SocialHistory profile。Core 全集（21 列）之群組見 VS-CoreUploadSet。acceptable→preferred 歸一見 ConceptMap TWHealthCheckLaboratoryMap。"
* ^experimental = false

// 09001C 總膽固醇 (Total Cholesterol) — Preferred 2093-3
* LNC#2093-3 "Cholesterol [Mass/volume] in Serum or Plasma"
* LNC#35200-5 "Cholesterol [Mass or Moles/volume] in Serum or Plasma"   // Acceptable: 質量/莫耳濃度未指定之變異碼（tx 確認非全血法）

// 09005C 飯前血糖 (Fasting Glucose) — Preferred 1558-6
* LNC#1558-6 "Fasting glucose [Mass/volume] in Serum or Plasma"
* LNC#2339-0 "Glucose [Mass/volume] in Blood"                            // Acceptable: 全血血糖
* LNC#2345-7 "Glucose [Mass/volume] in Serum or Plasma"                  // Acceptable: 一般血糖（未指定空腹；tx 確認非「post fasting」）

// 09004C 三酸甘油酯 (Triglyceride) — Preferred 2571-8
* LNC#2571-8 "Triglyceride [Mass/volume] in Serum or Plasma"
* LNC#3043-7 "Triglyceride [Mass/volume] in Blood"                       // Acceptable: 全血法

// 09043C 高密度脂蛋白膽固醇 (HDL-C) — Preferred 2085-9
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
// (-) HDL-C 無「全血」對應碼：原列 3048-6 經 tx 驗證實為 Triglyceride --fasting（非 HDL），已移除；
//     LOINC 現無乾淨之 HDL-in-Blood 代碼，acceptable 從缺，僅保留 Preferred 2085-9。

// 09044C 低密度脂蛋白膽固醇 (LDL-C) — Preferred 2089-1（**方法通用碼**：tx 確認其官方顯示名未指定方法，
//        適合作為 Preferred 以相容各院所方法；13457-7 計算法、18262-6 直接測定法為方法具名之 Acceptable）
* LNC#2089-1 "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
* LNC#13457-7 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation" // Acceptable: 計算法
* LNC#18262-6 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay" // Acceptable: 直接法舊碼

// 09015C 肌酸酐 (Creatinine) — Preferred 2160-0
* LNC#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* LNC#38483-4 "Creatinine [Mass/volume] in Blood"                        // Acceptable: 全血法

// 06003C 尿蛋白定量 (Urine Protein, quantitative) — Preferred 2888-6
* LNC#2888-6 "Protein [Mass/volume] in Urine"

// 06003C 尿蛋白定性 (Urine Protein, qualitative) — Preferred 5804-0
* LNC#5804-0 "Protein [Mass/volume] in Urine by Test strip"
* LNC#57735-3 "Protein [Presence] in Urine by Automated test strip"                // Acceptable: 試紙變異碼

// 14032C B型肝炎表面抗原 (HBsAg) — Preferred 5196-1
* LNC#5196-1 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* LNC#5195-3 "Hepatitis B virus surface Ag [Presence] in Serum"          // Acceptable: 血清定性(原22326-3 經tx驗證實為 HCV 5-1-1 Ab，已更正)
* LNC#63557-3 "Hepatitis B virus surface Ag [Units/volume] in Serum or Plasma by Immunoassay" // Acceptable: 免疫法

// 14051C C型肝炎抗體 (anti-HCV) — Preferred 13955-0
* LNC#13955-0 "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay"
* LNC#16128-1 "Hepatitis C virus Ab [Presence] in Serum"                  // Acceptable: 血清通用碼（原 47365-2 為捐血者篩檢情境碼，不適用一般健檢，已更正）
