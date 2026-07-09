# 身體質量指數 (BMI) 測量結果範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Observation: 身體質量指數 (BMI) 測量結果範例

Profile: [職業健檢生命徵象 Profile](StructureDefinition-TWHA-VitalSigns.md)

**status**: Final

**category**: Vital Signs

**code**: Body mass index (BMI) [Ratio]

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 08:15:00+0800

**value**: 22.86 kg/m2 (Details: UCUM codekg/m2 = 'kg/m2')



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-bmi",
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
      "code" : "39156-5",
      "display" : "Body mass index (BMI) [Ratio]"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
  "valueQuantity" : {
    "value" : 22.86,
    "unit" : "kg/m2",
    "system" : "http://unitsofmeasure.org",
    "code" : "kg/m2"
  }
}

```
