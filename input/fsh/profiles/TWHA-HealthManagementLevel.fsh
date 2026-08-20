Profile: TWHAHealthManagementLevelProfile
Parent: Observation
Id: TWHA-HealthManagementLevel
Title: "健康檢查健康管理分級 Observation Profile"
Description: "【依據：勞工健康保護規則附表】用於以獨立 Observation 資源記錄受檢勞工健康檢查後，經醫師總評判定之健康管理分級（1-4級）。"
// 綁定之值集為 provisional 本地碼（待勞動部職安署確認，M-2），故本結構亦標為實驗性。
// 若逕標 false 會與所依賴代碼之暫定性質矛盾（IG Publisher 亦就此提出警告）。
* ^experimental = true
* status = #final
* code = SCT#406221003 "Health status"
* subject only Reference(TWHAPatientProfile)
* value[x] only CodeableConcept
* valueCodeableConcept from VS_HealthMgmtLevel (required)

* obeys twha-obs-1