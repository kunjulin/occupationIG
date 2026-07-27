Extension: ExtFitnessForWork
Id: ext-fitness-for-work
Title: "適性配工建議項目擴充"
Description: "用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。"
// 綁定之值集為 provisional 本地碼（待勞動部職安署確認，M-2），故本結構亦標為實驗性。
// 若逕標 false 會與所依賴代碼之暫定性質矛盾（IG Publisher 亦就此提出警告）。
* ^experimental = true
* ^context[0].type = #element
* ^context[0].expression = "CarePlan"
* value[x] only CodeableConcept
* valueCodeableConcept from VS_FitnessForWork (required)
