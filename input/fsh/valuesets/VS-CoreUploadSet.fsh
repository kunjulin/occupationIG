ValueSet: VS_CoreUploadSet
Id: VS-CoreUploadSet
Title: "主管機關最小共通上傳集（國健署原案 21 列，跨值集群組）"
Description: "群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳之量／年／戒除年由臺灣癌症登記短表 IG（TWCR_SF, fhir.TWCRSF#0.1.1）之值集承載（sf-BetNutChewAmount／sf-BetNutChewYear／sf-BetNutChewQuit，required 綁定，見 TWHA-SocialHistory-BetelNut），非本 IG 自訂，亦非無碼；LOINC／SNOMED 就此無對應碼故採國內值集。注意上游以「年」計，與吸菸之戒除「月數」（LNC#63632-4）單位不同。"
* ^experimental = false
// 檢驗子集（10 項 + acceptable）
* include codes from valueset VS_CoreDataset
// 生理量測（身高/體重/腰圍/血壓）
* include codes from valueset VS_TWHAVitalSigns
// 社會史（吸菸狀態/吸菸量/戒菸月數/嚼檳狀態）
* LNC#72166-2  // 吸菸狀態 Tobacco smoking status
* LNC#64218-1  // 吸菸量 How many cigarettes do you smoke per day now [PhenX]（官方 Property NRat＝Count/Time，單位為「支/日」`/d`，非「包/日」；pack-year／packs/day 須另尋代碼並經查證，勿沿用本碼）
* LNC#63632-4  // 戒菸月數 Have quit smoking (duration)
* SCT#698188003 // 嚼檳狀態 Chews betel quid
