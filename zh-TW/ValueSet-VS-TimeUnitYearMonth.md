# 時間單位值集（年／月） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.2

## ValueSet: 時間單位值集（年／月） 

 
【主管機關：國民健康署】戒除期間所允許之 UCUM 時間單位：`a`（年）與 `mo`（月）。**以原始採集粒度為準**——原始以年收集者送 `a`，不得逕行乘 12（JOB-29 §A.6）。兩者皆為 UCUM 時間量綱，術語伺服器可自動換算，跨機構統計不受影響。 

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
  "id" : "VS-TimeUnitYearMonth",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-TimeUnitYearMonth",
  "version" : "0.6.2",
  "name" : "VS_TimeUnitYearMonth",
  "title" : "時間單位值集（年／月）",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T00:14:56+00:00",
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
  "description" : "【主管機關：國民健康署】戒除期間所允許之 UCUM 時間單位：`a`（年）與 `mo`（月）。**以原始採集粒度為準**——原始以年收集者送 `a`，不得逕行乘 12（JOB-29 §A.6）。兩者皆為 UCUM 時間量綱，術語伺服器可自動換算，跨機構統計不受影響。",
  "compose" : {
    "include" : [{
      "system" : "http://unitsofmeasure.org",
      "concept" : [{
        "code" : "a",
        "display" : "a"
      },
      {
        "code" : "mo",
        "display" : "mo"
      }]
    }]
  }
}

```
