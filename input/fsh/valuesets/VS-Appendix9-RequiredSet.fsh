// 附表九「一般體格檢查／健康檢查」之法定應執行項目值集（JOB-07，情境資料集③）。
//
// 定位：這是 index.md「三層資料集」框架中的 **③ 情境資料集**——「某法定情境依法
// 應做什麼」，與 ①（本 IG 能表達什麼＝Core∪Extended）、②（主管機關最小上傳集）
// 皆不同。此前 ③ 僅有 markdown 對照表（general-exam.md §4.1），無機器可讀形式。
//
// 權威來源：docs/regulations/附表九（逐項核對，非轉抄既有 markdown）。體格檢查與
// 健康檢查兩欄項目相同，僅健康檢查第(6)項多列 LDL-C；本值集為兩者之聯集，涵蓋
// 健康檢查之完整項目。
//
// ⚠️ 只收「可以 LOINC／量表代碼表達的檢驗與量測項目」。附表九之非檢驗項目
//    （作業經歷、既往病史、生活習慣、自覺症狀、身體各系統理學檢查）**不以值集成員
//    表達**，而以對應 profile 承載，見下方對照與 general-exam.md §4.1。把它們硬塞
//    LOINC 會製造語意錯誤的代碼（JOB-07 §3.2）。
//
// 代碼來源：本值集所收之代碼**全部**取自已通過 JOB-01 術語稽核之既有內容
//    （general-exam.md §4.1、VS-OccHealthCheck-Required），未引入任何新代碼。
//
// 綁定強度：本值集用於「完整性稽核」（判定某次健檢是否做齊法定項目），
//    **不**作為任何 profile 之 element binding——避免與各 profile 現行 extensible
//    綁定衝突，亦不影響既有範例。用法見 general-exam.md 之稽核示範。

ValueSet: VS_Appendix9RequiredSet
Id: VS-Appendix9-RequiredSet
Title: "附表九 一般健康檢查法定應執行項目值集"
Description: "【依據：勞工健康保護規則附表】《勞工健康保護規則》附表九所列一般體格／健康檢查之法定應執行**檢驗與量測**項目（以健康檢查欄為準，含 LDL-C）。非檢驗項目（作業經歷、既往病史、生活習慣、自覺症狀、身體各系統理學檢查）以 TWHA-Occupation／TWHA-Condition／SocialHistory／TWHA-PhysicalExam 承載，不列為本值集成員。用於法定完整性稽核，非 profile 之 element binding。所有代碼均取自已通過術語稽核之既有內容。⚠️ 紅血球數（789-8）與 MCV（787-2）係 115.06.26 修正新增；repo 內附表九 PDF 為修正前版本，該二項無 repo 內原文可逐項核對，見未決事項 M-11。"
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = true
* ^status = #draft

// 附表九(2)：身高、體重、腰圍、視力、辨色力、聽力、血壓
* LNC#8302-2 "Body height"                                              // 身高
* LNC#29463-7 "Body weight"                                             // 體重
* LNC#8280-0 "Waist Circumference at umbilicus by Tape measure"         // 腰圍
* LNC#85354-9 "Blood pressure panel with all children optional"        // 血壓
* LNC#98497-1 "Visual acuity panel"                                     // 視力（辨色力為其 panel 成員 46673-0）
* LNC#89015-2 "Pure tone air conduction threshold audiometry panel"    // 聽力
// 附表九(4)：尿蛋白、尿潛血
* LNC#5804-0 "Protein [Mass/volume] in Urine by Test strip"            // 尿蛋白
* LNC#5794-3 "Hemoglobin [Presence] in Urine by Test strip"           // 尿潛血
// 附表九(5)：血色素、白血球數（115.06.26 修正另增 紅血球數、MCV）
* LNC#718-7 "Hemoglobin [Mass/volume] in Blood"                        // 血色素
* LNC#6690-2 "Leukocytes [#/volume] in Blood by Automated count"      // 白血球數
* LNC#789-8 "Erythrocytes [#/volume] in Blood by Automated count"    // 紅血球數（新增）
* LNC#787-2 "MCV [Entitic mean volume] in Red Blood Cells by Automated count" // MCV（新增）
// 附表九(6)：血糖、ALT、肌酸酐、膽固醇、三酸甘油酯、HDL-C、（健檢另含 LDL-C）
* LNC#1558-6 "Fasting glucose [Mass/volume] in Serum or Plasma"        // 血糖
* LNC#1742-6 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma" // ALT
* LNC#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"            // 肌酸酐
* LNC#2093-3 "Cholesterol [Mass/volume] in Serum or Plasma"          // 總膽固醇
* LNC#2571-8 "Triglyceride [Mass/volume] in Serum or Plasma"         // 三酸甘油酯
* LNC#2085-9 "Cholesterol in HDL [Mass/volume] in Serum or Plasma"   // HDL-C
* LNC#2089-1 "Cholesterol in LDL [Mass/volume] in Serum or Plasma"   // LDL-C（健康檢查欄新增）
// 附表九(3)：胸部 X 光（大片）
* LNC#24648-8 "XR Chest PA upright"                                    // 胸部 X 光
