# 工作經歷與職業別範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.0

## 範例 Observation: 工作經歷與職業別範例

Profile: [健康檢查工作經歷與職業別 Profile](StructureDefinition-TWHA-Occupation.md)

**status**: Final

**category**: Social History

**code**: 職業史

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2020-03-01 --> (ongoing)

**performer**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**value**: 化學處理課作業員（職業分類碼待引用經查證之 occupation-mol-tw 代碼）

### Components

| | | |
| :--- | :--- | :--- |
| - | **Code** | **Value[x]** |
| * | 行業別 | 電子零組件製造業 |



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-occupation",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Occupation"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
      "code" : "social-history"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "11341-5"
    }],
    "text" : "職業史"
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectivePeriod" : {
    "start" : "2020-03-01"
  },
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "valueCodeableConcept" : {
    "text" : "化學處理課作業員（職業分類碼待引用經查證之 occupation-mol-tw 代碼）"
  },
  "component" : [{
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "86188-0"
      }],
      "text" : "行業別"
    },
    "valueCodeableConcept" : {
      "text" : "電子零組件製造業"
    }
  }]
}

```
