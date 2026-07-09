# 聽力檢查結果範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 聽力檢查結果範例

Profile: [聽力檢查 Profile](StructureDefinition-TWHA-HearingTest.md)

**status**: Final

**category**: Exam

**code**: Pure tone threshold audiometry panel

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:25:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

> **component****code**: Hearing threshold Ear-left 500 Hz [dB]**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-left 1000 Hz [dB]**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-left 2000 Hz [dB]**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-left 4000 Hz [dB]**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-right 500 Hz [dB]**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-right 1000 Hz [dB]**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-right 2000 Hz [dB]**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear-right 4000 Hz [dB]**value**: 20 dB (Details: UCUM codedB = 'dB')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-hearing",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HearingTest"]
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
      "code" : "89015-2",
      "display" : "Pure tone threshold audiometry panel"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:25:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89024-4",
        "display" : "Hearing threshold Ear-left 500 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 15,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89016-0",
        "display" : "Hearing threshold Ear-left 1000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 15,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89017-8",
        "display" : "Hearing threshold Ear-left 2000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 20,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89018-6",
        "display" : "Hearing threshold Ear-left 4000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 20,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89028-5",
        "display" : "Hearing threshold Ear-right 500 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 15,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89020-2",
        "display" : "Hearing threshold Ear-right 1000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 15,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89019-4",
        "display" : "Hearing threshold Ear-right 2000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 20,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89022-8",
        "display" : "Hearing threshold Ear-right 4000 Hz [dB]"
      }]
    },
    "valueQuantity" : {
      "value" : 20,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  }]
}

```
