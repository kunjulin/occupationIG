Profile: TWHACompositionServiceRecordProfile
Parent: Composition
Id: TWHA-Composition-ServiceRecord
Title: "健康檢查健康服務執行紀錄組成結構 Profile"
Description: "本 Profile 用於定義臨場健康服務執行紀錄表單（附表八）的文件組成結構，以 Composition 作為文件核心。"
* ^experimental = false
* status = #final
* type = http://loinc.org#34133-9 "Summary of episode note"
* subject only Reference(TWCoreOrganization)
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
