# 附表十特別危害健康作業值集（35 項） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 附表十特別危害健康作業值集（35 項） 

 
包含《勞工健康保護規則》附表十 35 項法定具名作業之代碼。 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-Appendix10-Operation",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Operation",
  "version" : "0.1.0",
  "name" : "VS_Appendix10Operation",
  "title" : "附表十特別危害健康作業值集（35 項）",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26T10:07:44+08:00",
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
  "description" : "包含《勞工健康保護規則》附表十 35 項法定具名作業之代碼。",
  "compose" : {
    "include" : [{
      "system" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-Appendix10Operation"
    }]
  }
}

```
