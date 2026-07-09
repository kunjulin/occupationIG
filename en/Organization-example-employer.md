# 雇主事業單位範例 - 大同電子 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Organization: 雇主事業單位範例 - 大同電子

Profile: [健康檢查所屬事業單位（雇主公司） Profile](StructureDefinition-TWHA-Organization-Employer.md)

**identifier**: Unified Business number/12345678 (use: official, )

**type**: Non-Healthcare Business or Corporation

**name**: 大同電子股份有限公司



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "example-employer",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Employer"]
  },
  "identifier" : [{
    "use" : "official",
    "type" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/v2-0203",
        "code" : "UBN"
      }]
    },
    "system" : "https://gcis.nat.gov.tw",
    "value" : "12345678"
  }],
  "type" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/organization-type",
      "code" : "bus"
    }]
  }],
  "name" : "大同電子股份有限公司"
}

```
