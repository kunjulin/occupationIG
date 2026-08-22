Profile: TWHASocialHistorySmokingProfile
Parent: TWCoreSmokingStatus
Id: TWHA-SocialHistory-Smoking
Title: "吸菸歷史與狀態 Profile"
Description: "【主管機關：國民健康署】用於記錄勞工之吸菸狀態與吸菸量、戒菸時間等資訊，繼承自 TW Core Observation Smoking Status。"
* ^experimental = false
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* valueCodeableConcept.coding ^slicing.discriminator.type = #value
* valueCodeableConcept.coding ^slicing.discriminator.path = "system"
* valueCodeableConcept.coding ^slicing.rules = #open
* valueCodeableConcept.coding contains
    localSmokingStatus 0..1
* valueCodeableConcept.coding[localSmokingStatus].system = "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus"
* valueCodeableConcept.coding[localSmokingStatus] from VS_SmokingStatus (required)
* extension contains ExtSmokingQuantity named smokingQuantity 0..1
* extension contains ExtCessationDuration named cessationDuration 0..1

* obeys twha-obs-1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use
Profile: TWHASocialHistoryBetelNutProfile
Parent: Observation
Id: TWHA-SocialHistory-BetelNut
Title: "嚼檳榔歷史與狀態 Profile"
Description: "【主管機關：國民健康署】用於記錄勞工之嚼檳榔狀態與量化資料。狀態以 `value[x]` 承載（值集 VS-BetelNutStatus，與吸菸之 CS-SmokingStatus 逐碼對稱）；每日嚼食量、嚼食年數與戒除期間以 `component` 之 `Quantity` 承載（UCUM）。上游臺灣癌症登記短表 (TWCR_SF) 之級距碼降為可選 component（extensible），供與癌症登記勾稽。"
// ═══ JOB-29 路徑甲 ＋ C-0（v0.4.0）═══════════════════════════════════
//
// 本 Profile 於 v0.4.0 前之三個問題，一併於此解決：
//
// 1. **狀態欄位無承載位置**（JOB-29 §2.1）。舊版未約束 value[x]、亦無 status
//    component，故「嚼檳狀態」在指引中無處可放——外部若依《建議修訂案 v2.1》
//    第 9 列實作，送出之資源反而過不了本指引之 Profile。現以 value[x] 承載。
//
// 2. **Observation.code 與敘述頁不符**（JOB-29 §2.1.1，即 C-0）。舊版固定為
//    上游 TWCRSFObsBehCS#BetelNutChewing，而 general-exam.md／datamodel.md
//    在與吸菸相同之欄位（吸菸列填的正是其實際 code LNC#72166-2）均宣稱
//    SNOMED 698188003。且該欄位為 1..1、固定為上游代碼，是本 Profile 對上游
//    **最後一處硬綁定**——不改則其餘解耦做完仍達不到「可切換級」。
//
// 3. **把數值編碼化**（JOB-29 §3）。以 94 個代碼列舉「每日 N 顆」，與同指引之
//    吸菸建模（64218-1 + UCUM /d）不對稱，且 required 綁定使建置成為單點相依。
//    更嚴重者，上游該批清單把「數量」「設限值（≧90）」「狀態（偶爾嚼）」
//    「缺值原因」四種語意壓在同一代碼軸（JOB-29 §A.5），接收端把代碼當數字用時
//    #91 會被讀成「每日 91 顆」，而它其實是「偶爾嚼、沒有定量」。改 Quantity 後，
//    這四者各自落到 FHIR 的正規位置（Quantity／comparator／value／dataAbsentReason）。
//
// **解耦之實際著力點是 component.code**：值改成 Quantity 仍不夠——component.code
// 若續用上游 sf-BetNutChewBeh，建置照樣要解析上游 canonical。故改用本地
// CS-BetelNutComponent（與上游 amount／year／quit 為 1:1，對照見 terminology.md）。
//
// experimental = true 之理由已更換：舊版是因綁定【本地 stub】（JOB-10 §7），
// 該批 stub 已於 v0.3.0 刪除（JOB-28、G-5 結案）。現為**本 Profile 所綁之本地值集
// 皆為 provisional**（待主管機關確認，M-5），依 CS-HealthMgmtLevel 之既有做法辦理。
* ^experimental = true
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
// ⚠️ v0.9.0（JOB-32 步驟 2）：由 SCT#698188003 改為本指引自訂之**狀態問句碼**。
// 698188003 是肯定式 finding（斷言此人嚼檳），放在問題位會使
// obs-betelnut-never 這類資源自相矛盾（code 說嚼、value 說從未），
// 且以 code 檢索會撈出從未嚼檳者。**屬 Level 1 破壞性變更**，遷移說明見
// conformance.md §7 與 docs/known-limitations.md。
// 698188003 改列為肯定式狀態（1-occasional／2-daily）之 SNOMED 對應，
// 見 terminology.md §6.2b 之對照表——**不得放回本欄**。
* code = CS_BetelNutObservable#betel-quid-chewing-status "嚼檳榔狀態"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)

