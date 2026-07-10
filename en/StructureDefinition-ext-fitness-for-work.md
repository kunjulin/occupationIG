# 適性配工建議項目擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Extension: 適性配工建議項目擴充 

用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [健康檢查適性配工計畫 Profile](StructureDefinition-TWHA-CarePlan.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-fitness-for-work.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-ext-fitness-for-work.csv), [Excel](../StructureDefinition-ext-fitness-for-work.xlsx), [Schematron](../StructureDefinition-ext-fitness-for-work.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-fitness-for-work",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
  "version" : "0.1.0",
  "name" : "ExtFitnessForWork",
  "title" : "適性配工建議項目擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-10T19:56:53+08:00",
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
  "description" : "用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。",
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
    "expression" : "CarePlan"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "適性配工建議項目擴充",
      "definition" : "用於 CarePlan 中標註具體的適性配工或變更作業場所等建議項目。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-FitnessForWork"
      }
    }]
  }
}

```
