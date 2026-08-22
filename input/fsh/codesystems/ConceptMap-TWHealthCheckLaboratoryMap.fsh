Instance: TWHealthCheckLaboratoryMap
// We use ConceptMap directly
InstanceOf: ConceptMap
Title: "健康檢查檢驗項目代碼對應 ConceptMap"
Description: "【主管機關：國民健康署】將健康檢查實驗室檢驗之 acceptable code 歸一至 preferred (primary) code。值集綁定採 extensible binding；本 ConceptMap 供接收端將院所 LIS 之可接受變異碼標準化至優先碼。

**來源版本**：LOINC 2.82（經 tx.fhir.org 驗證）。**驗證狀態**：全數 source／target 代碼已於 2026-07-26 完成 $validate-code 代碼有效性驗證。**審查狀態**：equivalence 已於 2026-07-26 逐筆覆核並補列理由（comment），工作小組建議方案，提請確認可否作為下一階段試作基礎。

**equivalence 使用原則**：R4 之 `narrower`／`wider` **以 target 為主詞**（`narrower` = target 較 source 窄；`wider` = target 較 source 廣），與直覺相反——R5 已改名為 `source-is-narrower-than-target` 以消除歧義。故本 ConceptMap 之判準為：source 為方法特化而 target 為方法通用碼者用 **`wider`**（target 較廣）；source 語意較廣而 target 較窄（指定空腹／方法／偵測極限）者用 **`narrower`**（target 較窄）；不同具體方法、不同檢體、或需數值換算而無包含關係者用 `relatedto`（Level 1，官方語意為「有關聯但確切關係未知」，**不得據以自動換算數值**）。`equivalent` 僅用於完全等義，現行無任何一組適用。\n\n⚠️ comment 之方向敘述與 equivalence 值之一致性已納入建置閘門逐筆檢核。

⚠️ **歸一之臨床限制**：本對照供資料標準化之用，**不表示歸一後之數值可直接互換比較**（例如 MDRD 與 CKD-EPI eGFR、IFCC 與 NGSP HbA1c 均需換算或不可互換）。交換時應保留原始代碼。"
* name = "TWHealthCheckLaboratoryMap"
// ⚠️ v0.7.1：本檔原僅以 `Description:` 關鍵字提供描述，且**無 `Usage: #definition`**
// （預設為 #example），SUSHI 遂將 Title:／Description: 視為範例之 IG 層 metadata，
// **不寫入 ConceptMap.title／.description**——v0.7.0 線上實測該資源兩欄皆為 null。
// 故權責標籤改以元素賦值提供，元素賦值必定落地，與 Appendix10-to-HazardType、
// NS-ReportIdentifier 之作法一致。
//
// ⚠️ v0.8.2：`title` 同理。上方之 `Title:` 關鍵字與 `Description:` 一樣**不寫入資源**，
// 故 ConceptMap.title 一直是 null，觸發 ShareableConceptMap 之 WARNING。
// 此處以元素賦值補上，字串與 `Title:` 保持一致以免根層與資源層兩套名稱。
* title = "健康檢查檢驗項目代碼對應 ConceptMap"
* description = "【主管機關：國民健康署】將健康檢查實驗室檢驗之 acceptable code 歸一至 preferred (primary) code。值集綁定採 extensible binding；本 ConceptMap 供接收端將院所 LIS 之可接受變異碼標準化至優先碼。詳細之來源版本、驗證狀態、equivalence 使用原則與歸一之臨床限制，見本指引〈術語〉頁與本檔 Description。"
// JOB-31 §5(A)：納入權責登記（hpa／Level 1）。本對照為 Level 1 之必要配套——
// Level 1 之值集綁定為 extensible，接收端正是靠它把院所送的 acceptable 變異碼
// 歸一至 preferred，故其成熟度須與 Level 1 一致並同受閘門保護。status 維持 active。
* status = #active
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[0].valueCode = #trial-use
* experimental = false
* version = "2026-07-26"
* date = "2026-07-26"
* sourceUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"
* targetUri = "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"

// WBC Mapping
* group[0].source = "http://loinc.org"
* group[0].target = "http://loinc.org"
* group[0].element[0].code = #804-5
* group[0].element[0].display = "Leukocytes [#/volume] in Blood by Manual count"
* group[0].element[0].target[0].code = #6690-2
* group[0].element[0].target[0].display = "Leukocytes [#/volume] in Blood by Automated count"
* group[0].element[0].target[0].equivalence = #relatedto
* group[0].element[0].target[0].comment = "Manual 與 Automated 為不同具體方法，無包含關係；數值不可直接比較（比照 element[5] 之處理）"

