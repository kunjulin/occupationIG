// ==========================================
// 6. 總評分級與適性配工（Impression）
// ==========================================

Instance: example-clinical-impression
InstanceOf: TWHAClinicalImpressionProfile
Title: "醫師臨床總評與分級範例"
Description: "林職醫師針對王大同的健康檢查結果進行之總評，判定為第一級健康管理（正常）。"
* status = #completed
* subject = Reference(example-worker)
* assessor = Reference(example-doctor)
* summary = "本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。"
* extension[healthMgmtLevel].valueCodeableConcept = CS_HealthMgmtLevel#level-1 "第一級管理"
