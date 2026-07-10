# Submit Bundle Operation - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## OperationDefinition: Submit Bundle Operation 



## Resource Content

```json
{
  "resourceType" : "OperationDefinition",
  "id" : "Bundle-submit",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit",
  "version" : "0.1.0",
  "name" : "Submit",
  "title" : "Submit Bundle Operation",
  "status" : "active",
  "kind" : "operation",
  "date" : "2026-07-10T19:56:53+08:00",
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
  "code" : "submit",
  "resource" : ["Bundle"],
  "system" : false,
  "type" : true,
  "instance" : false,
  "parameter" : [{
    "name" : "content",
    "use" : "in",
    "min" : 1,
    "max" : "1",
    "type" : "Bundle"
  }]
}

```
