# 執業醫護人員範例 - 陳健護 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.5

## 範例 Practitioner: 執業醫護人員範例 - 陳健護

Profile: [執業/健檢醫護與服務人員 Profile](StructureDefinition-TWHA-Practitioner.md)

**identifier**: `http://example.org/fhir/sid/tw-practitioner-license`/RN-66666 (use: official, )

**name**: 陳健護(Official)



## Resource Content

```json
{
  "resourceType" : "Practitioner",
  "id" : "example-nurse",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
  },
  "identifier" : [{
    "use" : "official",
    "system" : "http://example.org/fhir/sid/tw-practitioner-license",
    "value" : "RN-66666"
  }],
  "name" : [{
    "use" : "official",
    "text" : "陳健護"
  }]
}

```
