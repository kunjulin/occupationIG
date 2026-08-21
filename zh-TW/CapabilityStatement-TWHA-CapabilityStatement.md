# 健康檢查資料交換平台服務宣告 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.3

## CapabilityStatement: 健康檢查資料交換平台服務宣告 

 
本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。本宣告為 requirements（規範要求）層級；實際部署之平台應發佈對應之 capability 宣告。 

 [OpenAPI-Swagger 定義原始檔](../TWHA-CapabilityStatement.openapi.json) | [下載](../TWHA-CapabilityStatement.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "TWHA-CapabilityStatement",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CapabilityStatement/TWHA-CapabilityStatement",
  "version" : "0.9.3",
  "title" : "健康檢查資料交換平台服務宣告",
  "status" : "active",
  "date" : "2026-07-29",
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
  "description" : "本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。本宣告為 requirements（規範要求）層級；實際部署之平台應發佈對應之 capability 宣告。",
  "kind" : "requirements",
  "fhirVersion" : "4.0.1",
  "format" : ["json", "xml"],
  "implementationGuide" : ["https://twcore.mohw.gov.tw/ig/twha/ImplementationGuide/mohw.tw.twha"],
  "rest" : [{
    "mode" : "server",
    "security" : {
      "service" : [{
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/restful-security-service",
          "code" : "SMART-on-FHIR",
          "display" : "SMART-on-FHIR"
        }]
      }],
      "description" : "採用 SMART on FHIR（OAuth 2.0／OIDC）與 TLS 1.3 安全傳輸協定。三類角色之建議 scope 與「雇主端欄位級隔離以 TWHA-Composition-EmployerSummary 達成」見安全與隱私頁 §2；scope 之細部語法與授權流程屬平台端決定（M-10）。"
    },
    "resource" : [{
      "type" : "Bundle",
      "profile" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction",
      "documentation" : "上傳入口。接受 TWHA-Bundle-Transaction（處理語意 transaction／batch 之抉擇為未決事項 M-9）。",
      "interaction" : [{
        "code" : "create"
      },
      {
        "code" : "read"
      }],
      "operation" : [{
        "name" : "submit",
        "definition" : "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit"
      }]
    },
    {
      "type" : "Patient",
      "documentation" : "以識別碼（病歷號等）查詢受檢者，供上傳前判重與上傳後對帳。",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchParam" : [{
        "name" : "identifier",
        "definition" : "http://hl7.org/fhir/SearchParameter/Patient-identifier",
        "type" : "token"
      }]
    },
    {
      "type" : "Observation",
      "documentation" : "查詢已上傳之檢查項目。",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchParam" : [{
        "name" : "patient",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-patient",
        "type" : "reference"
      },
      {
        "name" : "code",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-code",
        "type" : "token"
      },
      {
        "name" : "date",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-date",
        "type" : "date"
      }]
    },
    {
      "type" : "DiagnosticReport",
      "documentation" : "查詢已上傳之報告；identifier 對應本 IG 之報告識別碼命名空間（sid/report-id），為冪等重傳之判重鍵。",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchParam" : [{
        "name" : "patient",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-patient",
        "type" : "reference"
      },
      {
        "name" : "date",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-date",
        "type" : "date"
      },
      {
        "name" : "identifier",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-identifier",
        "type" : "token"
      }]
    }]
  }]
}

```
