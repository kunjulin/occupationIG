ValueSet: VS_CoreUploadSet
Id: VS-CoreUploadSet
Title: "主管機關最小共通上傳集（國健署原案 21 列，跨值集群組）"
Description: "【主管機關：國民健康署】群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳之狀態由本 IG 之 VS-BetelNutStatus 承載（與吸菸狀態四碼逐碼對稱）；量／年數／戒除期間自 v0.4.0 起改以 UCUM Quantity 承載（{quid}/d、a、a 或 mo），上游臺灣癌症登記短表 IG（TWCR_SF, fhir.TWCRSF#0.1.1）之級距碼降為可選 component（extensible）供勾稽之用，見 TWHA-SocialHistory-BetelNut 與術語頁 §6.2b。注意戒除期間之單位以原始採集粒度為準（上游以「年」計），與吸菸之戒除「月數」（LNC#63632-4）不同，不得逕行換算。"
* ^experimental = false
// ⚠️ 本群組值集**展開為 20 個 preferred 代碼，不等於原案之 21 列**（差三項，v0.5.0 查明）：
//   ＋ BMI 39156-5   ——**不是 Core 列**，係 VS-TWHAVitalSigns 之成員被群組一併帶入。
//                      **不得據本值集推論 BMI 屬最小上傳集。**
//   − 嚼檳量（30907X-2）／− 嚼檳月數（30907X-3）
//                    ——原案各為獨立一列，本指引以同一 Observation 之 component 承載
//                      （component[amount]／component[cessationDuration] 或 [durationYears]），
//                      非獨立 Observation.code，故本值集無對應碼。
//   核算：20 − 1 ＋ 2 = 21。兩個數字都對，計的不是同一件事。
// 逐列對照與三項待主管機關確認之事項見 conformance.md §7.2。
// 來源：TWHA IG 完整編碼附件 v7.6〈Core 主管機關最小集(21)〉。
// 檢驗子集（10 項 + acceptable）
* include codes from valueset VS_CoreDataset
// 生理量測（身高/體重/腰圍/血壓）
* include codes from valueset VS_TWHAVitalSigns
// 社會史（吸菸狀態/吸菸量/戒菸月數/嚼檳狀態）
* LNC#72166-2  // 吸菸狀態 Tobacco smoking status
* LNC#64218-1  // 吸菸量 How many cigarettes do you smoke per day now [PhenX]（官方 Property NRat＝Count/Time，單位為「支/日」`/d`，非「包/日」；pack-year／packs/day 須另尋代碼並經查證，勿沿用本碼）
* LNC#63632-4  // 戒菸月數 Have quit smoking (duration)
* CS_BetelNutObservable#betel-quid-chewing-status // 嚼檳狀態（問題碼）
// ⚠️ v0.9.0：本列由 SCT#698188003 改為自訂問句碼（JOB-32 步驟 2）。
//    698188003 是肯定式 finding，置於 Observation.code 會與「從未嚼食」之答案矛盾。
//    **本列所計之上傳欄位（醫令 30907X-1）未變**，變的只是承載該欄位之 FHIR 代碼。

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use