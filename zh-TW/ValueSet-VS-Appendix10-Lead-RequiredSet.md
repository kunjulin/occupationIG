# 附表十 鉛作業 專屬應執行項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.0

## ValueSet: 附表十 鉛作業 專屬應執行項目值集 () 

 
附表十第 5 項鉛作業之家族專屬檢查項目。附表十本文僅列血中鉛；尿中鉛／共聚卟啉／δ-ALA 係職安署特殊健檢細項生物偵測之口徑（非附表十逐字項目），該範疇界定為未決事項 M-11。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。 

 **References** 

* Included into [VS_Appendix10RequiredSet](ValueSet-VS-Appendix10-RequiredSet.md)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-Appendix10-Lead-RequiredSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Lead-RequiredSet",
  "version" : "0.2.0",
  "name" : "VS_Appendix10LeadRequiredSet",
  "title" : "附表十 鉛作業 專屬應執行項目值集",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-05T16:28:11+00:00",
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
  "description" : "附表十第 5 項鉛作業之家族專屬檢查項目。附表十本文僅列血中鉛；尿中鉛／共聚卟啉／δ-ALA 係職安署特殊健檢細項生物偵測之口徑（非附表十逐字項目），該範疇界定為未決事項 M-11。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "77307-7",
        "display" : "Lead [Mass/volume] in Venous blood"
      },
      {
        "code" : "5676-2",
        "display" : "Lead [Mass/volume] in Urine"
      },
      {
        "code" : "11212-8",
        "display" : "Coproporphyrin [Mass/volume] in Urine"
      },
      {
        "code" : "11215-1",
        "display" : "Delta aminolevulinate [Mass/volume] in Urine"
      }]
    }]
  }
}

```
