Instance: TWHealthCheckLaboratoryMap
// We use ConceptMap directly
InstanceOf: ConceptMap
Title: "健康檢查檢驗項目代碼對應 ConceptMap"
Description: "將健康檢查實驗室檢驗之可接受代碼 (Layer 2) 映射至最優先推薦之標準代碼 (Layer 1)。"
* name = "TWHealthCheckLaboratoryMap"
* status = #active
* experimental = false
* sourceUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"
* targetUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"

// WBC Mapping
* group[0].source = "http://loinc.org"
* group[0].target = "http://loinc.org"
* group[0].element[0].code = #804-5
* group[0].element[0].display = "WBC [#/volume] in Blood by Manual count"
* group[0].element[0].target[0].code = #6690-2
* group[0].element[0].target[0].display = "Leukocytes [#/volume] in Blood"
* group[0].element[0].target[0].equivalence = #equivalent

* group[0].element[1].code = #26464-8
* group[0].element[1].display = "WBC [#/volume] in Blood"
* group[0].element[1].target[0].code = #6690-2
* group[0].element[1].target[0].display = "Leukocytes [#/volume] in Blood"
* group[0].element[1].target[0].equivalence = #equivalent

// Urine Protein
* group[0].element[2].code = #2888-6
* group[0].element[2].display = "Protein [Mass/volume] in Urine"
* group[0].element[2].target[0].code = #5804-0
* group[0].element[2].target[0].display = "Protein [Presence] in Urine by Test strip"
* group[0].element[2].target[0].equivalence = #wider

// Glucose
* group[0].element[3].code = #2339-0
* group[0].element[3].display = "Glucose [Mass/volume] in Blood"
* group[0].element[3].target[0].code = #1558-6
* group[0].element[3].target[0].display = "Fasting Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[3].target[0].equivalence = #wider

// Creatinine
* group[0].element[4].code = #38483-4
* group[0].element[4].display = "Creatinine [Mass/volume] in Blood"
* group[0].element[4].target[0].code = #2160-0
* group[0].element[4].target[0].display = "Creatinine [Mass/volume] in Serum or Plasma"
* group[0].element[4].target[0].equivalence = #equivalent

// Uric Acid
* group[0].element[5].code = #49154-8
* group[0].element[5].display = "Uric acid [Mass/volume] in Blood"
* group[0].element[5].target[0].code = #3084-1
* group[0].element[5].target[0].display = "Uric acid [Mass/volume] in Serum or Plasma"
* group[0].element[5].target[0].equivalence = #equivalent

// Total Cholesterol
* group[0].element[6].code = #35200-5
* group[0].element[6].display = "Cholesterol [Mass/volume] in Blood"
* group[0].element[6].target[0].code = #2093-3
* group[0].element[6].target[0].display = "Cholesterol [Mass/volume] in Serum or Plasma"
* group[0].element[6].target[0].equivalence = #equivalent

// Triglycerides
* group[0].element[7].code = #3043-7
* group[0].element[7].display = "Triglyceride [Mass/volume] in Blood"
* group[0].element[7].target[0].code = #2571-8
* group[0].element[7].target[0].display = "Triglyceride [Mass/volume] in Serum or Plasma"
* group[0].element[7].target[0].equivalence = #equivalent

// HDL
* group[0].element[8].code = #3048-6
* group[0].element[8].display = "Cholesterol in HDL [Mass/volume] in Blood"
* group[0].element[8].target[0].code = #2085-9
* group[0].element[8].target[0].display = "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
* group[0].element[8].target[0].equivalence = #equivalent

// LDL
* group[0].element[9].code = #18262-6
* group[0].element[9].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* group[0].element[9].target[0].code = #13457-7
* group[0].element[9].target[0].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
* group[0].element[9].target[0].equivalence = #equivalent

// eGFR
* group[0].element[10].code = #33914-3
* group[0].element[10].display = "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation"
* group[0].element[10].target[0].code = #88293-6
* group[0].element[10].target[0].display = "Glomerular filtration rate/1.73 sq M.predicted by Creatinine-based formula (CKD-EPI 2021)"
* group[0].element[10].target[0].equivalence = #equivalent

// HBsAg
* group[0].element[11].code = #22326-3
* group[0].element[11].display = "Hepatitis B virus surface Ag [Presence] in Serum or Plasma"
* group[0].element[11].target[0].code = #5196-1
* group[0].element[11].target[0].display = "Hepatitis B virus surface Ag [Presence] in Serum"
* group[0].element[11].target[0].equivalence = #equivalent

// anti-HCV
* group[0].element[12].code = #47365-2
* group[0].element[12].display = "Hepatitis C virus Ab [Presence] in Blood"
* group[0].element[12].target[0].code = #13955-0
* group[0].element[12].target[0].display = "Hepatitis C virus Ab [Presence] in Serum or Plasma"
* group[0].element[12].target[0].equivalence = #equivalent

// =============================================================
// 血液學群組 (Hematology) — 新增 4 組
// 注意：Hemoglobin (718-7) 無 Acceptable 代碼；MCHC (786-4) 因語意差異亦不建立對應
// =============================================================

// Platelet (Acceptable: 26515-7 Automated count → Preferred: 777-3)
* group[0].element[13].code = #26515-7
* group[0].element[13].display = "Platelets [#/volume] in Blood by Automated count"
* group[0].element[13].target[0].code = #777-3
* group[0].element[13].target[0].display = "Platelets [#/volume] in Blood"
* group[0].element[13].target[0].equivalence = #equivalent

