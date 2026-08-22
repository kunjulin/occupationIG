# 肺功能檢查項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.1

## ValueSet: 肺功能檢查項目值集 

 
【依據：勞工健康保護規則附表】包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。 

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
  "id" : "VS-PulmonaryFunction",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-PulmonaryFunction",
  "version" : "0.10.1",
  "name" : "VS_PulmonaryFunction",
  "title" : "肺功能檢查項目值集",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-22T08:31:54+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
      },
      {
        "code" : "19870-5",
        "display" : "Forced vital capacity [Volume] Respiratory system"
      },
      {
        "code" : "19876-2",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation"
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
        "code" : "19935-6",
        "display" : "Maximum expiratory gas flow Respiratory system airway by Peak flow meter"
      },
      {
        "code" : "19911-7",
        "display" : "Diffusion capacity.carbon monoxide"
      },
      {
        "code" : "19862-2",
        "display" : "Total lung capacity"
      },
      {
        "code" : "20146-7",
        "display" : "Residual volume"
      }]
    }]
  }
}

```
