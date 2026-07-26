Profile: TWHAObservationServiceFindingProfile
Parent: Observation
Id: TWHA-Observation-ServiceFinding
Title: "臨場健康服務發現問題/風險 Profile"
Description: "用於記錄臨場健康服務中發現之作業場所問題、健康危害或風險（附表八）。

**subject／focus 語意界定（回應委員意見）**：本資源記錄「**現場發現**」。所發現問題**所屬之事業單位以 `focus` 表達**，不置於 `subject`；若該發現係針對特定勞工個人（如個別健康異常），則 `subject` 為該 Patient。事業單位不作為 `subject`。"
* ^experimental = false
* status = #final
* code = SCT#17458004 "Occupational hazard"
* subject only Reference(TWHAPatientProfile)   // 僅在發現係針對特定勞工個人時填寫；場所層級之發現可不填
* focus only Reference(TWCoreOrganization)     // 事業單位／作業場所以 focus 表達（不置於 subject）
* value[x] only string or CodeableConcept

* obeys twha-obs-1