Profile: TWHAOrganizationEmployerProfile
Parent: TWCoreOrganizationCo
Id: TWHA-Organization-Employer
Title: "健康檢查所屬事業單位（雇主公司） Profile"
Description: "【技術規格】本 Profile 用於描述受檢勞工所屬之事業單位或公司，繼承自 TW Core Organization (公司) 以精確反映公司法人組織語義。其中統一編號以 identifier 表示。"
* identifier 1..*
* type = http://terminology.hl7.org/CodeSystem/organization-type#bus

Profile: TWHAOrganizationFacilityProfile
Parent: TWCoreOrganizationHosp
Id: TWHA-Organization-Facility
Title: "實施健康檢查之醫療機構 Profile"
Description: "【技術規格】本 Profile 用於描述實施勞工體格檢查、健康檢查或提供臨場健康服務之醫療機構，繼承自 TW Core Organization (醫院) 以精確反映醫療機構語義。"
* identifier 1..*
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov
