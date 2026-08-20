Profile: TWHAECGProfile
Parent: TWCoreECG
Id: TWHA-ECG
Title: "心電圖檢查 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄勞工心電圖檢查結果，通常於高溫作業特殊健檢中實施，繼承自 TW Core Observation ECG（v1.0.0 新增之心電圖專用 Profile）。"
* ^experimental = false
* status = #final
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)
* value[x] only CodeableConcept

* obeys twha-obs-1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft