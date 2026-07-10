ValueSet: VS_CoreDataset
Id: VS-CoreDataset
Title: "健康檢查核心項目值集"
Description: "包含一般健康檢查及體格檢查之核心檢驗與實驗室項目，對應至 LOINC 代碼。"
* ^experimental = false

// 1. 血液學 (Hematology)
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood"
* LNC#4544-3 "Hematocrit [Volume Fraction] of Blood"
* LNC#789-8 "Erythrocytes [#/volume] in Blood"
* LNC#6690-2 "Leukocytes [#/volume] in Blood"
* LNC#804-5 "WBC [#/volume] in Blood by Manual count"            // Layer 2: WBC Manual
* LNC#26464-8 "WBC [#/volume] in Blood"                          // Layer 2: WBC unspecified
* LNC#777-3 "Platelets [#/volume] in Blood"
* LNC#26515-7 "Platelets [#/volume] in Blood by Automated count" // Layer 2: Plt Automated
* LNC#787-2 "MCV [Entitic volume] by Automated count"
* LNC#30428-7 "MCV [Entitic volume] by calculation"              // Layer 2: MCV calculation
* LNC#785-6 "MCH [Entitic mass] by Automated count"
* LNC#28539-5 "MCH [Entitic mass] by Automated count"            // Layer 2: MCH (full name)
* LNC#786-4 "MCHC [Mass/volume] by Automated count"
* LNC#788-0 "Erythrocyte distribution width [Ratio] by Automated count"
* LNC#770-8 "Neutrophils/100 leukocytes in Blood by Automated count"
* LNC#26508-2 "Neutrophils/100 leukocytes in Blood by Manual count" // Layer 2: Neutrophil Manual
* LNC#736-9 "Lymphocytes/100 leukocytes in Blood by Automated count"
* LNC#5905-5 "Monocytes/100 leukocytes in Blood by Automated count"
* LNC#713-8 "Eosinophils/100 leukocytes in Blood by Automated count"
* LNC#706-2 "Basophils/100 leukocytes in Blood by Automated count"
* LNC#751-8 "Neutrophils [#/volume] in Blood by Automated count"
* LNC#731-0 "Lymphocytes [#/volume] in Blood by Automated count"
* LNC#19048-8 "Erythroblasts/100 leukocytes in Blood by Automated count"
* LNC#13046-8 "Atypical lymphocytes/100 leukocytes in Blood"
* LNC#34921-7 "Plasmacytoid lymphocytes/100 leukocytes in Blood"
* LNC#30466-7 "Promonocytes/100 leukocytes in Blood"
* LNC#26505-8 "Hypersegmented neutrophils/100 leukocytes in Blood"
* LNC#30441-0 "Abnormal monocytes/100 leukocytes in Blood"
* LNC#70028-6 "Megakaryocytes/100 leukocytes in Blood"
* LNC#30413-9 "Abnormal lymphocytes/100 leukocytes in Blood"
* LNC#26446-5 "Blasts/100 leukocytes in Blood"
* LNC#26524-9 "Promyelocytes/100 leukocytes in Blood"
* LNC#26498-6 "Myelocytes/100 leukocytes in Blood"
* LNC#28541-1 "Metamyelocytes/100 leukocytes in Blood"
* LNC#26511-6 "Neutrophils.segmented/100 leukocytes in Blood"
* LNC#26478-8 "Lymphocytes/100 leukocytes in Blood by Manual count"
* LNC#26485-3 "Monocytes/100 leukocytes in Blood by Manual count"
* LNC#26450-7 "Eosinophils/100 leukocytes in Blood by Manual count"
* LNC#30180-4 "Basophils/100 leukocytes in Blood by Manual count"
* LNC#13047-6 "Plasma cells/100 leukocytes in Blood"

// 2. 生化、腎功能與心血管風險 (Chemistry/Renal/Cardiovascular)
* LNC#1558-6 "Fasting Glucose [Mass/volume] in Serum or Plasma"
* LNC#2339-0 "Glucose [Mass/volume] in Blood"
* LNC#2345-7 "Glucose [Mass/volume] in Serum or Plasma -- post fasting"
* LNC#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* LNC#59261-8 "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol" // Layer 2: HbA1c IFCC
* LNC#20448-7 "Insulin [Units/volume] in Serum or Plasma"
* LNC#47214-2 "Homeostasis model assessment"
* LNC#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* LNC#38483-4 "Creatinine [Mass/volume] in Blood"
* LNC#3094-0 "Urea nitrogen [Mass/volume] in Serum or Plasma"
* LNC#33914-3 "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation"
* LNC#88293-6 "Glomerular filtration rate/1.73 sq M.predicted by Creatinine-based formula (CKD-EPI 2021)"
* LNC#33863-2 "Cystatin C [Mass/volume] in Serum, Plasma or Blood"
* LNC#3084-1 "Uric acid [Mass/volume] in Serum or Plasma"
* LNC#49154-8 "Uric acid [Mass/volume] in Blood"
* LNC#17861-6 "Calcium [Mass/volume] in Serum or Plasma"
* LNC#2777-1 "Phosphate [Mass/volume] in Serum or Plasma"
* LNC#30522-7 "C reactive protein [Mass/volume] in Serum or Plasma by High sensitivity method"
* LNC#2428-1 "Homocysteine [Moles/volume] in Serum or Plasma"