// ── 狀態：主值（補 §2.1 之缺件）────────────────────────────────
// required 綁定本地 provisional 值集，與 TWHA-HealthManagementLevel 之
// VS_HealthMgmtLevel 同一做法（該值集同為 experimental = true）。
// 「不詳」不在值集內——送 value.dataAbsentReason（JOB-29 附錄 B.4）。
* value[x] only CodeableConcept
* valueCodeableConcept from VS_BetelNutStatus (required)

// ── 量化與情境：component ────────────────────────────────────
// 全部 0..1：舊版三者皆 1..1，使「從未嚼食」者仍必須填三個代碼
// （amount#00 ＋ year#00 ＋ quit#88），其中 quit#88 之語意是「無嚼檳榔」
// ——用一個外觀像「88 年」的代碼表達「從來沒有」（JOB-29 §A.2 範例③）。
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component contains
    amount 0..1 MS and
    durationYears 0..1 MS and
    cessationDuration 0..1 MS and
    cessationDate 0..1 and
    withTobacco 0..1 and
    additive 0..1 and
    lime 0..1 and
    informationSource 0..1 and
    hpaCategory 0..1 and
    amountCoded 0..1

* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].value[x] only Quantity
* component[amount].valueQuantity.system = "http://unitsofmeasure.org"
* component[amount].valueQuantity.code = #"{quid}/d"

// ═══ 本 component 承載主管機關最小上傳集之第 11 列（醫令 30907X-3）═══
// 原案欄名為「嚼檳月數」，其 r4 值規則寫「填寫戒檳月數」、註 2 並將填列條件
// 綁定於狀態 3（已戒檳）。**經本案專家會議決議**（見〈委員意見與決議紀錄〉v3.7 議題 16；
// 並經共同主持人曹又中主任 2026-07-31 回信補充說明）
// 認定係**原案文字有誤**，更正為**「嚼食持續期間」**——故對映至本欄，
// 不是 component[cessationDuration]。
//
// ⚠️ **填列規則**：本欄**不論現嚼或已戒均應填列**。原案之規則使已戒檳者
//    無處填寫嚼食持續期間，而該指標為檳榔相關口腔癌之核心累積暴露量、
//    **不因戒除而消失**——風險最需被評估之族群反而缺漏該指標，係原案之實質缺漏。
//
// ⚠️ **戒除資訊不因本更正而遺失**：原案 r4 所指之戒檳月數並未捨棄，
//    改由 component[cessationDuration]／component[cessationDate] 承載，
//    **不佔最小上傳集之列位**。
//
// ⚠️ **依據之來源與權責（v0.10.0 更正）**：本項為**本案專家會議之技術決議**，
//    屬**受託團隊職權範圍，無須委託單位或主管機關另行核定**。
//    v0.6.0–v0.9.3 期間本處記為「經主管機關答覆確認」，**該敘述不實**：
//    國民健康署從未就此作成函復。「經主管機關確認」是規範文件裡效力最強的措辭之一，
//    誤用會使該署日後讀到與事實不符，故逐處更正。
//    ⚠️ 仍屬國民健康署權責者為**21 列清單本身之法定效力與正式公告生效時點**（M-5），
//    與本項之語意更正是兩件事，不可混為一談。
//    ⚠️ 另就**原案文字之更正**已具體建議該署（見未決事項 M-12，對應專家會議
//    文件三之 M-7）——該建議之採納與否由該署決定；在其正式公告前，
//    本指引依專家會議決議辦理，並於正式公告後複核對齊。
//
// 單位由固定 #a 放寬為 `a` 或 `mo`：原案以**月**收集，而本指引原僅允許年。
// 不做強制換算——把「嚼 18 個月」寫成「1.5 年」或把「嚼 2 年」寫成「24 個月」
// 都會偽造精度，與 cessationDuration 採同一原則（JOB-29 §A.6）。
//
// ⚠️ 代碼 id 保留 `duration-years`（含 "years" 字樣）而不改名：該代碼已於 v0.4.0
//    發佈，改代碼屬破壞性變更。**以 display 與定義表達真實語意，不以代碼 id 表達**
//    ——代碼 id 只是識別字，不是語意來源（CLAUDE.md §2.2 之同一原則）。
* component[durationYears].code = CS_BetelNutComponent#duration-years "嚼食持續期間"
* component[durationYears].value[x] only Quantity
* component[durationYears].valueQuantity.system = "http://unitsofmeasure.org"
* component[durationYears].valueQuantity.code from VS_TimeUnitYearMonth (required)

