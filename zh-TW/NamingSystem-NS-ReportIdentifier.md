# 健檢報告封包識別碼 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## NamingSystem: 健檢報告封包識別碼 

 
【技術規格】勞工健康檢查報告封包（Bundle）之識別碼命名空間。 
**唯一性要求**：值在同一健檢機構內須唯一且不重複使用；跨機構之唯一性由 「命名空間 + 值」的組合達成。上傳端據此判定是否為同一份封包之重送（去重）。 
**穩定性要求**：同一份健檢報告重新上傳（例如更正後重送）時**應沿用相同的識別碼**， 否則監理端無從判斷這是更正還是新的一筆。若確為另一次健檢，則須給新的識別碼。 
**不得**以流水號以外可回推受檢者身分之內容組成（例如身分證號、病歷號）。 



## Resource Content

```json
{
  "resourceType" : "NamingSystem",
  "id" : "NS-ReportIdentifier",
  "extension" : [{
    "url" : "http://hl7.org/fhir/5.0/StructureDefinition/extension-NamingSystem.url",
    "valueUri" : "https://twcore.mohw.gov.tw/ig/twha/NamingSystem/NS-ReportIdentifier"
  },
  {
    "url" : "http://hl7.org/fhir/5.0/StructureDefinition/extension-NamingSystem.version",
    "valueString" : "0.9.3"
  }],
  "name" : "TWHAReportIdentifier",
  "status" : "draft",
  "kind" : "identifier",
  "date" : "2026-07-27",
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
  "responsible" : "產生封包之健檢機構（本 IG 僅規範命名空間，不集中發放）",
  "description" : "【技術規格】勞工健康檢查報告封包（Bundle）之識別碼命名空間。\n\n**唯一性要求**：值在同一健檢機構內須唯一且不重複使用；跨機構之唯一性由\n「命名空間 + 值」的組合達成。上傳端據此判定是否為同一份封包之重送（去重）。\n\n**穩定性要求**：同一份健檢報告重新上傳（例如更正後重送）時**應沿用相同的識別碼**，\n否則監理端無從判斷這是更正還是新的一筆。若確為另一次健檢，則須給新的識別碼。\n\n**不得**以流水號以外可回推受檢者身分之內容組成（例如身分證號、病歷號）。",
  "uniqueId" : [{
    "type" : "uri",
    "value" : "https://twcore.mohw.gov.tw/ig/twha/sid/report-id",
    "preferred" : true,
    "comment" : "canonical namespace 為 provisional，正式核定後須更新（CLAUDE.md §6）。"
  }]
}

```
