# Conformance - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Conformance

# 遵從性要求 (Conformance Requirements)

本指引定義了健康檢查（包含一般健康檢查、勞工健康檢查與成人預防保健）資料交換之最低遵從性要求。

## 1. 繼承與相容性要求

* 本指引之 Profiles 繼承自 `TW Core IG v1.0.0`。所有符合本指引的實作系統，亦必須相容於 `TW Core IG` 相關要求。
* 當 Profiles 間有重複定義之元素時，以本指引之約束為優先。

-------

## 2. 驗證與錯誤等級

* 系統產出之 FHIR 實例 (Instances) 必須通過 [HL7 FHIR Validator](https://validator.fhir.org/) 或 IG Publisher 的驗證。
* 驗證結果不得包含 **Errors** (錯誤) 等級之阻斷性問題。若有 **Warnings** (警告) 或 **Information** (提示)，開發團隊應評估其合理性並進行修正。

