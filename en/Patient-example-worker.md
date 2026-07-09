# 受檢勞工範例 - 王大同 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Example Patient: 受檢勞工範例 - 王大同

Profile: [受檢者 Profile](StructureDefinition-TWHA-Patient.md)

王大同(official) Male, DoB: 1985-05-15 ( Medical record number: MR-98765 (use: official, ))

-------

| | |
| :--- | :--- |
| Active: | true |
| [部門/課別擴充](StructureDefinition-ext-department.md) | 化學處理課 |
| [受僱日期擴充](StructureDefinition-ext-employment-date.md) | 2020-03-01 |
| [雇主事業單位資訊擴充](StructureDefinition-ext-employer-info.md) | [Organization 大同電子股份有限公司](Organization-example-employer.md) |



## Resource Content

```json
{
  "resourceType" : "Patient",
  "id" : "example-worker",
  "meta" : {
    "profile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
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

```
