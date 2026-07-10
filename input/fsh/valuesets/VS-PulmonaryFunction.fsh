ValueSet: VS_PulmonaryFunction
Id: VS-PulmonaryFunction
Title: "肺功能檢查項目值集"
Description: "包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。"
* ^experimental = false
// v1.1 修正：FEV1 之正確 LOINC 為 20150-9；19868-9 與 19870-5 之 Component 均為 FVC（非 FEV1），標示更正
* LNC#19876-2 "Forced vital capacity [Volume] in Airways by Spirometry"           // FVC (Preferred)
* LNC#19870-5 "Forced vital capacity [Volume] Respiratory system"                 // FVC (variant)
* LNC#19868-9 "Forced vital capacity [Volume] Respiratory system by Spirometry"   // FVC (variant)
* LNC#20150-9 "Forced expiratory volume in 1 second [Volume] in Airways by Spirometry" // FEV1 (Preferred)
* LNC#19926-5 "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry" // FEV1/FVC
* LNC#33439-8 "Left midclavicular line Peak expiratory flow rate"
* LNC#19911-7 "Carbon monoxide diffusing capacity"
* LNC#19862-2 "Total lung capacity"
* LNC#20146-7 "Residual volume"
