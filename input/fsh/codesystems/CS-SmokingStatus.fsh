CodeSystem: CS_SmokingStatus
Id: CS-SmokingStatus
Title: "吸菸狀態代碼系統"
Description: "【主管機關：國民健康署】勞工健檢生活習慣調查中之吸菸狀態分類。"
* ^experimental = false
* ^caseSensitive = true
* #0-never "從未吸菸" "受檢勞工從未吸菸。"
* #1-occasional "偶爾吸菸" "受檢勞工偶爾吸菸（非每日）。"
* #2-daily "每日吸菸" "受檢勞工每日吸菸。"
* #3-quit "已戒菸" "受檢勞工過去曾吸菸，目前已戒除。"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use
ValueSet: VS_SmokingStatus
Id: VS-SmokingStatus
Title: "吸菸狀態值集"
Description: "【主管機關：國民健康署】包含吸菸狀態代碼的值集。"
* ^experimental = false
* include codes from system CS_SmokingStatus

/// -------------------------------------

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use
CodeSystem: CS_HealthMgmtLevel
Id: CS-HealthMgmtLevel
Title: "健康管理分級代碼系統"
Description: "【依據：勞工健康保護規則附表】依據勞工健康保護規則第 21 條規定，醫師依健康檢查結果判定之健康管理分級。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待勞動部職業安全衛生署確認官方代碼與定義（M-2）**；不得表述為已對接官方申報系統。）"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = true
* ^caseSensitive = true
* #level-1 "第一級管理" "健康檢查結果無異常，或有部分異常但經醫師評估與工作無關，屬大致正常者。"
* #level-2 "第二級管理" "健康檢查結果異常，但經醫師評估與工作無關，需進行個人健康指導者。"
* #level-3 "第三級管理" "健康檢查結果異常，且無法確定其異常與工作之相關性，需進行追蹤檢查或工作場所危害暴露評估者。"
* #level-4 "第四級管理" "健康檢查結果異常，且經醫師評估與工作相關，屬健康危害顯著，需進行適性配工與治療者。"

ValueSet: VS_HealthMgmtLevel
Id: VS-HealthMgmtLevel
Title: "健康管理分級值集"
Description: "【依據：勞工健康保護規則附表】包含健康管理分級（第一級至第四級）代碼之值集。（provisional，隨 CS-HealthMgmtLevel 待官方確認）"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = true
* include codes from system CS_HealthMgmtLevel
