Profile: TWHACompositionServiceRecordProfile
Parent: Composition
Id: TWHA-Composition-ServiceRecord
Title: "健康檢查健康服務執行紀錄組成結構 Profile"
Description: "本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。

**subject／custodian 語意界定（回應委員意見）**：本文件之標的為「**一次臨場服務事件與其紀錄**」，故 `subject` 為受服務之事業單位（作業場所），`custodian` 為保管該紀錄之醫療機構。**惟本 IG 並非一律以 Organization 作 subject**：文件內各關聯資源依其性質分別設定——個人健康指導以 Patient 為 subject、群體衛教以 Group 為 subject、事業單位則以 `serviceProvider`／`custodian`／`focus`／`extension[employerInfo]` 表達，詳見各該 Profile。"
* ^experimental = false
* status = #final
* type = http://loinc.org#34133-9 "Summary of episode note"
* subject only Reference(TWCoreOrganization)   // 紀錄標的＝受服務之事業單位（作業場所）
* custodian only Reference(TWHAOrganizationFacilityProfile)  // 紀錄保管機構＝提供服務之醫療機構
* author only Reference(TWHAPractitionerProfile)
* title = "勞工健康服務執行紀錄表"

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.ordered = false

* section contains
    workplace 1..1 and
    activities 1..1 and
    findings 0..1 and
    recommendations 0..1

* section[workplace].code = http://loinc.org#51847-2
* section[workplace].title = "作業場所概況"
* section[workplace].entry only Reference(TWHAEncounterServiceProfile)

* section[activities].code = http://loinc.org#97726-4
* section[activities].title = "臨場服務執行情形"
* section[activities].entry only Reference(Procedure)

* section[findings].code = http://loinc.org#29554-3
* section[findings].title = "現場發現問題"
* section[findings].entry only Reference(Observation)

* section[recommendations].code = http://loinc.org#51898-5
* section[recommendations].title = "改善建議與追蹤"
* section[recommendations].entry only Reference(Task)
