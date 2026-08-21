# 雇主事業單位範例 - 大同電子 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## 範例 Organization: 雇主事業單位範例 - 大同電子

Profile: [健康檢查所屬事業單位（雇主公司） Profile](StructureDefinition-TWHA-Organization-Employer.md)

**identifier**: 公司或企業統一編號/12345678 (use: official, )

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
