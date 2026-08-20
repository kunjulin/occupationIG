Extension: ExtExamType
Id: ext-exam-type
Title: "檢查類型擴充"
Description: "【技術規格】標註該就醫事件（Encounter）是屬於一般體格、一般健康、特殊體格或特殊健康檢查。"
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Encounter"
* value[x] only CodeableConcept
* valueCodeableConcept from VS_ExamType (required)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft