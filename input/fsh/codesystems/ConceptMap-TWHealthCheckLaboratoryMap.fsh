Instance: TWHealthCheckLaboratoryMap
// We use ConceptMap directly
InstanceOf: ConceptMap
Title: "健康檢查檢驗項目代碼對應 ConceptMap"
Description: "將健康檢查實驗室檢驗之 acceptable code 歸一至 preferred (primary) code。值集綁定採 extensible binding；本 ConceptMap 供接收端將院所 LIS 之可接受變異碼標準化至優先碼。

**來源版本**：LOINC 2.82（經 tx.fhir.org 驗證）。**驗證狀態**：全數 source／target 代碼已於 2026-07-26 完成 $validate-code 代碼有效性驗證。**審查狀態**：equivalence 已於 2026-07-26 依 FHIR 語意逐筆覆核並補列理由（comment），工作小組建議方案，提請確認可否作為下一階段試作基礎。

**equivalence 使用原則**：`equivalent` 僅用於完全等義（同概念、同檢體、方法同為未指定或同一方法）；source 為 target 之方法特化者用 `narrower`；source 語意較廣者用 `wider`；不同具體方法、不同檢體、或需數值換算而無包含關係者用 `relatedto`（R4 之 ConceptMapEquivalence 代碼，語意為「有關聯但確切關係未知」）。

⚠️ **歸一之臨床限制**：本對照供資料標準化之用，**不表示歸一後之數值可直接互換比較**（例如 MDRD 與 CKD-EPI eGFR、IFCC 與 NGSP HbA1c 均需換算或不可互換）。交換時應保留原始代碼。"
* name = "TWHealthCheckLaboratoryMap"
* status = #active
* experimental = false
* version = "2026-07-26"
* date = "2026-07-26"
* sourceUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"
* targetUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"

// WBC Mapping
* group[0].source = "http://loinc.org"
* group[0].target = "http://loinc.org"
* group[0].element[0].code = #804-5
* group[0].element[0].display = "WBC [#/volume] in Blood by Manual count"
* group[0].element[0].target[0].code = #6690-2
* group[0].element[0].target[0].display = "Leukocytes [#/volume] in Blood"
* group[0].element[0].target[0].equivalence = #narrower
* group[0].element[0].target[0].comment = "source 指定 Manual count，target 方法未指定，source 為其特化"

* group[0].element[1].code = #26464-8
* group[0].element[1].display = "WBC [#/volume] in Blood"
* group[0].element[1].target[0].code = #6690-2
* group[0].element[1].target[0].display = "Leukocytes [#/volume] in Blood"
* group[0].element[1].target[0].equivalence = #equivalent
* group[0].element[1].target[0].comment = "同概念、同檢體、方法均未指定"

// Urine Protein
* group[0].element[2].code = #2888-6
* group[0].element[2].display = "Protein [Mass/volume] in Urine"
* group[0].element[2].target[0].code = #5804-0
* group[0].element[2].target[0].display = "Protein [Mass/volume] in Urine by Test strip"
* group[0].element[2].target[0].equivalence = #relatedto
* group[0].element[2].target[0].comment = "定量(Mass/volume)與試紙法屬不同量測方式，非包含關係"

// Glucose
* group[0].element[3].code = #2339-0
* group[0].element[3].display = "Glucose [Mass/volume] in Blood"
* group[0].element[3].target[0].code = #1558-6
* group[0].element[3].target[0].display = "Fasting glucose [Mass/volume] in Serum or Plasma"
* group[0].element[3].target[0].equivalence = #wider
* group[0].element[3].target[0].comment = "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣；另檢體不同"

// Creatinine
* group[0].element[4].code = #38483-4
* group[0].element[4].display = "Creatinine [Mass/volume] in Blood"
* group[0].element[4].target[0].code = #2160-0
* group[0].element[4].target[0].display = "Creatinine [Mass/volume] in Serum or Plasma"
* group[0].element[4].target[0].equivalence = #relatedto
* group[0].element[4].target[0].comment = "檢體不同(Blood vs Serum/Plasma)，非包含關係"

