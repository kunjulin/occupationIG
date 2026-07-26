Profile: TWHAPulmonaryFunctionProfile
Parent: TWCoreClinicalResult
Id: TWHA-PulmonaryFunction
Title: "肺功能檢查 Profile"
Description: "用於記錄勞工肺功能檢查結果（主要包括 FVC, FEV1, FEV1/FVC），繼承自 TW Core Observation Clinical Result。"
* ^experimental = false
* status = #final
* code = LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry"
* value[x] only Quantity
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    fev1 0..1 and
    ratio 0..1
* component[fev1].code = LNC#20150-9 "FEV1"
* component[fev1].value[x] only Quantity
* component[ratio].code = LNC#19926-5 "FEV1/FVC"
* component[ratio].value[x] only Quantity or Ratio

* obeys twha-obs-1