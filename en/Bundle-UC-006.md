# UC-006 勞工健康服務臨場服務紀錄封包 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Bundle: UC-006 勞工健康服務臨場服務紀錄封包



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "UC-006",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Document"]
  },
  "identifier" : {
    "system" : "https://twcore.mohw.gov.tw/ig/twha/bundle-id",
    "value" : "bundle-uc-006"
  },
  "type" : "document",
  "timestamp" : "2026-06-10T14:00:00+08:00",
  "entry" : [{
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Composition/example-composition-service",
    "resource" : {
      "resourceType" : "Composition",
      "id" : "example-composition-service",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-ServiceRecord"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Composition_example-composition-service\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Composition example-composition-service</b></p><a name=\"example-composition-service\"> </a><a name=\"hcexample-composition-service\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Composition-ServiceRecord.html\">健康檢查健康服務執行紀錄組成結構 Profile</a></p></div><p><b>status</b>: Final</p><p><b>type</b>: <span title=\"Codes:{http://loinc.org 34133-9}\">Summarization of clinical note</span></p><p><b>date</b>: 2026-06-10 14:00:00+0800</p><p><b>author</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>title</b>: 勞工健康服務執行紀錄表</p></div>"
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
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Organization/example-employer",
    "resource" : {
      "resourceType" : "Organization",
      "id" : "example-employer",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Employer"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Organization_example-employer\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Organization example-employer</b></p><a name=\"example-employer\"> </a><a name=\"hcexample-employer\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Organization-Employer.html\">健康檢查所屬事業單位（雇主公司） Profile</a></p></div><p><b>identifier</b>: Unified Business number/12345678 (use: official, )</p><p><b>type</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/organization-type bus}\">Non-Healthcare Business or Corporation</span></p><p><b>name</b>: 大同電子股份有限公司</p></div>"
      },
      "identifier" : [{
        "use" : "official",
        "type" : {
          "coding" : [{
            "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/v2-0203",
            "code" : "UBN"
          }]
        },
        "system" : "https://gcis.nat.gov.tw",
        "value" : "12345678"
      }],
      "type" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/organization-type",
          "code" : "bus"
        }]
      }],
      "name" : "大同電子股份有限公司"
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
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Encounter/example-encounter-service",
    "resource" : {
      "resourceType" : "Encounter",
      "id" : "example-encounter-service",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Encounter_example-encounter-service\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Encounter example-encounter-service</b></p><a name=\"example-encounter-service\"> </a><a name=\"hcexample-encounter-service\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Encounter-Service.html\">臨場健康服務事件 Profile</a></p></div><p><b>雇主事業單位資訊擴充</b>: <a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></p><p><b>部門/課別擴充</b>: 化學製造現場</p><p><b>status</b>: Finished</p><p><b>class</b>: <a href=\"http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-FLD\">v3 Code System ActCode: FLD</a> (field)</p><h3>Participants</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Individual</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></td></tr></table><p><b>period</b>: 2026-06-10 09:00:00+0800 --&gt; 2026-06-10 12:00:00+0800</p><p><b>serviceProvider</b>: <a href=\"Organization-example-hospital.html\">Organization 交通部民用航空局航空醫務中心</a></p></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
        "valueReference" : {
          "reference" : "Organization/example-employer"
        }
      },
      {
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-department",
        "valueString" : "化學製造現場"
      }],
      "status" : "finished",
      "class" : {
        "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
        "code" : "FLD",
        "display" : "field"
      },
      "participant" : [{
        "individual" : {
          "reference" : "Practitioner/example-doctor"
        }
      }],
      "period" : {
        "start" : "2026-06-10T09:00:00+08:00",
        "end" : "2026-06-10T12:00:00+08:00"
      },
      "serviceProvider" : {
        "reference" : "Organization/example-hospital"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Group/example-group-workers",
    "resource" : {
      "resourceType" : "Group",
      "id" : "example-group-workers",
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Group_example-group-workers\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Group example-group-workers</b></p><a name=\"example-group-workers\"> </a><a name=\"hcexample-group-workers\"> </a><p><b>type</b>: Person</p><p><b>actual</b>: true</p><p><b>name</b>: 大同電子化學製造課全體勞工</p></div>"
      },
      "type" : "person",
      "actual" : true,
      "name" : "大同電子化學製造課全體勞工"
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Procedure/example-procedure-activity",
    "resource" : {
      "resourceType" : "Procedure",
      "id" : "example-procedure-activity",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Procedure-ServiceActivity"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Procedure_example-procedure-activity\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Procedure example-procedure-activity</b></p><a name=\"example-procedure-activity\"> </a><a name=\"hcexample-procedure-activity\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Procedure-ServiceActivity.html\">臨場服務執行活動項目 Profile</a></p></div><p><b>雇主事業單位資訊擴充</b>: <a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></p><p><b>status</b>: Completed</p><p><b>code</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ServiceActivityType exam-analysis}\">健康檢查結果分析</span></p><p><b>subject</b>: <a href=\"Group-example-group-workers.html\">Group 大同電子化學製造課全體勞工</a></p></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
        "valueReference" : {
          "reference" : "Organization/example-employer"
        }
      }],
      "status" : "completed",
      "code" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-ServiceActivityType",
          "code" : "exam-analysis",
          "display" : "健康檢查結果分析"
        }]
      },
      "subject" : {
        "reference" : "Group/example-group-workers"
      }
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Observation/example-service-finding",
    "resource" : {
      "resourceType" : "Observation",
      "id" : "example-service-finding",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding"]
      },
      "text" : {
        "status" : "generated",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Observation_example-service-finding\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Observation example-service-finding</b></p><a name=\"example-service-finding\"> </a><a name=\"hcexample-service-finding\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Observation-ServiceFinding.html\">臨場健康服務發現問題/風險 Profile</a></p></div><p><b>status</b>: Final</p><p><b>code</b>: <span title=\"Codes:{http://snomed.info/sct 278486003}\">Occupational health hazard (finding)</span></p><p><b>focus</b>: <a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></p><p><b>value</b>: 發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。</p></div>"
      },
      "status" : "final",
      "code" : {
        "coding" : [{
          "system" : "http://snomed.info/sct",
          "code" : "278486003",
          "display" : "Occupational health hazard (finding)"
        }]
      },
      "focus" : [{
        "reference" : "Organization/example-employer"
      }],
      "valueString" : "發現部分現場勞動條件局部排氣裝置風速異常降低，且現場作業人員於正己烷暴露區域未確實配戴防護面罩。"
    }
  },
  {
    "fullUrl" : "https://twcore.mohw.gov.tw/ig/twha/Task/example-service-task",
    "resource" : {
      "resourceType" : "Task",
      "id" : "example-service-task",
      "meta" : {
        "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Task-ServiceTask"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"Task_example-service-task\"> </a><p class=\"res-header-id\"><b>Generated Narrative: Task example-service-task</b></p><a name=\"example-service-task\"> </a><a name=\"hcexample-service-task\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\"/><p style=\"margin-bottom: 0px\">Profile: <a href=\"StructureDefinition-TWHA-Task-ServiceTask.html\">臨場健康服務建議與改善任務 Profile</a></p></div><p><b>雇主事業單位資訊擴充</b>: <a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></p><p><b>status</b>: Requested</p><p><b>intent</b>: plan</p><p><b>description</b>: 大同電子應於兩週內委託專業廠商維修化學製造現場之局部排氣系統，並落實每日作業前防護具配戴檢查機制。</p><p><b>focus</b>: <a href=\"Observation-example-service-finding.html\">Observation Occupational health hazard (finding)</a></p><p><b>requester</b>: <a href=\"Practitioner-example-doctor.html\">Practitioner 林職醫(official)</a></p><p><b>owner</b>: <a href=\"Organization-example-employer.html\">Organization 大同電子股份有限公司</a></p></div>"
      },
      "extension" : [{
        "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/ext-employer-info",
        "valueReference" : {
          "reference" : "Organization/example-employer"
        }
      }],
      "status" : "requested",
      "intent" : "plan",
      "description" : "大同電子應於兩週內委託專業廠商維修化學製造現場之局部排氣系統，並落實每日作業前防護具配戴檢查機制。",
      "focus" : {
        "reference" : "Observation/example-service-finding"
      },
      "requester" : {
        "reference" : "Practitioner/example-doctor"
      },
      "owner" : {
        "reference" : "Organization/example-employer"
      }
    }
  }]
}

```
