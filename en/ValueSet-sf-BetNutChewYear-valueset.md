# 嚼檳榔年值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 嚼檳榔年值集 

 
Betel Nut Chewing Year Value Set 

 **References** 

* [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "sf-BetNutChewYear-valueset",
  "url" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewYear-valueset",
  "version" : "0.1.0",
  "name" : "sf-BetNutChewYear-valueset",
  "title" : "嚼檳榔年值集",
  "status" : "active",
  "date" : "2026-07-10T19:56:53+08:00",
  "publisher" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
  "contact" : [{
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  },
  {
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  }],
  "description" : "Betel Nut Chewing Year Value Set",
  "compose" : {
    "include" : [{
      "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewYear-codesystem"
    }]
  }
}

```
