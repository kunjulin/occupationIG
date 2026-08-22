# 勞工健康檢查法定必驗項目值集（第一期草案） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.3

## ValueSet: 勞工健康檢查法定必驗項目值集（第一期草案） (實驗性) 

 
【依據：勞工健康保護規則附表】第一期法定必驗之勞工健康檢查項目草案子集，涵蓋附表九一般必驗生理量測與實驗室項目，以及噪音／鉛／粉塵三模組之核心必驗代碼。此為初版草案，範疇待附表九/十逐項法規盤點確認後修訂。 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-OccHealthCheck-Required",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-OccHealthCheck-Required",
  "version" : "0.10.3",
  "name" : "VS_OccHealthCheckRequired",
  "title" : "勞工健康檢查法定必驗項目值集（第一期草案）",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-22T17:09:34+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】第一期法定必驗之勞工健康檢查項目草案子集，涵蓋附表九一般必驗生理量測與實驗室項目，以及噪音／鉛／粉塵三模組之核心必驗代碼。此為初版草案，範疇待附表九/十逐項法規盤點確認後修訂。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "8302-2",
        "display" : "Body height"
      },
      {
        "code" : "29463-7",
        "display" : "Body weight"
      },
      {
        "code" : "85354-9",
        "display" : "Blood pressure panel with all children optional"
      },
      {
        "code" : "1558-6",
        "display" : "Fasting glucose [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2085-9",
        "display" : "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5804-0",
        "display" : "Protein [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "718-7",
        "display" : "Hemoglobin [Mass/volume] in Blood"
      },
      {
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "789-8",
        "display" : "Erythrocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "787-2",
        "display" : "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
      },
      {
        "code" : "89015-2",
        "display" : "Pure tone air conduction threshold audiometry panel"
      },
      {
        "code" : "77307-7",
        "display" : "Lead [Mass/volume] in Venous blood"
      },
      {
        "code" : "23749-5",
        "display" : "Lead [Mass/volume] in Specimen"
      },
      {
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
      },
      {
        "code" : "20150-9",
        "display" : "FEV1"
      },
      {
        "code" : "19926-5",
        "display" : "FEV1/FVC"
      },
      {
        "code" : "36643-5",
        "display" : "XR Chest 2 Views"
      }]
    }]
  }
}

```
