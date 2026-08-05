# 特定化學物質種類值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.1

## ValueSet: 特定化學物質種類值集 

 
包含特別危害健康作業中之常見特定化學物質代碼。 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-SpecificChemicalType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-SpecificChemicalType",
  "version" : "0.2.1",
  "name" : "VS_SpecificChemicalType",
  "title" : "特定化學物質種類值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-05T16:48:01+00:00",
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
  "description" : "包含特別危害健康作業中之常見特定化學物質代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SpecificChemicalType"
    }]
  }
}

```
