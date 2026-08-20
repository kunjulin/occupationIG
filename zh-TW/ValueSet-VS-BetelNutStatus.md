# 嚼檳榔狀態值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## ValueSet: 嚼檳榔狀態值集 (實驗性) 

 
【主管機關：國民健康署】包含嚼檳榔狀態代碼的值集。（provisional，隨 CS-BetelNutStatus 待官方確認）不含「不詳」——狀態不詳者以 `dataAbsentReason` 表達，見 CS-BetelNutStatus 之說明。 

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
  "id" : "VS-BetelNutStatus",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutStatus",
  "version" : "0.6.0",
  "name" : "VS_BetelNutStatus",
  "title" : "嚼檳榔狀態值集",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-20T17:39:23+00:00",
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
  "description" : "【主管機關：國民健康署】包含嚼檳榔狀態代碼的值集。（provisional，隨 CS-BetelNutStatus 待官方確認）不含「不詳」——狀態不詳者以 `dataAbsentReason` 表達，見 CS-BetelNutStatus 之說明。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutStatus"
    }]
  }
}

```
