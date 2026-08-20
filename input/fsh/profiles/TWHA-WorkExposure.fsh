Profile: TWHAWorkExposureProfile
Parent: Observation
Id: TWHA-WorkExposure
Title: "特別危害健康作業危害因子暴露史 Profile"
Description: "【依據：勞工健康保護規則附表】用於記錄受檢勞工從事特別危害作業（如高溫、噪音、鉛、粉塵等）之暴露年數與詳細工作性質。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* ^experimental = false
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = LNC#87729-0 "History of Occupational hazard"
* subject only Reference(TWHAPatientProfile)
* value[x] only CodeableConcept
* valueCodeableConcept from VS_HazardType (required)
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    exposureYears 0..1 and
    workDetails 0..1
* component[exposureYears].code = LNC#104905-5 "Duration of exposure"
* component[exposureYears].value[x] only Quantity
* component[workDetails].code = LNC#21847-9 "Usual occupation Narrative"
* component[workDetails].value[x] only string

* obeys twha-obs-1