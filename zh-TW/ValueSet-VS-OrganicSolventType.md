# 有機溶劑種類值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.3

## ValueSet: 有機溶劑種類值集 

 
包含特別危害健康作業中之常見有機溶劑代碼。 

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
  "id" : "VS-OrganicSolventType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-OrganicSolventType",
  "version" : "0.2.3",
  "name" : "VS_OrganicSolventType",
  "title" : "有機溶劑種類值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-17T03:02:16+00:00",
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
  "description" : "包含特別危害健康作業中之常見有機溶劑代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-OrganicSolventType"
    }]
  }
}

```
