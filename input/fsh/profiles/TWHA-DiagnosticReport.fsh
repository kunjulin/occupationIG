Profile: TWHADiagnosticReportProfile
Parent: TWCoreDiagnosticReport
Id: TWHA-DiagnosticReport
Title: "健康檢查健檢診斷報告 Profile"
Description: "【技術規格】本 Profile 用於彙整勞工體格及健康檢查結果之診斷報告，繼承自 TW Core DiagnosticReport。"
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile or TWHAOrganizationFacilityProfile)
* encounter only Reference(TWHAEncounterProfile)
* imagingStudy only Reference(TWCoreImagingStudy)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft