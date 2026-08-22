# 聽力檢查 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.3

## 資源 Profile: 聽力檢查 Profile 

 
【依據：勞工健康保護規則附表】用於記錄勞工純音聽力測試結果，依左右耳及頻率（0.5/1/2/3/4/6/8 kHz）分切片記錄。繼承自 TW Core Observation Clinical Result。v1.1 修正：更正並補齊純音氣導聽閾 LOINC 代碼（原 v3 之頻率×耳別代碼多處錯置，且缺 3/6/8 kHz），使各切片代碼與 LOINC「Pure tone threshold audiometry panel」(89015-2) 之成員一致，符合《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率要求。 
**交換規則（回應委員意見）**： 
1. **須保留原始 panel／component 代碼**：若來源系統採`21104-5`系列等變異碼，交換時**應同時保留原始代碼**（如置於`code.coding`之另一 coding），**不得僅存歸一後之代碼**，以維持可追溯性。
1. **panel 層 mapping 不等於 component 層等價**：ConceptMap 現僅建立 panel 對 panel 之對應；**各頻率 component 之對應尚未建立（mapping unavailable）**，不得逕行推論等價。
1. **聽閾單位**：以 UCUM`dB`表達（臨床意義為 dB HL，依 ISO 1999 判讀）。
1. **特殊情形不得以一般數值表達**：「未測」「無反應」「超出儀器上限」等情形，**應以 `dataAbsentReason` 或明確代碼表達**，不得填入 0、999 等假數值，亦不得省略該 component。
 

**Usages:**

* Examples for this Profile: [Observation/obs-hearing](Observation-obs-hearing.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-HearingTest.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.component

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Constraints

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.component

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-HearingTest.csv), [Excel](../StructureDefinition-TWHA-HearingTest.xlsx), [Schematron](../StructureDefinition-TWHA-HearingTest.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-HearingTest",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HearingTest",
  "version" : "0.10.3",
  "name" : "TWHAHearingTestProfile",
  "title" : "聽力檢查 Profile",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-22T17:09:34+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】用於記錄勞工純音聽力測試結果，依左右耳及頻率（0.5/1/2/3/4/6/8 kHz）分切片記錄。繼承自 TW Core Observation Clinical Result。v1.1 修正：更正並補齊純音氣導聽閾 LOINC 代碼（原 v3 之頻率×耳別代碼多處錯置，且缺 3/6/8 kHz），使各切片代碼與 LOINC「Pure tone threshold audiometry panel」(89015-2) 之成員一致，符合《勞工健康保護規則》附表十噪音作業之 0.5–8 kHz 全頻率要求。\n\n**交換規則（回應委員意見）**：\n1. **須保留原始 panel／component 代碼**：若來源系統採 `21104-5` 系列等變異碼，交換時**應同時保留原始代碼**（如置於 `code.coding` 之另一 coding），**不得僅存歸一後之代碼**，以維持可追溯性。\n2. **panel 層 mapping 不等於 component 層等價**：ConceptMap 現僅建立 panel 對 panel 之對應；**各頻率 component 之對應尚未建立（mapping unavailable）**，不得逕行推論等價。\n3. **聽閾單位**：以 UCUM `dB` 表達（臨床意義為 dB HL，依 ISO 1999 判讀）。\n4. **特殊情形不得以一般數值表達**：「未測」「無反應」「超出儀器上限」等情形，**應以 `dataAbsentReason` 或明確代碼表達**，不得填入 0、999 等假數值，亦不得省略該 component。",
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
          "display" : "Pure tone air conduction threshold audiometry panel"
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
