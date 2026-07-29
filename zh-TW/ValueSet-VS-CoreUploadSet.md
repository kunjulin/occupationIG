# 主管機關最小共通上傳集（國健署原案 21 列，跨值集群組） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 主管機關最小共通上傳集（國健署原案 21 列，跨值集群組） 

 
群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳量／嚼檳月數屬本地 Extension（ext-betelnut-quantity），無國際碼，於文件註記。 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### 

-------

 . 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-CoreUploadSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreUploadSet",
  "version" : "0.1.0",
  "name" : "VS_CoreUploadSet",
  "title" : "主管機關最小共通上傳集（國健署原案 21 列，跨值集群組）",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-29T09:46:30+00:00",
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
  "description" : "群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳量／嚼檳月數屬本地 Extension（ext-betelnut-quantity），無國際碼，於文件註記。",
  "compose" : {
    "include" : [{
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset"]
    },
    {
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-TWHAVitalSigns"]
    },
    {
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "72166-2"
      },
      {
        "code" : "64218-1"
      },
      {
        "code" : "63632-4"
      }]
    },
    {
      "system" : "http://snomed.info/sct",
      "concept" : [{
        "code" : "698188003"
      }]
    }]
  }
}

```
