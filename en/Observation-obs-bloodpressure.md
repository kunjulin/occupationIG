# 血壓測量結果範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 血壓測量結果範例

Profile: [TW Core Observation Blood Pressure](https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Observation-bloodPressure-twcore.html)

**status**: Final

**category**: Vital Signs

**code**: Blood pressure panel with all children optional

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:15:00+0800

> **component****code**: Systolic blood pressure**value**: 120 mmHg (Details: UCUM codemm[Hg] = 'mm[Hg]')

> **component****code**: Diastolic blood pressure**value**: 80 mmHg (Details: UCUM codemm[Hg] = 'mm[Hg]')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-bloodpressure",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-bloodPressure-twcore"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "vital-signs"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "85354-9",
      "display" : "Blood pressure panel with all children optional"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "8480-6",
        "display" : "Systolic blood pressure"
      }]
    },
    "valueQuantity" : {
      "value" : 120,
      "unit" : "mmHg",
      "system" : "http://unitsofmeasure.org",
      "code" : "mm[Hg]"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "8462-4",
        "display" : "Diastolic blood pressure"
      }]
    },
    "valueQuantity" : {
      "value" : 80,
      "unit" : "mmHg",
      "system" : "http://unitsofmeasure.org",
      "code" : "mm[Hg]"
    }
  }]
}

```
