# 健檢就醫事件範例 - 噪音作業特殊健康檢查 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## 範例 Encounter: 健檢就醫事件範例 - 噪音作業特殊健康檢查

Profile: [健康檢查健檢就醫事件 Profile](StructureDefinition-TWHA-Encounter.md)

**檢查類型擴充**: 特殊健康檢查

**特別危害健康作業類別擴充**: 噪音作業

**部門/課別擴充**: 化學處理課

**勞動部通報報告代碼擴充**: 噪音作業特殊健檢通報

**status**: Finished

**class**: [ActCode: AMB](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActCode.html#v3-ActCode-AMB) (ambulatory)

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

### Participants

| | |
| :--- | :--- |
| - | **Individual** |
| * | [Practitioner 林職醫(official)](Practitioner-example-doctor.md) |

**period**: 2026-06-12 09:00:00+0800 --> 2026-06-12 11:00:00+0800

**serviceProvider**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)



## Resource Content

```json
{
  "resourceType" : "Encounter",
  "id" : "example-encounter-special",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
  },
  "extension" : [{
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-exam-type",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType",
        "code" : "special-health",
        "display" : "特殊健康檢查"
      }]
    }
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-hazard-type",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType",
        "code" : "noise",
        "display" : "噪音作業"
      }]
    }
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department",
    "valueString" : "化學處理課"
  },
  {
    "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-labor-report-code",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-LaborReportCode",
        "code" : "30902X",
        "display" : "噪音作業特殊健檢通報"
      }]
    }
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
    "start" : "2026-06-12T09:00:00+08:00",
    "end" : "2026-06-12T11:00:00+08:00"
  },
  "serviceProvider" : {
    "reference" : "Organization/example-hospital"
  }
}

```
