# 嚼檳榔行為值集 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## ValueSet: 嚼檳榔行為值集 

 
Betel Nut Chewing Behavior Value Set 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "sf-BetNutChewBeh-valueset",
  "url" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewBeh-valueset",
  "version" : "0.1.0",
  "name" : "sf-BetNutChewBeh-valueset",
  "title" : "嚼檳榔行為值集",
  "status" : "active",
  "date" : "2026-07-09T21:42:02+08:00",
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
  "description" : "Betel Nut Chewing Behavior Value Set",
  "compose" : {
    "include" : [{
      "system" : "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem"
    }]
  }
}

```
