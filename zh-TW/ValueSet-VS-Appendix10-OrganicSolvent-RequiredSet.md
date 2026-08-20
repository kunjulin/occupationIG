# 附表十 有機溶劑作業 專屬應執行項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

## ValueSet: 附表十 有機溶劑作業 專屬應執行項目值集 (實驗性) 

 
【依據：勞工健康保護規則附表】附表十第 7–12、33–35 項有機溶劑類作業之家族專屬檢查項目：各作業之尿中生物偵測代謝物與肝功能。⚠️ 附表十本文對此類作業僅列肝功能（ALT／γ-GT，二硫化碳另含心電圖）；各尿中代謝物係職安署特殊健檢細項生物偵測之口徑（非附表十逐字項目），該範疇界定為未決事項 M-11。附表十號別 → 代謝物之對應見 special-exam.md 涵蓋表。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。 

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
  "id" : "VS-Appendix10-OrganicSolvent-RequiredSet",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-Appendix10-OrganicSolvent-RequiredSet",
  "version" : "0.5.0",
  "name" : "VS_Appendix10OrganicSolventRequiredSet",
  "title" : "附表十 有機溶劑作業 專屬應執行項目值集",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-08-20T16:35:38+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】附表十第 7–12、33–35 項有機溶劑類作業之家族專屬檢查項目：各作業之尿中生物偵測代謝物與肝功能。⚠️ 附表十本文對此類作業僅列肝功能（ALT／γ-GT，二硫化碳另含心電圖）；各尿中代謝物係職安署特殊健檢細項生物偵測之口徑（非附表十逐字項目），該範疇界定為未決事項 M-11。附表十號別 → 代謝物之對應見 special-exam.md 涵蓋表。共同一般項目見 VS-Appendix9-RequiredSet。用於完整性稽核，非 element binding。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2324-2",
        "display" : "Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "12533-6",
        "display" : "Thiazolidine-2-Thione-4-Carboxylic acid [Mass/volume] in Urine"
      },
      {
        "code" : "3041-1",
        "display" : "Trichloroacetate [Mass/volume] in Urine"
      },
      {
        "code" : "12543-5",
        "display" : "Methyl formamide [Mass/volume] in Urine"
      },
      {
        "code" : "31170-4",
        "display" : "2,5-Hexanedione [Mass/volume] in Urine"
      },
      {
        "code" : "13000-5",
        "display" : "Mandelate [Mass/volume] in Urine"
      },
      {
        "code" : "6709-0",
        "display" : "Hippurate [Mass/volume] in Urine"
      },
      {
        "code" : "2725-0",
        "display" : "Para methylhippurate [Mass/volume] in Urine"
      }]
    }]
  }
}

```
