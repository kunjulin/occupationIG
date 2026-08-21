Profile: TWHACompositionEmergencySummaryProfile
Parent: TWCoreComposition
Id: TWHA-Composition-EmergencySummary
Title: "職業健康急診友善摘要 Composition Profile"
Description: "【技術規格】職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用。

**定位**：本 Profile 為**按需產生之臨床摘要原型（prototype）**，屬工作小組建議方案，**非正式交換要求**；俟臨床測試與回饋後再確認其範圍與必填欄位。

**使用限制（負向表列，實作與臨床使用時必須遵守）**：
1. **本摘要不取代急診臨床評估**：所載資料為既有健檢紀錄之彙整，不構成診斷或處置建議，急診決策仍應以當下臨床評估為準。
2. **舊值必須顯示資料日期與來源機構**：所引用之每筆檢驗／量測結果，均須可辨識其 `effectiveDateTime` 與 `performer`／來源機構；未標示日期與來源之數值不得呈現。
3. **無資料不等於無暴露**：本摘要未列出某項危害暴露，僅表示系統中無相關紀錄，**不得推論該勞工未曾暴露**；必要時仍應詢問病史。
4. **受檢者自述與機構驗證資料必須可區分**：以問卷／自述取得之資訊（如 QuestionnaireResponse）與經醫療機構檢驗驗證之結果，須於呈現時明確區分，不得混同陳列。"
* ^experimental = false
* status = #final
* type = http://loinc.org#60591-5 "Patient summary Document"
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* author only Reference(TWHAPractitionerProfile)
* title 1..1

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.ordered = false

* section contains
    exposureHistory 1..1 and
    vitalSigns 0..1 and
    keyLabs 0..1 and
    assessment 0..1

* section[exposureHistory].code = http://loinc.org#11341-5
* section[exposureHistory].title = "作業與暴露史"
* section[exposureHistory].entry only Reference(Observation)

* section[vitalSigns].code = http://loinc.org#8716-3
* section[vitalSigns].title = "生命徵象"
* section[vitalSigns].entry only Reference(Observation)

* section[keyLabs].code = http://loinc.org#30954-2
* section[keyLabs].title = "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）"
* section[keyLabs].entry only Reference(Observation or DiagnosticReport)

// ⚠️ v0.9.0：entry 加入 TWHAHealthManagementLevelProfile，與 TWHA-Composition
// 於 v0.8.5 之處置一脈相承。本節之 Description 已明文承諾承載「健康管理分級」
//（見本檔 Description：「供急診醫師快速掌握其……以及健康管理分級」、
// 「將……總評分級以 section.entry 引用」），型別約束卻不收承載分級的那個資源
// ——**文件承諾與型別約束互相矛盾**。
//
// ⚠️ 本節與 TWHA-Composition.section[assessment]、
//    TWHA-Composition-EmployerSummary.section[healthManagement] **同用 51848-0**，
//    而 section 切片之判別子為 code 之 pattern，故三者在 FHIR 眼中是同一個 section。
//    修正後三者對該 section 之型別認定一致。
//
// ⚠️ 目前無任何實例把分級放進本摘要，故此矛盾**不產生任何 WARNING**——
//    沒有訊號的矛盾不會自己浮出來，這正是它必須被主動修掉而非等它出事的理由。
//
// 屬**放寬**：既有實例全數仍合法，非破壞性變更。加的是 profile 而非裸 Observation。
* section[assessment].code = http://loinc.org#51848-0
* section[assessment].title = "健康管理分級與急診注意事項"
* section[assessment].entry only Reference(ClinicalImpression or CarePlan or TWHAHealthManagementLevelProfile)
