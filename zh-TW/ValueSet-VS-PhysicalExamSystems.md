# 身體檢查系統部位值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.0

## ValueSet: 身體檢查系統部位值集 

 
【依據：勞工健康保護規則附表】包含理學檢查中各系統部位代碼之值集。 

 **References** 

* [身體理學檢查 Profile](StructureDefinition-TWHA-PhysicalExam.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-PhysicalExamSystems",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-PhysicalExamSystems",
  "version" : "0.10.0",
  "name" : "VS_PhysicalExamSystems",
  "title" : "身體檢查系統部位值集",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-22T02:14:01+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】包含理學檢查中各系統部位代碼之值集。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems"
    }]
  }
}

```
