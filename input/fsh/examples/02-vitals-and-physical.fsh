// ==========================================
// 3. 生理特徵與物理檢查結果（Observation）
// ==========================================

Instance: obs-height
InstanceOf: TWHAVitalSignsProfile
Title: "身高測量結果範例"
Description: "受檢勞工王大同的身高測量結果 (175 cm)。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = LNC#8302-2 "Body height"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:15:00+08:00"
* valueQuantity = 175 'cm' "cm"

Instance: obs-weight
InstanceOf: TWHAVitalSignsProfile
Title: "體重測量結果範例"
Description: "受檢勞工王大同的體重測量結果 (70 kg)。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = LNC#29463-7 "Body weight"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:15:00+08:00"
* valueQuantity = 70 'kg' "kg"

Instance: obs-waist
InstanceOf: TWHAVitalSignsProfile
Title: "腰圍測量結果範例"
Description: "受檢勞工王大同的腰圍測量結果 (82 cm)。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = LNC#8280-0 "Waist Circumference at umbilicus by Tape measure"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:15:00+08:00"
* valueQuantity = 82 'cm' "cm"

Instance: obs-bmi
InstanceOf: TWHAVitalSignsProfile
Title: "身體質量指數 (BMI) 測量結果範例"
Description: "受檢勞工王大同的身體質量指數 (BMI) 測量結果 (22.86 kg/m2)。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = LNC#39156-5 "Body mass index (BMI) [Ratio]"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:15:00+08:00"
* valueQuantity = 22.86 'kg/m2' "kg/m2"

Instance: obs-bloodpressure
InstanceOf: TWCoreBloodPressure
Title: "血壓測量結果範例"
Description: "受檢勞工王大同的血壓測量結果 (120/80 mmHg)，繼承自 TW Core Blood Pressure。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code = LNC#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:15:00+08:00"
* component[0].code = LNC#8480-6 "Systolic blood pressure"
* component[0].valueQuantity = 120 'mm[Hg]' "mmHg"
* component[1].code = LNC#8462-4 "Diastolic blood pressure"
* component[1].valueQuantity = 80 'mm[Hg]' "mmHg"

Instance: obs-vision
InstanceOf: TWHAVisionTestProfile
Title: "視力及辨色力檢查結果範例"
Description: "受檢勞工王大同的視力（裸視左/右 1.0）及辨色力（正常）檢查結果。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#98497-1 "Visual acuity panel"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:20:00+08:00"
* performer = Reference(example-doctor)
* component[leftEyeVision].code = LNC#98498-9 "Visual acuity uncorrected Left eye"
* component[leftEyeVision].valueQuantity = 1.0 '1'
* component[rightEyeVision].code = LNC#98499-7 "Visual acuity uncorrected Right eye"
* component[rightEyeVision].valueQuantity = 1.0 '1'
* component[colorVision].code = LNC#46673-0 "Color vision [RFC]"
* component[colorVision].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-hearing
InstanceOf: TWHAHearingTestProfile
Title: "聽力檢查結果範例"
Description: "受檢勞工王大同的純音聽力測試結果（左右耳 0.5–8 kHz 各頻率聽力閾值均在正常範圍 ≤25 dB）。v1.1 更新：使用正確 Panel code 89015-2 及更正／補齊之頻率×耳別切片（0.5/1/2/3/4/6/8 kHz）。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#89015-2 "Pure tone air conduction threshold audiometry panel"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:25:00+08:00"
* performer = Reference(example-doctor)
// 左耳各頻率閾值 (dB HL) — 正常值 ≤25 dB
* component[leftEar500].valueQuantity = 15 'dB' "dB"
* component[leftEar1000].valueQuantity = 15 'dB' "dB"
* component[leftEar2000].valueQuantity = 20 'dB' "dB"
* component[leftEar3000].valueQuantity = 20 'dB' "dB"
* component[leftEar4000].valueQuantity = 20 'dB' "dB"
* component[leftEar6000].valueQuantity = 25 'dB' "dB"
* component[leftEar8000].valueQuantity = 20 'dB' "dB"
// 右耳各頻率閾值 (dB HL)
* component[rightEar500].valueQuantity = 15 'dB' "dB"
* component[rightEar1000].valueQuantity = 15 'dB' "dB"
* component[rightEar2000].valueQuantity = 20 'dB' "dB"
* component[rightEar3000].valueQuantity = 20 'dB' "dB"
* component[rightEar4000].valueQuantity = 20 'dB' "dB"
* component[rightEar6000].valueQuantity = 25 'dB' "dB"
* component[rightEar8000].valueQuantity = 20 'dB' "dB"

Instance: obs-physical
InstanceOf: TWHAPhysicalExamProfile
Title: "理學檢查結果範例"
Description: "受檢勞工王大同各系統理學檢查結果（正常）。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#29545-1 "Physical findings note"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:30:00+08:00"
* performer = Reference(example-doctor)
* component[0].code = CS_PhysicalExamSystems#head-neck "頭頸部"
* component[0].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N
* component[1].code = CS_PhysicalExamSystems#respiratory "呼吸系統"
* component[1].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-pulmonary
InstanceOf: TWHAPulmonaryFunctionProfile
Title: "肺功能檢查結果範例"
Description: "受檢勞工王大同的肺功能檢查結果（FVC = 4.2 L, FEV1 = 3.5 L, FEV1/FVC = 83.3%）。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:45:00+08:00"
* performer = Reference(example-doctor)
* valueQuantity = 4.2 'L' "L"
* component[fev1].valueQuantity = 3.5 'L' "L"
* component[ratio].valueQuantity = 83.3 '%' "%"
