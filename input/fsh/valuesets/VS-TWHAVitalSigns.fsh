ValueSet: VS_TWHAVitalSigns
Id: VS-TWHAVitalSigns
Title: "職業健檢生命徵象項目值集"
Description: "包含身高、體重、腰圍及血壓等生理測量項目之 LOINC 代碼。"
* ^experimental = false
* LNC#8302-2 "Body height"
* LNC#29463-7 "Body weight"
* LNC#56086-2 "Waist Circumference"
* LNC#8480-6 "Systolic blood pressure"
* LNC#8462-4 "Diastolic blood pressure"
* LNC#39156-5 "Body mass index (BMI) [Ratio]"

/// -------------------------------------

CodeSystem: CS_PhysicalExamSystems
Id: CS-PhysicalExamSystems
Title: "身體檢查系統部位代碼系統"
Description: "附表十一理學檢查中所涉及之身體系統部位分類。"
* ^experimental = false
* ^caseSensitive = true
* #head-neck "頭頸部" "包含眼、耳、鼻、喉、口腔及頸部之檢查。"
* #respiratory "呼吸系統" "包含胸腔、肺部及呼吸音之聽診檢查。"
* #cardiovascular "心臟血管系統" "包含心臟聽診、心音、心率及周邊血管之檢查。"
* #digestive "消化系統" "包含腹部觸診、肝脾腫大及腸胃道系統之檢查。"
* #neurological "神經系統" "包含意識狀態、肌腱反射及感覺運動系統之檢查。"
* #musculoskeletal "肌肉骨骼系統" "包含脊椎、四肢關節活動度及肌肉力量之檢查。"
* #skin "皮膚" "包含皮膚疹、黃疸、疤痕或潰瘍之檢查。"

ValueSet: VS_PhysicalExamSystems
Id: VS-PhysicalExamSystems
Title: "身體檢查系統部位值集"
Description: "包含理學檢查中各系統部位代碼之值集。"
* ^experimental = false
* include codes from system CS_PhysicalExamSystems

/// -------------------------------------

ValueSet: VS_UnfitDiseases
Id: VS-UnfitDiseases
Title: "不適合從事作業之疾病值集"
Description: "依據勞工健康保護規則附表十二所列，不適合從事特定特別危害健康作業之疾病代碼值集（以 ICD-10-CM 表示）。"
* ^experimental = false
* include codes from system ICD10CM
