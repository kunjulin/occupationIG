Extension: ExtExamInterval
Id: ext-exam-interval
Title: "健康檢查實施週期擴充"
Description: "【依據：勞工健康保護規則附表】標註此次健康檢查之實施週期（如每年、每3年、每5年）。"
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only Quantity
