# 臨場服務事件範例 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Encounter: 臨場服務事件範例

Profile: [臨場健康服務事件 Profile](StructureDefinition-TWHA-Encounter-Service.md)

**雇主事業單位資訊擴充**: [Organization 大同電子股份有限公司](Organization-example-employer.md)

**部門/課別擴充**: 化學製造現場

**status**: Finished

**class**: [v3 Code System ActCode: FLD](http://hl7.org/fhir/R4/v3/ActCode/cs.html#v3-ActCode-FLD) (field)

### Participants

| | |
| :--- | :--- |
| - | **Individual** |
| * | [Practitioner 林職醫(official)](Practitioner-example-doctor.md) |

**period**: 2026-06-10 09:00:00+0800 --> 2026-06-10 12:00:00+0800

**serviceProvider**: [Organization 交通部民用航空局航空醫務中心](Organization-example-hospital.md)



## Resource Content

```json
{
  "resourceType" : "Encounter",
  "id" : "example-encounter-service",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Encounter-Service"]
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

```
