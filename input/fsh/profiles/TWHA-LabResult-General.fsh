Profile: TWHALabResultGeneralProfile
Parent: TWCoreLabResult
Id: TWHA-LabResult-General
Title: "一般健檢實驗室檢驗 Profile"
Description: "【主管機關：國民健康署】用於記錄勞工一般體格與健康檢查之實驗室檢驗結果，如血液、尿液及生化項目，繼承自 TW Core Lab Result。"
* subject only Reference(TWHAPatientProfile)
* code from VS_CoreDataset (extensible)
// 第 19 條紀錄保存與稽核需可追溯「執行檢驗之機構／人員」，故 performer 標 Must Support（非強制填寫）
* performer MS

* obeys twha-obs-1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use