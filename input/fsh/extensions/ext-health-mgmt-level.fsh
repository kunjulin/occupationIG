Extension: ExtHealthMgmtLevel
Id: ext-health-mgmt-level
Title: "健康管理分級擴充"
Description: "【依據：勞工健康保護規則附表】記錄醫師針對勞工健康狀況判定之健康管理分級（1-4級）。"
// 綁定之值集為 provisional 本地碼（待勞動部職安署確認，M-2），故本結構亦標為實驗性。
// 若逕標 false 會與所依賴代碼之暫定性質矛盾（IG Publisher 亦就此提出警告）。
* ^experimental = true
* ^context[0].type = #element
* ^context[0].expression = "ClinicalImpression"
* ^context[1].type = #element
* ^context[1].expression = "Observation"
* value[x] only CodeableConcept
* valueCodeableConcept from VS_HealthMgmtLevel (required)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft