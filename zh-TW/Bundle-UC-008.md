# UC-008 一般健檢結果上傳封包（首次上傳） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## 範例 Bundle: UC-008 一般健檢結果上傳封包（首次上傳）



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-008",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction"]
  },
  "type" : "transaction",
  "entry" : [{
    "fullUrl" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001",
    "resource" : {
      "resourceType" : "Patient",
      "id" : "tx-patient",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Patient_tx-patient\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 患者 tx-patient</b></p><a name=\"tx-patient\"> </a><a name=\"hctx-patient\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Patient.html\">受檢者 Profile</a></p></div><p style=\"border: 1px #661aff solid; background-color: #e6e6ff; padding: 10px;\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</p><hr/><table class=\"grid\"><tr><td style=\"background-color: #f3f5da\" title=\"Record is active\">Active:</td><td colspan=\"3\">true</td></tr></table></div>"
      },
      "identifier" : [{
        "use" : "official",
        "type" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code" : "MR",
            "display" : "Medical record number"
          }]
        },
        "system" : "https://www.cgmh.org.tw/tw/patient-id",
        "value" : "MR-98765"
      }],
      "active" : true,
      "name" : [{
        "use" : "official",
        "text" : "王大同"
      }],
      "gender" : "male",
      "birthDate" : "1985-05-15"
    },
    "request" : {
      "method" : "POST",
      "url" : "Patient",
      "ifNoneExist" : "identifier=https://www.cgmh.org.tw/tw/patient-id|MR-98765"
    }
  },
  {
    "fullUrl" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002",
    "resource" : {
      "resourceType" : "Organization",
      "id" : "tx-org-hospital",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Organization_tx-org-hospital\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 组织机构 tx-org-hospital</b></p><a name=\"tx-org-hospital\"> </a><a name=\"hctx-org-hospital\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Organization-Facility.html\">實施健康檢查之醫療機構 Profile</a></p></div><p><b>identifier</b>: Provider number/2701010024 (use: official, )</p><p><b>name</b>: 交通部民用航空局航空醫務中心</p></div>"
      },
      "identifier" : [{
        "use" : "official",
        "type" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
            "code" : "PRN"
          }]
        },
        "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw",
        "value" : "2701010024"
      }],
      "name" : "交通部民用航空局航空醫務中心"
    },
    "request" : {
      "method" : "POST",
      "url" : "Organization",
      "ifNoneExist" : "identifier=https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/organization-identifier-tw|2701010024"
    }
  },
  {
    "fullUrl" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0003",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "tx-obs-glucose",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-LabResult-General"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_tx-obs-glucose\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 tx-obs-glucose</b></p><a name=\"tx-obs-glucose\"> </a><a name=\"hctx-obs-glucose\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-LabResult-General.html\">一般健檢實驗室檢驗 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category laboratory}\">Laboratory</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 1558-6}\">Fasting glucose [Mass/volume] in Serum or Plasma</span></p><p><b>subject</b>: <a href=\"Bundle-UC-008.html#urn-uuid-8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 09:00:00+0800</p><p><b>performer</b>: <a href=\"Bundle-UC-008.html#urn-uuid-8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002\">Organization 交通部民用航空局航空醫務中心</a></p><p><b>value</b>: 95 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></p></div>"
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
          "code" : "1558-6",
          "display" : "Fasting glucose [Mass/volume] in Serum or Plasma"
        }]
      },
      "subject" : {
        "reference" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001"
      },
      "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
      "performer" : [{
        "reference" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002"
      }],
      "valueQuantity" : {
        "value" : 95,
        "unit" : "mg/dL",
        "system" : "http://unitsofmeasure.org",
        "code" : "mg/dL"
      }
    },
    "request" : {
      "method" : "POST",
      "url" : "Observation"
    }
  },
  {
    "fullUrl" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0004",
    "resource" : {
      "resourceType" : "DiagnosticReport",
      "id" : "tx-report-general",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-DiagnosticReport"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"DiagnosticReport_tx-report-general\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 诊断报告 tx-report-general</b></p><a name=\"tx-report-general\"> </a><a name=\"hctx-report-general\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-DiagnosticReport.html\">健康檢查健檢診斷報告 Profile</a></p></div><h2><span title=\"Codes:\">一般健康檢查檢驗報告</span> (<span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v2-0074 LAB}\">Laboratory</span>) </h2><table class=\"grid\"><tr><td>Subject</td><td>王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</td></tr><tr><td>Relevant Time</td><td>2026-06-12 09:00:00+0800</td></tr><tr><td>Reported</td><td>2026-06-15 10:00:00+0800</td></tr><tr><td>Performer</td><td> <a href=\"Bundle-UC-008.html#urn-uuid-8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002\">Organization 交通部民用航空局航空醫務中心</a></td></tr><tr><td>Identifier</td><td> <a href=\"NamingSystem-NS-ReportIdentifier.html\" title=\"勞工健康檢查報告封包（Bundle）之識別碼命名空間。\n\n**唯一性要求**：值在同一健檢機構內須唯一且不重複使用；跨機構之唯一性由\n「命名空間 + 值」的組合達成。上傳端據此判定是否為同一份封包之重送（去重）。\n\n**穩定性要求**：同一份健檢報告重新上傳（例如更正後重送）時**應沿用相同的識別碼**，\n否則監理端無從判斷這是更正還是新的一筆。若確為另一次健檢，則須給新的識別碼。\n\n**不得**以流水號以外可回推受檢者身分之內容組成（例如身分證號、病歷號）。\">TWHAReportIdentifier</a>/RPT-2026-0612-002</td></tr></table><p><b>Report Details</b></p><table class=\"grid\"><tr><td><b>Code</b></td><td><b>Value</b></td><td><b>Flags</b></td></tr><tr><td><a href=\"Bundle-UC-008.html#urn-uuid-8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0003\"><span title=\"Codes:{http://loinc.org 1558-6}\">Fasting glucose [Mass/volume] in Serum or Plasma</span></a></td><td>95 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></td><td>Final</td></tr></table></div>"
      },
      "identifier" : [{
        "system" : "https://twcore.mohw.gov.tw/ig/twha/sid/report-id",
        "value" : "RPT-2026-0612-002"
      }],
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/v2-0074",
          "code" : "LAB",
          "display" : "Laboratory"
        }]
      }],
      "code" : {
        "text" : "一般健康檢查檢驗報告"
      },
      "subject" : {
        "reference" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0001"
      },
      "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
      "issued" : "2026-06-15T10:00:00+08:00",
      "performer" : [{
        "reference" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0002"
      }],
      "result" : [{
        "reference" : "urn:uuid:8f7a0001-1a2b-4c3d-9e4f-5a6b7c8d0003"
      }]
    },
    "request" : {
      "method" : "POST",
      "url" : "DiagnosticReport",
      "ifNoneExist" : "identifier=https://twcore.mohw.gov.tw/ig/twha/sid/report-id|RPT-2026-0612-002"
    }
  }]
}

```
