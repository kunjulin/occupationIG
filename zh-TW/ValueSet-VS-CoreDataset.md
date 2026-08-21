# 健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## ValueSet: 健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集） 

 
【主管機關：國民健康署】Core 之檢驗子集（主管機關（國健署）最小共通上傳集之 Observation.code 綁定值集，綁定強度 extensible）。僅收錄 Core 之 10 檢驗項 preferred code 及其 acceptable 變異碼；生理量測（身高/體重/腰圍/血壓）碼分屬 VS-TWHAVitalSigns、社會史（吸菸/嚼檳）碼分屬 SocialHistory profile。Core 全集（21 列）之群組見 VS-CoreUploadSet。acceptable→preferred 歸一見 ConceptMap TWHealthCheckLaboratoryMap。 

 **References** 

* Included into [VS_CoreUploadSet](ValueSet-VS-CoreUploadSet.md)
* [一般健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-General.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-CoreDataset",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset",
  "version" : "0.9.0",
  "name" : "VS_CoreDataset",
  "title" : "健康檢查核心檢驗項目值集（主管機關最小上傳集之檢驗子集）",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【主管機關：國民健康署】Core 之檢驗子集（主管機關（國健署）最小共通上傳集之 Observation.code 綁定值集，綁定強度 extensible）。僅收錄 Core 之 10 檢驗項 preferred code 及其 acceptable 變異碼；生理量測（身高/體重/腰圍/血壓）碼分屬 VS-TWHAVitalSigns、社會史（吸菸/嚼檳）碼分屬 SocialHistory profile。Core 全集（21 列）之群組見 VS-CoreUploadSet。acceptable→preferred 歸一見 ConceptMap TWHealthCheckLaboratoryMap。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "35200-5",
        "display" : "Cholesterol [Mass or Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "1558-6",
        "display" : "Fasting glucose [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2339-0",
        "display" : "Glucose [Mass/volume] in Blood"
      },
      {
        "code" : "2345-7",
        "display" : "Glucose [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3043-7",
        "display" : "Triglyceride [Mass/volume] in Blood"
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
        "code" : "13457-7",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
      },
      {
        "code" : "18262-6",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
      },
      {
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "38483-4",
        "display" : "Creatinine [Mass/volume] in Blood"
      },
      {
        "code" : "2888-6",
        "display" : "Protein [Mass/volume] in Urine"
      },
      {
        "code" : "5804-0",
        "display" : "Protein [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "57735-3",
        "display" : "Protein [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "5196-1",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "5195-3",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum"
      },
      {
        "code" : "63557-3",
        "display" : "Hepatitis B virus surface Ag [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "13955-0",
        "display" : "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "16128-1",
        "display" : "Hepatitis C virus Ab [Presence] in Serum"
      }]
    }]
  }
}

```
