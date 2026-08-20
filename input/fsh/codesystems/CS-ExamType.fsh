CodeSystem: CS_ExamType
Id: CS-ExamType
Title: "檢查類型代碼系統"
Description: "【技術規格】勞工體格及健康檢查之類型，包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查。"
* ^experimental = false
* ^caseSensitive = true
* #general-physical "一般體格檢查" "雇主僱用勞工時，為辨識其工作適性，實施之體格檢查。"
* #general-health "一般健康檢查" "雇主對在職勞工，按其年齡及週期實施之定期健康檢查。"
* #special-physical "特殊體格檢查" "雇主使勞工從事特別危害健康作業前，實施之體格檢查。"
* #special-health "特殊健康檢查" "雇主對從事特別危害健康作業在職勞工，每年實施之定期健康檢查。"

ValueSet: VS_ExamType
Id: VS-ExamType
Title: "檢查類型值集"
Description: "【技術規格】包含一般體格檢查、一般健康檢查、特殊體格檢查及特殊健康檢查之代碼。"
* ^experimental = false
* include codes from system CS_ExamType
