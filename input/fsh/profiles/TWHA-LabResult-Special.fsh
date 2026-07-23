Profile: TWHALabResultSpecialProfile
Parent: TWCoreLabResult
Id: TWHA-LabResult-Special
Title: "特殊健檢實驗室檢驗 Profile"
Description: "用於記錄特別危害健康作業勞工之特殊實驗室檢驗結果（如血中鉛等），繼承自 TW Core Lab Result。"
* subject only Reference(TWHAPatientProfile)
* code from VS_ExtendedDataset (extensible)
// 第 19 條特殊檢查紀錄保存 ≥10 年（部分致癌物更長），稽核需可追溯執行檢驗者，故 performer 標 Must Support
* performer MS

* obeys twha-obs-1