* group[0].element[1].code = #26464-8
* group[0].element[1].display = "Leukocytes [#/volume] in Blood"
* group[0].element[1].target[0].code = #6690-2
* group[0].element[1].target[0].display = "Leukocytes [#/volume] in Blood by Automated count"
* group[0].element[1].target[0].equivalence = #narrower
* group[0].element[1].target[0].comment = "source 方法未指定，target 指定 Automated count；target 語意較窄"

// Urine Protein：(-) 無 acceptable 變異碼。原 element[2] 之 2888-6 → 5804-0 已於 v20260730（JOB-21）移除——
//      2888-6（尿蛋白定量，醫令 06003C-1）與 5804-0（尿蛋白定性，醫令 06003C-2）各為獨立醫令項目之
//      Preferred，於主管機關最小上傳集為兩個獨立列。歸一之語意為「送 A 時視為 B」，而定量與定性係不同
//      檢驗、不同醫令代碼、不同 Property（Mass/volume vs Presence），不可互相取代（原 comment 自身即載明
//      「非包含關係」，與歸一之用途相牴觸）。二者之臨床關聯見 terminology.md，不放回本 ConceptMap。
//      （其後 element 已重新編號為連續索引。）

// Glucose
* group[0].element[2].code = #2339-0
* group[0].element[2].display = "Glucose [Mass/volume] in Blood"
* group[0].element[2].target[0].code = #1558-6
* group[0].element[2].target[0].display = "Fasting glucose [Mass/volume] in Serum or Plasma"
* group[0].element[2].target[0].equivalence = #relatedto
* group[0].element[2].target[0].comment = "空腹狀態與檢體均不同（source 為未指定空腹之全血、target 為空腹血漿），無包含關係；全血與血漿葡萄糖數值不可直接比較（比照 element[5] 之處理）"

// Creatinine
* group[0].element[3].code = #38483-4
* group[0].element[3].display = "Creatinine [Mass/volume] in Blood"
* group[0].element[3].target[0].code = #2160-0
* group[0].element[3].target[0].display = "Creatinine [Mass/volume] in Serum or Plasma"
* group[0].element[3].target[0].equivalence = #relatedto
* group[0].element[3].target[0].comment = "檢體不同(Blood vs Serum/Plasma)，非包含關係"

// Uric Acid：(-確定無合適碼)。原 source 49154-8 經 tx 驗證實為 Rickettsia conorii IgG Ab [Titer]，
//   非尿酸之可接受碼，已移除該組對應。

// Total Cholesterol
* group[0].element[4].code = #35200-5
* group[0].element[4].display = "Cholesterol [Mass or Moles/volume] in Serum or Plasma"
* group[0].element[4].target[0].code = #2093-3
* group[0].element[4].target[0].display = "Cholesterol [Mass/volume] in Serum or Plasma"
* group[0].element[4].target[0].equivalence = #narrower
* group[0].element[4].target[0].comment = "source 允許質量或莫耳濃度兩種尺度，語意較 target 廣"

// Triglycerides
* group[0].element[5].code = #3043-7
* group[0].element[5].display = "Triglyceride [Mass/volume] in Blood"
* group[0].element[5].target[0].code = #2571-8
* group[0].element[5].target[0].display = "Triglyceride [Mass/volume] in Serum or Plasma"
* group[0].element[5].target[0].equivalence = #relatedto
* group[0].element[5].target[0].comment = "檢體不同(Blood vs Serum/Plasma)"

// HDL：(-) 無 acceptable 變異碼。原 element[7] 之 source 3048-6 經 tx 驗證實為 Triglyceride --fasting，
//      非 HDL 之可接受碼，已移除該組對應（其後 element 已重新編號為連續索引）。

// LDL (Preferred 2089-1 為方法通用碼；計算法 13457-7 與直接測定法 18262-6 為方法具名之 Acceptable)
* group[0].element[6].code = #13457-7
* group[0].element[6].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
* group[0].element[6].target[0].code = #2089-1
* group[0].element[6].target[0].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
* group[0].element[6].target[0].equivalence = #wider
* group[0].element[6].target[0].comment = "source 指定計算法，target 方法未指定"

