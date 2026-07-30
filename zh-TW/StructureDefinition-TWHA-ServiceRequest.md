# 健康檢查健檢追蹤檢查要求 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 健康檢查健檢追蹤檢查要求 Profile 

 
針對第三級或需要追蹤之勞工，醫師開立之追蹤檢查或現場評估排程要求，繼承自 TW Core ServiceRequest。 

**Usages:**

* Examples for this Profile: [ServiceRequest/example-servicerequest-followup](ServiceRequest-example-servicerequest-followup.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-ServiceRequest.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-ServiceRequest",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ServiceRequest",
  "version" : "0.2.0",
  "name" : "TWHAServiceRequestProfile",
  "title" : "健康檢查健檢追蹤檢查要求 Profile",
  "status" : "active",
  "date" : "2026-07-30T14:17:56+00:00",
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
  "description" : "針對第三級或需要追蹤之勞工，醫師開立之追蹤檢查或現場評估排程要求，繼承自 TW Core ServiceRequest。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "quick",
    "uri" : "http://siframework.org/cqf",
    "name" : "Quality Improvement and Clinical Knowledge (QUICK)"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ServiceRequest",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/ServiceRequest-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "ServiceRequest",
      "path" : "ServiceRequest"
    },
    {
      "id" : "ServiceRequest.subject",
      "path" : "ServiceRequest.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "ServiceRequest.requester",
      "path" : "ServiceRequest.requester",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    }]
  }
}

```
