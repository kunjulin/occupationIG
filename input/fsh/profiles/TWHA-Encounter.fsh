Profile: TWHAEncounterProfile
Parent: TWCoreEncounter
Id: TWHA-Encounter
Title: "健康檢查健檢就醫事件 Profile"
Description: "【技術規格】本 Profile 用於描述勞工進行一般體格檢查、一般健康檢查或特殊體格/健康檢查的就醫事件，繼承自 TW Core Encounter。"
* extension contains ExtExamType named examType 1..1
* extension contains ExtHazardType named hazardType 0..1
* extension contains ExtExamInterval named examInterval 0..1
* extension contains ExtDepartment named department 0..1
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB
* subject only Reference(TWHAPatientProfile)
* participant.individual only Reference(TWHAPractitionerProfile)
* serviceProvider only Reference(TWHAOrganizationFacilityProfile)
