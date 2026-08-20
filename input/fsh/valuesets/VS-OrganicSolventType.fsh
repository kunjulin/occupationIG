CodeSystem: CS_OrganicSolventType
Id: CS-OrganicSolventType
Title: "有機溶劑種類代碼系統"
Description: "【依據：勞工健康保護規則附表】特別危害健康作業中之有機溶劑種類（主要 7 種）。"
* ^experimental = false
* ^caseSensitive = true
* #tetrachloroethane "四氯乙烷"
* #carbon-tetrachloride "四氯化碳"
* #carbon-disulfide "二硫化碳"
* #trichloroethylene "三氯乙烯"
* #tetrachloroethylene "四氯乙烯"
* #dimethylformamide "二甲基甲醯胺"
* #n-hexane "正己烷"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_OrganicSolventType
Id: VS-OrganicSolventType
Title: "有機溶劑種類值集"
Description: "【依據：勞工健康保護規則附表】包含特別危害健康作業中之常見有機溶劑代碼。"
* ^experimental = false
* include codes from system CS_OrganicSolventType

/// -------------------------------------

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
CodeSystem: CS_SpecificChemicalType
Id: CS-SpecificChemicalType
Title: "特定化學物質種類代碼系統"
Description: "【依據：勞工健康保護規則附表】特別危害健康作業中之特定化學物質種類。"
* ^experimental = false
* ^caseSensitive = true
* #benzidine "聯苯胺"
* #beta-naphthylamine "β-萘胺"
* #beryllium "鈹"
* #vinyl-chloride "氯乙烯"
* #benzene "苯"
* #asbestos "石綿"
* #arsenic "砷"
* #cadmium "鎘"
* #chromium "鉻"
* #manganese "錳"
* #mercury "汞"
* #formaldehyde "甲醛"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
ValueSet: VS_SpecificChemicalType
Id: VS-SpecificChemicalType
Title: "特定化學物質種類值集"
Description: "【依據：勞工健康保護規則附表】包含特別危害健康作業中之常見特定化學物質代碼。"
* ^experimental = false
* include codes from system CS_SpecificChemicalType

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft