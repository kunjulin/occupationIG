# 臨場服務紀錄組成文件範例 (UC-006) - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Composition: 臨場服務紀錄組成文件範例 (UC-006)

Profile: [健康檢查健康服務執行紀錄組成結構 Profile](StructureDefinition-TWHA-Composition-ServiceRecord.md)

**status**: Final

**type**: Summarization of clinical note

**date**: 2026-06-10 14:00:00+0800

**author**: [Practitioner 林職醫(official)](Practitioner-example-doctor.md)

**title**: 勞工健康服務執行紀錄表



## Resource Content

```json
{
  "resourceType" : "Composition",
  "id" : "example-composition-service",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-ServiceRecord"]
  },
  "status" : "final",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "34133-9",
      "display" : "Summarization of clinical note"
    }]
  },
  "subject" : {
    "reference" : "Organization/example-employer"
  },
  "date" : "2026-06-10T14:00:00+08:00",
  "author" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "title" : "勞工健康服務執行紀錄表",
  "section" : [{
    "title" : "作業場所概況",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51847-2"
      }]
    },
    "entry" : [{
      "reference" : "Encounter/example-encounter-service"
    }]
  },
  {
    "title" : "臨場服務執行情形",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "97726-4"
      }]
    },
    "entry" : [{
      "reference" : "Procedure/example-procedure-activity"
    }]
  },
  {
    "title" : "現場發現問題",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "29554-3"
      }]
    },
    "entry" : [{
      "reference" : "Observation/example-service-finding"
    }]
  },
  {
    "title" : "改善建議與追蹤",
    "code" : {
      "coding" : [{
        "system" : "http://loinc.org",
        "code" : "51898-5"
      }]
    },
    "entry" : [{
      "reference" : "Task/example-service-task"
    }]
  }]
}

```
