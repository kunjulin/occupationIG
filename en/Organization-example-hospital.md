# 實施健檢之醫療機構範例 - 航空醫務中心 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Organization: 實施健檢之醫療機構範例 - 航空醫務中心

Profile: [實施健康檢查之醫療機構 Profile](StructureDefinition-TWHA-Organization-Facility.md)

**identifier**: Provider number/2701010024 (use: official, )

**name**: 交通部民用航空局航空醫務中心



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "example-hospital",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
  },
  "identifier" : [{
    "use" : "official",
    "type" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
        "code" : "PRN"
      }]
    },
    "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw",
    "value" : "2701010024"
  }],
  "name" : "交通部民用航空局航空醫務中心"
}

```
