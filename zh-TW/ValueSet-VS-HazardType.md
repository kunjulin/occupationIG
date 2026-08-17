# 特別危害健康作業類別值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.3

## ValueSet: 特別危害健康作業類別值集 

 
包含 12 大類特別危害健康作業類別之代碼。 

 **References** 

* [特別危害健康作業危害因子暴露史 Profile](StructureDefinition-TWHA-WorkExposure.md)
* [特別危害健康作業類別擴充](StructureDefinition-ext-hazard-type.md)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-HazardType",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HazardType",
  "version" : "0.2.3",
  "name" : "VS_HazardType",
  "title" : "特別危害健康作業類別值集",
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
  "description" : "包含 12 大類特別危害健康作業類別之代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType"
    }]
  }
}

```
