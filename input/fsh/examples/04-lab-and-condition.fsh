// ==========================================
// 5. 實驗室與檢驗項目（Observation & Condition）
// ==========================================

Instance: obs-lab-glucose
InstanceOf: TWHALabResultGeneralProfile
Title: "實驗室檢驗範例 - 空腹血糖"
Description: "受檢勞工王大同的空腹血糖檢驗結果 (95 mg/dL)。"
* status = #final
* category[0] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = LNC#1558-6 "Fasting glucose [Mass/volume] in Serum or Plasma"
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T09:00:00+08:00"
* valueQuantity = 95 'mg/dL' "mg/dL"
* referenceRange[0].low = 70 'mg/dL' "mg/dL"
* referenceRange[0].high = 100 'mg/dL' "mg/dL"

Instance: example-past-condition
InstanceOf: TWHAConditionProfile
Title: "既往病史範例 - 高血壓"
Description: "受檢勞工王大同的高血壓既往病史。"
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* code = ICD10CM#I10 "Essential (primary) hypertension"
* subject = Reference(example-worker)
