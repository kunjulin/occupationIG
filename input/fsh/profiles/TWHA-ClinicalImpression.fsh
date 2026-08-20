Profile: TWHAClinicalImpressionProfile
Parent: ClinicalImpression
Id: TWHA-ClinicalImpression
Title: "健康檢查健檢醫師總評與分級 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄健檢判定醫師針對勞工檢查結果進行之總體臨床評估、健康管理分級（1-4級）及處置建議。"
* ^experimental = false
* status = #completed
* subject only Reference(TWHAPatientProfile)
* assessor only Reference(TWHAPractitionerProfile)
* extension contains ExtHealthMgmtLevel named healthMgmtLevel 1..1
* summary 1..1
