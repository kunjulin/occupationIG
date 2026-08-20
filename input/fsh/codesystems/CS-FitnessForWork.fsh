CodeSystem: CS_FitnessForWork
Id: CS-FitnessForWork
Title: "適性配工建議代碼系統"
Description: "【依據：勞工健康保護規則附表】第四級管理中，醫師針對受檢勞工提出之適性配工或變更作業內容建議。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）"
* ^experimental = true
* ^caseSensitive = true
* #change-workplace "變更工作場所" "調整勞工之作業場所，避開特定危害因子。"
* #change-job "更換工作" "調換勞工至其他職務或性質不同之工作。"
* #reduce-hours "縮短工作時間" "減少勞工暴露於危害作業之每日或每週工作時間。"
* #clinical-treatment "醫療處置與限制" "限制從事特定性質工作或建議配合臨床治療。"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_FitnessForWork
Id: VS-FitnessForWork
Title: "適性配工建議值集"
Description: "【依據：勞工健康保護規則附表】包含適性配工或工作調整建議代碼之值集。（provisional，隨 CS-FitnessForWork 待官方確認）"
* ^experimental = true
* include codes from system CS_FitnessForWork

/// -------------------------------------

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
CodeSystem: CS_LaborReportCode
Id: CS-LaborReportCode
Title: "勞動部通報報告代碼系統"
Description: "【依據：勞工健康保護規則附表】勞工健檢結果通報勞動部（LABOR）系統時所使用之報告類別代碼。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）"
* ^experimental = true
* ^caseSensitive = true
* #30901X "一般檢查通報" "一般體格及健康檢查結果通報。"
* #30902X "噪音作業特殊健檢通報" "從事噪音作業勞工之特殊健檢結果通報。"
* #30903X "粉塵作業特殊健檢通報" "從事粉塵作業勞工之特殊健檢結果通報。"
* #30904X "鉛作業特殊健檢通報" "從事鉛作業勞工之特殊健檢結果通報。"
* #30905X "其他特殊危害健康作業通報" "其他特別危害作業勞工之特殊健檢結果通報。"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_LaborReportCode
Id: VS-LaborReportCode
Title: "勞動部通報報告代碼值集"
Description: "【依據：勞工健康保護規則附表】包含勞動部通報報告類別代碼之值集。（provisional，隨 CS-LaborReportCode 待官方確認）"
* ^experimental = true
* include codes from system CS_LaborReportCode

/// -------------------------------------

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
CodeSystem: CS_ServiceActivityType
Id: CS-ServiceActivityType
Title: "臨場健康服務辦理事項代碼系統"
Description: "【依據：勞工健康保護規則附表】附表八中醫護人員辦理之臨場健康服務項目活動類別代碼系統。（**provisional**：本地代碼配置，尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）。另因 SNOMED 現無適切之職業健康諮詢 procedure 代碼，改善建議諮詢暫以本代碼系統承載，該用法列為本地碼治理事項。）"
* ^experimental = true
* ^caseSensitive = true
* #exam-analysis "健康檢查結果分析" "辦理健康檢查結果分析、評估、管理與保存。"
* #abnormal-followup "異常追蹤管理" "針對健檢異常勞工辦理個案追蹤與健康指導。"
* #health-education "健康教育指導" "辦理勞工健康教育、衛生指導、健康促進等活動。"
* #injury-prevention "工作相關傷病預防" "規劃與執行重複性作業等工作相關傷病預防措施。"
* #exposure-evaluation "作業環境危害暴露評估" "配合職業安全衛生人員進行危害暴露評估與現場巡視。"
* #maternity-protection "母性健康保護" "規劃與辦理妊娠、分娩後勞工之母性健康保護。"
* #unfit-assessment "配工與復工評估" "辦理勞工適性配工、工作限制或復工評估。"
* #emergency-response "緊急醫療規劃" "規劃與辦理工作場所緊急醫療與急救計畫。"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_ServiceActivityType
Id: VS-ServiceActivityType
Title: "臨場健康服務辦理事項值集"
Description: "【依據：勞工健康保護規則附表】包含臨場健康服務項目活動類別代碼之值集。（provisional，隨 CS-ServiceActivityType 待官方確認）"
* ^experimental = true
* include codes from system CS_ServiceActivityType

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft