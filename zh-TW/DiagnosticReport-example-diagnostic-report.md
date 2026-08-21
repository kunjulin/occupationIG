# 健檢診斷報告範例 - 噪音作業特殊健康檢查 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## 範例 DiagnosticReport: 健檢診斷報告範例 - 噪音作業特殊健康檢查

Profile: [健康檢查健檢診斷報告 Profile](StructureDefinition-TWHA-DiagnosticReport.md)

## 噪音作業特殊健康檢查報告 (Outside Lab) 

| | |
| :--- | :--- |
| Subject | 王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, )) |
| Relevant Time | 2026-06-12 11:00:00+0800 |
| Reported | 2026-06-15 10:00:00+0800 |
| Performer | [Practitioner 林職醫(official)](Practitioner-example-doctor.md) |

**Report Details**

雙耳高頻聽力閾值輕度上升，與噪音暴露相關；肺功能、心電圖與胸部X光未見異常。建議列第四級健康管理並實施適性配工。



## Resource Content

```json
{
  "resourceType" : "DiagnosticReport",
  "id" : "example-diagnostic-report",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-DiagnosticReport"]
  },
  "status" : "final",
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v2-0074",
      "code" : "OSL",
      "display" : "Outside Lab"
    }]
  }],
  "code" : {
    "text" : "噪音作業特殊健康檢查報告"
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "encounter" : {
    "reference" : "Encounter/example-encounter-special"
  },
  "effectiveDateTime" : "2026-06-12T11:00:00+08:00",
  "issued" : "2026-06-15T10:00:00+08:00",
  "performer" : [{
    "reference" : "Practitioner/example-doctor"
  }],
  "imagingStudy" : [{
    "reference" : "ImagingStudy/example-imaging-chest-xray"
  }],
  "conclusion" : "雙耳高頻聽力閾值輕度上升，與噪音暴露相關；肺功能、心電圖與胸部X光未見異常。建議列第四級健康管理並實施適性配工。"
}

```
