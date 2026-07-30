# 職業健康急診友善摘要 Composition Profile - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## : 職業健康急診友善摘要 Composition Profile 

 
職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用。 
**定位**：本 Profile 為**按需產生之臨床摘要原型（prototype）**，屬工作小組建議方案，**非正式交換要求**；俟臨床測試與回饋後再確認其範圍與必填欄位。 
**使用限制（負向表列，實作與臨床使用時必須遵守）**： 
1. **本摘要不取代急診臨床評估**：所載資料為既有健檢紀錄之彙整，不構成診斷或處置建議，急診決策仍應以當下臨床評估為準。
1. **舊值必須顯示資料日期與來源機構**：所引用之每筆檢驗／量測結果，均須可辨識其`effectiveDateTime`與`performer`／來源機構；未標示日期與來源之數值不得呈現。
1. **無資料不等於無暴露**：本摘要未列出某項危害暴露，僅表示系統中無相關紀錄，**不得推論該勞工未曾暴露**；必要時仍應詢問病史。
1. **受檢者自述與機構驗證資料必須可區分**：以問卷／自述取得之資訊（如 QuestionnaireResponse）與經醫療機構檢驗驗證之結果，須於呈現時明確區分，不得混同陳列。
 

**Usages:**

* Examples for this Profile: [Composition/composition-emergency-summary](Composition-composition-emergency-summary.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mohw.tw.twha|current/StructureDefinition/StructureDefinition-TWHA-Composition-EmergencySummary.json)

### 

 . 

*   
*   
*   
*   

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 4 elements(3 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section

 **View** 

#### Terminology Bindings

#### Constraints

** Summary **

Mandatory: 4 elements(3 nested mandatory elements)

**Structures**

This structure refers to these other structures:

* [受檢者 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Patient)](StructureDefinition-TWHA-Patient.md)
* [執業/健檢醫護與服務人員 Profile (https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner)](StructureDefinition-TWHA-Practitioner.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the values of Composition.section

 

 ,  



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "TWHA-Composition-EmergencySummary",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Composition-EmergencySummary",
  "version" : "0.2.0",
  "name" : "TWHACompositionEmergencySummaryProfile",
  "title" : "職業健康急診友善摘要 Composition Profile",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-30T14:46:31+00:00",
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
  "description" : "職業健康急診友善摘要（Occupational Health Emergency Summary）。當勞工於急診就醫時，供急診醫師快速掌握其特別危害作業暴露史、關鍵生命徵象與檢驗值、以及健康管理分級。以 Composition 承載，將既有之暴露史（TWHA-WorkExposure）、生命徵象、CBC／肝腎功能等關鍵檢驗與總評分級以 section.entry 引用。\n\n**定位**：本 Profile 為**按需產生之臨床摘要原型（prototype）**，屬工作小組建議方案，**非正式交換要求**；俟臨床測試與回饋後再確認其範圍與必填欄位。\n\n**使用限制（負向表列，實作與臨床使用時必須遵守）**：\n1. **本摘要不取代急診臨床評估**：所載資料為既有健檢紀錄之彙整，不構成診斷或處置建議，急診決策仍應以當下臨床評估為準。\n2. **舊值必須顯示資料日期與來源機構**：所引用之每筆檢驗／量測結果，均須可辨識其 `effectiveDateTime` 與 `performer`／來源機構；未標示日期與來源之數值不得呈現。\n3. **無資料不等於無暴露**：本摘要未列出某項危害暴露，僅表示系統中無相關紀錄，**不得推論該勞工未曾暴露**；必要時仍應詢問病史。\n4. **受檢者自述與機構驗證資料必須可區分**：以問卷／自述取得之資訊（如 QuestionnaireResponse）與經醫療機構檢驗驗證之結果，須於呈現時明確區分，不得混同陳列。",
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
      "id" : "Composition.type",
      "path" : "Composition.type",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "60591-5",
          "display" : "Patient summary Document"
        }]
      }
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
        "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Practitioner"]
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
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "Composition.section:exposureHistory",
      "path" : "Composition.section",
      "sliceName" : "exposureHistory",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Composition.section:exposureHistory.title",
      "path" : "Composition.section.title",
      "patternString" : "作業與暴露史"
    },
    {
      "id" : "Composition.section:exposureHistory.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11341-5"
        }]
      }
    },
    {
      "id" : "Composition.section:exposureHistory.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:vitalSigns",
      "path" : "Composition.section",
      "sliceName" : "vitalSigns",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:vitalSigns.title",
      "path" : "Composition.section.title",
      "patternString" : "生命徵象"
    },
    {
      "id" : "Composition.section:vitalSigns.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "8716-3"
        }]
      }
    },
    {
      "id" : "Composition.section:vitalSigns.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation"]
      }]
    },
    {
      "id" : "Composition.section:keyLabs",
      "path" : "Composition.section",
      "sliceName" : "keyLabs",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:keyLabs.title",
      "path" : "Composition.section.title",
      "patternString" : "關鍵檢驗值（CBC／肝腎功能／暴露生物指標）"
    },
    {
      "id" : "Composition.section:keyLabs.code",
      "path" : "Composition.section.code",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "30954-2"
        }]
      }
    },
    {
      "id" : "Composition.section:keyLabs.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/DiagnosticReport"]
      }]
    },
    {
      "id" : "Composition.section:assessment",
      "path" : "Composition.section",
      "sliceName" : "assessment",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Composition.section:assessment.title",
      "path" : "Composition.section.title",
      "patternString" : "健康管理分級與急診注意事項"
    },
    {
      "id" : "Composition.section:assessment.code",
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
      "id" : "Composition.section:assessment.entry",
      "path" : "Composition.section.entry",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/ClinicalImpression",
        "http://hl7.org/fhir/StructureDefinition/CarePlan"]
      }]
    }]
  }
}

```
