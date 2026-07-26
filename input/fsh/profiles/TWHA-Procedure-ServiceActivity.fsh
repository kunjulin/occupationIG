Profile: TWHAProcedureServiceActivityProfile
Parent: Procedure
Id: TWHA-Procedure-ServiceActivity
Title: "臨場服務執行活動項目 Profile"
Description: "用於記錄醫護人員在臨場健康服務中實際辦理之活動項目（對應附表八之臨場健康服務執行情形），繼承自 TW Core Procedure。

**subject 選用規則（回應委員意見）**：**個人健康指導／個案追蹤 → `subject` = Patient**；**群體衛教／全廠宣導 → `subject` = Group**。**事業單位不作為 `subject`**，改以 `extension[employerInfo]` 表達所屬事業單位。"
* ^experimental = false
* status = #completed
* code from VS_ServiceActivityType (required)
* subject only Reference(Group or TWHAPatientProfile)
* extension contains ExtEmployerInfo named employerInfo 1..1
