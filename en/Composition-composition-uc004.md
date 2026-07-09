# 自費健康檢查與進階影像鏡檢報告組成文件範例 (UC-004) - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Composition: 自費健康檢查與進階影像鏡檢報告組成文件範例 (UC-004)

Profile: [健康檢查健檢報告組成結構 Profile](StructureDefinition-TWHA-Composition.md)

**status**: Final

**type**: Laboratory report

**date**: 2026-06-12 11:45:00+0800

**author**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**title**: 自費健康檢查報告



## Resource Content

```json
{
  "resourceType" : "Composition",
  "id" : "composition-uc004",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition"]
  },
  "status" : "final",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "11502-2",
      "display" : "Laboratory report"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "date" : "2026-06-12T11:45:00+08:00",
  "author" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "title" : "自費健康檢查報告",
  "section" : [{
    "title" : "基本資料與行政資訊",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51847-2"
      }]
    },
    "entry" : [{
      "reference" : "Patient/example-worker"
    },
    {
      "reference" : "Encounter/example-encounter-general"
    }]
  },
  {
    "title" : "醫師總評、分級與建議",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51848-0"
      }]
    },
    "entry" : [{
      "reference" : "ClinicalImpression/example-clinical-impression"
    }]
  },
  {
    "title" : "檢驗與影像檢查",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "30954-2"
      }]
    },
    "entry" : [{
      "reference" : "Observation/obs-imaging-mammo"
    },
    {
      "reference" : "Observation/obs-imaging-brain-mri"
    },
    {
      "reference" : "Observation/obs-imaging-lung-ct"
    },
    {
      "reference" : "Observation/obs-imaging-pet"
    },
    {
      "reference" : "Observation/obs-imaging-cta"
    },
    {
      "reference" : "Observation/obs-endoscopy-egd"
    },
    {
      "reference" : "Observation/obs-endoscopy-colon"
    }]
  }]
}

```
