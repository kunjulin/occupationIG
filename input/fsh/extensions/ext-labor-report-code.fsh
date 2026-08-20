Extension: ExtLaborReportCode
Id: ext-labor-report-code
Title: "勞動部通報報告代碼擴充"
Description: "【依據：勞工健康保護規則附表】標註此檢查結果通報至勞動部時所採用之報告大類代碼。"
// 綁定之值集為 provisional 本地碼（待勞動部職安署確認，M-2），故本結構亦標為實驗性。
// 若逕標 false 會與所依賴代碼之暫定性質矛盾（IG Publisher 亦就此提出警告）。
* ^experimental = true
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* ^context[1].type = #element
* ^context[1].expression = "Encounter"
* ^context[2].type = #element
* ^context[2].expression = "Bundle"
* value[x] only CodeableConcept
* valueCodeableConcept from VS_LaborReportCode (required)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft