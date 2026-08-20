Profile: TWHACarePlanProfile
Parent: TWCoreCarePlan
Id: TWHA-CarePlan
Title: "健康檢查適性配工計畫 Profile"
Description: "【依據：勞工健康保護規則附表】用於針對第四級健康管理勞工，由醫師、事業單位等共同制定之適性配工計畫（變更場所、工作或縮短工時等），繼承自 TW Core CarePlan。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* status = #active
* intent = #plan
* subject only Reference(TWHAPatientProfile)
* extension contains ExtFitnessForWork named fitnessForWork 1..*
