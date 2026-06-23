Profile: TWHAProcedureCounselingProfile
Parent: TWCoreProcedure
Id: TWHA-Procedure-Counseling
Title: "健康諮詢與衛教指導 Profile"
Description: "用於記錄成人預防保健服務及一般健康檢查中，醫師或醫護團隊提供之健康諮詢、衛教指導與預防教育活動（如戒菸、節酒、腎病識能指導等），繼承自 TW Core Procedure。"
* ^experimental = false
* status = #completed
* code from VS_HealthCounseling (required)
* subject only Reference(TWHAPatientProfile)
* encounter only Reference(TWHAEncounterProfile)
