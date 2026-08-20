Extension: ExtEmploymentDate
Id: ext-employment-date
Title: "受僱日期擴充"
Description: "【依據：勞工健康保護規則附表】記錄受檢勞工於事業單位之受僱日期。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* value[x] only date
