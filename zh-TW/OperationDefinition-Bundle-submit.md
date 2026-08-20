# Submit Bundle Operation - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## OperationDefinition: Submit Bundle Operation 

 
健檢機構向主管機關平台上傳健檢資料之作業。輸入為符合 TWHA-Bundle-Transaction 之上傳封包；去重規則：Patient／Organization 以識別碼條件式建立（ifNoneExist）、DiagnosticReport 以報告識別碼（https://twcore.mohw.gov.tw/ig/twha/sid/report-id）條件式更新，同一份報告重傳為覆寫（冪等）。成功回傳 transaction-response Bundle；驗證失敗回傳 OperationOutcome，issue.expression 指向出錯之 entry。整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，定案前平台端不得依任一語意實作錯誤處理。完整契約見 conformance.html 之「上傳介接契約」一節。 



## Resource Content

```json
{
  "resourceType" : "OperationDefinition",
  "id" : "Bundle-submit",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit",
  "version" : "0.3.3",
  "name" : "Submit",
  "title" : "健檢資料上傳作業 ($submit)",
  "status" : "active",
  "kind" : "operation",
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
  "description" : "健檢機構向主管機關平台上傳健檢資料之作業。輸入為符合 TWHA-Bundle-Transaction 之上傳封包；去重規則：Patient／Organization 以識別碼條件式建立（ifNoneExist）、DiagnosticReport 以報告識別碼（https://twcore.mohw.gov.tw/ig/twha/sid/report-id）條件式更新，同一份報告重傳為覆寫（冪等）。成功回傳 transaction-response Bundle；驗證失敗回傳 OperationOutcome，issue.expression 指向出錯之 entry。整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，定案前平台端不得依任一語意實作錯誤處理。完整契約見 conformance.html 之「上傳介接契約」一節。",
  "code" : "submit",
  "resource" : ["Bundle"],
  "system" : false,
  "type" : true,
  "instance" : false,
  "parameter" : [{
    "name" : "content",
    "use" : "in",
    "min" : 1,
    "max" : "1",
    "documentation" : "上傳封包，須符合 TWHA-Bundle-Transaction（每個 entry 具 request.method 與 request.url）。範例見 Bundle-UC-008.html／Bundle-UC-009.html。",
    "type" : "Bundle",
    "targetProfile" : ["https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction"]
  },
  {
    "name" : "return",
    "use" : "out",
    "min" : 1,
    "max" : "1",
    "documentation" : "成功時為 type = transaction-response 之 Bundle，逐 entry 回報 response.status 與伺服器指派之位址；驗證失敗時整體回應為 OperationOutcome（HTTP 422），issue.expression 指向出錯之 entry 路徑。",
    "type" : "Bundle"
  }]
}

```
