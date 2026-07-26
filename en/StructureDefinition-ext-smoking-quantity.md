# 吸菸量及菸齡擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Extension: 吸菸量及菸齡擴充 

記錄每日吸菸支數與吸菸年數。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [吸菸歷史與狀態 Profile](StructureDefinition-TWHA-SocialHistory-Smoking.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-smoking-quantity.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-ext-smoking-quantity.csv), [Excel](../StructureDefinition-ext-smoking-quantity.xlsx), [Schematron](../StructureDefinition-ext-smoking-quantity.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-smoking-quantity",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity",
  "version" : "0.1.0",
  "name" : "ExtSmokingQuantity",
  "title" : "吸菸量及菸齡擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T14:28:30+08:00",
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
  "description" : "記錄每日吸菸支數與吸菸年數。",
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
      "definition" : "記錄每日吸菸支數與吸菸年數。"
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
