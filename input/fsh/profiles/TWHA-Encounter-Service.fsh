Profile: TWHAEncounterServiceProfile
Parent: TWCoreEncounter
Id: TWHA-Encounter-Service
Title: "臨場健康服務事件 Profile"
Description: "【依據：勞工健康保護規則附表】本 Profile 用於描述醫護團隊到事業單位提供臨場健康服務之就醫/諮詢事件（對應附表八）。

**語意界定（回應委員意見）**：本資源表達「**一次臨場服務事件**」。`serviceProvider` 為提供服務之醫療機構；受服務之事業單位以 `extension[employerInfo]` 表達，**不置於 subject**。"
* ^status = #draft
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft
* extension contains ExtEmployerInfo named employerInfo 1..1
* extension contains ExtDepartment named department 0..1
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#FLD
* participant.individual only Reference(TWHAPractitionerProfile)
* serviceProvider only Reference(TWHAOrganizationFacilityProfile)
