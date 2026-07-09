# 視力及辨色力檢查結果範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 視力及辨色力檢查結果範例

Profile: [視力與辨色力檢查 Profile](StructureDefinition-TWHA-VisionTest.md)

**status**: Final

**category**: Exam

**code**: Vision test panel

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:20:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

> **component****code**: Visual acuity Left eye**value**: 1 1 (Details: UCUM code1 = '1')

> **component****code**: Visual acuity Right eye**value**: 1 1 (Details: UCUM code1 = '1')

> **component****code**: Color vision Test**value**: None



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-vision",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VisionTest"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "exam"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "79880-1",
      "display" : "Vision test panel"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:20:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "70936-0",
        "display" : "Visual acuity Left eye"
      }]
    },
    "valueQuantity" : {
      "value" : 1,
      "system" : "http://unitsofmeasure.org",
      "code" : "1"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "70935-2",
        "display" : "Visual acuity Right eye"
      }]
    },
    "valueQuantity" : {
      "value" : 1,
      "system" : "http://unitsofmeasure.org",
      "code" : "1"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "48024-3",
        "display" : "Color vision Test"
      }]
    },
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
        "code" : "N"
      }]
    }
  }]
}

```
