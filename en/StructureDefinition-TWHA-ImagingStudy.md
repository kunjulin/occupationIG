# 健康檢查健檢影像檢查 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 健康檢查健檢影像檢查 Profile 

 
用於記錄勞工胸部 X 光、骨骼 X 光等影像檢查，繼承自 TW Core ImagingStudy。 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-ImagingStudy.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-ImagingStudy.csv), [Excel](../StructureDefinition-TWHA-ImagingStudy.xlsx), [Schematron](../StructureDefinition-TWHA-ImagingStudy.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-ImagingStudy",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ImagingStudy",
  "version" : "0.1.0",
  "name" : "TWHAImagingStudyProfile",
  "title" : "健康檢查健檢影像檢查 Profile",
  "status" : "active",
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
  "description" : "用於記錄勞工胸部 X 光、骨骼 X 光等影像檢查，繼承自 TW Core ImagingStudy。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "dicom",
    "uri" : "http://nema.org/dicom",
    "name" : "DICOM Tag Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ImagingStudy",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/ImagingStudy-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "ImagingStudy",
      "path" : "ImagingStudy"
    },
    {
      "id" : "ImagingStudy.subject",
      "path" : "ImagingStudy.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    }]
  }
}

```
