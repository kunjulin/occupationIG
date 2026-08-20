# 聽力檢查結果範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

## 範例 Observation: 聽力檢查結果範例

Profile: [聽力檢查 Profile](StructureDefinition-TWHA-HearingTest.md)

**status**: Final

**category**: Exam

**code**: Pure tone air conduction threshold audiometry panel

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:25:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

> **component****code**: Hearing threshold Ear - left --500 Hz**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --1000 Hz**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --2000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --3000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --4000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --6000 Hz**value**: 25 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - left --8000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --500 Hz**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --1000 Hz**value**: 15 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --2000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --3000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --4000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --6000 Hz**value**: 25 dB (Details: UCUM codedB = 'dB')

> **component****code**: Hearing threshold Ear - right --8000 Hz**value**: 20 dB (Details: UCUM codedB = 'dB')



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
      "display" : "Pure tone air conduction threshold audiometry panel"
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
        "display" : "Hearing threshold Ear - left --500 Hz"
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
        "display" : "Hearing threshold Ear - left --1000 Hz"
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
        "code" : "89018-6",
        "display" : "Hearing threshold Ear - left --2000 Hz"
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
        "code" : "89020-2",
        "display" : "Hearing threshold Ear - left --3000 Hz"
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
        "display" : "Hearing threshold Ear - left --4000 Hz"
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
        "code" : "89026-9",
        "display" : "Hearing threshold Ear - left --6000 Hz"
      }]
    },
    "valueQuantity" : {
      "value" : 25,
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
        "display" : "Hearing threshold Ear - left --8000 Hz"
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
        "code" : "89025-1",
        "display" : "Hearing threshold Ear - right --500 Hz"
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
        "display" : "Hearing threshold Ear - right --1000 Hz"
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
        "display" : "Hearing threshold Ear - right --2000 Hz"
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
        "code" : "89021-0",
        "display" : "Hearing threshold Ear - right --3000 Hz"
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
        "code" : "89023-6",
        "display" : "Hearing threshold Ear - right --4000 Hz"
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
        "code" : "89027-7",
        "display" : "Hearing threshold Ear - right --6000 Hz"
      }]
    },
    "valueQuantity" : {
      "value" : 25,
      "unit" : "dB",
      "system" : "http://unitsofmeasure.org",
      "code" : "dB"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "89029-3",
        "display" : "Hearing threshold Ear - right --8000 Hz"
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
