# 雇主端健康管理摘要範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

## 範例 Composition: 雇主端健康管理摘要範例

Profile: [雇主端健康管理摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmployerSummary.md)

**status**: Final

**type**: Patient summary Document

**date**: 2026-06-15 10:30:00+0800

**author**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**title**: 雇主端健康管理摘要



## Resource Content

```json
{
  "resourceType" : "Composition",
  "id" : "example-composition-employer-summary",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmployerSummary"]
  },
  "status" : "final",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "60591-5",
      "display" : "Patient summary Document"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "date" : "2026-06-15T10:30:00+08:00",
  "author" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "title" : "雇主端健康管理摘要",
  "section" : [{
    "title" : "健康管理分級與適性配工建議",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51848-0"
      }]
    },
    "entry" : [{
      "reference" : "Observation/obs-health-mgmt-level"
    },
    {
      "reference" : "CarePlan/example-careplan-fitness"
    }]
  },
  {
    "title" : "臨場服務發現問題",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "29554-3"
      }]
    },
    "entry" : [{
      "reference" : "Observation/example-service-finding"
    }]
  }]
}

```
