# 肺功能檢查結果範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.1

## 範例 Observation: 肺功能檢查結果範例

Profile: [肺功能檢查 Profile](StructureDefinition-TWHA-PulmonaryFunction.md)

**status**: Final

**category**: Exam

**code**: Forced vital capacity [Volume] Respiratory system by Spirometry

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:45:00+0800

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**value**: 4.2 L (Details: UCUM codeL = 'L')

> **component****code**: FEV1**value**: 3.5 L (Details: UCUM codeL = 'L')

> **component****code**: FEV1/FVC**value**: 83.3 % (Details: UCUM code% = '%')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-pulmonary",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-PulmonaryFunction"]
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
      "code" : "19868-9",
      "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:45:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueQuantity" : {
    "value" : 4.2,
    "unit" : "L",
    "system" : "http://unitsofmeasure.org",
    "code" : "L"
  },
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "20150-9",
        "display" : "FEV1"
      }]
    },
    "valueQuantity" : {
      "value" : 3.5,
      "unit" : "L",
      "system" : "http://unitsofmeasure.org",
      "code" : "L"
    }
  },
  {
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "19926-5",
        "display" : "FEV1/FVC"
      }]
    },
    "valueQuantity" : {
      "value" : 83.3,
      "unit" : "%",
      "system" : "http://unitsofmeasure.org",
      "code" : "%"
    }
  }]
}

```
