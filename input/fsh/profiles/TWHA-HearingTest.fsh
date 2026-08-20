Profile: TWHAHearingTestProfile
Parent: TWCoreClinicalResult
Id: TWHA-HearingTest
Title: "聽力檢查 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄勞工純音聽力測試結果，依左右耳及頻率（0.5/1/2/3/4/6/8 kHz）分切片記錄。繼承自 TW Core Observation Clinical Result。v1.1 修正：更正並補齊純音氣導聽閾 LOINC 代碼（原 v3 之頻率×耳別代碼多處錯置，且缺 3/6/8 kHz），使各切片代碼與 LOINC「Pure tone threshold audiometry panel」(89015-2) 之成員一致，符合《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率要求。
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft

**交換規則（回應委員意見）**：
1. **須保留原始 panel／component 代碼**：若來源系統採 `21104-5` 系列等變異碼，交換時**應同時保留原始代碼**（如置於 `code.coding` 之另一 coding），**不得僅存歸一後之代碼**，以維持可追溯性。
2. **panel 層 mapping 不等於 component 層等價**：ConceptMap 現僅建立 panel 對 panel 之對應；**各頻率 component 之對應尚未建立（mapping unavailable）**，不得逕行推論等價。
3. **聽閾單位**：以 UCUM `dB` 表達（臨床意義為 dB HL，依 ISO 1999 判讀）。
4. **特殊情形不得以一般數值表達**：「未測」「無反應」「超出儀器上限」等情形，**應以 `dataAbsentReason` 或明確代碼表達**，不得填入 0、999 等假數值，亦不得省略該 component。"
* ^experimental = false
* status = #final
// 89015-2 = "Pure tone threshold audiometry panel"（Panel code）
// 各頻率×耳別代碼依 LOINC 89015-2 panel 成員逐一核對（v1.1 修正錯置並補齊 3/6/8 kHz）
* code = LNC#89015-2 "Pure tone air conduction threshold audiometry panel"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    leftEar500  0..1 and
    leftEar1000 0..1 and
    leftEar2000 0..1 and
    leftEar3000 0..1 and
    leftEar4000 0..1 and
    leftEar6000 0..1 and
    leftEar8000 0..1 and
    rightEar500  0..1 and
    rightEar1000 0..1 and
    rightEar2000 0..1 and
    rightEar3000 0..1 and
    rightEar4000 0..1 and
    rightEar6000 0..1 and
    rightEar8000 0..1

// 左耳各頻率氣導聽閾 (Left ear air-conduction thresholds)
* component[leftEar500].code  = LNC#89024-4 "Hearing threshold Ear - left --500 Hz"
* component[leftEar500].value[x] only Quantity
* component[leftEar500].valueQuantity.unit = "dB"
* component[leftEar500].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar500].valueQuantity.code = #dB

* component[leftEar1000].code = LNC#89016-0 "Hearing threshold Ear - left --1000 Hz"
* component[leftEar1000].value[x] only Quantity
* component[leftEar1000].valueQuantity.unit = "dB"
* component[leftEar1000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar1000].valueQuantity.code = #dB

* component[leftEar2000].code = LNC#89018-6 "Hearing threshold Ear - left --2000 Hz"
* component[leftEar2000].value[x] only Quantity
* component[leftEar2000].valueQuantity.unit = "dB"
* component[leftEar2000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar2000].valueQuantity.code = #dB

* component[leftEar3000].code = LNC#89020-2 "Hearing threshold Ear - left --3000 Hz"
* component[leftEar3000].value[x] only Quantity
* component[leftEar3000].valueQuantity.unit = "dB"
* component[leftEar3000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar3000].valueQuantity.code = #dB

* component[leftEar4000].code = LNC#89022-8 "Hearing threshold Ear - left --4000 Hz"
* component[leftEar4000].value[x] only Quantity
* component[leftEar4000].valueQuantity.unit = "dB"
* component[leftEar4000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar4000].valueQuantity.code = #dB

* component[leftEar6000].code = LNC#89026-9 "Hearing threshold Ear - left --6000 Hz"
* component[leftEar6000].value[x] only Quantity
* component[leftEar6000].valueQuantity.unit = "dB"
* component[leftEar6000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar6000].valueQuantity.code = #dB

* component[leftEar8000].code = LNC#89028-5 "Hearing threshold Ear - left --8000 Hz"
* component[leftEar8000].value[x] only Quantity
* component[leftEar8000].valueQuantity.unit = "dB"
* component[leftEar8000].valueQuantity.system = "http://unitsofmeasure.org"
* component[leftEar8000].valueQuantity.code = #dB

// 右耳各頻率氣導聽閾 (Right ear air-conduction thresholds)
* component[rightEar500].code  = LNC#89025-1 "Hearing threshold Ear - right --500 Hz"
* component[rightEar500].value[x] only Quantity
* component[rightEar500].valueQuantity.unit = "dB"
* component[rightEar500].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar500].valueQuantity.code = #dB

* component[rightEar1000].code = LNC#89017-8 "Hearing threshold Ear - right --1000 Hz"
* component[rightEar1000].value[x] only Quantity
* component[rightEar1000].valueQuantity.unit = "dB"
* component[rightEar1000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar1000].valueQuantity.code = #dB

* component[rightEar2000].code = LNC#89019-4 "Hearing threshold Ear - right --2000 Hz"
* component[rightEar2000].value[x] only Quantity
* component[rightEar2000].valueQuantity.unit = "dB"
* component[rightEar2000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar2000].valueQuantity.code = #dB

* component[rightEar3000].code = LNC#89021-0 "Hearing threshold Ear - right --3000 Hz"
* component[rightEar3000].value[x] only Quantity
* component[rightEar3000].valueQuantity.unit = "dB"
* component[rightEar3000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar3000].valueQuantity.code = #dB

* component[rightEar4000].code = LNC#89023-6 "Hearing threshold Ear - right --4000 Hz"
* component[rightEar4000].value[x] only Quantity
* component[rightEar4000].valueQuantity.unit = "dB"
* component[rightEar4000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar4000].valueQuantity.code = #dB

* component[rightEar6000].code = LNC#89027-7 "Hearing threshold Ear - right --6000 Hz"
* component[rightEar6000].value[x] only Quantity
* component[rightEar6000].valueQuantity.unit = "dB"
* component[rightEar6000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar6000].valueQuantity.code = #dB

* component[rightEar8000].code = LNC#89029-3 "Hearing threshold Ear - right --8000 Hz"
* component[rightEar8000].value[x] only Quantity
* component[rightEar8000].valueQuantity.unit = "dB"
* component[rightEar8000].valueQuantity.system = "http://unitsofmeasure.org"
* component[rightEar8000].valueQuantity.code = #dB

* obeys twha-obs-1