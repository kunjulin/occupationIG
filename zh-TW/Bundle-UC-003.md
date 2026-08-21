# UC-003 特殊危害健康作業檢查報告封包 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.2

## 範例 Bundle: UC-003 特殊危害健康作業檢查報告封包



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-003",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"]
  },
  "identifier" : {
    "system" : "https://twcore.mohw.gov.tw/ig/twha/sid/report-id",
    "value" : "bundle-uc-003"
  },
  "type" : "document",
  "timestamp" : "2026-06-12T12:00:00+08:00",
  "entry" : [{
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc003",
    "resource" : {
      "resourceType" : "Composition",
      "id" : "composition-uc003",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Composition_composition-uc003\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 组合式文书 composition-uc003</b></p><a name=\"composition-uc003\"> </a><a name=\"hccomposition-uc003\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Composition.html\">健康檢查健檢報告組成結構 Profile</a></p></div><p><b>status</b>: Final</p><p><b>type</b>: <span title=\"Codes:{http://loinc.org 11502-2}\">Laboratory report</span></p><p><b>date</b>: 2026-06-12 11:45:00+0800</p><p><b>author</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>title</b>: 特殊危害健康作業檢查報告</p></div>"
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
      "title" : "特殊危害健康作業檢查報告",
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
        "title" : "理學檢查",
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "29545-1"
          }]
        },
        "entry" : [{
          "reference" : "Observation/obs-hearing"
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
          "reference" : "Observation/obs-pulmonary"
        }]
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Patient/example-worker",
    "resource" : {
      "resourceType" : "Patient",
      "id" : "example-worker",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Patient_example-worker\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 患者 example-worker</b></p><a name=\"example-worker\"> </a><a name=\"hcexample-worker\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Patient.html\">受檢者 Profile</a></p></div><p style=\"border: 1px #661aff solid; background-color: #e6e6ff; padding: 10px;\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</p><hr/><table class=\"grid\"><tr><td style=\"background-color: #f3f5da\" title=\"Record is active\">Active:</td><td colspan=\"3\">true</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"【技術規格】記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。\"><a href=\"StructureDefinition-ext-department.html\">部門/課別擴充</a></td><td colspan=\"3\">化學處理課</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"【依據：勞工健康保護規則附表】記錄受檢勞工於事業單位之受僱日期。\"><a href=\"StructureDefinition-ext-employment-date.html\">受僱日期擴充</a></td><td colspan=\"3\">2020-03-01</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"【技術規格】關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。\"><a href=\"StructureDefinition-ext-employer-info.html\">雇主事業單位資訊擴充</a></td><td colspan=\"3\"><a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></td></tr></table></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
        "valueReference" : {
          "reference" : "Organization/example-employer"
        }
      },
      {
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employment-date",
        "valueDate" : "2020-03-01"
      },
      {
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department",
        "valueString" : "化學處理課"
      }],
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
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-doctor",
    "resource" : {
      "resourceType" : "Practitioner",
      "id" : "example-doctor",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Practitioner_example-doctor\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 执业人员 example-doctor</b></p><a name=\"example-doctor\"> </a><a name=\"hcexample-doctor\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Practitioner.html\">執業/健檢醫護與服務人員 Profile</a></p></div><p><b>identifier</b>: <code>http://example.org/fhir/sid/tw-practitioner-license</code>/MD-88888 (use: official, )</p><p><b>name</b>: 林職醫(Official)</p></div>"
      },
      "identifier" : [{
        "use" : "official",
        "system" : "http://example.org/fhir/sid/tw-practitioner-license",
        "value" : "MD-88888"
      }],
      "name" : [{
        "use" : "official",
        "text" : "林職醫"
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Organization/example-hospital",
    "resource" : {
      "resourceType" : "Organization",
      "id" : "example-hospital",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Organization_example-hospital\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 组织机构 example-hospital</b></p><a name=\"example-hospital\"> </a><a name=\"hcexample-hospital\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Organization-Facility.html\">實施健康檢查之醫療機構 Profile</a></p></div><p><b>identifier</b>: Provider number/2701010024 (use: official, )</p><p><b>name</b>: 交通部民用航空局航空醫務中心</p></div>"
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
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-general",
    "resource" : {
      "resourceType" : "Encounter",
      "id" : "example-encounter-general",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Encounter_example-encounter-general\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 就医过程 example-encounter-general</b></p><a name=\"example-encounter-general\"> </a><a name=\"hcexample-encounter-general\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Encounter.html\">健康檢查健檢就醫事件 Profile</a></p></div><p><b>檢查類型擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType general-health}\">一般健康檢查</span></p><p><b>健康檢查實施週期擴充</b>: 3 years<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codea = 'a')</span></p><p><b>部門/課別擴充</b>: 化學處理課</p><p><b>status</b>: Finished</p><p><b>class</b>: <a href=\"http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActCode.html#v3-ActCode-AMB\">ActCode: AMB</a> (ambulatory)</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><h3>Participants</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Individual</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></td></tr></table><p><b>period</b>: 2026-06-12 08:00:00+0800 --&gt; 2026-06-12 11:30:00+0800</p><p><b>serviceProvider</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p></div>"
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
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-hearing",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-hearing",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HearingTest"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-hearing\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-hearing</b></p><a name=\"obs-hearing\"> </a><a name=\"hcobs-hearing\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-HearingTest.html\">聽力檢查 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category exam}\">Exam</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89015-2}\">Pure tone air conduction threshold audiometry panel</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:25:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89024-4}\">Hearing threshold Ear - left --500 Hz</span></p><p><b>value</b>: 15 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89016-0}\">Hearing threshold Ear - left --1000 Hz</span></p><p><b>value</b>: 15 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89018-6}\">Hearing threshold Ear - left --2000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89020-2}\">Hearing threshold Ear - left --3000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89022-8}\">Hearing threshold Ear - left --4000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89026-9}\">Hearing threshold Ear - left --6000 Hz</span></p><p><b>value</b>: 25 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89028-5}\">Hearing threshold Ear - left --8000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89025-1}\">Hearing threshold Ear - right --500 Hz</span></p><p><b>value</b>: 15 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89017-8}\">Hearing threshold Ear - right --1000 Hz</span></p><p><b>value</b>: 15 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89019-4}\">Hearing threshold Ear - right --2000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89021-0}\">Hearing threshold Ear - right --3000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89023-6}\">Hearing threshold Ear - right --4000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89027-7}\">Hearing threshold Ear - right --6000 Hz</span></p><p><b>value</b>: 25 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 89029-3}\">Hearing threshold Ear - right --8000 Hz</span></p><p><b>value</b>: 20 dB<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codedB = 'dB')</span></p></blockquote></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "exam"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "89015-2",
          "display" : "Pure tone air conduction threshold audiometry panel"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:25:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89024-4",
            "display" : "Hearing threshold Ear - left --500 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 15,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89016-0",
            "display" : "Hearing threshold Ear - left --1000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 15,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89018-6",
            "display" : "Hearing threshold Ear - left --2000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89020-2",
            "display" : "Hearing threshold Ear - left --3000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89022-8",
            "display" : "Hearing threshold Ear - left --4000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89026-9",
            "display" : "Hearing threshold Ear - left --6000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 25,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89028-5",
            "display" : "Hearing threshold Ear - left --8000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89025-1",
            "display" : "Hearing threshold Ear - right --500 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 15,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89017-8",
            "display" : "Hearing threshold Ear - right --1000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 15,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89019-4",
            "display" : "Hearing threshold Ear - right --2000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89021-0",
            "display" : "Hearing threshold Ear - right --3000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89023-6",
            "display" : "Hearing threshold Ear - right --4000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89027-7",
            "display" : "Hearing threshold Ear - right --6000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 25,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "89029-3",
            "display" : "Hearing threshold Ear - right --8000 Hz"
          }]
        },
        "valueQuantity" : {
          "value" : 20,
          "unit" : "dB",
          "system" : "http://unitsofmeasure.org",
          "code" : "dB"
        }
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-pulmonary",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-pulmonary",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-PulmonaryFunction"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-pulmonary\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-pulmonary</b></p><a name=\"obs-pulmonary\"> </a><a name=\"hcobs-pulmonary\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-PulmonaryFunction.html\">肺功能檢查 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category exam}\">Exam</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 19868-9}\">Forced vital capacity [Volume] Respiratory system by Spirometry</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:45:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>value</b>: 4.2 L<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codeL = 'L')</span></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 20150-9}\">FEV1</span></p><p><b>value</b>: 3.5 L<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codeL = 'L')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 19926-5}\">FEV1/FVC</span></p><p><b>value</b>: 83.3 %<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  code% = '%')</span></p></blockquote></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "exam"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "19868-9",
          "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:45:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "valueQuantity" : {
        "value" : 4.2,
        "unit" : "L",
        "system" : "http://unitsofmeasure.org",
        "code" : "L"
      },
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "20150-9",
            "display" : "FEV1"
          }]
        },
        "valueQuantity" : {
          "value" : 3.5,
          "unit" : "L",
          "system" : "http://unitsofmeasure.org",
          "code" : "L"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "19926-5",
            "display" : "FEV1/FVC"
          }]
        },
        "valueQuantity" : {
          "value" : 83.3,
          "unit" : "%",
          "system" : "http://unitsofmeasure.org",
          "code" : "%"
        }
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/ClinicalImpression/example-clinical-impression",
    "resource" : {
      "resourceType" : "ClinicalImpression",
      "id" : "example-clinical-impression",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"ClinicalImpression_example-clinical-impression\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 临床印象 example-clinical-impression</b></p><a name=\"example-clinical-impression\"> </a><a name=\"hcexample-clinical-impression\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-ClinicalImpression.html\">健康檢查健檢醫師總評與分級 Profile</a></p></div><p><b>健康管理分級擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel level-1}\">第一級管理</span></p><p><b>status</b>: Completed</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>assessor</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>summary</b>: 本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。</p></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-health-mgmt-level",
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel",
            "code" : "level-1",
            "display" : "第一級管理"
          }]
        }
      }],
      "status" : "completed",
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "assessor" : {
        "reference" : "Practitioner/example-doctor"
      },
      "summary" : "本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。"
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-special",
    "resource" : {
      "resourceType" : "Encounter",
      "id" : "example-encounter-special",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Encounter_example-encounter-special\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 就医过程 example-encounter-special</b></p><a name=\"example-encounter-special\"> </a><a name=\"hcexample-encounter-special\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Encounter.html\">健康檢查健檢就醫事件 Profile</a></p></div><p><b>檢查類型擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType special-health}\">特殊健康檢查</span></p><p><b>特別危害健康作業類別擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType noise}\">噪音作業</span></p><p><b>部門/課別擴充</b>: 化學處理課</p><p><b>勞動部通報報告代碼擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-LaborReportCode 30902X}\">噪音作業特殊健檢通報</span></p><p><b>status</b>: Finished</p><p><b>class</b>: <a href=\"http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActCode.html#v3-ActCode-AMB\">ActCode: AMB</a> (ambulatory)</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><h3>Participants</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Individual</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></td></tr></table><p><b>period</b>: 2026-06-12 09:00:00+0800 --&gt; 2026-06-12 11:00:00+0800</p><p><b>serviceProvider</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p></div>"
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
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-occupation",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-occupation",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Occupation"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-occupation\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-occupation</b></p><a name=\"obs-occupation\"> </a><a name=\"hcobs-occupation\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Occupation.html\">健康檢查工作經歷與職業別 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category social-history}\">Social History</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 11341-5}\">職業史</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2020-03-01 --&gt; (ongoing)</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>value</b>: <span title=\"Codes:\">化學處理課作業員（職業分類碼待引用經查證之 occupation-mol-tw 代碼）</span></p><h3>Components</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Code</b></td><td><b>Value[x]</b></td></tr><tr><td style=\"display: none\">*</td><td><span title=\"Codes:{http://loinc.org 86188-0}\">行業別</span></td><td><span title=\"Codes:\">電子零組件製造業</span></td></tr></table></div>"
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
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-ecg",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-ecg",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ECG"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-ecg\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-ecg</b></p><a name=\"obs-ecg\"> </a><a name=\"hcobs-ecg\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-ECG.html\">心電圖檢查 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category procedure}\">Procedure</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 11524-6}\">EKG study</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 09:30:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>value</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v3-ObservationValue N}\">None</span></p></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "procedure"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11524-6",
          "display" : "EKG study"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T09:30:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "valueCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
          "code" : "N"
        }]
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/ImagingStudy/example-imaging-chest-xray",
    "resource" : {
      "resourceType" : "ImagingStudy",
      "id" : "example-imaging-chest-xray",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ImagingStudy"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"ImagingStudy_example-imaging-chest-xray\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 成像检查 example-imaging-chest-xray</b></p><a name=\"example-imaging-chest-xray\"> </a><a name=\"hcexample-imaging-chest-xray\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-ImagingStudy.html\">健康檢查健檢影像檢查 Profile</a></p></div><p><b>status</b>: Available</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>started</b>: 2026-06-12 09:45:00+0800</p><p><b>numberOfSeries</b>: 1</p><p><b>numberOfInstances</b>: 1</p><p><b>procedureCode</b>: <span title=\"Codes:\">胸部X光攝影（後前位）</span></p><p><b>reasonCode</b>: <span title=\"Codes:\">粉塵作業特殊健康檢查</span></p><blockquote><p><b>series</b></p><p><b>uid</b>: 1.2.826.0.1.3680043.8.498.10001</p><p><b>number</b>: 1</p><p><b>modality</b>: <a href=\"http://hl7.org/fhir/R4/codesystem-dicom-dcim.html#dicom-dcim-DX\">DICOM: DX</a> (Digital Radiography)</p><p><b>description</b>: Chest PA</p><h3>Instances</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Uid</b></td><td><b>SopClass</b></td><td><b>Number</b></td></tr><tr><td style=\"display: none\">*</td><td>1.2.826.0.1.3680043.8.498.20001</td><td>unknown: urn:oid:1.2.840.10008.5.1.4.1.1.1.1 (urn:oid:1.2.840.10008.5.1.4.1.1.1.1)</td><td>1</td></tr></table></blockquote></div>"
      },
      "status" : "available",
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "started" : "2026-06-12T09:45:00+08:00",
      "numberOfSeries" : 1,
      "numberOfInstances" : 1,
      "procedureCode" : [{
        "text" : "胸部X光攝影（後前位）"
      }],
      "reasonCode" : [{
        "text" : "粉塵作業特殊健康檢查"
      }],
      "series" : [{
        "uid" : "1.2.826.0.1.3680043.8.498.10001",
        "number" : 1,
        "modality" : {
          "system" : "http://dicom.nema.org/resources/ontology/DCM",
          "code" : "DX"
        },
        "description" : "Chest PA",
        "instance" : [{
          "uid" : "1.2.826.0.1.3680043.8.498.20001",
          "sopClass" : {
            "system" : "urn:ietf:rfc:3986",
            "code" : "urn:oid:1.2.840.10008.5.1.4.1.1.1.1"
          },
          "number" : 1
        }]
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/DiagnosticReport/example-diagnostic-report",
    "resource" : {
      "resourceType" : "DiagnosticReport",
      "id" : "example-diagnostic-report",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-DiagnosticReport"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"DiagnosticReport_example-diagnostic-report\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 诊断报告 example-diagnostic-report</b></p><a name=\"example-diagnostic-report\"> </a><a name=\"hcexample-diagnostic-report\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-DiagnosticReport.html\">健康檢查健檢診斷報告 Profile</a></p></div><h2><span title=\"Codes:\">噪音作業特殊健康檢查報告</span> (<span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v2-0074 OSL}\">Outside Lab</span>) </h2><table class=\"grid\"><tr><td>Subject</td><td>王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</td></tr><tr><td>Relevant Time</td><td>2026-06-12 11:00:00+0800</td></tr><tr><td>Reported</td><td>2026-06-15 10:00:00+0800</td></tr><tr><td>Performer</td><td> <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></td></tr></table><p><b>Report Details</b></p><p>雙耳高頻聽力閾值輕度上升，與噪音暴露相關；肺功能、心電圖與胸部X光未見異常。建議列第四級健康管理並實施適性配工。</p></div>"
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
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-health-mgmt-level",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-health-mgmt-level",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-health-mgmt-level\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-health-mgmt-level</b></p><a name=\"obs-health-mgmt-level\"> </a><a name=\"hcobs-health-mgmt-level\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-HealthManagementLevel.html\">健康檢查健康管理分級 Observation Profile</a></p></div><p><b>status</b>: Final</p><p><b>code</b>: <span title=\"Codes:{http://snomed.info/sct 406221003}\">Health status</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-15 10:00:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>value</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel level-4}\">第四級管理</span></p></div>"
      },
      "status" : "final",
      "code" : {
        "coding" : [{
          "system" : "http://snomed.info/sct",
          "code" : "406221003",
          "display" : "Health status"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-15T10:00:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "valueCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel",
          "code" : "level-4",
          "display" : "第四級管理"
        }]
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/CarePlan/example-careplan-fitness",
    "resource" : {
      "resourceType" : "CarePlan",
      "id" : "example-careplan-fitness",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan"]
      },
      "text" : {
        "status" : "additional",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"CarePlan_example-careplan-fitness\"> </a><p>依115年6月12日噪音作業特殊健康檢查結果，勞工王大同經判定為第四級健康管理。經職業醫學科醫師與事業單位協商，自115年7月1日起調整如下：</p><ul><li>變更工作場所：自化學處理課調整至噪音暴露低於85分貝之區域。</li><li>縮短工作時間：每日噪音作業時間不超過4小時。</li></ul><p>三個月後複檢並重新評估分級。</p></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork",
            "code" : "change-workplace",
            "display" : "變更工作場所"
          }]
        }
      },
      {
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-fitness-for-work",
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-FitnessForWork",
            "code" : "reduce-hours",
            "display" : "縮短工作時間"
          }]
        }
      }],
      "status" : "active",
      "intent" : "plan",
      "category" : [{
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/careplan-category-tw",
          "code" : "assess-plan"
        }]
      }],
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "period" : {
        "start" : "2026-07-01",
        "end" : "2026-10-01"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/ServiceRequest/example-servicerequest-followup",
    "resource" : {
      "resourceType" : "ServiceRequest",
      "id" : "example-servicerequest-followup",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ServiceRequest"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"ServiceRequest_example-servicerequest-followup\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 服务项目请求 example-servicerequest-followup</b></p><a name=\"example-servicerequest-followup\"> </a><a name=\"hcexample-servicerequest-followup\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-ServiceRequest.html\">健康檢查健檢追蹤檢查要求 Profile</a></p></div><p><b>status</b>: Active</p><p><b>intent</b>: Order</p><p><b>code</b>: <span title=\"Codes:\">純音聽力檢查（複檢）</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>occurrence</b>: 2026-10-01 09:00:00+0800</p><p><b>authoredOn</b>: 2026-06-15 10:30:00+0800</p><p><b>requester</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p></div>"
      },
      "status" : "active",
      "intent" : "order",
      "code" : {
        "text" : "純音聽力檢查（複檢）"
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "occurrenceDateTime" : "2026-10-01T09:00:00+08:00",
      "authoredOn" : "2026-06-15T10:30:00+08:00",
      "requester" : {
        "reference" : "Practitioner/example-doctor"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Practitioner/example-nurse",
    "resource" : {
      "resourceType" : "Practitioner",
      "id" : "example-nurse",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Practitioner_example-nurse\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 执业人员 example-nurse</b></p><a name=\"example-nurse\"> </a><a name=\"hcexample-nurse\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Practitioner.html\">執業/健檢醫護與服務人員 Profile</a></p></div><p><b>identifier</b>: <code>http://example.org/fhir/sid/tw-practitioner-license</code>/RN-66666 (use: official, )</p><p><b>name</b>: 陳健護(Official)</p></div>"
      },
      "identifier" : [{
        "use" : "official",
        "system" : "http://example.org/fhir/sid/tw-practitioner-license",
        "value" : "RN-66666"
      }],
      "name" : [{
        "use" : "official",
        "text" : "陳健護"
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-alcohol",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-alcohol",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Alcohol"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-alcohol\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-alcohol</b></p><a name=\"obs-alcohol\"> </a><a name=\"hcobs-alcohol\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-SocialHistory-Alcohol.html\">飲酒歷史與狀態 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category social-history}\">Social History</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 11331-6}\">History of Alcohol use</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:05:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><p><b>value</b>: <span title=\"Codes:{http://snomed.info/sct 219006}\">Current drinker of alcohol</span></p></div>"
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
          "code" : "11331-6",
          "display" : "History of Alcohol use"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-nurse"
      }],
      "valueCodeableConcept" : {
        "coding" : [{
          "system" : "http://snomed.info/sct",
          "code" : "219006",
          "display" : "Current drinker of alcohol"
        }]
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-smoking-former",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-smoking-former",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-Smoking"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-smoking-former\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-smoking-former</b></p><a name=\"obs-smoking-former\"> </a><a name=\"hcobs-smoking-former\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-SocialHistory-Smoking.html\">吸菸歷史與狀態 Profile</a></p></div><blockquote><p><b>吸菸量及菸齡擴充</b></p><ul><li>dailyAmount: 20</li><li>durationYears: 15</li></ul></blockquote><p><b>戒除時間（戒菸/戒檳榔月數）擴充</b>: 24</p><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category social-history}\">Social History</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 72166-2}\">Tobacco smoking status</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:05:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><p><b>value</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus 3-quit}\">已戒菸</span></p></div>"
      },
      "extension" : [{
        "extension" : [{
          "url" : "dailyAmount",
          "valueInteger" : 20
        },
        {
          "url" : "durationYears",
          "valueInteger" : 15
        }],
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-smoking-quantity"
      },
      {
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-cessation-duration",
        "valueInteger" : 24
      }],
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
          "code" : "72166-2",
          "display" : "Tobacco smoking status"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:05:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-nurse"
      }],
      "valueCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-SmokingStatus",
          "code" : "3-quit",
          "display" : "已戒菸"
        }]
      }
    }
  }]
}

```
