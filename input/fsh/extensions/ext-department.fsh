Extension: ExtDepartment
Id: ext-department
Title: "部門/課別擴充"
Description: "【技術規格】記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。"
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* ^context[1].type = #element
* ^context[1].expression = "Encounter"
* value[x] only string

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft