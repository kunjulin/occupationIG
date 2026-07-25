Profile: TWHAHealthManagementLevelProfile
Parent: Observation
Id: TWHA-HealthManagementLevel
Title: "健康檢查健康管理分級 Observation Profile"
Description: "用於以獨立 Observation 資源記錄受檢勞工健康檢查後，經醫師總評判定之健康管理分級（1-4級）。"
* ^experimental = false
* status = #final
* code = SCT#406221003 "Health status"
* subject only Reference(TWHAPatientProfile)
* value[x] only CodeableConcept
* valueCodeableConcept from VS_HealthMgmtLevel (required)

* obeys twha-obs-1