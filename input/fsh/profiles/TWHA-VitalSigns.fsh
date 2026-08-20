Profile: TWHAVitalSignsProfile
Parent: TWCoreVitalSigns
Id: TWHA-VitalSigns
Title: "職業健檢生命徵象 Profile"
Description: "【主管機關：國民健康署】用於記錄勞工身高、體重、腰圍等基本生理特徵，繼承自 TW Core Vital Signs。"
* subject only Reference(TWHAPatientProfile)
* code from VS_TWHAVitalSigns (extensible)
// 生理量測之執行者追溯（稽核用），performer 標 Must Support
* performer MS

* obeys twha-obs-1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use