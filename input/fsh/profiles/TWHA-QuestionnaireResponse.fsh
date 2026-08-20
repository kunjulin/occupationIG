Profile: TWHAQuestionnaireResponseProfile
Parent: TWCoreQuestionnaireResponse
Id: TWHA-QuestionnaireResponse
Title: "自覺症狀問卷回覆 Profile"
Description: "【技術規格】用於記錄勞工所填寫之自覺症狀問卷結果，必須關聯至受檢勞工，繼承自 TW Core QuestionnaireResponse。"
* ^experimental = false
* status = #completed
* subject 1..1
* subject only Reference(TWHAPatientProfile)
* source only Reference(TWHAPatientProfile)
* author only Reference(TWHAPatientProfile or TWHAPractitionerProfile)
