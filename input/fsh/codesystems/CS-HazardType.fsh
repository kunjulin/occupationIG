CodeSystem: CS_HazardType
Id: CS-HazardType
Title: "特別危害健康作業類別代碼系統"
Description: "【依據：勞工健康保護規則附表】勞工健康保護規則所定義之特別危害健康作業，歸併為 12 危害家族（家族層）。附表十（115.06.26 修正）逐號列舉之 35 項法定具名作業另以 CS-Appendix10Operation 表示，家族 ↔ 具名作業之對映見 ConceptMap Appendix10-to-HazardType。"
* ^experimental = false
* ^caseSensitive = true
* #high-temp "高溫作業" "高溫作業勞工作息時間標準所稱之高溫作業。"
* #noise "噪音作業" "連續八小時工作期間之均權音量達八十五分貝以上之作業。"
* #radiation "游離輻射作業" "從事游離輻射防護法所稱之輻射工作。"
* #abnormal-pressure "異常氣壓作業" "從事高壓室內作業或潛水作業。"
* #lead "鉛作業" "從事鉛中毒預防規則所定義之鉛作業。"
* #tetraalkyl-lead "四烷基鉛作業" "從事四烷基鉛中毒預防規則所定義之四烷基鉛作業。"
* #dust "粉塵作業" "從事粉塵危害預防標準所定義之粉塵作業。"
* #organic-solvent "有機溶劑作業" "從事有機溶劑中毒預防規則所定義之有機溶劑作業。"
* #specific-chemical "特定化學物質作業" "從事特定化學物質危害預防標準所定義之特定化學物質作業，涵蓋苯、氯乙烯單體、石綿、鉻、鎘、鈹、砷、汞、錳、聯苯胺類等物質作業；細分類對應請見 VS-SpecificChemicalType（呼應文件一之 18 類特定化學物質展開）。"
* #yellow-phosphorus "黃磷作業" "製造、處置或使用黃磷之作業。"
* #paraquat "聯吡啶或巴拉刈作業" "製造、處置或使用聯吡啶或巴拉刈之作業。"
* #other "其他指定作業" "其他經中央主管機關公告指定之作業。"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_HazardType
Id: VS-HazardType
Title: "特別危害健康作業類別值集"
Description: "【依據：勞工健康保護規則附表】包含 12 大類特別危害健康作業類別之代碼。"
* ^experimental = false
* include codes from system CS_HazardType

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft