# 附表十 特殊健康檢查應執行項目值集（已落地家族） - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

## ValueSet: 附表十 特殊健康檢查應執行項目值集（已落地家族） (實驗性) 

 
【依據：勞工健康保護規則附表】附表十特別危害健康作業之家族專屬應執行項目 grouping 值集。**目前僅含已通過術語稽核之四家族**（噪音／鉛／粉塵／有機溶劑）；其餘八家族之專屬代碼待臨床確認後擴充（見 special-exam.md 涵蓋表與未決事項 M-8）。任一家族之完整情境需求 ＝ 本 grouping 對應子集 ∪ VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。 

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
  "id" : "VS-Appendix10-RequiredSet",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-RequiredSet",
  "version" : "0.8.1",
  "name" : "VS_Appendix10RequiredSet",
  "title" : "附表十 特殊健康檢查應執行項目值集（已落地家族）",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-21T04:20:36+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】附表十特別危害健康作業之家族專屬應執行項目 grouping 值集。**目前僅含已通過術語稽核之四家族**（噪音／鉛／粉塵／有機溶劑）；其餘八家族之專屬代碼待臨床確認後擴充（見 special-exam.md 涵蓋表與未決事項 M-8）。任一家族之完整情境需求 ＝ 本 grouping 對應子集 ∪ VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。",
  "compose" : {
    "include" : [{
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Noise-RequiredSet"]
    },
    {
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Lead-RequiredSet"]
    },
    {
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-Dust-RequiredSet"]
    },
    {
      "valueSet" : ["https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-OrganicSolvent-RequiredSet"]
    }]
  }
}

```
