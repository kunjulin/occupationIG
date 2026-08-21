# 嚼檳榔歷史與狀態 Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.1

## 資源 Profile: 嚼檳榔歷史與狀態 Profile ( 實驗性 ) 

 
【主管機關：國民健康署】用於記錄勞工之嚼檳榔狀態與量化資料。狀態以 `value[x]` 承載（值集 VS-BetelNutStatus，與吸菸之 CS-SmokingStatus 逐碼對稱）；每日嚼食量、嚼食年數與戒除期間以 `component` 之 `Quantity` 承載（UCUM）。上游臺灣癌症登記短表 (TWCR_SF) 之級距碼降為可選 component（extensible），供與癌症登記勾稽。 

**Usages:**

* Examples for this Profile: [Observation/obs-betelnut-current](Observation-obs-betelnut-current.md), [Observation/obs-betelnut-never](Observation-obs-betelnut-never.md) and [Observation/obs-betelnut](Observation-obs-betelnut.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-SocialHistory-BetelNut.json)

### Profile 內容之正式檢視

 [差異表、快照表與其他表示法之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [重點元素表](#tabs-key) 
*  [差異表](#tabs-diff) 
*  [快照表](#tabs-snap) 
*  [統計／參照](#tabs-summ) 
*  [全部](#tabs-all) 

#### Terminology Bindings

#### Constraints

#### Terminology Bindings (Differential)

#### Constraints

#### Terminology Bindings

#### Constraints

** Summary **

Must-Support: 3 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.component

 **重點元素檢視** 

#### Terminology Bindings

#### Constraints

 **差異檢視** 

#### Terminology Bindings (Differential)

#### Constraints

 **快照檢視View** 

#### Terminology Bindings

#### Constraints

** Summary **

Must-Support: 3 elements

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Observation.component

 

本 Profile 之其他表示法： [CSV](../StructureDefinition-TWHA-SocialHistory-BetelNut.csv), [Excel](../StructureDefinition-TWHA-SocialHistory-BetelNut.xlsx), [Schematron](../StructureDefinition-TWHA-SocialHistory-BetelNut.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-SocialHistory-BetelNut",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut",
  "version" : "0.7.1",
  "name" : "TWHASocialHistoryBetelNutProfile",
  "title" : "嚼檳榔歷史與狀態 Profile",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-21T01:22:55+00:00",
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
  "description" : "【主管機關：國民健康署】用於記錄勞工之嚼檳榔狀態與量化資料。狀態以 `value[x]` 承載（值集 VS-BetelNutStatus，與吸菸之 CS-SmokingStatus 逐碼對稱）；每日嚼食量、嚼食年數與戒除期間以 `component` 之 `Quantity` 承載（UCUM）。上游臺灣癌症登記短表 (TWCR_SF) 之級距碼降為可選 component（extensible），供與癌症登記勾稽。",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "sct-concept",
    "uri" : "http://snomed.info/conceptdomain",
    "name" : "SNOMED CT Concept Domain Binding"
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
    "identity" : "sct-attr",
    "uri" : "http://snomed.org/attributebinding",
    "name" : "SNOMED CT Attribute Binding"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Observation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Observation",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Observation",
      "path" : "Observation",
      "constraint" : [{
        "key" : "twha-obs-1",
        "severity" : "error",
        "human" : "Observation 必須包含測量值 (value) 或資料缺失原因 (dataAbsentReason) 或分項測量值 (component)",
        "expression" : "value.exists() or dataAbsentReason.exists() or component.exists()",
        "source" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-SocialHistory-BetelNut"
      }]
    },
    {
      "id" : "Observation.status",
      "path" : "Observation.status",
      "patternCode" : "final"
    },
    {
      "id" : "Observation.category",
      "path" : "Observation.category",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/observation-category",
          "code" : "social-history"
        }]
      }
    },
    {
      "id" : "Observation.code",
      "path" : "Observation.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://snomed.info/sct",
          "code" : "698188003",
          "display" : "Chews betel quid"
        }]
      }
    },
    {
      "id" : "Observation.subject",
      "path" : "Observation.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient"]
      }]
    },
    {
      "id" : "Observation.performer",
      "path" : "Observation.performer",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
      }]
    },
    {
      "id" : "Observation.value[x]",
      "path" : "Observation.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutStatus"
      }
    },
    {
      "id" : "Observation.component",
      "path" : "Observation.component",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "code"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Observation.component:amount",
      "path" : "Observation.component",
      "sliceName" : "amount",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.component:amount.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "amount",
          "display" : "每日嚼食量"
        }]
      }
    },
    {
      "id" : "Observation.component:amount.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:amount.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:amount.value[x].code",
      "path" : "Observation.component.value[x].code",
      "patternCode" : "{quid}/d"
    },
    {
      "id" : "Observation.component:durationYears",
      "path" : "Observation.component",
      "sliceName" : "durationYears",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.component:durationYears.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "duration-years",
          "display" : "嚼食持續期間"
        }]
      }
    },
    {
      "id" : "Observation.component:durationYears.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:durationYears.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:durationYears.value[x].code",
      "path" : "Observation.component.value[x].code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-TimeUnitYearMonth"
      }
    },
    {
      "id" : "Observation.component:cessationDuration",
      "path" : "Observation.component",
      "sliceName" : "cessationDuration",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.component:cessationDuration.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "cessation-duration",
          "display" : "戒除期間"
        }]
      }
    },
    {
      "id" : "Observation.component:cessationDuration.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "Quantity"
      }]
    },
    {
      "id" : "Observation.component:cessationDuration.value[x].system",
      "path" : "Observation.component.value[x].system",
      "patternUri" : "http://unitsofmeasure.org"
    },
    {
      "id" : "Observation.component:cessationDuration.value[x].code",
      "path" : "Observation.component.value[x].code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-TimeUnitYearMonth"
      }
    },
    {
      "id" : "Observation.component:cessationDate",
      "path" : "Observation.component",
      "sliceName" : "cessationDate",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:cessationDate.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "cessation-date",
          "display" : "戒除日期"
        }]
      }
    },
    {
      "id" : "Observation.component:cessationDate.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "Observation.component:withTobacco",
      "path" : "Observation.component",
      "sliceName" : "withTobacco",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:withTobacco.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "with-tobacco",
          "display" : "是否含菸草"
        }]
      }
    },
    {
      "id" : "Observation.component:withTobacco.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "boolean"
      }]
    },
    {
      "id" : "Observation.component:additive",
      "path" : "Observation.component",
      "sliceName" : "additive",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:additive.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "additive",
          "display" : "添加物"
        }]
      }
    },
    {
      "id" : "Observation.component:additive.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutAdditive"
      }
    },
    {
      "id" : "Observation.component:lime",
      "path" : "Observation.component",
      "sliceName" : "lime",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:lime.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "lime",
          "display" : "石灰種類"
        }]
      }
    },
    {
      "id" : "Observation.component:lime.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutLime"
      }
    },
    {
      "id" : "Observation.component:informationSource",
      "path" : "Observation.component",
      "sliceName" : "informationSource",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:informationSource.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "48766-0",
          "display" : "Information source"
        }]
      }
    },
    {
      "id" : "Observation.component:informationSource.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutInfoSource"
      }
    },
    {
      "id" : "Observation.component:hpaCategory",
      "path" : "Observation.component",
      "sliceName" : "hpaCategory",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:hpaCategory.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "hpa-category",
          "display" : "口腔黏膜檢查表級距"
        }]
      }
    },
    {
      "id" : "Observation.component:hpaCategory.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-BetelNutHpaCategory"
      }
    },
    {
      "id" : "Observation.component:amountCoded",
      "path" : "Observation.component",
      "sliceName" : "amountCoded",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Observation.component:amountCoded.code",
      "path" : "Observation.component.code",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
          "code" : "amount-coded",
          "display" : "每日嚼食量（上游級距碼）"
        }]
      }
    },
    {
      "id" : "Observation.component:amountCoded.value[x]",
      "path" : "Observation.component.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewAmount-valueset"
      }
    }]
  }
}

```