// 3. 肝膽、胰臟與心肌功能 (Liver/Pancreas/Cardiac)
* LNC#1920-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#14409-7 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P" // Layer 2: AST UV
* LNC#88112-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* LNC#1742-6 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#14390-9 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"  // Layer 2: ALT UV
* LNC#1744-2 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* LNC#6768-6 "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1783-0 "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"                      // Layer 2: ALP unspecified
* LNC#2324-2 "Gamma glutamyltransferase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1975-2 "Bilirubin.total [Mass/volume] in Serum or Plasma"
* LNC#1968-7 "Bilirubin.direct [Mass/volume] in Serum or Plasma"
* LNC#1751-7 "Albumin [Mass/volume] in Serum or Plasma"
* LNC#2885-2 "Protein [Mass/volume] in Serum or Plasma"
* LNC#10834-0 "Globulin [Mass/volume] in Serum or Plasma by calculation"
* LNC#1759-0 "Albumin/Globulin [Mass Ratio] in Serum or Plasma"
* LNC#2532-0 "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#1798-8 "Amylase [Enzymatic activity/volume] in Serum or Plasma"
* LNC#3040-3 "Lipase [Enzymatic activity/volume] in Serum or Plasma"

// 4. 脂質分析 (Lipids)
* LNC#2093-3 "Cholesterol [Mass/volume] in Serum or Plasma"
* LNC#35200-5 "Cholesterol [Mass/volume] in Blood"
* LNC#2571-8 "Triglyceride [Mass/volume] in Serum or Plasma"
* LNC#3043-7 "Triglyceride [Mass/volume] in Blood"
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
* LNC#3048-6 "Cholesterol in HDL [Mass/volume] in Blood"
* LNC#13457-7 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
* LNC#18262-6 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* LNC#2089-1 "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* LNC#46986-6 "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"
* LNC#9830-1 "Cholesterol/Cholesterol in HDL [Mass Ratio] in Serum or Plasma"

// 5. 甲狀腺與營養指標 (Thyroid/Nutrition)
* LNC#11580-8 "Thyrotropin [Units/volume] in Serum or Plasma"
* LNC#3016-3 "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS"  // Layer 2: TSH 3rd gen
* LNC#3024-7 "Thyroxine (T4) free [Mass/volume] in Serum or Plasma"
* LNC#3051-0 "Triiodothyronine (T3) free [Mass/volume] in Serum or Plasma"
* LNC#3026-2 "Thyroxine (T4) total [Mass/volume] in Serum or Plasma"
* LNC#3053-6 "Triiodothyronine (T3) total [Mass/volume] in Serum or Plasma"
* LNC#8099-4 "Thyroid peroxidase Ab [Units/volume] in Serum or Plasma"
* LNC#62292-8 "25-hydroxyvitamin D3 [Mass/volume] in Serum or Plasma"
* LNC#2132-9 "Cobalamin (Vitamin B12) [Mass/volume] in Serum or Plasma"
* LNC#2284-8 "Folate [Mass/volume] in Serum or Plasma"

// 6. 癌症篩檢與 PHI (Cancer Markers/PHI)
// v1.1 重分層：本節項目屬進階/自費健檢常見之腫瘤標記與特殊篩檢，非附表九一般健檢共通必驗項目，
// 已移至 VS-ExtendedDataset §1.15（develop.md §3.2，回歸 Core = 最小共通集）。代碼未刪除，僅重分層。