// eGFR
* group[0].element[7].code = #33914-3
* group[0].element[7].display = "Glomerular filtration rate [Volume Rate/Area] in Serum or Plasma by Creatinine-based formula (MDRD)/1.73 sq M"
* group[0].element[7].target[0].code = #98979-8
* group[0].element[7].target[0].display = "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* group[0].element[7].target[0].equivalence = #relatedto
* group[0].element[7].target[0].comment = "MDRD 與 CKD-EPI 2021 為不同估算公式，數值不可直接互換。114 年成健採雙軌併行（MDRD 必填、CKD-EPI 非必填），同一份報告可能同時含兩碼，屬正常情形而非重複上傳；115.01.01 起僅採 CKD-EPI 2021。依國健署 115.01.15 國健慢病字第1150660003號函。"

// HBsAg
* group[0].element[8].code = #5195-3
* group[0].element[8].display = "Hepatitis B virus surface Ag [Presence] in Serum"
* group[0].element[8].target[0].code = #5196-1
* group[0].element[8].target[0].display = "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* group[0].element[8].target[0].equivalence = #relatedto
* group[0].element[8].target[0].comment = "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"

// anti-HCV
* group[0].element[9].code = #16128-1
* group[0].element[9].display = "Hepatitis C virus Ab [Presence] in Serum"
* group[0].element[9].target[0].code = #13955-0
* group[0].element[9].target[0].display = "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay"
* group[0].element[9].target[0].equivalence = #relatedto
* group[0].element[9].target[0].comment = "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"

// =============================================================
// 血液學群組 (Hematology) — 新增 4 組
// 注意：Hemoglobin (718-7) 無 Acceptable 代碼；MCHC (786-4) 因語意差異亦不建立對應
// =============================================================

// Platelet (Acceptable: 26515-7 Automated count → Preferred: 777-3)
* group[0].element[10].code = #26515-7
* group[0].element[10].display = "Platelets [#/volume] in Blood"
* group[0].element[10].target[0].code = #777-3
* group[0].element[10].target[0].display = "Platelets [#/volume] in Blood by Automated count"
* group[0].element[10].target[0].equivalence = #narrower
* group[0].element[10].target[0].comment = "source 方法未指定，target 指定 Automated count；target 語意較窄"

// MCV (Acceptable: 30428-7 by calculation → Preferred: 787-2 by Automated count)
* group[0].element[11].code = #30428-7
* group[0].element[11].display = "MCV [Entitic mean volume] in Red Blood Cells"
* group[0].element[11].target[0].code = #787-2
* group[0].element[11].target[0].display = "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
* group[0].element[11].target[0].equivalence = #relatedto
* group[0].element[11].target[0].comment = "calculation 與 Automated count 為不同具體方法，無包含關係"

// MCH (Acceptable: 28539-5 by Automated count → Preferred: 785-6 by Automated count)
* group[0].element[12].code = #28539-5
* group[0].element[12].display = "MCH [Entitic mass]"
* group[0].element[12].target[0].code = #785-6
* group[0].element[12].target[0].display = "MCH [Entitic mass] by Automated count"
* group[0].element[12].target[0].equivalence = #narrower
* group[0].element[12].target[0].comment = "source 方法未指定（MCH [Entitic mass]），target 指定 Automated count；target 語意較窄"

// Neutrophil % (Acceptable: 26508-2 Manual count → Preferred: 770-8 Automated count)
* group[0].element[13].code = #26508-2
* group[0].element[13].display = "Neutrophils/100 leukocytes in Blood by Manual count"
* group[0].element[13].target[0].code = #770-8
* group[0].element[13].target[0].display = "Neutrophils/Leukocytes in Blood by Automated count"
* group[0].element[13].target[0].equivalence = #relatedto
* group[0].element[13].target[0].comment = "Manual 與 Automated 為不同具體方法，無包含關係"

// =============================================================
// 肝功能群組 (Liver Function) — 新增 3 組
// =============================================================

// AST / GOT (Acceptable: 30239-8 with P-5'-P → Preferred: 1920-8)
* group[0].element[14].code = #30239-8
* group[0].element[14].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P"
* group[0].element[14].target[0].code = #1920-8
* group[0].element[14].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[14].target[0].equivalence = #wider
* group[0].element[14].target[0].comment = "source 指定 UV with P5P，target 方法未指定"

