# 口腔黏膜檢查表嚼檳榔習慣級距值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.1

## ValueSet: 口腔黏膜檢查表嚼檳榔習慣級距值集 (實驗性) 

 
【主管機關：國民健康署】包含口腔黏膜檢查表（107/7 修訂）嚼檳榔習慣六個級距之值集。（provisional，隨 CS-BetelNutHpaCategory） 

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
  "id" : "VS-BetelNutHpaCategory",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutHpaCategory",
  "version" : "0.6.1",
  "name" : "VS_BetelNutHpaCategory",
  "title" : "口腔黏膜檢查表嚼檳榔習慣級距值集",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-20T18:13:29+00:00",
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
  "description" : "【主管機關：國民健康署】包含口腔黏膜檢查表（107/7 修訂）嚼檳榔習慣六個級距之值集。（provisional，隨 CS-BetelNutHpaCategory）",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutHpaCategory"
    }]
  }
}

```
