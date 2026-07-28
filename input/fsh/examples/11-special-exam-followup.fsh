// ==========================================
// 特殊健檢後續處置：分級判定 → 適性配工 → 追蹤檢查（JOB-05）
// ==========================================
//
// 本檔補齊 JOB-05 §1 所列「無任何範例」之 artifact。刻意不做成互不相干的孤立範例，
// 而是延續 UC-003（特殊危害健康作業檢查）的敘事：
//   特殊健檢 → 影像與心電圖 → 診斷報告 → 判定第四級管理 → 適性配工計畫 → 追蹤檢查要求
// 使讀者能從一個情境看到這些資源如何互相參照。
//
// 各範例之必填欄位、固定值與 required 綁定，均以 scripts/describe-profile.js
// 對 tw.gov.mohw.twcore#1.0.0 實測取得（CI run 30377469406／30377963604），
// 非依 FHIR 基礎資源推測——TW Core 對多處收緊了基數（例如
// ServiceRequest.code 由 0..1 改為 1..1、CarePlan.text.status/div 為必填）。

// ------------------------------------------------------------------
// 特殊健檢之就醫事件（帶危害類別 extension）
// 一般健檢事件為 example-encounter-general；此處另立特殊健檢事件，
// 因為 ext-hazard-type 之語意是「本次檢查所針對的危害作業種類」，
// 填在一般健檢事件上並不正確。
// ------------------------------------------------------------------
Instance: example-encounter-special
InstanceOf: TWHAEncounterProfile
Title: "健檢就醫事件範例 - 噪音作業特殊健康檢查"
Description: "受檢勞工王大同於115年6月12日進行之噪音作業特殊健康檢查事件，以 ext-hazard-type 標註危害作業種類、ext-labor-report-code 標註通報大類。"
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* subject = Reference(example-worker)
* period.start = "2026-06-12T09:00:00+08:00"
* period.end = "2026-06-12T11:00:00+08:00"
* participant[0].individual = Reference(example-doctor)
* serviceProvider = Reference(example-hospital)
// 四個 extension 一律用數字索引：第一版把前三個用具名 slice、第四個用
// extension[+]，但 SUSHI 的數字 soft index 與具名 slice 是**兩套計數器**，
// [+] 從 0 起算而把 examType 蓋掉，產生「examType minimum required = 1,
// but only found 0」（run 30406136544）。切片歸屬交由驗證器以 url 判別。
// ext-labor-report-code 未被任何 profile 具名宣告（JOB-05 §4：不擴充模型），
// 本來就只能以 URL 引用。
* extension[0].url = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type"
* extension[0].valueCodeableConcept = CS_ExamType#special-health "特殊健康檢查"
* extension[1].url = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type"
* extension[1].valueCodeableConcept = CS_HazardType#noise "噪音作業"
* extension[2].url = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department"
* extension[2].valueString = "化學處理課"
* extension[3].url = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code"
* extension[3].valueCodeableConcept = CS_LaborReportCode#30902X "噪音作業特殊健檢通報"

// ------------------------------------------------------------------
// 心電圖（TWCoreECG 固定 code 為 LOINC 11524-6；category 為必填 1..*）
// ------------------------------------------------------------------
Instance: obs-ecg
InstanceOf: TWHAECGProfile
Title: "心電圖檢查結果範例"
Description: "受檢勞工王大同之十二導程心電圖檢查，判讀結果正常。"
* status = #final
* category[twcore] = http://terminology.hl7.org/CodeSystem/observation-category#procedure
* code = LNC#11524-6 "EKG study"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T09:30:00+08:00"
* performer = Reference(example-doctor)
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

// ------------------------------------------------------------------
// 胸部 X 光（ImagingStudy）
// TWCoreImagingStudy：放了 series 就連帶要求 series.uid、series.modality、
// series.instance.uid、series.instance.sopClass（實測）。此處完整示範，
// 不省略 series——省略雖也能通過驗證，但對實作端毫無參考價值。
// ------------------------------------------------------------------
Instance: example-imaging-chest-xray
InstanceOf: TWHAImagingStudyProfile
Title: "健檢影像檢查範例 - 胸部 X 光"
Description: "粉塵作業勞工之胸部 X 光攝影檢查，單一序列單一影像。"
* status = #available
* subject = Reference(example-worker)
* started = "2026-06-12T09:45:00+08:00"
* numberOfSeries = 1
* numberOfInstances = 1
* procedureCode.text = "胸部X光攝影（後前位）"
* reasonCode.text = "粉塵作業特殊健康檢查"
* series[0].uid = "1.2.826.0.1.3680043.8.498.10001"
* series[0].number = 1
* series[0].modality = http://dicom.nema.org/resources/ontology/DCM#DX
* series[0].description = "Chest PA"
* series[0].instance[0].uid = "1.2.826.0.1.3680043.8.498.20001"
* series[0].instance[0].sopClass = urn:ietf:rfc:3986#urn:oid:1.2.840.10008.5.1.4.1.1.1.1
* series[0].instance[0].number = 1

