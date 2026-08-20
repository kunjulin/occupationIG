Profile: TWHAServiceRequestProfile
Parent: TWCoreServiceRequest
Id: TWHA-ServiceRequest
Title: "健康檢查健檢追蹤檢查要求 Profile"
Description: "【技術規格】針對第三級或需要追蹤之勞工，醫師開立之追蹤檢查或現場評估排程要求，繼承自 TW Core ServiceRequest。"
* subject only Reference(TWHAPatientProfile)
* requester only Reference(TWHAPractitionerProfile or TWHAOrganizationFacilityProfile)
