ValueSet: VS_PulmonaryFunction
Id: VS-PulmonaryFunction
Title: "肺功能檢查項目值集"
Description: "【依據：勞工健康保護規則附表】包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。"
* ^experimental = false
// v1.1 修正：FEV1 之正確 LOINC 為 20150-9；19868-9 與 19870-5 之 Component 均為 FVC（非 FEV1），標示更正
* LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry"   // FVC (Preferred：方法通用碼，未限定支氣管擴張劑前後)
* LNC#19870-5 "Forced vital capacity [Volume] Respiratory system"                 // FVC (variant)
* LNC#19876-2 "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation"  // FVC (Acceptable：支氣管擴張劑前之特定碼)
* LNC#20150-9 "FEV1" // FEV1 (Preferred)
* LNC#19926-5 "FEV1/FVC" // FEV1/FVC
* LNC#19935-6 "Maximum expiratory gas flow Respiratory system airway by Peak flow meter"
* LNC#19911-7 "Diffusion capacity.carbon monoxide"
* LNC#19862-2 "Total lung capacity"
* LNC#20146-7 "Residual volume"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft