# 不適合從事作業之疾病值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.6.0

## ValueSet: 不適合從事作業之疾病值集 

 
【依據：勞工健康保護規則附表】依據勞工健康保護規則附表十二所列，不適合從事特定特別危害健康作業之疾病代碼值集（以 ICD-10-CM 表示）。 

 **References** 

* [健康檢查既往病史與不適作業疾病 Profile](StructureDefinition-TWHA-Condition.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-UnfitDiseases",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-UnfitDiseases",
  "version" : "0.6.0",
  "name" : "VS_UnfitDiseases",
  "title" : "不適合從事作業之疾病值集",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-20T17:39:23+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】依據勞工健康保護規則附表十二所列，不適合從事特定特別危害健康作業之疾病代碼值集（以 ICD-10-CM 表示）。",
  "compose" : {
    "include" : [{
      "system" : "http://hl7.org/fhir/sid/icd-10-cm"
    }]
  }
}

```
