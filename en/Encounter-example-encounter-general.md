# 健檢就醫事件範例 - 一般定期健康檢查 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Encounter: 健檢就醫事件範例 - 一般定期健康檢查

Profile: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)

**檢查類型擴充**: 一般健康檢查

**健康檢查實施週期擴充**: 3 years (Details: UCUM codea = 'a')

**部門/課別擴充**: 化學處理課

**status**: Finished

**class**: [v3 Code System ActCode: AMB](http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-AMB) (ambulatory)

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

### Participants

| | |
| :--- | :--- |
| - | **Individual** |
| * | [Practitioner 林職醫(official)](Practitioner-example-doctor.md) |

**period**: 2026-06-12 08:00:00+0800 --> 2026-06-12 11:30:00+0800

**serviceProvider**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)



## Resource Content

```json
{
  "resourceType" : "Encounter",
  "id" : "example-encounter-general",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType",
        "code" : "general-health",
        "display" : "一般健康檢查"
      }]
    }
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-interval",
    "valueQuantity" : {
      "value" : 3,
      "unit" : "years",
      "system" : "http://unitsofmeasure.org",
      "code" : "a"
    }
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department",
    "valueString" : "化學處理課"
  }],
  "status" : "finished",
  "class" : {
    "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
    "code" : "AMB",
    "display" : "ambulatory"
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "participant" : [{
    "individual" : {
      "reference" : "Practitioner/example-doctor"
    }
  }],
  "period" : {
    "start" : "2026-06-12T08:00:00+08:00",
    "end" : "2026-06-12T11:30:00+08:00"
  },
  "serviceProvider" : {
    "reference" : "Organization/example-hospital"
  }
}

```
