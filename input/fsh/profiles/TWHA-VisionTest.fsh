Profile: TWHAVisionTestProfile
Parent: TWCoreClinicalResult
Id: TWHA-VisionTest
Title: "視力與辨色力檢查 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄勞工眼部檢查結果，包含左右眼裸視/矯正視力及辨色力項目，繼承自 TW Core Observation Clinical Result。"
* ^experimental = false
* status = #final
* code = LNC#98497-1 "Visual acuity panel"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    leftEyeVision 0..1 and
    rightEyeVision 0..1 and
    colorVision 0..1
* component[leftEyeVision].code = LNC#98498-9 "Visual acuity uncorrected Left eye"
* component[leftEyeVision].value[x] only Quantity or CodeableConcept
* component[rightEyeVision].code = LNC#98499-7 "Visual acuity uncorrected Right eye"
* component[rightEyeVision].value[x] only Quantity or CodeableConcept
* component[colorVision].code = LNC#46673-0 "Color vision [RFC]"
* component[colorVision].value[x] only CodeableConcept

* obeys twha-obs-1