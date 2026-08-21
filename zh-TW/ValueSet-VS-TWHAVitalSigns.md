# 職業健檢生命徵象項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.7.0

## ValueSet: 職業健檢生命徵象項目值集 

 
【主管機關：國民健康署】包含身高、體重、腰圍及血壓等生理測量項目之 LOINC 代碼。 

 **References** 

* Included into [VS_CoreUploadSet](ValueSet-VS-CoreUploadSet.md)
* [職業健檢生命徵象 Profile](StructureDefinition-TWHA-VitalSigns.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-TWHAVitalSigns",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-TWHAVitalSigns",
  "version" : "0.7.0",
  "name" : "VS_TWHAVitalSigns",
  "title" : "職業健檢生命徵象項目值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-21T00:59:40+00:00",
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
  "description" : "【主管機關：國民健康署】包含身高、體重、腰圍及血壓等生理測量項目之 LOINC 代碼。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "8302-2",
        "display" : "Body height"
      },
      {
        "code" : "3137-7",
        "display" : "Body height Measured"
      },
      {
        "code" : "29463-7",
        "display" : "Body weight"
      },
      {
        "code" : "3141-9",
        "display" : "Body weight Measured"
      },
      {
        "code" : "8280-0",
        "display" : "Waist Circumference at umbilicus by Tape measure"
      },
      {
        "code" : "8480-6",
        "display" : "Systolic blood pressure"
      },
      {
        "code" : "8462-4",
        "display" : "Diastolic blood pressure"
      },
      {
        "code" : "39156-5",
        "display" : "Body mass index (BMI) [Ratio]"
      }]
    }]
  }
}

```
