# UC-005 成人預防保健檢查報告封包 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Bundle: UC-005 成人預防保健檢查報告封包



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-005",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"]
  },
  "identifier" : {
    "system" : "https://twcore.mohw.gov.tw/ig/twha/bundle-id",
    "value" : "bundle-uc-005"
  },
  "type" : "document",
  "timestamp" : "2026-06-12T12:00:00+08:00",
  "entry" : [{
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Composition/composition-uc005",
    "resource" : {
      "resourceType" : "Composition",
      "id" : "composition-uc005",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Composition_composition-uc005\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Composition composition-uc005</b></p><a name=\"composition-uc005\"> </a><a name=\"hccomposition-uc005\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Composition.html\">健康檢查健檢報告組成結構 Profile</a></p></div><p><b>status</b>: Final</p><p><b>type</b>: <span title=\"Codes:{http://loinc.org 11502-2}\">Laboratory report</span></p><p><b>date</b>: 2026-06-12 11:45:00+0800</p><p><b>author</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>title</b>: 成人預防保健檢查報告</p></div>"
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
      "title" : "成人預防保健檢查報告",
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
        },
        {
          "reference" : "Procedure/example-procedure-counseling"
        }]
      },
      {
        "title" : "自覺症狀",
        "code" : {
          "coding" : [{
            "system" : "http://loinc.org",
            "code" : "29554-3"
          }]
        },
        "entry" : [{
          "reference" : "QuestionnaireResponse/adult-preventive-care-response"
        },
        {
          "reference" : "QuestionnaireResponse/sdoh-questionnaire-response"
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
          "reference" : "Observation/obs-bmi"
        },
        {
          "reference" : "Observation/obs-waist"
        },
        {
          "reference" : "Observation/obs-bloodpressure"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Patient_example-worker\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Patient example-worker</b></p><a name=\"example-worker\"> </a><a name=\"hcexample-worker\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Patient.html\">受檢者 Profile</a></p></div><p style=\"border: 1px #661aff solid; background-color: #e6e6ff; padding: 10px;\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</p><hr/><table class=\"grid\"><tr><td style=\"background-color: #f3f5da\" title=\"Record is active\">Active:</td><td colspan=\"3\">true</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"記錄受檢勞工於事業單位中所屬之部門、課別或課室名稱。\"><a href=\"StructureDefinition-ext-department.html\">部門/課別擴充</a></td><td colspan=\"3\">化學處理課</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"記錄受檢勞工於事業單位之受僱日期。\"><a href=\"StructureDefinition-ext-employment-date.html\">受僱日期擴充</a></td><td colspan=\"3\">2020-03-01</td></tr><tr><td style=\"background-color: #f3f5da\" title=\"關聯受檢勞工所屬之事業單位組織資料，或臨場服務事件/活動所針對之事業單位。\"><a href=\"StructureDefinition-ext-employer-info.html\">雇主事業單位資訊擴充</a></td><td colspan=\"3\"><a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></td></tr></table></div>"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Practitioner_example-doctor\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Practitioner example-doctor</b></p><a name=\"example-doctor\"> </a><a name=\"hcexample-doctor\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Practitioner.html\">執業/健檢醫護與服務人員 Profile</a></p></div><p><b>identifier</b>: <code>https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/practitioner-license-tw</code>/MD-88888 (use: official, )</p><p><b>name</b>: 林職醫(Official)</p></div>"
      },
      "identifier" : [{
        "use" : "official",
        "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/practitioner-license-tw",
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Organization_example-hospital\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Organization example-hospital</b></p><a name=\"example-hospital\"> </a><a name=\"hcexample-hospital\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Organization-Facility.html\">實施健康檢查之醫療機構 Profile</a></p></div><p><b>identifier</b>: Provider number/2701010024 (use: official, )</p><p><b>name</b>: 交通部民用航空局航空醫務中心</p></div>"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Encounter_example-encounter-general\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Encounter example-encounter-general</b></p><a name=\"example-encounter-general\"> </a><a name=\"hcexample-encounter-general\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Encounter.html\">健康檢查健檢就醫事件 Profile</a></p></div><p><b>檢查類型擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ExamType general-health}\">一般健康檢查</span></p><p><b>健康檢查實施週期擴充</b>: 3 years<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codea = 'a')</span></p><p><b>部門/課別擴充</b>: 化學處理課</p><p><b>status</b>: Finished</p><p><b>class</b>: <a href=\"http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-AMB\">v3 Code System ActCode: AMB</a> (ambulatory)</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><h3>Participants</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Individual</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></td></tr></table><p><b>period</b>: 2026-06-12 08:00:00+0800 --&gt; 2026-06-12 11:30:00+0800</p><p><b>serviceProvider</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p></div>"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/QuestionnaireResponse/adult-preventive-care-response",
    "resource" : {
      "resourceType" : "QuestionnaireResponse",
      "id" : "adult-preventive-care-response",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-QuestionnaireResponse-HT"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"QuestionnaireResponse_adult-preventive-care-response\"> </a><p class=\"res-header-id\"><b>Generated Narrative: QuestionnaireResponse adult-preventive-care-response</b></p><a name=\"adult-preventive-care-response\"> </a><a name=\"hcadult-preventive-care-response\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-QuestionnaireResponse-HT.html\">成人預防保健問卷回覆 Profile</a></p></div><table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"border: 1px #F0F0F0 solid; font-size: 11px; font-family: verdana; vertical-align: top;\"><tr style=\"border: 2px #F0F0F0 solid; font-size: 11px; font-family: verdana; vertical-align: top\"><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"The linkID for the item\">LinkID</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Text for the item\">Text</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Minimum and Maximum # of times the item can appear in the instance\">Definition</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"The type of the item\">Answer</a><span style=\"float: right\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Legend for this format\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3goXBCwdPqAP0wAAAldJREFUOMuNk0tIlFEYhp9z/vE2jHkhxXA0zJCMitrUQlq4lnSltEqCFhFG2MJFhIvIFpkEWaTQqjaWZRkp0g26URZkTpbaaOJkDqk10szoODP//7XIMUe0elcfnPd9zsfLOYplGrpRwZaqTtw3K7PtGem7Q6FoidbGgqHVy/HRb669R+56zx7eRV1L31JGxYbBtjKK93cxeqfyQHbehkZbUkK20goELEuIzEd+dHS+qz/Y8PTSif0FnGkbiwcAjHaU1+QWOptFiyCLp/LnKptpqIuXHx6rbR26kJcBX3yLgBfnd7CxwJmflpP2wUg0HIAoUUpZBmKzELGWcN8nAr6Gpu7tLU/CkwAaoKTWRSQyt89Q8w6J+oVQkKnBoblH7V0PPvUOvDYXfopE/SJmALsxnVm6LbkotrUtNowMeIrVrBcBpaMmdS0j9df7abpSuy7HWehwJdt1lhVwi/J58U5beXGAF6c3UXLycw1wdFklArBn87xdh0ZsZtArghBdAA3+OEDVubG4UEzP6x1FOWneHh2VDAHBAt80IbdXDcesNoCvs3E5AFyNSU5nbrDPZpcUEQQTFZiEVx+51fxMhhyJEAgvlriadIJZZksRuwBYMOPBbO3hePVVqgEJhFeUuFLhIPkRP6BQLIBrmMenujm/3g4zc398awIe90Zb5A1vREALqneMcYgP/xVQWlG+Ncu5vgwwlaUNx+3799rfe96u9K0JSDXcOzOTJg4B6IgmXfsygc7/Bvg9g9E58/cDVmGIBOP/zT8Bz1zqWqpbXIsd0O9hajXfL6u4BaOS6SeWAAAAAElFTkSuQmCC\" alt=\"doco\" style=\"background-color: inherit\"/></a></span></th></tr><tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck1.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon_q_root.gif\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"QuestionnaireResponseRoot\" class=\"hierarchy\"/> adult-preventive-care-response</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">Questionnaire:<a href=\"Questionnaire-adult-preventive-care-questionnaire.html\">Questionnaire[https://twcore.mohw.gov.tw/ig/twha/Questionnaire/adult-preventive-care-questionnaire|0.1.0]</a></td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> smoking</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> drinking</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> betelnut</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> exercise</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">true</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> past-history</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> family-history</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">true</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> medication-history</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> depression-interest</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">0</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck00.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin_end.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> depression-mood</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">0</td></tr>\r\n<tr><td colspan=\"4\" class=\"hierarchy\"><br/><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Legend for this format\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3goXBCwdPqAP0wAAAldJREFUOMuNk0tIlFEYhp9z/vE2jHkhxXA0zJCMitrUQlq4lnSltEqCFhFG2MJFhIvIFpkEWaTQqjaWZRkp0g26URZkTpbaaOJkDqk10szoODP//7XIMUe0elcfnPd9zsfLOYplGrpRwZaqTtw3K7PtGem7Q6FoidbGgqHVy/HRb669R+56zx7eRV1L31JGxYbBtjKK93cxeqfyQHbehkZbUkK20goELEuIzEd+dHS+qz/Y8PTSif0FnGkbiwcAjHaU1+QWOptFiyCLp/LnKptpqIuXHx6rbR26kJcBX3yLgBfnd7CxwJmflpP2wUg0HIAoUUpZBmKzELGWcN8nAr6Gpu7tLU/CkwAaoKTWRSQyt89Q8w6J+oVQkKnBoblH7V0PPvUOvDYXfopE/SJmALsxnVm6LbkotrUtNowMeIrVrBcBpaMmdS0j9df7abpSuy7HWehwJdt1lhVwi/J58U5beXGAF6c3UXLycw1wdFklArBn87xdh0ZsZtArghBdAA3+OEDVubG4UEzP6x1FOWneHh2VDAHBAt80IbdXDcesNoCvs3E5AFyNSU5nbrDPZpcUEQQTFZiEVx+51fxMhhyJEAgvlriadIJZZksRuwBYMOPBbO3hePVVqgEJhFeUuFLhIPkRP6BQLIBrmMenujm/3g4zc398awIe90Zb5A1vREALqneMcYgP/xVQWlG+Ncu5vgwwlaUNx+3799rfe96u9K0JSDXcOzOTJg4B6IgmXfsygc7/Bvg9g9E58/cDVmGIBOP/zT8Bz1zqWqpbXIsd0O9hajXfL6u4BaOS6SeWAAAAAElFTkSuQmCC\" alt=\"doco\" style=\"background-color: inherit\"/> Documentation for this format</a></td></tr></table></div>"
      },
      "questionnaire" : "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/adult-preventive-care-questionnaire",
      "status" : "completed",
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "authored" : "2026-06-12T08:10:00+08:00",
      "author" : {
        "reference" : "Patient/example-worker"
      },
      "source" : {
        "reference" : "Patient/example-worker"
      },
      "item" : [{
        "linkId" : "smoking",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "drinking",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "betelnut",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "exercise",
        "answer" : [{
          "valueBoolean" : true
        }]
      },
      {
        "linkId" : "past-history",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "family-history",
        "answer" : [{
          "valueBoolean" : true
        }]
      },
      {
        "linkId" : "medication-history",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "depression-interest",
        "answer" : [{
          "valueInteger" : 0
        }]
      },
      {
        "linkId" : "depression-mood",
        "answer" : [{
          "valueInteger" : 0
        }]
      }]
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/QuestionnaireResponse/sdoh-questionnaire-response",
    "resource" : {
      "resourceType" : "QuestionnaireResponse",
      "id" : "sdoh-questionnaire-response",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SDOH-QuestionnaireResponse"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"QuestionnaireResponse_sdoh-questionnaire-response\"> </a><p class=\"res-header-id\"><b>Generated Narrative: QuestionnaireResponse sdoh-questionnaire-response</b></p><a name=\"sdoh-questionnaire-response\"> </a><a name=\"hcsdoh-questionnaire-response\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-SDOH-QuestionnaireResponse.html\">社會決定因素 (SDOH) 問卷回覆 Profile</a></p></div><table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"border: 1px #F0F0F0 solid; font-size: 11px; font-family: verdana; vertical-align: top;\"><tr style=\"border: 2px #F0F0F0 solid; font-size: 11px; font-family: verdana; vertical-align: top\"><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"The linkID for the item\">LinkID</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Text for the item\">Text</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Minimum and Maximum # of times the item can appear in the instance\">Definition</a></th><th style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; padding-top: 3px; padding-bottom: 3px\" class=\"hierarchy\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"The type of the item\">Answer</a><span style=\"float: right\"><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Legend for this format\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3goXBCwdPqAP0wAAAldJREFUOMuNk0tIlFEYhp9z/vE2jHkhxXA0zJCMitrUQlq4lnSltEqCFhFG2MJFhIvIFpkEWaTQqjaWZRkp0g26URZkTpbaaOJkDqk10szoODP//7XIMUe0elcfnPd9zsfLOYplGrpRwZaqTtw3K7PtGem7Q6FoidbGgqHVy/HRb669R+56zx7eRV1L31JGxYbBtjKK93cxeqfyQHbehkZbUkK20goELEuIzEd+dHS+qz/Y8PTSif0FnGkbiwcAjHaU1+QWOptFiyCLp/LnKptpqIuXHx6rbR26kJcBX3yLgBfnd7CxwJmflpP2wUg0HIAoUUpZBmKzELGWcN8nAr6Gpu7tLU/CkwAaoKTWRSQyt89Q8w6J+oVQkKnBoblH7V0PPvUOvDYXfopE/SJmALsxnVm6LbkotrUtNowMeIrVrBcBpaMmdS0j9df7abpSuy7HWehwJdt1lhVwi/J58U5beXGAF6c3UXLycw1wdFklArBn87xdh0ZsZtArghBdAA3+OEDVubG4UEzP6x1FOWneHh2VDAHBAt80IbdXDcesNoCvs3E5AFyNSU5nbrDPZpcUEQQTFZiEVx+51fxMhhyJEAgvlriadIJZZksRuwBYMOPBbO3hePVVqgEJhFeUuFLhIPkRP6BQLIBrmMenujm/3g4zc398awIe90Zb5A1vREALqneMcYgP/xVQWlG+Ncu5vgwwlaUNx+3799rfe96u9K0JSDXcOzOTJg4B6IgmXfsygc7/Bvg9g9E58/cDVmGIBOP/zT8Bz1zqWqpbXIsd0O9hajXfL6u4BaOS6SeWAAAAAElFTkSuQmCC\" alt=\"doco\" style=\"background-color: inherit\"/></a></span></th></tr><tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck1.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon_q_root.gif\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"QuestionnaireResponseRoot\" class=\"hierarchy\"/> sdoh-questionnaire-response</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">Questionnaire:<a href=\"Questionnaire-twha-sdoh-questionnaire.html\">Questionnaire[https://twcore.mohw.gov.tw/ig/twha/Questionnaire/twha-sdoh-questionnaire|0.1.0]</a></td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> education</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">大學畢業</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> employment</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">全職就業</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> housing-security</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: white\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck10.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: white; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> caregiver-stress</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: white; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr style=\"border: 1px #F0F0F0 solid; padding:0px; vertical-align: top; background-color: #F7F7F7\"><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px; white-space: nowrap; background-image: url(tbl_bck00.png)\" class=\"hierarchy\"><img src=\"tbl_spacer.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"tbl_vjoin_end.png\" alt=\".\" style=\"background-color: inherit\" class=\"hierarchy\"/><img src=\"icon-q-string.png\" alt=\".\" style=\"background-color: #F7F7F7; background-color: inherit\" title=\"Item\" class=\"hierarchy\"/> financial-hardship</td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"></td><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\"/><td style=\"vertical-align: top; text-align : var(--ig-left,left); background-color: #F7F7F7; border: 1px #F0F0F0 solid; padding:0px 4px 0px 4px\" class=\"hierarchy\">false</td></tr>\r\n<tr><td colspan=\"4\" class=\"hierarchy\"><br/><a href=\"https://hl7.org/fhir/R4/formats.html#table\" title=\"Legend for this format\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3goXBCwdPqAP0wAAAldJREFUOMuNk0tIlFEYhp9z/vE2jHkhxXA0zJCMitrUQlq4lnSltEqCFhFG2MJFhIvIFpkEWaTQqjaWZRkp0g26URZkTpbaaOJkDqk10szoODP//7XIMUe0elcfnPd9zsfLOYplGrpRwZaqTtw3K7PtGem7Q6FoidbGgqHVy/HRb669R+56zx7eRV1L31JGxYbBtjKK93cxeqfyQHbehkZbUkK20goELEuIzEd+dHS+qz/Y8PTSif0FnGkbiwcAjHaU1+QWOptFiyCLp/LnKptpqIuXHx6rbR26kJcBX3yLgBfnd7CxwJmflpP2wUg0HIAoUUpZBmKzELGWcN8nAr6Gpu7tLU/CkwAaoKTWRSQyt89Q8w6J+oVQkKnBoblH7V0PPvUOvDYXfopE/SJmALsxnVm6LbkotrUtNowMeIrVrBcBpaMmdS0j9df7abpSuy7HWehwJdt1lhVwi/J58U5beXGAF6c3UXLycw1wdFklArBn87xdh0ZsZtArghBdAA3+OEDVubG4UEzP6x1FOWneHh2VDAHBAt80IbdXDcesNoCvs3E5AFyNSU5nbrDPZpcUEQQTFZiEVx+51fxMhhyJEAgvlriadIJZZksRuwBYMOPBbO3hePVVqgEJhFeUuFLhIPkRP6BQLIBrmMenujm/3g4zc398awIe90Zb5A1vREALqneMcYgP/xVQWlG+Ncu5vgwwlaUNx+3799rfe96u9K0JSDXcOzOTJg4B6IgmXfsygc7/Bvg9g9E58/cDVmGIBOP/zT8Bz1zqWqpbXIsd0O9hajXfL6u4BaOS6SeWAAAAAElFTkSuQmCC\" alt=\"doco\" style=\"background-color: inherit\"/> Documentation for this format</a></td></tr></table></div>"
      },
      "questionnaire" : "https://twcore.mohw.gov.tw/ig/twha/Questionnaire/twha-sdoh-questionnaire",
      "status" : "completed",
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "authored" : "2026-06-12T08:10:00+08:00",
      "author" : {
        "reference" : "Patient/example-worker"
      },
      "source" : {
        "reference" : "Patient/example-worker"
      },
      "item" : [{
        "linkId" : "education",
        "answer" : [{
          "valueString" : "大學畢業"
        }]
      },
      {
        "linkId" : "employment",
        "answer" : [{
          "valueString" : "全職就業"
        }]
      },
      {
        "linkId" : "housing-security",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "caregiver-stress",
        "answer" : [{
          "valueBoolean" : false
        }]
      },
      {
        "linkId" : "financial-hardship",
        "answer" : [{
          "valueBoolean" : false
        }]
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-height\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-height</b></p><a name=\"obs-height\"> </a><a name=\"hcobs-height\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8302-2}\">Body height</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>value</b>: 175 cm<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codecm = 'cm')</span></p></div>"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-weight\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-weight</b></p><a name=\"obs-weight\"> </a><a name=\"hcobs-weight\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 29463-7}\">Body weight</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>value</b>: 70 kg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codekg = 'kg')</span></p></div>"
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
      "valueQuantity" : {
        "value" : 70,
        "unit" : "kg",
        "system" : "http://unitsofmeasure.org",
        "code" : "kg"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/obs-bmi",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "obs-bmi",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-VitalSigns"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-bmi\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-bmi</b></p><a name=\"obs-bmi\"> </a><a name=\"hcobs-bmi\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 39156-5}\">Body mass index (BMI) [Ratio]</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>value</b>: 22.86 kg/m2<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codekg/m2 = 'kg/m2')</span></p></div>"
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
          "code" : "39156-5",
          "display" : "Body mass index (BMI) [Ratio]"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
      "valueQuantity" : {
        "value" : 22.86,
        "unit" : "kg/m2",
        "system" : "http://unitsofmeasure.org",
        "code" : "kg/m2"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-waist\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-waist</b></p><a name=\"obs-waist\"> </a><a name=\"hcobs-waist\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-VitalSigns.html\">職業健檢生命徵象 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 56086-2}\">Waist Circumference</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><p><b>value</b>: 82 cm<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codecm = 'cm')</span></p></div>"
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
          "code" : "56086-2",
          "display" : "Waist Circumference"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T08:15:00+08:00",
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-bloodpressure\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-bloodpressure</b></p><a name=\"obs-bloodpressure\"> </a><a name=\"hcobs-bloodpressure\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"https://twcore.mohw.gov.tw/ig/twcore/1.0.0/StructureDefinition-Observation-bloodPressure-twcore.html\">TW Core Observation Blood Pressure</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category vital-signs}\">Vital Signs</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 85354-9}\">Blood pressure panel with all children optional</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 08:15:00+0800</p><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8480-6}\">Systolic blood pressure</span></p><p><b>value</b>: 120 mmHg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemm[Hg] = 'mm[Hg]')</span></p></blockquote><blockquote><p><b>component</b></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 8462-4}\">Diastolic blood pressure</span></p><p><b>value</b>: 80 mmHg<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemm[Hg] = 'mm[Hg]')</span></p></blockquote></div>"
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_obs-lab-glucose\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation obs-lab-glucose</b></p><a name=\"obs-lab-glucose\"> </a><a name=\"hcobs-lab-glucose\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-LabResult-General.html\">一般健檢實驗室檢驗 Profile</a></p></div><p><b>status</b>: Final</p><p><b>category</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/observation-category laboratory}\">Laboratory</span></p><p><b>code</b>: <span title=\"Codes:{http://loinc.org 1558-6}\">Fasting Glucose (mass/volume) in Serum or Plasma</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>effective</b>: 2026-06-12 09:00:00+0800</p><p><b>value</b>: 95 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></p><h3>ReferenceRanges</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Low</b></td><td><b>High</b></td></tr><tr><td style=\"display: none\">*</td><td>70 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></td><td>100 mg/dL<span style=\"background: LightGoldenRodYellow\"> (Details: UCUM  codemg/dL = 'mg/dL')</span></td></tr></table></div>"
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
          "display" : "Fasting Glucose (mass/volume) in Serum or Plasma"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "effectiveDateTime" : "2026-06-12T09:00:00+08:00",
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
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"ClinicalImpression_example-clinical-impression\"> </a><p class=\"res-header-id\"><b>Generated Narrative: ClinicalImpression example-clinical-impression</b></p><a name=\"example-clinical-impression\"> </a><a name=\"hcexample-clinical-impression\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-ClinicalImpression.html\">健康檢查健檢醫師總評與分級 Profile</a></p></div><p><b>健康管理分級擴充</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel level-1}\">第一級管理</span></p><p><b>status</b>: Completed</p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>assessor</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>summary</b>: 本次定期健康檢查結果大致正常，既往高血壓控制良好。建議持續維持健康生活習慣，定期監測血壓。</p></div>"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Procedure/example-procedure-counseling",
    "resource" : {
      "resourceType" : "Procedure",
      "id" : "example-procedure-counseling",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-Counseling"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Procedure_example-procedure-counseling\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Procedure example-procedure-counseling</b></p><a name=\"example-procedure-counseling\"> </a><a name=\"hcexample-procedure-counseling\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Procedure-Counseling.html\">健康諮詢與衛教指導 Profile</a></p></div><p><b>status</b>: Completed</p><p><b>code</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling counsel-exercise}, {https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling counsel-kidney}\">規律運動諮詢與衛教</span></p><p><b>subject</b>: <a href=\"Patient-example-worker.html\">王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))</a></p><p><b>encounter</b>: <a href=\"Encounter-example-encounter-general.html\">Encounter: extension = 一般健康檢查,3 years,化學處理課; status = finished; class = ambulatory (v3 Code System ActCode#AMB); period = 2026-06-12 08:00:00+0800 --&gt; 2026-06-12 11:30:00+0800</a></p></div>"
      },
      "status" : "completed",
      "code" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling",
          "code" : "counsel-exercise",
          "display" : "規律運動諮詢與衛教"
        },
        {
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthCounseling",
          "code" : "counsel-kidney",
          "display" : "腎病識能衛教指導"
        }]
      },
      "subject" : {
        "reference" : "Patient/example-worker"
      },
      "encounter" : {
        "reference" : "Encounter/example-encounter-general"
      }
    }
  }]
}

```