// ALT / GPT (Acceptable: 1743-4 with P-5'-P → Preferred: 1742-6)
* group[0].element[15].code = #1743-4
* group[0].element[15].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P"
* group[0].element[15].target[0].code = #1742-6
* group[0].element[15].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[15].target[0].equivalence = #wider
* group[0].element[15].target[0].comment = "source 指定 UV with P5P，target 方法未指定"


// =============================================================
// 內分泌與癌症標記群組 (Endocrine & Tumor Markers) — 新增 4 組
// =============================================================

// HbA1c (Acceptable: 59261-8 IFCC mmol/mol → Preferred: 4548-4 NGSP %)
// 單位換算說明：IFCC (mmol/mol) = (NGSP(%) - 2.152) / 0.9148
* group[0].element[16].code = #59261-8
* group[0].element[16].display = "Hemoglobin A1c/Hemoglobin.total standardized per IFCC-RMP for CDT in Blood"
* group[0].element[16].target[0].code = #4548-4
* group[0].element[16].target[0].display = "Hemoglobin A1c/Hemoglobin.total in Blood"
* group[0].element[16].target[0].equivalence = #relatedto
* group[0].element[16].target[0].comment = "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"

// TSH (Acceptable: 3016-3 3rd generation IS → Preferred: 11580-8)
* group[0].element[17].code = #3016-3
* group[0].element[17].display = "Thyrotropin [Units/volume] in Serum or Plasma"
* group[0].element[17].target[0].code = #11580-8
* group[0].element[17].target[0].display = "Thyrotropin [Units/volume] in Serum or Plasma by Detection limit <= 0.005 mIU/L"
* group[0].element[17].target[0].equivalence = #narrower
* group[0].element[17].target[0].comment = "source 為一般 TSH（未指定偵測極限），target 指定高敏感度（Detection limit <= 0.005 mIU/L）；target 語意較窄"


// CA-125 (Acceptable: 83082-8 by IA → Preferred: 10334-1)
* group[0].element[18].code = #83082-8
* group[0].element[18].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
* group[0].element[18].target[0].code = #10334-1
* group[0].element[18].target[0].display = "Cancer Ag 125 [Units/volume] in Serum or Plasma"
* group[0].element[18].target[0].equivalence = #wider
* group[0].element[18].target[0].comment = "source 指定 Immunoassay，target 方法未指定"

// CEA (Acceptable: 83085-1 by IA → Preferred: 2039-6)
* group[0].element[19].code = #83085-1
* group[0].element[19].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
* group[0].element[19].target[0].code = #2039-6
* group[0].element[19].target[0].display = "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
* group[0].element[19].target[0].equivalence = #wider
* group[0].element[19].target[0].comment = "source 指定 Immunoassay，target 方法未指定"

// AST (Acceptable: 88112-8 w/o P-5'-P → Preferred: 1920-8)
* group[0].element[20].code = #88112-8
* group[0].element[20].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[20].target[0].code = #1920-8
* group[0].element[20].target[0].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[20].target[0].equivalence = #wider
* group[0].element[20].target[0].comment = "source 指定 No addition of P-5'-P，target 方法未指定"

// ALT (Acceptable: 1744-2 w/o P-5'-P → Preferred: 1742-6)
* group[0].element[21].code = #1744-2
* group[0].element[21].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
* group[0].element[21].target[0].code = #1742-6
* group[0].element[21].target[0].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* group[0].element[21].target[0].equivalence = #wider
* group[0].element[21].target[0].comment = "source 指定 No addition of P-5'-P，target 方法未指定"

// Glucose AC (Acceptable: 2345-7 post fasting → Preferred: 1558-6 fasting)
* group[0].element[22].code = #2345-7
* group[0].element[22].display = "Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[22].target[0].code = #1558-6
* group[0].element[22].target[0].display = "Fasting Glucose [Mass/volume] in Serum or Plasma"
* group[0].element[22].target[0].equivalence = #narrower
* group[0].element[22].target[0].comment = "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣"

// LDL (舊版直接測定法代碼 → Preferred 2089-1)
* group[0].element[23].code = #18262-6
* group[0].element[23].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
* group[0].element[23].target[0].code = #2089-1
* group[0].element[23].target[0].display = "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
* group[0].element[23].target[0].equivalence = #wider
* group[0].element[23].target[0].comment = "source 指定 Direct assay，target 方法未指定"

