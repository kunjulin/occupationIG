# 肺功能檢查項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 肺功能檢查項目值集 

 
包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### Expansion

No Expansion for this valueset (not supported by Publication Tooling)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-PulmonaryFunction",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-PulmonaryFunction",
  "version" : "0.1.0",
  "name" : "VS_PulmonaryFunction",
  "title" : "肺功能檢查項目值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-10T21:30:50+08:00",
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
  "description" : "包含常用之肺功能檢查（如 FVC, FEV1, FEV1/FVC 等）的 LOINC 代碼，以供肺功能檢查 Profile 使用。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "19876-2",
        "display" : "Forced vital capacity [Volume] in Airways by Spirometry"
      },
      {
        "code" : "19870-5",
        "display" : "Forced vital capacity [Volume] Respiratory system"
      },
      {
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
      },
      {
        "code" : "20150-9",
        "display" : "Forced expiratory volume in 1 second [Volume] in Airways by Spirometry"
      },
      {
        "code" : "19926-5",
        "display" : "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry"
      },
      {
        "code" : "33439-8",
        "display" : "Left midclavicular line Peak expiratory flow rate"
      },
      {
        "code" : "19911-7",
        "display" : "Carbon monoxide diffusing capacity"
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
