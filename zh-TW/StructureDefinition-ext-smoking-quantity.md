# 吸菸量及菸齡擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.5

## 擴充: 吸菸量及菸齡擴充 

【主管機關：國民健康署】記錄每日吸菸支數與吸菸年數。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)
* Examples for this Extension: [Bundle/UC-003](Bundle-UC-003.md) and [Observation/obs-smoking-former](Observation-obs-smoking-former.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-smoking-quantity.json)

### 擴充內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Constraints

** Summary **

Complex Extension: 【主管機關：國民健康署】記錄每日吸菸支數與吸菸年數。

 **差異檢視Differential View** 

 **快照檢視** 

#### Constraints

** Summary **

Complex Extension: 【主管機關：國民健康署】記錄每日吸菸支數與吸菸年數。

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-ext-smoking-quantity.csv), [Excel](../StructureDefinition-ext-smoking-quantity.xlsx), [Schematron](../StructureDefinition-ext-smoking-quantity.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-smoking-quantity",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity",
  "version" : "0.8.5",
  "name" : "ExtSmokingQuantity",
  "title" : "吸菸量及菸齡擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T12:32:47+00:00",
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
  "description" : "【主管機關：國民健康署】記錄每日吸菸支數與吸菸年數。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "Observation"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "吸菸量及菸齡擴充",
      "definition" : "【主管機關：國民健康署】記錄每日吸菸支數與吸菸年數。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "min" : 2
    },
    {
      "id" : "Extension.extension:dailyAmount",
      "path" : "Extension.extension",
      "sliceName" : "dailyAmount",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:dailyAmount.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:dailyAmount.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "dailyAmount"
    },
    {
      "id" : "Extension.extension:dailyAmount.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "integer"
      }]
    },
    {
      "id" : "Extension.extension:durationYears",
      "path" : "Extension.extension",
      "sliceName" : "durationYears",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:durationYears.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:durationYears.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "durationYears"
    },
    {
      "id" : "Extension.extension:durationYears.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "integer"
      }]
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "max" : "0"
    }]
  }
}

```