// Uric Acid
* group[0].element[5].code = #49154-8
* group[0].element[5].display = "Uric acid [Mass/volume] in Blood"
* group[0].element[5].target[0].code = #3084-1
* group[0].element[5].target[0].display = "Uric acid [Mass/volume] in Serum or Plasma"
* group[0].element[5].target[0].equivalence = #relatedto
* group[0].element[5].target[0].comment = "檢體不同(Blood vs Serum/Plasma)"

// Total Cholesterol
* group[0].element[6].code = #35200-5
* group[0].element[6].display = "Cholesterol [Mass or Moles/volume] in Serum or Plasma"
* group[0].element[6].target[0].code = #2093-3
* group[0].element[6].target[0].display = "Cholesterol [Mass/volume] in Serum or Plasma"
* group[0].element[6].target[0].equivalence = #wider
* group[0].element[6].target[0].comment = "source 允許質量或莫耳濃度兩種尺度，語意較 target 廣"

// Triglycerides
* group[0].element[7].code = #3043-7
* group[0].element[7].display = "Triglyceride [Mass/volume] in Blood"
* group[0].element[7].target[0].code = #2571-8
* group[0].element[7].target[0].display = "Triglyceride [Mass/volume] in Serum or Plasma"
* group[0].element[7].target[0].equivalence = #relatedto
* group[0].element[7].target[0].comment = "檢體不同(Blood vs Serum/Plasma)"

// HDL：(-) 無 acceptable 變異碼。原 element[8] 之 source 3048-6 經 tx 驗證實為 Triglyceride --fasting，
//      非 HDL 之可接受碼，已移除該組對應（其後 element 已重新編號為連續索引）。

// LDL (Preferred 2089-1 為方法通用碼；計算法 13457-7 與直接測定法 18262-6 為方法具名之 Acceptable)
* group[0].element[8].code = #13457-7
* group[0].element[8].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
* group[0].element[8].target[0].code = #2089-1
* group[0].element[8].target[0].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
* group[0].element[8].target[0].equivalence = #narrower
* group[0].element[8].target[0].comment = "source 指定計算法，target 方法未指定"

// eGFR
* group[0].element[9].code = #33914-3
* group[0].element[9].display = "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation"
* group[0].element[9].target[0].code = #98979-8
* group[0].element[9].target[0].display = "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* group[0].element[9].target[0].equivalence = #relatedto
* group[0].element[9].target[0].comment = "MDRD 與 CKD-EPI 2021 為不同估算公式，數值不可直接互換"

// HBsAg
* group[0].element[10].code = #5195-3
* group[0].element[10].display = "Hepatitis B virus surface Ag [Presence] in Serum"
* group[0].element[10].target[0].code = #5196-1
* group[0].element[10].target[0].display = "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* group[0].element[10].target[0].equivalence = #relatedto
* group[0].element[10].target[0].comment = "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"

// anti-HCV
* group[0].element[11].code = #16128-1
* group[0].element[11].display = "Hepatitis C virus Ab [Presence] in Serum"
* group[0].element[11].target[0].code = #13955-0
* group[0].element[11].target[0].display = "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay"
* group[0].element[11].target[0].equivalence = #relatedto
* group[0].element[11].target[0].comment = "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"

// =============================================================
// 血液學群組 (Hematology) — 新增 4 組
// 注意：Hemoglobin (718-7) 無 Acceptable 代碼；MCHC (786-4) 因語意差異亦不建立對應
// =============================================================

// Platelet (Acceptable: 26515-7 Automated count → Preferred: 777-3)
* group[0].element[12].code = #26515-7
* group[0].element[12].display = "Platelets [#/volume] in Blood by Automated count"
* group[0].element[12].target[0].code = #777-3
* group[0].element[12].target[0].display = "Platelets [#/volume] in Blood"
* group[0].element[12].target[0].equivalence = #narrower
* group[0].element[12].target[0].comment = "source 指定 Automated count，target 方法未指定"

// MCV (Acceptable: 30428-7 by calculation → Preferred: 787-2 by Automated count)
* group[0].element[13].code = #30428-7
* group[0].element[13].display = "MCV [Entitic volume] by calculation"
* group[0].element[13].target[0].code = #787-2
* group[0].element[13].target[0].display = "MCV [Entitic volume] by Automated count"
* group[0].element[13].target[0].equivalence = #relatedto
* group[0].element[13].target[0].comment = "calculation 與 Automated count 為不同具體方法，無包含關係"

