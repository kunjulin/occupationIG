# 勞動部通報報告代碼擴充 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Extension: 勞動部通報報告代碼擴充 

標註此檢查結果通報至勞動部時所採用之報告大類代碼。

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-ext-labor-report-code.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-ext-labor-report-code.csv), [Excel](../StructureDefinition-ext-labor-report-code.xlsx), [Schematron](../StructureDefinition-ext-labor-report-code.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ext-labor-report-code",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code",
  "version" : "0.1.0",
  "name" : "ExtLaborReportCode",
  "title" : "勞動部通報報告代碼擴充",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T16:11:18+08:00",
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
  "description" : "標註此檢查結果通報至勞動部時所採用之報告大類代碼。",
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
  },
  {
    "type" : "element",
    "expression" : "Encounter"
  },
  {
    "type" : "element",
    "expression" : "Bundle"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "勞動部通報報告代碼擴充",
      "definition" : "標註此檢查結果通報至勞動部時所採用之報告大類代碼。"
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-LaborReportCode"
      }
    }]
  }
}

```
