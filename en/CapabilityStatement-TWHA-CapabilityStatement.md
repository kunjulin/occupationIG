# 健康檢查資料交換平台服務宣告 - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## CapabilityStatement: 健康檢查資料交換平台服務宣告 

 
本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。 

 [Raw OpenAPI-Swagger Definition file](../TWHA-CapabilityStatement.openapi.json) | [Download](../TWHA-CapabilityStatement.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "TWHA-CapabilityStatement",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CapabilityStatement/TWHA-CapabilityStatement",
  "version" : "0.1.0",
  "status" : "active",
  "date" : "2026-06-15",
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
  "description" : "本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。",
  "kind" : "requirements",
  "fhirVersion" : "4.0.1",
  "format" : ["json", "xml"],
  "rest" : [{
    "mode" : "server",
    "security" : {
      "description" : "採用 OAuth 2.0 與 TLS 1.3 安全傳輸協定"
    },
    "resource" : [{
      "type" : "Bundle",
      "profile" : "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction",
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
    }]
  }]
}

```