// MCH (Acceptable: 28539-5 by Automated count → Preferred: 785-6 by Automated count)
* group[0].element[14].code = #28539-5
* group[0].element[14].display = "MCH [Entitic mass] by Automated count"
* group[0].element[14].target[0].code = #785-6
* group[0].element[14].target[0].display = "MCH [Entitic mass] by Automated count"
* group[0].element[14].target[0].equivalence = #equivalent
* group[0].element[14].target[0].comment = "同概念、同方法(Automated count)，僅顯示名長短不同"

// Neutrophil % (Acceptable: 26508-2 Manual count → Preferred: 770-8 Automated count)
* group[0].element[15].code = #26508-2
* group[0].element[15].display = "Neutrophils/100 leukocytes in Blood by Manual count"
* group[0].element[15].target[0].code = #770-8
* group[0].element[15].target[0].display = "Neutrophils/100 leukocytes in Blood by Automated count"
* group[0].element[15].target[0].equivalence = #relatedto
* group[0].element[15].target[0].comment = "Manual 與 Automated 為不同具體方法，無包含關係"

// =============================================================
// 肝功能群組 (Liver Function) — 新增 3 組
// =============================================================

// AST / GOT (Acceptable: 14409-7 by UV with P5P → Preferred: 1920-8)
* group[0].element[16].code = #14409-7
* group[0].element[16].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
* group[0].element[16].target[0].code = #1920-8
* group[0].element[16].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[16].target[0].equivalence = #narrower
* group[0].element[16].target[0].comment = "source 指定 UV with P5P，target 方法未指定"

// ALT / GPT (Acceptable: 14390-9 by UV with P5P → Preferred: 1742-6)
* group[0].element[17].code = #14390-9
* group[0].element[17].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
* group[0].element[17].target[0].code = #1742-6
* group[0].element[17].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[17].target[0].equivalence = #narrower
* group[0].element[17].target[0].comment = "source 指定 UV with P5P，target 方法未指定"

// ALP (Acceptable: 1783-0 method-unspecified → Preferred: 6768-6)
* group[0].element[18].code = #1783-0
* group[0].element[18].display = "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[18].target[0].code = #6768-6
* group[0].element[18].target[0].display = "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[18].target[0].equivalence = #equivalent
* group[0].element[18].target[0].comment = "同概念同檢體，兩碼方法均未指定"

// =============================================================
// 內分泌與癌症標記群組 (Endocrine & Tumor Markers) — 新增 4 組
// =============================================================

// HbA1c (Acceptable: 59261-8 IFCC mmol/mol → Preferred: 4548-4 NGSP %)
// 單位換算說明：IFCC (mmol/mol) = (NGSP(%) - 2.152) / 0.9148
* group[0].element[19].code = #59261-8
* group[0].element[19].display = "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol"
* group[0].element[19].target[0].code = #4548-4
* group[0].element[19].target[0].display = "Hemoglobin A1c/Hemoglobin.total in Blood"
* group[0].element[19].target[0].equivalence = #relatedto
* group[0].element[19].target[0].comment = "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"

// TSH (Acceptable: 3016-3 3rd generation IS → Preferred: 11580-8)
* group[0].element[20].code = #3016-3
* group[0].element[20].display = "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS"
* group[0].element[20].target[0].code = #11580-8
* group[0].element[20].target[0].display = "Thyrotropin [Units/volume] in Serum or Plasma"
* group[0].element[20].target[0].equivalence = #narrower
* group[0].element[20].target[0].comment = "source 指定 3rd IS 標準品，target 未指定"

// PSA (Acceptable: 19199-9 method-unspecified → Preferred: 2857-1)
* group[0].element[21].code = #19199-9
* group[0].element[21].display = "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* group[0].element[21].target[0].code = #2857-1
* group[0].element[21].target[0].display = "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* group[0].element[21].target[0].equivalence = #equivalent
* group[0].element[21].target[0].comment = "同概念同檢體，方法均未指定"

