# UC-002 勞工一般體格與健康檢查報告封包 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.2

## 範例 Bundle: UC-002 勞工一般體格與健康檢查報告封包



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-002",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"]
  },
  "identifier" : {
    "system" : "https://twcore.mohw.gov.tw/ig/twha/sid/report-id",
    "value" : "bundle-uc-002"
  },
  "type" : "document",
  "timestamp" : "2026-06-12T12:00:00+08:00",
  "entry" : [{
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc002",
    "resource" : {
      "resourceType" : "Composition",
      "id" : "composition-uc002",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Composition_composition-uc002\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 组合式文书 composition-uc002</b></p><a name=\"composition-uc002\"> </a><a name=\"hccomposition-uc002\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Composition.html\">健康檢查健檢報告組成結構 Profile</a></p></div><p><b>status</b>: Final</p><p><b>type</b>: <span title=\"Codes:{http://loinc.org 11502-2}\">Laboratory report</span></p><p><b>date</b>: 2026-06-12 11:45:00+0800</p><p><b>author</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>title</b>: 勞工一般體格及健康檢查紀錄</p></div>"
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
      "title" : "勞工一般體格及健康檢查紀錄",
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
          "reference" : "Observation/obs-height"
        },
        {
          "reference" : "Observation/obs-weight"
        },
        {
          "reference" : "Observation/obs-waist"
        },
        {
          "reference" : "Observation/obs-bloodpressure"
        },
        {
          "reference" : "Observation/obs-vision"
        },
        {
          "reference" : "Observation/obs-hearing"
        },
        {
          "reference" : "Observation/obs-physical"
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
          "reference" : "Observation/obs-lab-glucose"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-waist",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-waist",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VitalSigns"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-waist\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-waist</b></p><a name=\"obs-waist\"> </a><a name=\"hcobs-waist\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8280-0}\">Waist Circumference at umbilicus by Tape measure</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-nurse.html\">Practitioner 陳健護(official)</a></p><p><b>value</b>: 82 cm<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codecm = 'cm')</span></p></div>"
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
          "code" : "8280-0",
          "display" : "Waist Circumference at umbilicus by Tape measure"
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
        "value" : 82,
        "unit" : "cm",
        "system" : "http://unitsofmeasure.org",
        "code" : "cm"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-vision",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-vision",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VisionTest"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-vision\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-vision</b></p><a name=\"obs-vision\"> </a><a name=\"hcobs-vision\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VisionTest.html\">視力與辨色力檢查 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category exam}\">Exam</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 98497-1}\">Visual acuity panel</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:20:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 98498-9}\">Visual acuity uncorrected Left eye</span></p><p><b>value</b>: 1 1<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  code1 = '1')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 98499-7}\">Visual acuity uncorrected Right eye</span></p><p><b>value</b>: 1 1<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  code1 = '1')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 46673-0}\">Color vision [RFC]</span></p><p><b>value</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v3-ObservationValue N}\">None</span></p></blockquote></div>"
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
          "code" : "98497-1",
          "display" : "Visual acuity panel"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:20:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "98498-9",
            "display" : "Visual acuity uncorrected Left eye"
          }]
        },
        "valueQuantity" : {
          "value" : 1,
          "system" : "http://unitsofmeasure.org",
          "code" : "1"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "98499-7",
            "display" : "Visual acuity uncorrected Right eye"
          }]
        },
        "valueQuantity" : {
          "value" : 1,
          "system" : "http://unitsofmeasure.org",
          "code" : "1"
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "46673-0",
            "display" : "Color vision [RFC]"
          }]
        },
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
            "code" : "N"
          }]
        }
      }]
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-physical",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-physical",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-PhysicalExam"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-physical\"> </a><p class=\"res-header-id\"><b>Generated Narrative: 观察 obs-physical</b></p><a name=\"obs-physical\"> </a><a name=\"hcobs-physical\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-PhysicalExam.html\">身體理學檢查 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category exam}\">Exam</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 29545-1}\">Physical findings note</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:30:00+0800</p><p><b>performer</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems head-neck}\">頭頸部</span></p><p><b>value</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v3-ObservationValue N}\">None</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems respiratory}\">呼吸系統</span></p><p><b>value</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v3-ObservationValue N}\">None</span></p></blockquote></div>"
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
          "code" : "29545-1",
          "display" : "Physical findings note"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:30:00+08:00",
      "performer" : [{
        "reference" : "Practitioner/example-doctor"
      }],
      "component" : [{
        "code" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems",
            "code" : "head-neck",
            "display" : "頭頸部"
          }]
        },
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
            "code" : "N"
          }]
        }
      },
      {
        "code" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems",
            "code" : "respiratory",
            "display" : "呼吸系統"
          }]
        },
        "valueCodeableConcept" : {
          "coding" : [{
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
            "code" : "N"
          }]
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