// 7. 傳染病、HPV與胃部篩檢 (Infections/HPV/Stomach)
* LNC#5196-1 "Hepatitis B virus surface Ag [Presence] in Serum"
* LNC#22326-3 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma"
* LNC#22322-2 "Hepatitis B virus surface Ab [Units/volume] in Serum"
* LNC#5193-8 "Hepatitis B virus surface Ab [Presence] in Serum or Plasma"
* LNC#13952-7 "Hepatitis B virus core Ab [Presence] in Serum or Plasma"
* LNC#63557-3 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* LNC#13955-0 "Hepatitis C virus Ab [Presence] in Serum or Plasma"
* LNC#47365-2 "Hepatitis C virus Ab [Presence] in Blood"
* LNC#20507-0 "Reagin Ab [Presence] in Serum by RPR"
* LNC#31147-2 "Reagin Ab [Presence] in Serum by RPR -- titer"
* LNC#24110-9 "Treponema pallidum Ab [Presence] in Serum by Immunoassay"
* LNC#56888-1 "HIV 1 and 2 Ag and Ab panel [Presence] in Serum or Plasma"
* LNC#13950-1 "Hepatitis A virus IgM Ab [Presence] in Serum or Plasma"
* LNC#51913-2 "Hepatitis A virus Ab [Presence] in Serum or Plasma"
* LNC#7962-4 "Measles virus IgG Ab [Units/volume] in Serum or Plasma"
* LNC#5403-1 "Varicella zoster virus IgG Ab [Units/volume] in Serum or Plasma"
* LNC#5334-8 "Rubella virus IgG Ab [Units/volume] in Serum or Plasma"
* LNC#5176-3 "Helicobacter pylori IgG Ab [Presence] in Serum"
* LNC#17780-8 "Helicobacter pylori Ag [Presence] in Stool"
* LNC#29771-3 "Hemoglobin.occult [Mass/volume] in Stool by Immunochemical method"
* LNC#21440-3 "Human papilloma virus 16+18+31+33+35+45+51+52+56 DNA [Presence] in Cervix by Probe"

// 8. 尿液常規 (Urinalysis)
* LNC#5803-2 "pH of Urine by Test strip"
* LNC#50560-2 "pH of Urine by Test strip"
* LNC#5804-0 "Protein [Presence] in Urine by Test strip"
* LNC#57735-3 "Protein [Presence] in Urine by Test strip"
* LNC#2888-6 "Protein [Mass/volume] in Urine"
* LNC#5792-7 "Glucose [Presence] in Urine by Test strip"
* LNC#50555-2 "Glucose [Presence] in Urine by Test strip"
* LNC#5794-3 "Hemoglobin [Presence] in Urine by Test strip"
* LNC#57751-0 "Hemoglobin [Presence] in Urine by Test strip"
* LNC#5797-6 "Ketones [Presence] in Urine by Test strip"
* LNC#57734-6 "Ketones [Presence] in Urine by Test strip"
* LNC#5802-4 "Nitrite [Presence] in Urine by Test strip"
* LNC#50558-6 "Nitrite [Presence] in Urine by Test strip"
* LNC#5770-3 "Bilirubin [Presence] in Urine by Test strip"
* LNC#50551-1 "Bilirubin [Presence] in Urine by Test strip"
* LNC#13658-0 "Urobilinogen [Presence] in Urine by Test strip"
* LNC#62487-4 "Urobilinogen [Presence] in Urine by Test strip"
* LNC#5810-7 "Specific gravity of Urine"
* LNC#50562-8 "Specific gravity of Urine by Refractometer"
* LNC#5799-2 "Leukocyte esterase [Presence] in Urine by Test strip"
* LNC#60026-2 "Leukocyte esterase [Presence] in Urine by Test strip"
* LNC#13945-1 "Erythrocytes [#/area] in Urine sediment by Microscopy high power field"
* LNC#5821-4 "Leukocytes [#/area] in Urine sediment by Microscopy high power field"
* LNC#11277-1 "Epithelial cells.squamous [#/area] in Urine sediment by Microscopy high power field"
* LNC#5796-8 "Hyaline casts [#/area] in Urine sediment by Microscopy low power field"
* LNC#25145-4 "Bacteria [Presence] in Urine sediment by Light microscopy"
* LNC#20627-6 "Color of Urine"
* LNC#20621-9 "Albumin/Creatinine [Ratio] in Urine by Test strip"
* LNC#11218-5 "Microalbumin [Mass/volume] in Urine by Test strip"
* LNC#30004-6 "Creatinine [Mass/volume] in Urine by Test strip"
* LNC#46419-8 "Erythrocytes [#/volume] in Urine sediment by Automated count"
* LNC#46702-7 "Leukocytes [#/volume] in Urine sediment by Automated count"
* LNC#33219-7 "Epithelial cells.squamous [#/volume] in Urine sediment by Automated count"
* LNC#33342-7 "Epithelial cells [#/volume] in Urine sediment by Automated count"
* LNC#33223-9 "Hyaline casts [#/volume] in Urine sediment by Automated count"
* LNC#43755-8 "Casts [#/volume] in Urine sediment by Automated count"
* LNC#12453-7 "Amorphous phosphate crystals [Presence] in Urine sediment"
* LNC#5774-5 "Calcium oxalate crystals [Presence] in Urine sediment"
* LNC#5817-2 "Uric acid crystals [Presence] in Urine sediment"
* LNC#5814-9 "Calcium magnesium ammonium phosphate crystals [Presence] in Urine sediment"
* LNC#5773-7 "Calcium carbonate crystals [Presence] in Urine sediment"
* LNC#53975-9 "Drug crystals [Presence] in Urine sediment"
* LNC#32356-8 "Yeast [Presence] in Urine sediment"
* LNC#33218-9 "Bacteria [#/volume] in Urine sediment by Automated count"
* LNC#5813-1 "Trichomonas vaginalis [Presence] in Urine sediment"
* LNC#20456-0 "Fungi yeast-like [Presence] in Urine sediment"
* LNC#53324-0 "Spermatozoa [#/volume] in Urine sediment by Automated count"
* LNC#50235-1 "Mucus [#/volume] in Urine sediment by Automated count"
* LNC#5788-5 "Oval fat bodies [#/area] in Urine sediment by Microscopy high power field"
* LNC#5766-1 "Ammonium acid urate crystals [Presence] in Urine sediment"
* LNC#12454-5 "Amorphous urate crystals [Presence] in Urine sediment"
* LNC#5771-1 "Bilirubin crystals [Presence] in Urine sediment"
* LNC#5775-2 "Calcium phosphate crystals [Presence] in Urine sediment"
* LNC#5784-4 "Cystine crystals [Presence] in Urine sediment"
* LNC#5777-8 "Cholesterol crystals [Presence] in Urine sediment"
* LNC#5787-7 "Epithelial cells [#/area] in Urine sediment by Microscopy high power field"

