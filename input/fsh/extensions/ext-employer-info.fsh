Extension: ExtEmployerInfo
Id: ext-employer-info
Title: "雇主事業單位資訊擴充"
Description: "【技術規格】關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。"
* ^experimental = false
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* ^context[1].type = #element
* ^context[1].expression = "Encounter"
* ^context[2].type = #element
* ^context[2].expression = "Procedure"
* ^context[3].type = #element
* ^context[3].expression = "Task"
* value[x] only Reference(TWCoreOrganization)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft