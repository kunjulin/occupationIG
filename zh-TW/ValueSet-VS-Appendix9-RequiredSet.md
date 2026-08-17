# 附表九 一般健康檢查法定應執行項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.5

## ValueSet: 附表九 一般健康檢查法定應執行項目值集 (實驗性) 

 
《勞工健康保護規則》附表九所列一般體格／健康檢查之法定應執行**檢驗與量測**項目（以健康檢查欄為準，含 LDL-C）。非檢驗項目（作業經歷、既往病史、生活習慣、自覺症狀、身體各系統理學檢查）以 TWHA-Occupation／TWHA-Condition／SocialHistory／TWHA-PhysicalExam 承載，不列為本值集成員。用於法定完整性稽核，非 profile 之 element binding。所有代碼均取自已通過術語稽核之既有內容。⚠️ 紅血球數（789-8）與 MCV（787-2）係 115.06.26 修正新增；repo 內附表九 PDF 為修正前版本，該二項無 repo 內原文可逐項核對，見未決事項 M-11。 

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
  "id" : "VS-Appendix9-RequiredSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix9-RequiredSet",
  "version" : "0.2.5",
  "name" : "VS_Appendix9RequiredSet",
  "title" : "附表九 一般健康檢查法定應執行項目值集",
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
  "description" : "《勞工健康保護規則》附表九所列一般體格／健康檢查之法定應執行**檢驗與量測**項目（以健康檢查欄為準，含 LDL-C）。非檢驗項目（作業經歷、既往病史、生活習慣、自覺症狀、身體各系統理學檢查）以 TWHA-Occupation／TWHA-Condition／SocialHistory／TWHA-PhysicalExam 承載，不列為本值集成員。用於法定完整性稽核，非 profile 之 element binding。所有代碼均取自已通過術語稽核之既有內容。⚠️ 紅血球數（789-8）與 MCV（787-2）係 115.06.26 修正新增；repo 內附表九 PDF 為修正前版本，該二項無 repo 內原文可逐項核對，見未決事項 M-11。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "8302-2",
        "display" : "Body height"
      },
      {
        "code" : "29463-7",
        "display" : "Body weight"
      },
      {
        "code" : "8280-0",
        "display" : "Waist Circumference at umbilicus by Tape measure"
      },
      {
        "code" : "85354-9",
        "display" : "Blood pressure panel with all children optional"
      },
      {
        "code" : "98497-1",
        "display" : "Visual acuity panel"
      },
      {
        "code" : "89015-2",
        "display" : "Pure tone air conduction threshold audiometry panel"
      },
      {
        "code" : "5804-0",
        "display" : "Protein [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "5794-3",
        "display" : "Hemoglobin [Presence] in Urine by Test strip"
      },
      {
        "code" : "718-7",
        "display" : "Hemoglobin [Mass/volume] in Blood"
      },
      {
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "789-8",
        "display" : "Erythrocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "787-2",
        "display" : "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
      },
      {
        "code" : "1558-6",
        "display" : "Fasting glucose [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2085-9",
        "display" : "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "24648-8",
        "display" : "XR Chest PA upright"
      }]
    }]
  }
}

```