// 單位不固定為 mo：以原始採集粒度為準，強制轉換會偽造精度（JOB-29 §A.6）。
* component[cessationDuration].code = CS_BetelNutComponent#cessation-duration "戒除期間"
* component[cessationDuration].value[x] only Quantity
* component[cessationDuration].valueQuantity.system = "http://unitsofmeasure.org"
* component[cessationDuration].valueQuantity.code from VS_TimeUnitYearMonth (required)

// 日期為原始事實、期間為導出值（期間會隨檢查日改變）。兩者並存時以本欄為準；
// **不得由「已戒 N 年」回推本欄**（JOB-29 附錄 B.3）。
* component[cessationDate].code = CS_BetelNutComponent#cessation-date "戒除日期"
* component[cessationDate].value[x] only dateTime

* component[withTobacco].code = CS_BetelNutComponent#with-tobacco "是否含菸草"
* component[withTobacco].value[x] only boolean

// 添加物與石灰種類為**兩個軸**，非四選一（JOB-29 附錄 B.6）。
* component[additive].code = CS_BetelNutComponent#additive "添加物"
* component[additive].value[x] only CodeableConcept
* component[additive].valueCodeableConcept from VS_BetelNutAdditive (required)

* component[lime].code = CS_BetelNutComponent#lime "石灰種類"
* component[lime].value[x] only CodeableConcept
* component[lime].valueCodeableConcept from VS_BetelNutLime (required)

// 口腔黏膜檢查表（107/7 修訂）之原始勾選，保留不換算（T-13、附錄 B.1 #7）。
// 該表為癌症篩檢用表、非健檢上傳欄位——收錄係為可回溯，不得據此把篩檢表欄位
// 當成健檢上傳欄位（M-5 之標的）。
* component[hpaCategory].code = CS_BetelNutComponent#hpa-category "口腔黏膜檢查表級距"
* component[hpaCategory].value[x] only CodeableConcept
* component[hpaCategory].valueCodeableConcept from VS_BetelNutHpaCategory (required)

* component[informationSource].code = LNC#48766-0 "Information source"
* component[informationSource].value[x] only CodeableConcept
* component[informationSource].valueCodeableConcept from VS_BetelNutInfoSource (extensible)

// C-2：上游級距碼降為可選、extensible。移除本 component 不影響任何核心資料
// ——這正是「把單點相依從建置阻斷級降為可切換級」之所在。
// 上游碼與 Quantity 之關係為**一對一之數值編碼**（#05 = 每日 5 顆），
// 對照應以可執行之轉換規則表達，**不宜硬套 ConceptMap**——ConceptMap 對映的是
// 概念與概念，不是概念與數值（JOB-29 §3.2）。
* component[amountCoded].code = CS_BetelNutComponent#amount-coded "每日嚼食量（上游級距碼）"
* component[amountCoded].value[x] only CodeableConcept
* component[amountCoded].valueCodeableConcept from TWCRSFBetNutChewAmountVS (extensible)

* obeys twha-obs-1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use
Profile: TWHASocialHistoryAlcoholProfile
Parent: Observation
Id: TWHA-SocialHistory-Alcohol
Title: "飲酒歷史與狀態 Profile"
Description: "【技術規格】用於記錄勞工之飲酒習慣歷史與狀態。"
* ^experimental = false
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#11331-6 "History of Alcohol use"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* value[x] only CodeableConcept

* obeys twha-obs-1
Profile: TWHASocialHistorySleepProfile
Parent: Observation
Id: TWHA-SocialHistory-Sleep
Title: "睡眠狀況 Profile"
Description: "【技術規格】用於記錄勞工之平均每日睡眠時間（以小時計）。"
* ^experimental = false
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#93832-4 "Sleep duration"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #h
* valueQuantity.unit = "hours"

* obeys twha-obs-1