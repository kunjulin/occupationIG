# 適性配工建議值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 適性配工建議值集 

 
包含適性配工或工作調整建議代碼之值集。 

 **References** 

* [適性配工建議項目擴充](StructureDefinition-ext-fitness-for-work.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-FitnessForWork",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-FitnessForWork",
  "version" : "0.1.0",
  "name" : "VS_FitnessForWork",
  "title" : "適性配工建議值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-25T16:18:15+08:00",
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
  "description" : "包含適性配工或工作調整建議代碼之值集。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork"
    }]
  }
}

```
