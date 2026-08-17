# 附表十 粉塵作業 專屬應執行項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.5

## ValueSet: 附表十 粉塵作業 專屬應執行項目值集 (實驗性) 

 
附表十第 23 項粉塵作業之家族專屬檢查項目（胸部 X 光與肺功能）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。 

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
  "id" : "VS-Appendix10-Dust-RequiredSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Dust-RequiredSet",
  "version" : "0.2.5",
  "name" : "VS_Appendix10DustRequiredSet",
  "title" : "附表十 粉塵作業 專屬應執行項目值集",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-17T06:57:01+00:00",
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
  "description" : "附表十第 23 項粉塵作業之家族專屬檢查項目（胸部 X 光與肺功能）。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "36643-5",
        "display" : "XR Chest 2 Views"
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
      }]
    }]
  }
}

```
