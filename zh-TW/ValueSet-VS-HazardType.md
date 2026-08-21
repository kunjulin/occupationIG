# 特別危害健康作業類別值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.1

## ValueSet: 特別危害健康作業類別值集 

 
【依據：勞工健康保護規則附表】包含 12 大類特別危害健康作業類別之代碼。 

 **References** 

* [特別危害健康作業危害因子暴露史 Profile](StructureDefinition-TWHA-WorkExposure.md)
* [特別危害健康作業類別擴充](StructureDefinition-ext-hazard-type.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-HazardType",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HazardType",
  "version" : "0.7.1",
  "name" : "VS_HazardType",
  "title" : "特別危害健康作業類別值集",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-21T01:22:55+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】包含 12 大類特別危害健康作業類別之代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType"
    }]
  }
}

```