// ------------------------------------------------------------------
// 健檢診斷報告（彙整前述結果）
// TWCoreDiagnosticReport：status／code／subject 必填；code 之四個 coding 切片
// 各自綁 required 值集，此處只填 code.text 以免引用未經 $lookup 確認之代碼。
// ------------------------------------------------------------------
Instance: example-diagnostic-report
InstanceOf: TWHADiagnosticReportProfile
Title: "健檢診斷報告範例 - 噪音作業特殊健康檢查"
Description: "彙整噪音作業特殊健康檢查各項結果之診斷報告，含聽力檢查、肺功能、心電圖與胸部X光。"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#OSL "Outside Lab"
* code.text = "噪音作業特殊健康檢查報告"
* subject = Reference(example-worker)
* encounter = Reference(example-encounter-special)
* effectiveDateTime = "2026-06-12T11:00:00+08:00"
* issued = "2026-06-15T10:00:00+08:00"
* performer = Reference(example-doctor)
// ⚠️ 刻意不填 result：TWCoreDiagnosticReport 把 result 限定為
// Reference(Observation-laboratoryResult-twcore)，聽力／肺功能／心電圖等
// 非檢驗類 Observation 一律不符（run 30406136544 實測 3 筆
// "Unable to find a profile match"）。健檢報告如何彙整非檢驗結果
// 屬未決之建模議題，見未決事項 T-10；本範例以 Composition 之 section
// 承載該連結（見 composition-uc003），DiagnosticReport 僅示範
// 容器欄位與影像參照。
* imagingStudy[0] = Reference(example-imaging-chest-xray)
* conclusion = "雙耳高頻聽力閾值輕度上升，與噪音暴露相關；肺功能、心電圖與胸部X光未見異常。建議列第四級健康管理並實施適性配工。"

// ------------------------------------------------------------------
// 健康管理分級判定
// ------------------------------------------------------------------
Instance: obs-health-mgmt-level
InstanceOf: TWHAHealthManagementLevelProfile
Title: "健康管理分級判定範例 - 第四級管理"
Description: "醫師依噪音作業特殊健康檢查結果，判定受檢勞工王大同為第四級健康管理（異常且與工作相關，需適性配工與治療）。"
* status = #final
* code = SCT#406221003 "Health status"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-15T10:00:00+08:00"
* performer = Reference(example-doctor)
* valueCodeableConcept = CS_HealthMgmtLevel#level-4 "第四級管理"

// ------------------------------------------------------------------
// 適性配工計畫
// TWCoreCarePlan 實測：text.status 與 text.div 為**必填**，且
// category:AssessPlan 為 1..1 並有固定 pattern。這三項是 FHIR 基礎資源
// 所沒有的收緊，不查上游不會知道。
// ------------------------------------------------------------------
Instance: example-careplan-fitness
InstanceOf: TWHACarePlanProfile
Title: "適性配工計畫範例 - 第四級管理之工作調整"
Description: "針對判定為第四級健康管理之勞工王大同，由職業醫學科醫師與事業單位共同制定之適性配工計畫：變更工作場所並縮短噪音暴露時間。"
* text.status = #additional
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>依115年6月12日噪音作業特殊健康檢查結果，勞工王大同經判定為第四級健康管理。經職業醫學科醫師與事業單位協商，自115年7月1日起調整如下：</p><ul><li>變更工作場所：自化學處理課調整至噪音暴露低於85分貝之區域。</li><li>縮短工作時間：每日噪音作業時間不超過4小時。</li></ul><p>三個月後複檢並重新評估分級。</p></div>"
* status = #active
* intent = #plan
* category[AssessPlan] = https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/careplan-category-tw#assess-plan
* subject = Reference(example-worker)
* period.start = "2026-07-01"
* period.end = "2026-10-01"
* extension[fitnessForWork][0].valueCodeableConcept = CS_FitnessForWork#change-workplace "變更工作場所"
* extension[fitnessForWork][1].valueCodeableConcept = CS_FitnessForWork#reduce-hours "縮短工作時間"

// ------------------------------------------------------------------
// 追蹤檢查要求
// TWCoreServiceRequest 實測：code 為 1..1（FHIR 基礎資源為 0..1）。
// 其 coding 切片各綁 ICD-10-PCS／SNOMED／LOINC 之 required 值集，
// 此處僅填 code.text，理由同 DiagnosticReport。
// ------------------------------------------------------------------
Instance: example-servicerequest-followup
InstanceOf: TWHAServiceRequestProfile
Title: "追蹤檢查要求範例 - 三個月後聽力複檢"
Description: "醫師針對第四級健康管理之勞工王大同開立之追蹤檢查要求：三個月後實施純音聽力檢查複檢。"
* status = #active
* intent = #order
* code.text = "純音聽力檢查（複檢）"
* subject = Reference(example-worker)
* occurrenceDateTime = "2026-10-01T09:00:00+08:00"
* authoredOn = "2026-06-15T10:30:00+08:00"
* requester = Reference(example-doctor)

// ------------------------------------------------------------------
// 工作經歷與職業別
// Observation-occupation-twcore 實測（run 30378189454）：
//   value[x] 為 1..1 CodeableConcept；其下 LiaRocOccupation／MolOccupation 兩個
//   coding 切片各綁 required 值集（occupation-lia-roc-tw／occupation-mol-tw）。
//   切片本身非必填——此處僅填 value.text，不引用未經查證之職業分類碼。
//   effective[x] 不接受 dateTime（第一版用 effectiveDateTime 遭 SUSHI 拒絕），
//   職業經歷本質上是期間，改用 effectivePeriod（起日對齊 ext-employment-date）。
//   code 固定 LOINC 11341-5、category 之 twcore 切片固定 social-history。
// ------------------------------------------------------------------
Instance: obs-occupation
InstanceOf: TWHAOccupationProfile
Title: "工作經歷與職業別範例"
Description: "受檢勞工王大同之現任職業與行業別：電子零組件製造業之化學處理課作業員，2020 年 3 月到職迄今。"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#11341-5
* code.text = "職業史"
* subject = Reference(example-worker)
* effectivePeriod.start = "2020-03-01"
* performer = Reference(example-doctor)
* valueCodeableConcept.text = "化學處理課作業員（職業分類碼待引用經查證之 occupation-mol-tw 代碼）"
* component[0].code = LNC#86188-0
* component[0].code.text = "行業別"
* component[0].valueCodeableConcept.text = "電子零組件製造業"
