Profile: TWHAPatientProfile
Parent: TWCorePatient
Id: TWHA-Patient
Title: "受檢者 Profile"
Description: "【技術規格】本 Profile 用於描述接受健康檢查（含一般健檢、勞工健檢與成人預防保健）之受檢者，繼承自 TW Core Patient，並可選擴充記錄其所屬事業單位、受僱日期與所屬部門。"
* extension contains ExtEmployerInfo named employerInfo 0..1
* extension contains ExtEmploymentDate named employmentDate 0..1
* extension contains ExtDepartment named department 0..1
