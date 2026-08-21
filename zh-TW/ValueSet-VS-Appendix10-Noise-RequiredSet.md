# 附表十 噪音作業 專屬應執行項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.1

## ValueSet: 附表十 噪音作業 專屬應執行項目值集 (實驗性) 

 
【依據：勞工健康保護規則附表】附表十第 2 項噪音作業之家族專屬檢查項目（純音聽力）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。 

 **References** 

* Included into [VS_Appendix10RequiredSet](ValueSet-VS-Appendix10-RequiredSet.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-Appendix10-Noise-RequiredSet",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Noise-RequiredSet",
  "version" : "0.7.1",
  "name" : "VS_Appendix10NoiseRequiredSet",
  "title" : "附表十 噪音作業 專屬應執行項目值集",
  "status" : "draft",
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
  "description" : "【依據：勞工健康保護規則附表】附表十第 2 項噪音作業之家族專屬檢查項目（純音聽力）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "89015-2",
        "display" : "Pure tone air conduction threshold audiometry panel"
      }]
    }]
  }
}

```
