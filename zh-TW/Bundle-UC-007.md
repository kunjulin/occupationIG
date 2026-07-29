# UC-007 職業健康急診友善摘要封包 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

##  Bundle: UC-007 職業健康急診友善摘要封包



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-007",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"]
  },
  "identifier" : {
    "system" : "https://twcore.mohw.gov.tw/ig/twha/sid/report-id",
    "value" : "bundle-uc-007"
  },
  "type" : "document",
  "timestamp" : "2026-06-12T12:00:00+08:00",
  "entry" : [{
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-emergency-summary",
    "resource" : {
      "resourceType" : "Composition",
      "id" : "composition-emergency-summary",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmergencySummary"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Composition_composition-emergency-summary\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 组合式文书 composition-emergency-summary</b></p><a name=\"composition-emergency-summary\"> </a><a name=\"hccomposition-emergency-summary\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Composition-EmergencySummary.html\">職業健康急診友善摘要 Composition Profile</a></p></div><p><b>status</b>: Final</p><p><b>type</b>: <span title=\"Codes:{http://loinc.org 60591-5}\">Patient summary Document</span></p><p><b>date</b>: 2026-06-12 11:50:00+0800</p><p><b>author</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>title</b>: 職業健康急診友善摘要</p></div>"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Patient_example-worker\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 患者 example-worker</b></p><a name=\"example-worker\"> </a><a name=\"hcexample-worker\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Patient.html\">受檢者 Profile</a></p></div><p style=\"border: 1px #661aff solid; background-color: #e6e6ff; padding: 10px;\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</p><hr/><table class=\"grid\"><tr><td style=\"background-color: #f3f5da\" title=\"Record is active\">Active:</td><td colspan=\"3\">true</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。\"><a href=\"StructureDefinition-ext-department.html\">部門/課別擴充</a></td><td colspan=\"3\">化學處理課</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"記錄受檢勞工於事業單位之受僱日期。\"><a href=\"StructureDefinition-ext-employment-date.html\">受僱日期擴充</a></td><td colspan=\"3\">2020-03-01</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。\"><a href=\"StructureDefinition-ext-employer-info.html\">雇主事業單位資訊擴充</a></td><td colspan=\"3\"><a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></td></tr></table></div>"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-exposure-lead",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-exposure-lead",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-WorkExposure"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-exposure-lead\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-exposure-lead</b></p><a name=\"obs-exposure-lead\"> </a><a name=\"hcobs-exposure-lead\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-WorkExposure.html\">特別危害健康作業危害因子暴露史 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category social-history}\">Social History</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 87729-0}\">History of Occupational hazard</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:00:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>value</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType lead}\">鉛作業</span></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 104905-5}\">Duration of exposure</span></p><p><b>value</b>: 8 years<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codea = 'a')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 21847-9}\">Usual occupation Narrative</span></p><p><b>value</b>: 電池極板熔鉛作業</p></blockquote></div>"
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
          "code" : "87729-0",
          "display" : "History of Occupational hazard"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:00:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "valueCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HazardType",
          "code" : "lead",
          "display" : "鉛作業"
        }]
      },
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "104905-5",
            "display" : "Duration of exposure"
          }]
        },
        "valueQuantity" : {
          "value" : 8,
          "unit" : "years",
          "system" : "http://unitsofmeasure.org",
          "code" : "a"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "21847-9",
            "display" : "Usual occupation Narrative"
          }]
        },
        "valueString" : "電池極板熔鉛作業"
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-height",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-height",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VitalSigns"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-height\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-height</b></p><a name=\"obs-height\"> </a><a name=\"hcobs-height\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8302-2}\">Body height</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><p><b>value</b>: 175 cm<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codecm = 'cm')</span></p></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "vital-signs"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "8302-2",
          "display" : "Body height"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-nurse"
      }],
      "valueQuantity" : {
        "value" : 175,
        "unit" : "cm",
        "system" : "http://unitsofmeasure.org",
        "code" : "cm"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-weight",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-weight",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VitalSigns"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-weight\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-weight</b></p><a name=\"obs-weight\"> </a><a name=\"hcobs-weight\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 29463-7}\">Body weight</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><p><b>value</b>: 70 kg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codekg = 'kg')</span></p></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "vital-signs"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "29463-7",
          "display" : "Body weight"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-nurse"
      }],
      "valueQuantity" : {
        "value" : 70,
        "unit" : "kg",
        "system" : "http://unitsofmeasure.org",
        "code" : "kg"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bloodpressure",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-bloodpressure",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Observation-bloodPressure-twcore"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-bloodpressure\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-bloodpressure</b></p><a name=\"obs-bloodpressure\"> </a><a name=\"hcobs-bloodpressure\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Observation-bloodPressure-twcore.html\">TW Core Observation Blood Pressure</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 85354-9}\">Blood pressure panel with all children optional</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8480-6}\">Systolic blood pressure</span></p><p><b>value</b>: 120 mmHg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemm[Hg] = 'mm[Hg]')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8462-4}\">Diastolic blood pressure</span></p><p><b>value</b>: 80 mmHg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemm[Hg] = 'mm[Hg]')</span></p></blockquote></div>"
      },
      "status" : "final",
      "category" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "vital-signs"
        }]
      }],
      "code" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "85354-9",
          "display" : "Blood pressure panel with all children optional"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-nurse"
      }],
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "8480-6",
            "display" : "Systolic blood pressure"
          }]
        },
        "valueQuantity" : {
          "value" : 120,
          "unit" : "mmHg",
          "system" : "http://unitsofmeasure.org",
          "code" : "mm[Hg]"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "8462-4",
            "display" : "Diastolic blood pressure"
          }]
        },
        "valueQuantity" : {
          "value" : 80,
          "unit" : "mmHg",
          "system" : "http://unitsofmeasure.org",
          "code" : "mm[Hg]"
        }
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-glucose",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-lab-glucose",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-LabResult-General"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-lab-glucose\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-lab-glucose</b></p><a name=\"obs-lab-glucose\"> </a><a name=\"hcobs-lab-glucose\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-LabResult-General.html\">一般健檢實驗室檢驗 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category laboratory}\">Laboratory</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 1558-6}\">Fasting glucose [Mass/volume] in Serum or Plasma</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 09:00:00+0800</p><p><b>performer</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p><p><b>value</b>: 95 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></p><h3>ReferenceRanges</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Low</b></td><td><b>High</b></td></tr><tr><td style=\"display: none\">*</td><td>70 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></td><td>100 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></td></tr></table></div>"
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
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
      "performer" : [{
        "reference" : "Organization/example-hospital"
      }],
      "valueQuantity" : {
        "value" : 95,
        "unit" : "mg/dL",
        "system" : "http://unitsofmeasure.org",
        "code" : "mg/dL"
      },
      "referenceRange" : [{
        "low" : {
          "value" : 70,
          "unit" : "mg/dL",
          "system" : "http://unitsofmeasure.org",
          "code" : "mg/dL"
        },
        "high" : {
          "value" : 100,
          "unit" : "mg/dL",
          "system" : "http://unitsofmeasure.org",
          "code" : "mg/dL"
        }
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-lab-egfr-absent",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-lab-egfr-absent",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-LabResult-Special"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-lab-egfr-absent\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-lab-egfr-absent</b></p><a name=\"obs-lab-egfr-absent\"> </a><a name=\"hcobs-lab-egfr-absent\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-LabResult-Special.html\">特殊健檢實驗室檢驗 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category laboratory}\">Laboratory</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 98979-8}\">Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 09:00:00+0800</p><p><b>performer</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p><p><b>dataAbsentReason</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/data-absent-reason not-performed}\">Not Performed</span></p></div>"
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
  }]
}

```
