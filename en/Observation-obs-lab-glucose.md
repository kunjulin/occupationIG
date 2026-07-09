# 實驗室檢驗範例 - 空腹血糖 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 實驗室檢驗範例 - 空腹血糖

Profile: [一般健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-General.md)

**status**: Final

**category**: Laboratory

**code**: Fasting Glucose (mass/volume) in Serum or Plasma

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 09:00:00+0800

**value**: 95 mg/dL (Details: UCUM codemg/dL = 'mg/dL')

### ReferenceRanges

| | | |
| :--- | :--- | :--- |
| - | **Low** | **High** |
| * | 70 mg/dL (Details: UCUM codemg/dL = 'mg/dL') | 100 mg/dL (Details: UCUM codemg/dL = 'mg/dL') |



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-lab-glucose",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-LabResult-General"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "laboratory"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "1558-6",
      "display" : "Fasting Glucose (mass/volume) in Serum or Plasma"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
  "valueQuantity" : {
    "value" : 95,
    "unit" : "mg/dL",
    "system" : "http://unitsofmeasure.org",
    "code" : "mg/dL"
  },
  "referenceRange" : [{
    "low" : {
      "value" : 70,
      "unit" : "mg/dL",
      "system" : "http://unitsofmeasure.org",
      "code" : "mg/dL"
    },
    "high" : {
      "value" : 100,
      "unit" : "mg/dL",
      "system" : "http://unitsofmeasure.org",
      "code" : "mg/dL"
    }
  }]
}

```
