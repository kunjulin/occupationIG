Profile: TWHAObservationServiceFindingProfile
Parent: Observation
Id: TWHA-Observation-ServiceFinding
Title: "臨場健康服務發現問題/風險 Profile"
Description: "用於記錄臨場健康服務中發現之作業場所問題、健康危害或風險（附表八）。"
* ^experimental = false
* status = #final
* code = SCT#17458004 "Occupational hazard"
* focus only Reference(TWCoreOrganization) // focus 指向所服務之事業單位公司
* value[x] only string or CodeableConcept

* obeys twha-obs-1