// 9. 一般心血管與腎臟篩檢 (General Cardiac/Renal Screening)
// v1.1 重分層：原「進階心血管、自體免疫」中之 Lp(a)/ApoA-I/ApoB/NT-proBNP/ANA/RF/CYFRA21-1
// 已移至 VS-ExtendedDataset §1.16（develop.md §3.2），本節僅保留一般健檢常見之項目。
* LNC#1988-5 "C reactive protein [Mass/volume] in Serum or Plasma"
* LNC#13705-9 "Albumin/Creatinine [Mass Ratio] in Urine"
* LNC#14957-5 "Microalbumin [Mass/volume] in Urine"
* LNC#2161-8 "Creatinine [Mass/volume] in Urine"
* LNC#4588-0 "Hemoglobin H/Hemoglobin.total in Blood"

// =============================================================
// 10. 肺功能檢查核心代碼 (Pulmonary Function — Core)
// 注意：這些代碼同時收錄於 VS-PulmonaryFunction（供完整肺功能代碼集查詢）
//       與本 ValueSet（供術語查詢與 CoreDataset 完整性），用途不同，非重複。
// =============================================================
* LNC#19876-2 "Forced vital capacity [Volume] in Airways by Spirometry"
* LNC#19868-9 "Forced expiratory volume in 1 second"
* LNC#19926-5 "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry"

// =============================================================
// 11. 視力檢查（Panel Level，v3 修正：僅 Panel code 進 CoreDataset）
// component-level 代碼（70936-0 左眼、70935-2 右眼、48024-3 辨色力）
// 由 TWHAVisionTestProfile 的 component.code 層級處理，不進本 ValueSet。
// =============================================================
* LNC#79880-1 "Vision test panel"

// =============================================================
// 12. 聽力檢查（Panel Level，v3 修正：個別頻率代碼由 TWHA-HearingTest component 處理）
// 左右耳頻率代碼（89024-4/89016-0/89017-8/89018-6/89028-5/89020-2/89019-4/89022-8）
// 收錄於 VS-ExtendedDataset，不進本 CoreDataset。
// =============================================================
* LNC#89015-2 "Pure tone threshold audiometry panel"

// =============================================================
// 13. 糞便檢查 (Stool Examination) [NEW]
// =============================================================
* LNC#9397-1 "Color of Stool"
* LNC#42524-9 "Mucus [Presence] in Stool by Microscopy"
* LNC#2335-8 "Hemoglobin [Presence] in Stool"
* LNC#10704-5 "Ova and parasites [Presence] in Stool by Microscopy"
* LNC#13655-6 "Leukocytes [Presence] in Stool by Microscopy"
* LNC#33668-5 "Erythrocytes [Presence] in Stool by Microscopy"
* LNC#10701-1 "Ova and parasites [Presence] in Stool by Concentration method"
