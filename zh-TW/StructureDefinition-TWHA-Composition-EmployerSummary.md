# 雇主端健康管理摘要 Composition Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 雇主端健康管理摘要 Composition Profile 

 
雇主端／職安人員健康管理摘要（Employer Health Management Summary）。落實 security.md 之角色存取控制：雇主僅得取得**健康管理分級、適性配工建議與臨場服務發現**，**不得**取得檢驗數值。以 **closed section slicing** 結構性保證本摘要不含檢驗／影像 section；各 section 之 entry 以 profile 限定，檢驗類 Observation／DiagnosticReport 無從置入。此為欄位級隔離之可驗證機制，取代僅以文字宣示之做法（SMART scope 難達欄位級隔離，見 security.md §2）。存取控制之實作機制（scope／Consent／端點）屬平台端決定，見未決事項 M-10。 

**Usages:**

* Examples for this Profile: [Composition/example-composition-employer-summary](Composition-example-composition-employer-summary.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition-EmployerSummary.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 5 elements(1 nested mandatory element)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)
* [健康檢查健康管理分級 Observation Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel)](StructureDefinition-TWHA-HealthManagementLevel.md)
* [健康檢查健檢醫師總評與分級 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression)](StructureDefinition-TWHA-ClinicalImpression.md)
* [健康檢查適性配工計畫 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan)](StructureDefinition-TWHA-CarePlan.md)
* [臨場健康服務發現問題/風險 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding)](StructureDefinition-TWHA-Observation-ServiceFinding.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section (Closed)

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 5 elements(1 nested mandatory element)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)
* [實施健康檢查之醫療機構 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility)](StructureDefinition-TWHA-Organization-Facility.md)
* [健康檢查健康管理分級 Observation Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel)](StructureDefinition-TWHA-HealthManagementLevel.md)
* [健康檢查健檢醫師總評與分級 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression)](StructureDefinition-TWHA-ClinicalImpression.md)
* [健康檢查適性配工計畫 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan)](StructureDefinition-TWHA-CarePlan.md)
* [臨場健康服務發現問題/風險 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding)](StructureDefinition-TWHA-Observation-ServiceFinding.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section (Closed)

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition-EmployerSummary",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmployerSummary",
  "version" : "0.2.0",
  "name" : "TWHACompositionEmployerSummaryProfile",
  "title" : "雇主端健康管理摘要 Composition Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-29T16:54:28+00:00",
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
  "description" : "雇主端／職安人員健康管理摘要（Employer Health Management Summary）。落實 security.md 之角色存取控制：雇主僅得取得**健康管理分級、適性配工建議與臨場服務發現**，**不得**取得檢驗數值。以 **closed section slicing** 結構性保證本摘要不含檢驗／影像 section；各 section 之 entry 以 profile 限定，檢驗類 Observation／DiagnosticReport 無從置入。此為欄位級隔離之可驗證機制，取代僅以文字宣示之做法（SMART scope 難達欄位級隔離，見 security.md §2）。存取控制之實作機制（scope／Consent／端點）屬平台端決定，見未決事項 M-10。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "fhirdocumentreference",
    "uri" : "http://hl7.org/fhir/documentreference",
    "name" : "FHIR DocumentReference"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Composition",
  "baseDefinition" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Composition-twcore",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Composition",
      "path" : "Composition"
    },
    {
      "id" : "Composition.status",
      "path" : "Composition.status",
      "patternCode" : "final"
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Composition.author",
      "path" : "Composition.author",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Organization-Facility"]
      }]
    },
    {
      "id" : "Composition.section",
      "path" : "Composition.section",
      "slicing" : {
        "discriminator" : [{
          "type" : "pattern",
          "path" : "code"
        }],
        "ordered" : false,
        "rules" : "closed"
      },
      "min" : 1
    },
    {
      "id" : "Composition.section:healthManagement",
      "path" : "Composition.section",
      "sliceName" : "healthManagement",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:healthManagement.title",
      "path" : "Composition.section.title",
      "patternString" : "健康管理分級與適性配工建議"
    },
    {
      "id" : "Composition.section:healthManagement.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "51848-0"
        }]
      }
    },
    {
      "id" : "Composition.section:healthManagement.entry",
      "path" : "Composition.section.entry",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-HealthManagementLevel",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-ClinicalImpression",
        "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-CarePlan"]
      }]
    },
    {
      "id" : "Composition.section:serviceFindings",
      "path" : "Composition.section",
      "sliceName" : "serviceFindings",
      "min" : 0,
      "max" : "*"
    },
    {
      "id" : "Composition.section:serviceFindings.title",
      "path" : "Composition.section.title",
      "patternString" : "臨場服務發現問題"
    },
    {
      "id" : "Composition.section:serviceFindings.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "29554-3"
        }]
      }
    },
    {
      "id" : "Composition.section:serviceFindings.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Observation-ServiceFinding"]
      }]
    }]
  }
}

```
