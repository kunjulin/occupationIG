# 檳榔添加物值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## ValueSet: 檳榔添加物值集 (實驗性) 

 
【主管機關：國民健康署】包含檳榔添加物代碼之值集。（provisional，隨 CS-BetelNutAdditive 待官方確認） 

 **References** 

* [嚼檳榔歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-BetelNut.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-BetelNutAdditive",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutAdditive",
  "version" : "0.9.0",
  "name" : "VS_BetelNutAdditive",
  "title" : "檳榔添加物值集",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【主管機關：國民健康署】包含檳榔添加物代碼之值集。（provisional，隨 CS-BetelNutAdditive 待官方確認）",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutAdditive"
    }]
  }
}

```
