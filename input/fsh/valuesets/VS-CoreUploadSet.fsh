ValueSet: VS_CoreUploadSet
Id: VS-CoreUploadSet
Title: "主管機關最小共通上傳集（國健署原案 21 列，跨值集群組）"
Description: "【主管機關：國民健康署】群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳之狀態由本 IG 之 VS-BetelNutStatus 承載（與吸菸狀態四碼逐碼對稱）；量／年數／戒除期間自 v0.4.0 起改以 UCUM Quantity 承載（{quid}/d、a、a 或 mo），上游臺灣癌症登記短表 IG（TWCR_SF, fhir.TWCRSF#0.1.1）之級距碼降為可選 component（extensible）供勾稽之用，見 TWHA-SocialHistory-BetelNut 與術語頁 §6.2b。注意戒除期間之單位以原始採集粒度為準（上游以「年」計），與吸菸之戒除「月數」（LNC#63632-4）不同，不得逕行換算。"
* ^experimental = false
// ⚠️ 本群組值集之碼數**與原案之 21 列計的不是同一件事**（v0.5.0 查明，v0.10.0 調整）：
//   − 嚼檳量（30907X-2）／− 嚼食持續期間（30907X-3，原案欄名「嚼檳月數」）
//                    ——原案各為獨立一列，本指引以同一 Observation 之 component 承載
//                      （component[amount]／component[durationYears]），
//                      非獨立 Observation.code，故本值集無對應碼。
//                      ⚠️ 第 11 列之語意經**本案專家會議決議**更正為「嚼食持續期間」
//                      （原案 r4 誤寫為「戒檳月數」），詳見 conformance.md §7.2 與
//                      未決事項 M-12。戒除資訊改由 component[cessationDuration]／
//                      [cessationDate] 承載，**不佔列位**，故不影響本值集之組成。
//   核算：**preferred 主碼數** ＋ 2（以 component 承載者）= 21。
//   ⚠️ **碼數以實測為準**（見 conformance.md §7.2），不得沿用註解所載之數字。
//   🔴 v0.10.1 更正名詞：本行原寫「展開碼數」，但「展開」在 FHIR 指 $expand，
//      其結果**含所有 acceptable 變異碼**（光 VS-CoreDataset 之碼數就已超過 21），
//      成員代碼數 ＋ 2 不會等於 21。算式算的是每列之 preferred 主碼，非 $expand 結果。
//
// ═══ BMI 之處置：v0.10.0 由「註解排除」改為「明文 exclude」═══
// **主管機關原案未列 BMI**，故不納入最小上傳集。
// ⚠️ 這是**事實陳述**，不是本指引之主張：原案 21 列中本來就沒有 BMI，
//    本次只是讓值集之機器可讀結果與原案一致。**回到原案，不需任何一方核定。**
//
// 原作法僅在本註解區宣告「不是 Core 列、不得據以推論」。**註解攔不住機器**——
// 任何以值集展開做涵蓋核對的程式，看到的仍是含 BMI 的清單。故改為明文排除。
//
// ⚠️ **刻意不改成逐碼重列生理量測**：那會漏掉 acceptable 變異碼，且日後
//    VS-TWHAVitalSigns 新增代碼時不會自動帶入。exclude 只拿掉一碼，其餘機制不動。
// ⚠️ **VS-TWHAVitalSigns 本身不動**：BMI 仍是有效之生理量測項目，
//    只是不屬最小上傳集。兩者是不同的問題。
//
// 逐列對照見 conformance.md §7.2。
// 來源：TWHA IG 完整編碼附件 v7.7〈Core 主管機關最小集(21)〉（原案內容同 v7.6）。
// 檢驗子集（10 項 + acceptable）
* include codes from valueset VS_CoreDataset
// 生理量測（身高/體重/腰圍/血壓）
* include codes from valueset VS_TWHAVitalSigns
* exclude LNC#39156-5   // BMI：主管機關原案 21 列未列此碼，故不納入最小上傳集（回到原案）
// 社會史（吸菸狀態/吸菸量/戒菸月數/嚼檳狀態）
* LNC#72166-2  // 吸菸狀態 Tobacco smoking status
* LNC#64218-1  // 吸菸量 How many cigarettes do you smoke per day now [PhenX]（官方 Property NRat＝Count/Time，單位為「支/日」`/d`，非「包/日」；pack-year／packs/day 須另尋代碼並經查證，勿沿用本碼）
* LNC#63632-4  // 戒菸月數 Have quit smoking (duration)
* CS_BetelNutObservable#betel-quid-chewing-status // 嚼檳狀態（問題碼）
// ⚠️ v0.9.0：本列由 SCT#698188003 改為自訂問句碼（JOB-32 步驟 2）。
//    698188003 是肯定式 finding，置於 Observation.code 會與「從未嚼食」之答案矛盾。
//    **本列所計之上傳欄位（醫令 30907X-1）未變**，變的只是承載該欄位之 FHIR 代碼。

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use