// CA-125 (Acceptable: 83082-8 by IA → Preferred: 10334-1)
* group[0].element[22].code = #83082-8
* group[0].element[22].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
* group[0].element[22].target[0].code = #10334-1
* group[0].element[22].target[0].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma"
* group[0].element[22].target[0].equivalence = #narrower
* group[0].element[22].target[0].comment = "source 指定 Immunoassay，target 方法未指定"

// CEA (Acceptable: 83085-1 by IA → Preferred: 2039-6)
* group[0].element[23].code = #83085-1
* group[0].element[23].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* group[0].element[23].target[0].code = #2039-6
* group[0].element[23].target[0].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
* group[0].element[23].target[0].equivalence = #narrower
* group[0].element[23].target[0].comment = "source 指定 Immunoassay，target 方法未指定"

// AST (Acceptable: 88112-8 w/o P-5'-P → Preferred: 1920-8)
* group[0].element[24].code = #88112-8
* group[0].element[24].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[24].target[0].code = #1920-8
* group[0].element[24].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[24].target[0].equivalence = #narrower
* group[0].element[24].target[0].comment = "source 指定 No addition of P-5'-P，target 方法未指定"

// ALT (Acceptable: 1744-2 w/o P-5'-P → Preferred: 1742-6)
* group[0].element[25].code = #1744-2
* group[0].element[25].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[25].target[0].code = #1742-6
* group[0].element[25].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[25].target[0].equivalence = #narrower
* group[0].element[25].target[0].comment = "source 指定 No addition of P-5'-P，target 方法未指定"

// Glucose AC (Acceptable: 2345-7 post fasting → Preferred: 1558-6 fasting)
* group[0].element[26].code = #2345-7
* group[0].element[26].display = "Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[26].target[0].code = #1558-6
* group[0].element[26].target[0].display = "Fasting Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[26].target[0].equivalence = #wider
* group[0].element[26].target[0].comment = "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣"

// LDL (舊版直接測定法代碼 → Preferred 2089-1)
* group[0].element[27].code = #18262-6
* group[0].element[27].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* group[0].element[27].target[0].code = #2089-1
* group[0].element[27].target[0].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
* group[0].element[27].target[0].equivalence = #narrower
* group[0].element[27].target[0].comment = "source 指定 Direct assay，target 方法未指定"

// =============================================================
// v20260724（文件一/二 v3.0 對齊，P4：補齊已宣告為 Acceptable 但缺 ConceptMap 之對應）
// =============================================================

// 血中鉛：院內 LIS Specimen 碼 → Preferred Blood
* group[0].element[28].code = #23749-5
* group[0].element[28].display = "Lead [Mass/volume] in Specimen"
* group[0].element[28].target[0].code = #5671-3
* group[0].element[28].target[0].display = "Lead [Mass/volume] in Blood"
* group[0].element[28].target[0].equivalence = #relatedto
* group[0].element[28].target[0].comment = "source 檢體為泛稱 Specimen、target 限 Blood，非單純包含"

// 腰圍：一般腰圍碼（語意較廣） → Preferred 臍位皮尺法
* group[0].element[29].code = #56086-2
* group[0].element[29].display = "Waist Circumference"
* group[0].element[29].target[0].code = #8280-0
* group[0].element[29].target[0].display = "Waist Circumference at umbilicus by Tape measure"
* group[0].element[29].target[0].equivalence = #relatedto
* group[0].element[29].target[0].comment = "source 為 PhenX 之量測 protocol 碼、target 為臍位皮尺量測碼，性質不同"

// 聽力：純音聽力 panel 變異碼 → Preferred panel（採方案 A：僅 panel 對 panel；
// 21104-5 系列之 14 個頻率 component 對應列為後續 backlog，另建 ConceptMap 處理）
* group[0].element[30].code = #21104-5
* group[0].element[30].display = "Pure tone audiometry - Audiometry study"
* group[0].element[30].target[0].code = #89015-2
* group[0].element[30].target[0].display = "Pure tone threshold audiometry panel"
* group[0].element[30].target[0].equivalence = #relatedto
* group[0].element[30].target[0].comment = "panel 層對應；兩者頻率成分結構未逐一對齊，component 層等價未經確立"

