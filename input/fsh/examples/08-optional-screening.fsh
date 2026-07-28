// ==========================================
// 自費健檢項目（影像與內視鏡）
// 原 examples.fsh §8 之後半段。非《勞工健康保護規則》應辦項目，故獨立成檔。
// ==========================================

Instance: obs-imaging-mammo
InstanceOf: Observation
Title: "自費健檢項目 - 乳房攝影"
Description: "自費健檢中乳房攝影檢查的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#imaging
* code = LNC#24606-6 "MG Breast Screening"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T10:00:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-imaging-brain-mri
InstanceOf: Observation
Title: "自費健檢項目 - 腦部核磁共振造影"
Description: "自費健檢中腦部核磁共振造影 (Brain MRI) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#imaging
* code = LNC#24590-2 "MR Brain"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T10:15:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-imaging-lung-ct
InstanceOf: Observation
Title: "自費健檢項目 - 肺部低劑量電腦斷層"
Description: "自費健檢中肺部低劑量電腦斷層 (LDCT) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#imaging
* code = LNC#79086-5 "CT Chest Screening WO contr"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T10:30:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-imaging-pet
InstanceOf: Observation
Title: "自費健檢項目 - 全身正子造影"
Description: "自費健檢中全身正子造影 (FDG PET/CT) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#imaging
* code = LNC#81555-5 "PT+CT Whole body Tum loc W 18F-FDG IV"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T10:45:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-imaging-cta
InstanceOf: Observation
Title: "自費健檢項目 - 心臟冠狀動脈電腦斷層血管攝影"
Description: "自費健檢中心臟冠狀動脈電腦斷層血管攝影 (Cardiac CTA) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#imaging
* code = LNC#79073-3 "CTA Hrt+CA W contr IV"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T11:00:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-endoscopy-egd
InstanceOf: Observation
Title: "自費健檢項目 - 胃鏡檢查"
Description: "自費健檢中上消化道胃鏡鏡檢 (EGD) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#28014-9 "EGD Study"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T11:15:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N

Instance: obs-endoscopy-colon
InstanceOf: Observation
Title: "自費健檢項目 - 大腸鏡檢查"
Description: "自費健檢中下消化道大腸鏡鏡檢 (Colonoscopy) 的結果紀錄。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#exam
* code = LNC#28023-0 "Colonoscopy Study"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T11:30:00+08:00"
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-ObservationValue#N
