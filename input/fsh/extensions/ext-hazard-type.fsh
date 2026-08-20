Extension: ExtHazardType
Id: ext-hazard-type
Title: "特別危害健康作業類別擴充"
Description: "【依據：勞工健康保護規則附表】標註該特殊體格或健康檢查所針對的危害作業種類（12大類）。"
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only CodeableConcept
* valueCodeableConcept from VS_HazardType (required)