// =============================================================
// v20260724（文件一/二 v3.0 對齊，P4：補齊已宣告為 Acceptable 但缺 ConceptMap 之對應）
// =============================================================

// 血中鉛：院內 LIS Specimen 碼 → Preferred Blood
* group[0].element[24].code = #23749-5
* group[0].element[24].display = "Lead [Mass/volume] in Specimen"
* group[0].element[24].target[0].code = #77307-7
* group[0].element[24].target[0].display = "Lead [Mass/volume] in Venous blood"
* group[0].element[24].target[0].equivalence = #relatedto
* group[0].element[24].target[0].comment = "source 檢體為泛稱 Specimen、target 限 Blood，非單純包含"

// 腰圍：一般腰圍碼（語意較廣） → Preferred 臍位皮尺法
* group[0].element[25].code = #56086-2
* group[0].element[25].display = "Waist Circumference"
* group[0].element[25].target[0].code = #8280-0
* group[0].element[25].target[0].display = "Waist Circumference at umbilicus by Tape measure"
* group[0].element[25].target[0].equivalence = #relatedto
* group[0].element[25].target[0].comment = "source 為 PhenX 之量測 protocol 碼、target 為臍位皮尺量測碼，性質不同"

// 聽力：(-確定無合適碼)。原 source 21104-5 經 tx 驗證實為 Deprecated 大豆粉塵 IgE 過敏原，
//   非聽力之可接受碼，已移除該組對應；聽力代碼以 89015-2 panel 及其成員碼為準。

// 血中鉛：檢體未指定舊碼（DISCOURAGED）→ Preferred 靜脈血
* group[0].element[26].code = #5671-3
* group[0].element[26].display = "Lead [Mass/volume] in Blood"
* group[0].element[26].target[0].code = #77307-7
* group[0].element[26].target[0].display = "Lead [Mass/volume] in Venous blood"
* group[0].element[26].target[0].equivalence = #relatedto
* group[0].element[26].target[0].comment = "source 之檢體為未指定之 Blood、target 限 Venous blood；職業血鉛監測慣用靜脈血。source 之 LOINC 狀態為 DISCOURAGED。"


// 尿沉渣面積碼（/HPF 鏡檢）→ Preferred 體積碼（/µL 全尿自動）——JOB-14 回收
* group[0].element[27].code = #33218-9
* group[0].element[27].display = "Bacteria [#/area] in Urine sediment by Automated count"
* group[0].element[27].target[0].code = #51480-2
* group[0].element[27].target[0].display = "Bacteria [#/volume] in Urine by Automated count"
* group[0].element[27].target[0].equivalence = #relatedto
* group[0].element[27].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[28].code = #33219-7
* group[0].element[28].display = "Epithelial cells.squamous [#/area] in Urine sediment by Automated count"
* group[0].element[28].target[0].code = #51486-9
* group[0].element[28].target[0].display = "Epithelial cells.squamous [#/volume] in Urine by Automated count"
* group[0].element[28].target[0].equivalence = #relatedto
* group[0].element[28].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[29].code = #33223-9
* group[0].element[29].display = "Hyaline casts [#/area] in Urine sediment by Automated count"
* group[0].element[29].target[0].code = #51484-4
* group[0].element[29].target[0].display = "Hyaline casts [#/volume] in Urine by Automated count"
* group[0].element[29].target[0].equivalence = #relatedto
* group[0].element[29].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[30].code = #33342-7
* group[0].element[30].display = "Epithelial cells [#/area] in Urine sediment by Automated count"
* group[0].element[30].target[0].code = #87926-2
* group[0].element[30].target[0].display = "Epithelial cells [#/volume] in Urine by Automated"
* group[0].element[30].target[0].equivalence = #relatedto
* group[0].element[30].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[31].code = #43755-8
* group[0].element[31].display = "Casts [#/area] in Urine sediment by Automated count"
* group[0].element[31].target[0].code = #51483-6
* group[0].element[31].target[0].display = "Casts [#/volume] in Urine by Automated count"
* group[0].element[31].target[0].equivalence = #relatedto
* group[0].element[31].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[32].code = #46419-8
* group[0].element[32].display = "Erythrocytes [#/area] in Urine sediment by Automated count"
* group[0].element[32].target[0].code = #798-9
* group[0].element[32].target[0].display = "Erythrocytes [#/volume] in Urine by Automated count"
* group[0].element[32].target[0].equivalence = #relatedto
* group[0].element[32].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[33].code = #46702-7
* group[0].element[33].display = "Leukocytes [#/area] in Urine sediment by Automated count"
* group[0].element[33].target[0].code = #51487-7
* group[0].element[33].target[0].display = "Leukocytes [#/volume] in Urine by Automated count"
* group[0].element[33].target[0].equivalence = #relatedto
* group[0].element[33].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[34].code = #50235-1
* group[0].element[34].display = "Mucus [#/area] in Urine sediment by Automated count"
* group[0].element[34].target[0].code = #51478-6
* group[0].element[34].target[0].display = "Mucus [#/volume] in Urine by Automated count"
* group[0].element[34].target[0].equivalence = #relatedto
* group[0].element[34].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
* group[0].element[35].code = #53324-0
* group[0].element[35].display = "Spermatozoa [#/area] in Urine sediment by Automated count"
* group[0].element[35].target[0].code = #51479-4
* group[0].element[35].target[0].display = "Spermatozoa [#/volume] in Urine by Automated count"
* group[0].element[35].target[0].equivalence = #relatedto
* group[0].element[35].target[0].comment = "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"