// MCV (Acceptable: 30428-7 by calculation → Preferred: 787-2 by Automated count)
* group[0].element[14].code = #30428-7
* group[0].element[14].display = "MCV [Entitic volume] by calculation"
* group[0].element[14].target[0].code = #787-2
* group[0].element[14].target[0].display = "MCV [Entitic volume] by Automated count"
* group[0].element[14].target[0].equivalence = #equivalent

// MCH (Acceptable: 28539-5 by Automated count → Preferred: 785-6 by Automated count)
* group[0].element[15].code = #28539-5
* group[0].element[15].display = "MCH [Entitic mass] by Automated count"
* group[0].element[15].target[0].code = #785-6
* group[0].element[15].target[0].display = "MCH [Entitic mass] by Automated count"
* group[0].element[15].target[0].equivalence = #equivalent

// Neutrophil % (Acceptable: 26508-2 Manual count → Preferred: 770-8 Automated count)
* group[0].element[16].code = #26508-2
* group[0].element[16].display = "Neutrophils/100 leukocytes in Blood by Manual count"
* group[0].element[16].target[0].code = #770-8
* group[0].element[16].target[0].display = "Neutrophils/100 leukocytes in Blood by Automated count"
* group[0].element[16].target[0].equivalence = #equivalent

// =============================================================
// 肝功能群組 (Liver Function) — 新增 3 組
// =============================================================

// AST / GOT (Acceptable: 14409-7 by UV with P5P → Preferred: 1920-8)
* group[0].element[17].code = #14409-7
* group[0].element[17].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
* group[0].element[17].target[0].code = #1920-8
* group[0].element[17].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[17].target[0].equivalence = #equivalent

// ALT / GPT (Acceptable: 14390-9 by UV with P5P → Preferred: 1742-6)
* group[0].element[18].code = #14390-9
* group[0].element[18].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
* group[0].element[18].target[0].code = #1742-6
* group[0].element[18].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[18].target[0].equivalence = #equivalent

// ALP (Acceptable: 1783-0 method-unspecified → Preferred: 6768-6)
* group[0].element[19].code = #1783-0
* group[0].element[19].display = "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[19].target[0].code = #6768-6
* group[0].element[19].target[0].display = "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[19].target[0].equivalence = #equivalent

// =============================================================
// 內分泌與癌症標記群組 (Endocrine & Tumor Markers) — 新增 4 組
// =============================================================

// HbA1c (Acceptable: 59261-8 IFCC mmol/mol → Preferred: 4548-4 NGSP %)
// 單位換算說明：IFCC (mmol/mol) = (NGSP(%) - 2.152) / 0.9148
* group[0].element[20].code = #59261-8
* group[0].element[20].display = "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol"
* group[0].element[20].target[0].code = #4548-4
* group[0].element[20].target[0].display = "Hemoglobin A1c/Hemoglobin.total in Blood"
* group[0].element[20].target[0].equivalence = #equivalent
* group[0].element[20].target[0].comment = "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"

// TSH (Acceptable: 3016-3 3rd generation IS → Preferred: 11580-8)
* group[0].element[21].code = #3016-3
* group[0].element[21].display = "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS"
* group[0].element[21].target[0].code = #11580-8
* group[0].element[21].target[0].display = "Thyrotropin [Units/volume] in Serum or Plasma"
* group[0].element[21].target[0].equivalence = #equivalent

// PSA (Acceptable: 19199-9 method-unspecified → Preferred: 2857-1)
* group[0].element[22].code = #19199-9
* group[0].element[22].display = "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* group[0].element[22].target[0].code = #2857-1
* group[0].element[22].target[0].display = "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* group[0].element[22].target[0].equivalence = #equivalent

// CA-125 (Acceptable: 83082-8 by IA → Preferred: 10334-1)
* group[0].element[23].code = #83082-8
* group[0].element[23].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
* group[0].element[23].target[0].code = #10334-1
* group[0].element[23].target[0].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma"
* group[0].element[23].target[0].equivalence = #equivalent

// CEA (Acceptable: 83085-1 by IA → Preferred: 2039-6)
* group[0].element[24].code = #83085-1
* group[0].element[24].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* group[0].element[24].target[0].code = #2039-6
* group[0].element[24].target[0].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
* group[0].element[24].target[0].equivalence = #equivalent

// AST (Acceptable: 88112-8 w/o P-5'-P → Preferred: 1920-8)
* group[0].element[25].code = #88112-8
* group[0].element[25].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[25].target[0].code = #1920-8
* group[0].element[25].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[25].target[0].equivalence = #equivalent

// ALT (Acceptable: 1744-2 w/o P-5'-P → Preferred: 1742-6)
* group[0].element[26].code = #1744-2
* group[0].element[26].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[26].target[0].code = #1742-6
* group[0].element[26].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[26].target[0].equivalence = #equivalent

// Glucose AC (Acceptable: 2345-7 post fasting → Preferred: 1558-6 fasting)
* group[0].element[27].code = #2345-7
* group[0].element[27].display = "Glucose [Mass/volume] in Serum or Plasma -- post fasting"
* group[0].element[27].target[0].code = #1558-6
* group[0].element[27].target[0].display = "Fasting Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[27].target[0].equivalence = #equivalent

