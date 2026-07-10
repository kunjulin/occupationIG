# 聽力檢查 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## Resource Profile: 聽力檢查 Profile 

 
用於記錄勞工純音聽力測試結果，依左右耳及頻率（0.5/1/2/3/4/6/8 kHz）分切片記錄。繼承自 TW Core Observation Clinical Result。v1.1 修正：更正並補齊純音氣導聽閾 LOINC 代碼（原 v3 之頻率×耳別代碼多處錯置，且缺 3/6/8 kHz），使各切片代碼與 LOINC「Pure tone threshold audiometry panel」(89015-2) 之成員一致，符合《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率要求。 

**Usages:**

* Examples for this Profile: [Observation/obs-hearing](Observation-obs-hearing.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-HearingTest.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-TWHA-HearingTest.csv), [Excel](../StructureDefinition-TWHA-HearingTest.xlsx), [Schematron](../StructureDefinition-TWHA-HearingTest.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-HearingTest",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HearingTest",
  "version" : "0.1.0",
  "name" : "TWHAHearingTestProfile",
  "title" : "聽力檢查 Profile",
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
  "description" : "用於記錄勞工純音聽力測試結果，依左右耳及頻率（0.5/1/2/3/4/6/8 kHz）分切片記錄。繼承自 TW Core Observation Clinical Result。v1.1 修正：更正並補齊純音氣導聽閾 LOINC 代碼（原 v3 之頻率×耳別代碼多處錯置，且缺 3/6/8 kHz），使各切片代碼與 LOINC「Pure tone threshold audiometry panel」(89015-2) 之成員一致，符合《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率要求。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "sct-concept",
    "uri" : "http://snomed.info/conceptdomain",
    "name" : "SNOMED CT Concept Domain Binding"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "sct-attr",
    "uri" : "http://snomed.org/attributebinding",
    "name" : "SNOMED CT Attribute Binding"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Observation",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-clinical-result-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Observation",
      "path" : "Observation",
      "constraint" : [{
        "key" : "twha-obs-1",
        "severity" : "error",
        "human" : "Observation 必須包含測量值 (value) 或資料缺失原因 (dataAbsentReason) 或分項測量值 (component)",
        "expression" : "value.exists() or dataAbsentReason.exists() or component.exists()",
        "source" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HearingTest"
      }]
    },
    {
      "id" : "Observation.status",
      "path" : "Observation.status",
      "patternCode" : "final"
    },
    {
      "id" : "Observation.code",
      "path" : "Observation.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89015-2",
          "display" : "Pure tone threshold audiometry panel"
        }]
      }
    },
    {
      "id" : "Observation.subject",
      "path" : "Observation.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Observation.performer",
      "path" : "Observation.performer",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Observation.component",
      "path" : "Observation.component",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "code"
        }],
        "rules" : "open"
      }
    },
    {
      "id" : "Observation.component:leftEar500",
      "path" : "Observation.component",
      "sliceName" : "leftEar500",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar500.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89024-4",
          "display" : "Hearing threshold Ear - left --500 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar500.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar500.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar500.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar500.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar1000",
      "path" : "Observation.component",
      "sliceName" : "leftEar1000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar1000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89016-0",
          "display" : "Hearing threshold Ear - left --1000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar1000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar1000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar1000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar1000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar2000",
      "path" : "Observation.component",
      "sliceName" : "leftEar2000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar2000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89018-6",
          "display" : "Hearing threshold Ear - left --2000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar2000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar2000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar2000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar2000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar3000",
      "path" : "Observation.component",
      "sliceName" : "leftEar3000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar3000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89020-2",
          "display" : "Hearing threshold Ear - left --3000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar3000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar3000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar3000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar3000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar4000",
      "path" : "Observation.component",
      "sliceName" : "leftEar4000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar4000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89022-8",
          "display" : "Hearing threshold Ear - left --4000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar4000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar4000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar4000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar4000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar6000",
      "path" : "Observation.component",
      "sliceName" : "leftEar6000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar6000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89026-9",
          "display" : "Hearing threshold Ear - left --6000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar6000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar6000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar6000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar6000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:leftEar8000",
      "path" : "Observation.component",
      "sliceName" : "leftEar8000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:leftEar8000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89028-5",
          "display" : "Hearing threshold Ear - left --8000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:leftEar8000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:leftEar8000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:leftEar8000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:leftEar8000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar500",
      "path" : "Observation.component",
      "sliceName" : "rightEar500",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar500.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89025-1",
          "display" : "Hearing threshold Ear - right --500 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar500.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar500.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar500.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar500.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar1000",
      "path" : "Observation.component",
      "sliceName" : "rightEar1000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar1000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89017-8",
          "display" : "Hearing threshold Ear - right --1000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar1000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar1000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar1000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar1000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar2000",
      "path" : "Observation.component",
      "sliceName" : "rightEar2000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar2000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89019-4",
          "display" : "Hearing threshold Ear - right --2000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar2000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar2000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar2000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar2000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar3000",
      "path" : "Observation.component",
      "sliceName" : "rightEar3000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar3000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89021-0",
          "display" : "Hearing threshold Ear - right --3000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar3000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar3000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar3000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar3000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar4000",
      "path" : "Observation.component",
      "sliceName" : "rightEar4000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar4000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89023-6",
          "display" : "Hearing threshold Ear - right --4000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar4000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar4000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar4000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar4000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar6000",
      "path" : "Observation.component",
      "sliceName" : "rightEar6000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar6000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89027-7",
          "display" : "Hearing threshold Ear - right --6000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar6000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar6000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar6000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar6000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    },
    {
      "id" : "Observation.component:rightEar8000",
      "path" : "Observation.component",
      "sliceName" : "rightEar8000",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:rightEar8000.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89029-3",
          "display" : "Hearing threshold Ear - right --8000 Hz"
        }]
      }
    },
    {
      "id" : "Observation.component:rightEar8000.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:rightEar8000.value[x].unit",
      "path" : "Observation.component.value[x].unit",
      "patternString" : "dB"
    },
    {
      "id" : "Observation.component:rightEar8000.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:rightEar8000.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "dB"
    }]
  }
}

```
