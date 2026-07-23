# 健康管理分級值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 健康管理分級值集 

 
包含健康管理分級（第一級至第四級）代碼之值集。 

 **References** 

* [健康檢查健康管理分級 Observation Profile](StructureDefinition-TWHA-HealthManagementLevel.md)
* [健康管理分級擴充](StructureDefinition-ext-health-mgmt-level.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-HealthMgmtLevel",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-HealthMgmtLevel",
  "version" : "0.1.0",
  "name" : "VS_HealthMgmtLevel",
  "title" : "健康管理分級值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-23T22:22:27+08:00",
  "publisher" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
  "contact" : [{
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  },
  {
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  }],
  "description" : "包含健康管理分級（第一級至第四級）代碼之值集。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-HealthMgmtLevel"
    }]
  }
}

```
