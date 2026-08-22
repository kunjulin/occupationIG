ValueSet: VS_TWHAVitalSigns
Id: VS-TWHAVitalSigns
Title: "職業健檢生命徵象項目值集"
Description: "【主管機關：國民健康署】包含身高、體重、腰圍及血壓等生理測量項目之 LOINC 代碼。"
* ^experimental = false
* LNC#8302-2 "Body height"
// ⚠️ 關係值以 FHIR R4 之 target 為主詞：source 指定量測方法、target 方法未指定，
//    故 target 語意較廣 ＝ #wider。本兩行原記 #narrower，係 JOB-22 全面更正關係值方向時
//    改了 ConceptMap 而未回頭改本檔註解，v0.10.1 更正（實值一律以 ConceptMap 為準）。
* LNC#3137-7 "Body height Measured"      // Acceptable：方法特化碼（Method = Measured）；經 ConceptMap 歸一至 8302-2（#wider）
* LNC#29463-7 "Body weight"
* LNC#3141-9 "Body weight Measured"      // Acceptable：方法特化碼（Method = Measured）；經 ConceptMap 歸一至 29463-7（#wider）
* LNC#8280-0 "Waist Circumference at umbilicus by Tape measure"  // 腰圍 Preferred（委員建議，臍位皮尺法；送件前以 loinc.org 覆核顯示名）
* LNC#8281-8 "Waist Circumference at umbilicus by US"   // Acceptable：超音波量測法（2026-08-22 委員決議收錄——健檢情境允許超音波量測）；經 ConceptMap 歸一至 8280-0（#relatedto——同層方法兄弟碼，數值不可直接等同比較）
// ⚠️ 8281-8 與 8280-0 為**同層之方法兄弟碼**，非通用／特化之包含關係，故關係值為
//    #relatedto 而非 #wider——與身高／體重兩組（方法特化 → 方法通用）不同，勿比照套用。
// (-) 腰圍之量測 protocol 碼（56086-2 PhenX、56114-2 NHANES、56115-9 NCFS）**刻意不納入本值集**：
//     三者均為量測 protocol／調查工具碼而非量測碼（56086-2 經 tx 驗證為
//     PhenX「Adult Waist Circumference Protocol」）。院所若以該三碼上傳，
//     仍可經 ConceptMap TWHealthCheckLaboratoryMap 歸一至 Preferred 8280-0。
* LNC#8480-6 "Systolic blood pressure"
* LNC#8462-4 "Diastolic blood pressure"
* LNC#39156-5 "Body mass index (BMI) [Ratio]"
// (-) 腰臀比 (WHR)：LOINC 現無對應代碼（原列 73708-3 經 tx 驗證為無效碼，已移除）。
//     如需交換，建議以本地擴充或俟 LOINC 新增後補列。

/// -------------------------------------

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use
CodeSystem: CS_PhysicalExamSystems
Id: CS-PhysicalExamSystems
Title: "身體檢查系統部位代碼系統"
Description: "【依據：勞工健康保護規則附表】附表十一理學檢查中所涉及之身體系統部位分類。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
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
Description: "【依據：勞工健康保護規則附表】包含理學檢查中各系統部位代碼之值集。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* include codes from system CS_PhysicalExamSystems

/// -------------------------------------

ValueSet: VS_UnfitDiseases
Id: VS-UnfitDiseases
Title: "不適合從事作業之疾病值集"
Description: "【依據：勞工健康保護規則附表】依據勞工健康保護規則附表十二所列，不適合從事特定特別危害健康作業之疾病代碼值集（以 ICD-10-CM 表示）。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* include codes from system ICD10CM
