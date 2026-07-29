// 附表十「特殊體格檢查／健康檢查」之情境資料集③（JOB-07）。
//
// 顆粒度決策（JOB-07 §5）：附表十逐號列 35 項具名作業，但檢查項目高度重疊——
// 多數家族共用「作業經歷/生活習慣/自覺症狀調查 ＋ 尿蛋白尿潛血 ＋ 肝腎功能 ＋ CBC」，
// 差異在少數家族專屬生物偵測項。故：
//   - **不**做 35 個值集（維護困難、稽核價值低）；
//   - 以 **12 危害家族**（CS-HazardType）為值集主體；附表十 35 號 → 家族之導引沿用
//     既有 ConceptMap-Appendix10-to-HazardType，不重複定義。
//
// ⚠️ **分期落地（與 JOB-01 綁定）**：JOB-07 §5 明訂「務必在 JOB-01 之後做，
//    勿把錯碼寫進法定必驗值集」。special-exam.md 之涵蓋表逐家族標註臨床審查狀態；
//    目前**僅噪音／鉛／粉塵／有機溶劑四家族為「已審／已驗」**。本檔只落地這四家族，
//    其餘八家族（高溫、游離輻射、異常氣壓、四烷基鉛、特定化學物質、黃磷、聯吡啶）
//    之專屬代碼多為「未審／部分驗證」，**刻意不納入**——待 JOB-01（T-1，23 碼待
//    臨床確認）完成後再擴充。此分期本身登記於未決事項 M-8。
//
// 共同項目：每一家族之特殊健檢均含附表九一般項目，故完整之情境需求 ＝
//    VS-Appendix9-RequiredSet ∪ 對應家族之專屬值集。稽核示範見 special-exam.md。
//
// 代碼來源：所有專屬代碼取自 special-exam.md 涵蓋表之「已審／已驗」列，未引入新代碼。

// ---- 噪音作業（附表十 2；★ 第一期已結構化）----
ValueSet: VS_Appendix10NoiseRequiredSet
Id: VS-Appendix10-Noise-RequiredSet
Title: "附表十 噪音作業 專屬應執行項目值集"
Description: "附表十第 2 項噪音作業之家族專屬檢查項目（純音聽力）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。"
* ^experimental = true
* ^status = #draft
* LNC#89015-2 "Pure tone air conduction threshold audiometry panel"    // 純音聽力（0.5–8 kHz 各頻率以 TWHA-HearingTest component 承載）

// ---- 鉛作業（附表十 5；★ 第一期已結構化）----
ValueSet: VS_Appendix10LeadRequiredSet
Id: VS-Appendix10-Lead-RequiredSet
Title: "附表十 鉛作業 專屬應執行項目值集"
Description: "附表十第 5 項鉛作業之家族專屬檢查項目（血中鉛及尿中鉛相關生物偵測）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。"
* ^experimental = true
* ^status = #draft
* LNC#77307-7 "Lead [Mass/volume] in Venous blood"                     // 血中鉛（Preferred；5671-3／23749-5 為 Acceptable，經 ConceptMap 歸一）
* LNC#5676-2 "Lead [Mass/volume] in Urine"                             // 尿中鉛
* LNC#11212-8 "Coproporphyrin [Mass/volume] in Urine"           // 尿中共聚卟啉
* LNC#11215-1 "Delta aminolevulinate [Mass/volume] in Urine"          // 尿中 δ-胺基酮戊酸

// ---- 粉塵作業（附表十 23；★ 第一期已結構化）----
ValueSet: VS_Appendix10DustRequiredSet
Id: VS-Appendix10-Dust-RequiredSet
Title: "附表十 粉塵作業 專屬應執行項目值集"
Description: "附表十第 23 項粉塵作業之家族專屬檢查項目（胸部 X 光與肺功能）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。"
* ^experimental = true
* ^status = #draft
* LNC#36643-5 "XR Chest 2 Views"                                       // 胸部 X 光（塵肺症）
* LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry" // FVC
* LNC#20150-9 "FEV1"                                                    // FEV1
* LNC#19926-5 "FEV1/FVC"                                                // FEV1/FVC

// ---- 有機溶劑作業（附表十 7–12、33–35；涵蓋表列為已審／已驗）----
// 一個值集涵蓋有機溶劑家族之各作業專屬尿中代謝物；哪一號作業對應哪一代謝物，
// 見 special-exam.md 涵蓋表與各節說明。肝功能 ALT／γ-GT 為家族共同要求。
ValueSet: VS_Appendix10OrganicSolventRequiredSet
Id: VS-Appendix10-OrganicSolvent-RequiredSet
Title: "附表十 有機溶劑作業 專屬應執行項目值集"
Description: "附表十第 7–12、33–35 項有機溶劑類作業之家族專屬檢查項目：各作業之尿中生物偵測代謝物與肝功能。附表十號別 → 代謝物之對應見 special-exam.md 涵蓋表。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。"
* ^experimental = true
* ^status = #draft
* LNC#1742-6 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma" // ALT（家族共同）
* LNC#2324-2 "Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma" // γ-GT（家族共同）
* LNC#12533-6 "Thiazolidine-2-Thione-4-Carboxylic acid [Mass/volume] in Urine" // 二硫化碳：尿中 TTCA
* LNC#3041-1 "Trichloroacetate [Mass/volume] in Urine"                 // 三氯乙烯：尿中三氯乙酸
* LNC#12543-5 "Methyl formamide [Mass/volume] in Urine"                 // DMF：尿中 N-甲基甲醯胺
* LNC#31170-4 "2,5-Hexanedione [Mass/volume] in Urine"                     // 正己烷：尿中 2,5-己二酮
* LNC#13000-5 "Mandelate [Mass/volume] in Urine"                       // 苯乙烯：尿中扁桃酸（過渡期）
* LNC#6709-0 "Hippurate [Mass/volume] in Urine"                        // 甲苯：尿中馬尿酸（過渡期）
* LNC#2725-0 "Para methylhippurate [Mass/volume] in Urine"                  // 二甲苯：尿中甲基馬尿酸（過渡期）

// ---- grouping：附表十已落地家族之總集 ----
// 隨 JOB-01 逐家族結案，於此 include 增列對應子值集；未落地家族之清單見
// special-exam.md 涵蓋表與 M-8。此為分期揭露，非「附表十完整需求」之表述。
ValueSet: VS_Appendix10RequiredSet
Id: VS-Appendix10-RequiredSet
Title: "附表十 特殊健康檢查應執行項目值集（已落地家族）"
Description: "附表十特別危害健康作業之家族專屬應執行項目 grouping 值集。**目前僅含已通過術語稽核之四家族**（噪音／鉛／粉塵／有機溶劑）；其餘八家族之專屬代碼待 JOB-01 臨床確認後擴充（見 special-exam.md 涵蓋表與未決事項 M-8）。任一家族之完整情境需求 ＝ 本 grouping 對應子集 ∪ VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。"
* ^experimental = true
* ^status = #draft
* include codes from valueset VS_Appendix10NoiseRequiredSet
* include codes from valueset VS_Appendix10LeadRequiredSet
* include codes from valueset VS_Appendix10DustRequiredSet
* include codes from valueset VS_Appendix10OrganicSolventRequiredSet
