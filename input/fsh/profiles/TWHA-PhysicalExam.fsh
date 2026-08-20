Profile: TWHAPhysicalExamProfile
Parent: TWCoreClinicalResult
Id: TWHA-PhysicalExam
Title: "身體理學檢查 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄勞工身體各系統（頭頸部、呼吸、心血管、消化、神經、肌肉骨骼、皮膚）之理學檢查結果，繼承自 TW Core Observation Clinical Result。"
* ^experimental = false
* status = #final
* code = LNC#29545-1 "Physical findings note"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    systemExam 1..*
* component[systemExam].code from VS_PhysicalExamSystems (required)
* component[systemExam].value[x] only CodeableConcept or string

* obeys twha-obs-1