// 身高（方法特化）：JOB-18。與尿沉渣（relatedto）不同——此處為方法特化與方法通用之包含關係，數值可直接比較，故 #narrower。
* group[0].element[36].code = #3137-7
* group[0].element[36].display = "Body height Measured"
* group[0].element[36].target[0].code = #8302-2
* group[0].element[36].target[0].display = "Body height"
* group[0].element[36].target[0].equivalence = #wider
* group[0].element[36].target[0].comment = "source 指定量測方法（Method = Measured），target 方法未指定；二者為同一身高量測概念之方法特化與通用，屬包含關係，數值可直接比較。"
// 體重（方法特化）：JOB-18，同上。
* group[0].element[37].code = #3141-9
* group[0].element[37].display = "Body weight Measured"
* group[0].element[37].target[0].code = #29463-7
* group[0].element[37].target[0].display = "Body weight"
* group[0].element[37].target[0].equivalence = #wider
* group[0].element[37].target[0].comment = "source 指定量測方法（Method = Measured），target 方法未指定；二者為同一體重量測概念之方法特化與通用，屬包含關係，數值可直接比較。"

// =============================================================
// JOB-21 §1.3 A 類：FSH 標 // Acceptable 但原無歸一路徑之 3 組（實作端送出時無法歸一）。
// equivalence 依 FHIR R4 target-relative 判準（見 JOB-22）。均使用既有代碼，未新增 LOINC。
// =============================================================
// 尿蛋白試紙（自動化）→ 試紙法通用碼
* group[0].element[38].code = #57735-3
* group[0].element[38].display = "Protein [Presence] in Urine by Automated test strip"
* group[0].element[38].target[0].code = #5804-0
* group[0].element[38].target[0].display = "Protein [Mass/volume] in Urine by Test strip"
* group[0].element[38].target[0].equivalence = #relatedto
* group[0].element[38].target[0].comment = "source 為定性（Property = PrThr、Scale = Ord、自動化試紙）、target 為半定量（MCnc / SemiQn、試紙法）；Property 與 Scale 均不同而無包含關係，定性結果不可直接當作半定量分級比較，須依判讀閾值轉換。⚠️ v0.10.2 更正：本組原標 wider，其 comment 僅描述 Method 一軸（「source 指定自動化試紙判讀，target 方法未指定自動化」），漏看 Property 與 Scale 亦不相同。判準與 element[47]／[48]（2887-8／20454-5）完全相同，故一併改為 relatedto。"
// HBsAg 定量（免疫法）→ 定性 Preferred
* group[0].element[39].code = #63557-3
* group[0].element[39].display = "Hepatitis B virus surface Ag [Units/volume] in Serum or Plasma by Immunoassay"
* group[0].element[39].target[0].code = #5196-1
* group[0].element[39].target[0].display = "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* group[0].element[39].target[0].equivalence = #relatedto
* group[0].element[39].target[0].comment = "source 為定量（Units/volume）、target 為定性（Presence），Property 不同而無包含關係；定量值不可直接當作定性結果比較，須依判讀閾值轉換"
// FVC 支氣管擴張劑前 → FVC Preferred
* group[0].element[40].code = #19876-2
* group[0].element[40].display = "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation"
* group[0].element[40].target[0].code = #19868-9
* group[0].element[40].target[0].display = "Forced vital capacity [Volume] Respiratory system by Spirometry"
* group[0].element[40].target[0].equivalence = #wider
* group[0].element[40].target[0].comment = "source 指定支氣管擴張劑給藥前之特定條件，target 未指定給藥前後；target 語意較廣"

