# 實驗室檢驗缺值範例 - eGFR 未檢測（dataAbsentReason） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.2

## 範例 Observation: 實驗室檢驗缺值範例 - eGFR 未檢測（dataAbsentReason）

Profile: [特殊健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-Special.md)

**status**: Final

**category**: Laboratory

**code**: Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M

**subject**: [王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))](Patient-example-worker.md)

**effective**: 2026-06-12 09:00:00+0800

**performer**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)

**dataAbsentReason**: Not Performed



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "obs-lab-egfr-absent",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-LabResult-Special"]
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
      "code" : "98979-8",
      "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
    }]
  },
  "subject" : {
    "reference" : "Patient/example-worker"
  },
  "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
  "performer" : [{
    "reference" : "Organization/example-hospital"
  }],
  "dataAbsentReason" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/data-absent-reason",
      "code" : "not-performed",
      "display" : "Not Performed"
    }]
  }
}

```
