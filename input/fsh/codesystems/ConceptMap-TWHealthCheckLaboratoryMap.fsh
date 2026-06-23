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