// =============================================================
// 2026-08-22 委員決議之新增 4 組（element[41]–[44]）。
// 溯源：v1.0 候選碼經 tx.fhir.org $lookup 補充查證（2026-08-22，LOINC 2.82），全數 ACTIVE。
//
// ⚠️ 四組中**僅 element[41] 為 #wider**，其餘三組為 #relatedto——差別在於
//    「條件特化 vs 同層兄弟／protocol 碼」，不可一體套用：
//      41  空腹採檢是同一量測之**條件特化**（target 未指定空腹，語意較廣）→ #wider
//      42  超音波與皮尺是**同層之兩種量測方法**，非包含關係            → #relatedto
//      43/44  NHANES／NCFS 是**量測 protocol 碼**，性質與量測碼不同     → #relatedto
//    43／44 比照既有 element[25]（56086-2 PhenX protocol）之處理。
// =============================================================
// 三酸甘油酯 空腹採檢 → 三酸甘油酯 Preferred（條件特化，比照 element[40] 之處理）
* group[0].element[41].code = #3048-6
* group[0].element[41].display = "Triglyceride [Mass/volume] in Serum or Plasma --fasting"
* group[0].element[41].target[0].code = #2571-8
* group[0].element[41].target[0].display = "Triglyceride [Mass/volume] in Serum or Plasma"
* group[0].element[41].target[0].equivalence = #wider
* group[0].element[41].target[0].comment = "source 指定空腹採檢條件，target 未指定空腹；target 語意較廣。數值可直接比較，惟歸一後會遺失「空腹」之條件標示，接收端如需區分應保留原始 coding。"
// 腰圍 超音波法 → 腰圍 Preferred（同層方法兄弟碼）
* group[0].element[42].code = #8281-8
* group[0].element[42].display = "Waist Circumference at umbilicus by US"
* group[0].element[42].target[0].code = #8280-0
* group[0].element[42].target[0].display = "Waist Circumference at umbilicus by Tape measure"
* group[0].element[42].target[0].equivalence = #relatedto
* group[0].element[42].target[0].comment = "source 為超音波量測、target 為臍位皮尺量測；兩者為同層之方法兄弟碼而非通用與特化之包含關係，量測原理不同，數值不可直接等同比較。"
// 腰圍 NHANES protocol → 腰圍 Preferred（protocol 碼，不納入值集）
* group[0].element[43].code = #56114-2
* group[0].element[43].display = "Waist Circumference by NHANES"
* group[0].element[43].target[0].code = #8280-0
* group[0].element[43].target[0].display = "Waist Circumference at umbilicus by Tape measure"
* group[0].element[43].target[0].equivalence = #relatedto
* group[0].element[43].target[0].comment = "source 為 NHANES 之量測 protocol 碼、target 為臍位皮尺量測碼，性質不同（比照 element[25] 之 PhenX protocol 碼）。本碼不納入任何值集，僅供接收端歸一。"
// 腰圍 NCFS protocol → 腰圍 Preferred（protocol 碼，不納入值集）
* group[0].element[44].code = #56115-9
* group[0].element[44].display = "Waist Circumference by NCFS"
* group[0].element[44].target[0].code = #8280-0
* group[0].element[44].target[0].display = "Waist Circumference at umbilicus by Tape measure"
* group[0].element[44].target[0].equivalence = #relatedto
* group[0].element[44].target[0].comment = "source 為 NCFS 之量測 protocol 碼、target 為臍位皮尺量測碼，性質不同（比照 element[25] 之 PhenX protocol 碼）。本碼不納入任何值集，僅供接收端歸一。"

