# 職業健康急診友善摘要範例 (UC-007) - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

## 範例 Composition: 職業健康急診友善摘要範例 (UC-007)

Profile: [職業健康急診友善摘要 Composition Profile](StructureDefinition-TWHA-Composition-EmergencySummary.md)

**status**: Final

**type**: Patient summary Document

**date**: 2026-06-12 11:50:00+0800

**author**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**title**: 職業健康急診友善摘要



## Resource Content

```json
{
  "resourceType" : "Composition",
  "id" : "composition-emergency-summary",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmergencySummary"]
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
  "date" : "2026-06-12T11:50:00+08:00",
  "author" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "title" : "職業健康急診友善摘要",
  "section" : [{
    "title" : "作業與暴露史",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "11341-5"
      }]
    },
    "entry" : [{
      "reference" : "Observation/obs-exposure-lead"
    }]
  },
  {
    "title" : "生命徵象",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "8716-3"
      }]
    },
    "entry" : [{
      "reference" : "Observation/obs-height"
    },
    {
      "reference" : "Observation/obs-weight"
    },
    {
      "reference" : "Observation/obs-bloodpressure"
    }]
  },
  {
    "title" : "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "30954-2"
      }]
    },
    "entry" : [{
      "reference" : "Observation/obs-lab-glucose"
    },
    {
      "reference" : "Observation/obs-lab-egfr-absent"
    }]
  },
  {
    "title" : "健康管理分級與急診注意事項",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51848-0"
      }]
    },
    "entry" : [{
      "reference" : "ClinicalImpression/example-clinical-impression"
    }]
  }]
}

```
