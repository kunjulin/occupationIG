# 適性配工建議值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## ValueSet: 適性配工建議值集 (實驗性) 

 
【依據：勞工健康保護規則附表】包含適性配工或工作調整建議代碼之值集。（provisional，隨 CS-FitnessForWork 待官方確認） 

 **References** 

* [適性配工建議項目擴充](StructureDefinition-ext-fitness-for-work.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-FitnessForWork",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-FitnessForWork",
  "version" : "0.9.3",
  "name" : "VS_FitnessForWork",
  "title" : "適性配工建議值集",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-21T16:05:47+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】包含適性配工或工作調整建議代碼之值集。（provisional，隨 CS-FitnessForWork 待官方確認）",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork"
    }]
  }
}

```