// =============================================================
// 2026-08-22 第二批委員決議之新增 4 組（element[45]–[48]）。
// 溯源：四碼經 tx.fhir.org $lookup 查證（2026-08-22，LOINC 2.82）均為 ACTIVE。
//
// ⚠️ **[46] 與 [47]／[48] 之差別，是本批最需要看清楚的一件事**：
//    三者 target 同為 5804-0（SemiQn / MCnc），差別在 source 之軸：
//      50561-0  SemiQn / MCnc  → 與 target **同 Property 同 Scale**，僅 Method 特化 → #wider
//      2887-8   Ord    / PrThr → Property 與 Scale **均不同**                      → #relatedto
//      20454-5  Ord    / PrThr → 同上（Method 雖同為試紙法，仍不構成包含關係）      → #relatedto
//
//    ⚠️ **不得因值集層已允許跨 Scale 綁定，就把 [47]／[48] 改標 #wider。**
//    「允許跨 Scale」是**值集層**之治理決議（見 VS-CoreDataset 之 06003C 定性區塊與
//    terminology.md §3.1.1）；#wider／#narrower 則是**歸一層**對語意包含關係之斷言。
//    PrThr 與 MCnc 之間沒有包含關係，寫成 #wider 等於以治理決議覆蓋術語事實。
//    #relatedto 是唯一誠實的值。比照 element[39]（63557-3 定量 → 5196-1 定性）。
// =============================================================
// 三酸甘油酯 12 小時空腹 → 三酸甘油酯 Preferred（條件特化，同 element[41] 之處理）
* group[0].element[45].code = #1644-4
* group[0].element[45].display = "Triglyceride [Mass/volume] in Serum or Plasma --12 hours fasting"
* group[0].element[45].target[0].code = #2571-8
* group[0].element[45].target[0].display = "Triglyceride [Mass/volume] in Serum or Plasma"
* group[0].element[45].target[0].equivalence = #wider
* group[0].element[45].target[0].comment = "source 指定 12 小時空腹條件，target 未指定空腹；target 語意較廣。數值可直接比較，惟歸一後會遺失空腹時數之標示，接收端如需區分應保留原始 coding。與 element[41]（3048-6 --fasting）同型，差別僅在本碼明指 12 小時。"
// 尿蛋白 自動化試紙（半定量）→ 尿蛋白定性 Preferred（方法特化，未跨 Scale）
* group[0].element[46].code = #50561-0
* group[0].element[46].display = "Protein [Mass/volume] in Urine by Automated test strip"
* group[0].element[46].target[0].code = #5804-0
* group[0].element[46].target[0].display = "Protein [Mass/volume] in Urine by Test strip"
* group[0].element[46].target[0].equivalence = #wider
* group[0].element[46].target[0].comment = "source 指定自動化試紙判讀，target 方法未指定自動化；Property（MCnc）與 Scale（SemiQn）均與 target 相同，僅 Method 特化，屬包含關係，數值可直接比較。本組未跨 Scale，與 element[47]／[48] 不同。"
// 尿蛋白 定性通用碼 → 尿蛋白定性 Preferred（跨 Property 與 Scale，無包含關係）
* group[0].element[47].code = #2887-8
* group[0].element[47].display = "Protein [Presence] in Urine"
* group[0].element[47].target[0].code = #5804-0
* group[0].element[47].target[0].display = "Protein [Mass/volume] in Urine by Test strip"
* group[0].element[47].target[0].equivalence = #relatedto
* group[0].element[47].target[0].comment = "source 為定性（Property = PrThr、Scale = Ord、方法未指定）、target 為半定量（MCnc / SemiQn、試紙法）；Property 與 Scale 均不同而無包含關係，定性結果不可直接當作半定量分級比較，須依判讀閾值轉換。比照 element[39]（63557-3 定量 → 5196-1 定性）之處理。"
// 尿蛋白 定性試紙碼 → 尿蛋白定性 Preferred（同上）
* group[0].element[48].code = #20454-5
* group[0].element[48].display = "Protein [Presence] in Urine by Test strip"
* group[0].element[48].target[0].code = #5804-0
* group[0].element[48].target[0].display = "Protein [Mass/volume] in Urine by Test strip"
* group[0].element[48].target[0].equivalence = #relatedto
* group[0].element[48].target[0].comment = "source 為定性（PrThr / Ord）、target 為半定量（MCnc / SemiQn）；Method 雖同為試紙法，惟 Property 與 Scale 不同而無包含關係，須依判讀閾值轉換。同 element[47] 之判準。"
