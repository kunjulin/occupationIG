# 體重測量結果範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.1

## 範例 Observation: 體重測量結果範例

Profile: [職業健檢生命徵象 Profile](StructureDefinition-TWHA-VitalSigns.md)

**status**: Final

**category**: Vital Signs

**code**: Body weight

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:15:00+0800

**performer**: [Practitioner 陳健護(official)](Practitioner-example-nurse.md)

**value**: 70 kg (Details: UCUM codekg = 'kg')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-weight",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VitalSigns"]
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
      "code" : "29463-7",
      "display" : "Body weight"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-nurse"
  }],
  "valueQuantity" : {
    "value" : 70,
    "unit" : "kg",
    "system" : "http://unitsofmeasure.org",
    "code" : "kg"
  }
}

```
