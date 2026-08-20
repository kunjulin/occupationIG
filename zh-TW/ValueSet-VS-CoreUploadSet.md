# 主管機關最小共通上傳集（國健署原案 21 列，跨值集群組） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## ValueSet: 主管機關最小共通上傳集（國健署原案 21 列，跨值集群組） 

 
群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳之量／年／戒除年由臺灣癌症登記短表 IG（TWCR_SF, fhir.TWCRSF#0.1.1）之值集承載（sf-BetNutChewAmount／sf-BetNutChewYear／sf-BetNutChewQuit，required 綁定，見 TWHA-SocialHistory-BetelNut），非本 IG 自訂，亦非無碼；LOINC／SNOMED 就此無對應碼故採國內值集。注意上游以「年」計，與吸菸之戒除「月數」（LNC#63632-4）單位不同。 

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
  "id" : "VS-CoreUploadSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreUploadSet",
  "version" : "0.3.3",
  "name" : "VS_CoreUploadSet",
  "title" : "主管機關最小共通上傳集（國健署原案 21 列，跨值集群組）",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-20T12:04:33+00:00",
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
  "description" : "群組值集：組合 Core 之檢驗子集（VS-CoreDataset）、生理量測（VS-TWHAVitalSigns）與社會史碼，具體化主管機關（國健署）制定之最小共通上傳集（原案 16 主項／21 列，對標 USCDI regulator-defined minimum）。僅供文件與完整度／覆蓋矩陣機器核對，不作 Observation.code 綁定。嚼檳之量／年／戒除年由臺灣癌症登記短表 IG（TWCR_SF, fhir.TWCRSF#0.1.1）之值集承載（sf-BetNutChewAmount／sf-BetNutChewYear／sf-BetNutChewQuit，required 綁定，見 TWHA-SocialHistory-BetelNut），非本 IG 自訂，亦非無碼；LOINC／SNOMED 就此無對應碼故採國內值集。注意上游以「年」計，與吸菸之戒除「月數」（LNC#63632-4）單位不同。",
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
