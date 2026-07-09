# 執業醫護人員範例 - 林職醫 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Practitioner: 執業醫護人員範例 - 林職醫

Profile: [執業/健檢醫護與服務人員 Profile](StructureDefinition-TWHA-Practitioner.md)

**identifier**: `https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/practitioner-license-tw`/MD-88888 (use: official, )

**name**: 林職醫(Official)



## Resource Content

```json
{
  "resourceType" : "Practitioner",
  "id" : "example-doctor",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
  },
  "identifier" : [{
    "use" : "official",
    "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/practitioner-license-tw",
    "value" : "MD-88888"
  }],
  "name" : [{
    "use" : "official",
    "text" : "林職醫"
  }]
}

```
