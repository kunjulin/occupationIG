ValueSet: VS_CoreDataset
Id: VS-CoreDataset
Title: "健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集）"
Description: "【主管機關：國民健康署】Core 之檢驗子集（主管機關（國健署）最小共通上傳集之 Observation.code 綁定值集，綁定強度 extensible）。僅收錄 Core 之 10 檢驗項 preferred code 及其 acceptable 變異碼；生理量測（身高/體重/腰圍/血壓）碼分屬 VS-TWHAVitalSigns、社會史（吸菸/嚼檳）碼分屬 SocialHistory profile。Core 全集（21 列）之群組見 VS-CoreUploadSet。acceptable→preferred 歸一見 ConceptMap TWHealthCheckLaboratoryMap。"
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
* LNC#3048-6 "Triglyceride [Mass/volume] in Serum or Plasma --fasting"   // Acceptable：空腹採檢條件特化（2026-08-22 委員決議補回——健檢實務確為空腹採檢）；經 ConceptMap 歸一至 2571-8（#wider）
* LNC#1644-4 "Triglyceride [Mass/volume] in Serum or Plasma --12 hours fasting"   // Acceptable：12 小時空腹條件特化（2026-08-22 第二批委員決議）；經 ConceptMap 歸一至 2571-8（#wider）
// ⚠️ 3048-6 與 1644-4 均為空腹條件之特化，差別在 1644-4 明指「12 小時」。
//    兩者對 2571-8 皆為 #wider（target 未指定空腹，語意較廣），歸一後**空腹條件之標示會遺失**；
//    接收端若需區分空腹時數，應保留原始 coding，勿僅存歸一後之代碼。

// 09043C 高密度脂蛋白膽固醇 (HDL-C) — Preferred 2085-9
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
// (-) HDL-C 無「全血」對應碼：原列 3048-6 經 tx 驗證實為 Triglyceride --fasting（非 HDL），
//     已自本項移除，並於 2026-08-22 依委員決議改列三酸甘油酯（09004C）之 Acceptable（見上）——
//     **該碼並未被判廢，只是原本掛錯了項目**。
//     LOINC 現無乾淨之 HDL-in-Blood 代碼，本項 acceptable 從缺，僅保留 Preferred 2085-9。

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
//
// ⚠️ **跨 Scale／Property 綁定之明文例外（2026-08-22 治理決議；v0.10.2 擴及四碼）**
//    本區塊各碼之 Scale／Property（經 tx.fhir.org $lookup 查證，2026-08-22，LOINC 2.82）：
//      5804-0   Protein [Mass/volume] in Urine by Test strip            SemiQn / MCnc   ← Preferred
//      50561-0  Protein [Mass/volume] in Urine by Automated test strip  SemiQn / MCnc   ← **同型，不跨**
//      57735-3  Protein [Presence] in Urine by Automated test strip     Ord    / PrThr  ← 跨
//      2887-8   Protein [Presence] in Urine                             Ord    / PrThr  ← 跨
//      20454-5  Protein [Presence] in Urine by Test strip               Ord    / PrThr  ← 跨
//
//    一般而言同一值集內不應混編不同 Scale——半定量（分級濃度）與定性（有無）之判讀方式不同，
//    接收端若逕行比較會失真。本組**刻意**保留此跨 Scale 綁定，理由為國內 LIS 系統現況：
//    試紙尿蛋白之報告型態各院不一，強制單一 Scale 將使部分機構無碼可用。
//    **由實作端自行對應**（定性結果不得逕行視為半定量分級，反之亦然）。
//
//    ⚠️ 這是**經治理裁示之刻意設計，不是缺陷**。載為明文之目的即在於：
//    下一輪術語稽核若再次偵測到本組跨 Scale，應比對本註記後放行，
//    不得再列為待處理事項，亦不得以「一致性」為由逕自刪碼。
//    見 terminology.md §3.1.1 之同一意旨說明。
//
//    ⚠️ **「值集層允許跨 Scale」不等於「歸一層可宣告包含關係」**——兩者是不同的層。
//    值集可以讓 Ord 與 SemiQn 並存、由實作端對應；但 ConceptMap 之 #wider／#narrower
//    宣告的是**語意包含**，而 PrThr 與 MCnc 之間沒有包含關係。故上表三個跨 Scale 之碼
//    （57735-3／2887-8／20454-5）於 ConceptMap 一律為 #relatedto，**不得**因值集層之
//    治理決議而改標 #wider——那是用治理決議覆蓋術語事實。
//
//    🔴 **v0.10.2 更正**：57735-3 原標 #wider（element[38]），其 comment 僅描述 Method
//    一軸而漏看 Property 與 Scale 亦不同。它與 20454-5 對 5804-0 之軸差完全相同，
//    卻掛不同的 equivalence——同一份 ConceptMap 自相矛盾。已一併改為 #relatedto。
//    ⚠️ **對實作端之影響**：該組之「數值可否直接比較」由「可」翻為**「不可」**，
//    先前據以直接比較者須改為依判讀閾值轉換。50561-0 未跨 Scale，不受此更正影響。
* LNC#5804-0 "Protein [Mass/volume] in Urine by Test strip"
* LNC#57735-3 "Protein [Presence] in Urine by Automated test strip"                // Acceptable：自動化試紙定性碼；Ord/PrThr，跨 Scale；經 ConceptMap 歸一至 5804-0（#relatedto——v0.10.2 由 #wider 更正，見下註）
* LNC#50561-0 "Protein [Mass/volume] in Urine by Automated test strip"             // Acceptable：自動化試紙（2026-08-22 第二批委員決議）；Property 與 Scale 均與 Preferred 相同，僅 Method 特化，**不跨 Scale**；經 ConceptMap 歸一至 5804-0（#wider）
* LNC#2887-8 "Protein [Presence] in Urine"                                         // Acceptable：定性通用碼（2026-08-22 第二批委員決議）；Ord/PrThr，跨 Scale；經 ConceptMap 歸一至 5804-0（#relatedto——無包含關係，須依判讀閾值轉換）
* LNC#20454-5 "Protein [Presence] in Urine by Test strip"                          // Acceptable：定性試紙碼（2026-08-22 第二批委員決議）；Ord/PrThr，跨 Scale；經 ConceptMap 歸一至 5804-0（#relatedto，同上）

// 14032C B型肝炎表面抗原 (HBsAg) — Preferred 5196-1
* LNC#5196-1 "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
* LNC#5195-3 "Hepatitis B virus surface Ag [Presence] in Serum"          // Acceptable: 血清定性(原22326-3 經tx驗證實為 HCV 5-1-1 Ab，已更正)
* LNC#63557-3 "Hepatitis B virus surface Ag [Units/volume] in Serum or Plasma by Immunoassay" // Acceptable: 免疫法

// 14051C C型肝炎抗體 (anti-HCV) — Preferred 13955-0
* LNC#13955-0 "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay"
* LNC#16128-1 "Hepatitis C virus Ab [Presence] in Serum"                  // Acceptable: 血清通用碼（原 47365-2 為捐血者篩檢情境碼，不適用一般健檢，已更正）

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use