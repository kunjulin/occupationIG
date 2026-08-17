# 遵從性與依賴 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.5

## 遵從性與依賴

# 遵從性要求 (Conformance Requirements)

本指引定義了健康檢查（包含一般健康檢查、勞工健康檢查與成人預防保健）資料交換之最低遵從性要求。

## 1. 繼承與相容性要求

* 本指引之 Profiles 繼承自 `TW Core IG v1.0.0`。所有符合本指引的實作系統，亦必須相容於 `TW Core IG` 相關要求。
* 當 Profiles 間有重複定義之元素時，以本指引之約束為優先。

-------

## 2. 驗證與錯誤等級

* 系統產出之 FHIR 實例 (Instances) 必須通過 [HL7 FHIR Validator](https://validator.fhir.org/) 或 IG Publisher 的驗證。
* 驗證結果不得包含 **Errors** (錯誤) 等級之阻斷性問題。若有 **Warnings** (警告) 或 **Information** (提示)，開發團隊應評估其合理性並進行修正。

> ⚠️ **驗證通過之意義界定**：IG Publisher 之驗證通過，僅證明**語法正確**且**已被引用之術語** 通過代碼有效性檢查；**不包含臨床適切性、法規符合性與情境完整性之保證**。 尤須注意：驗證**不檢查 ValueSet 內之 `display` 是否與代碼真實語意相符**， 故語意錯誤之代碼可能通過 0 Error 建置。詳見 [README 之驗證結果意義界定](https://github.com/kunjulin/occupationIG#建置與編譯步驟)。

-------

## 3. 依賴之實作指引與套件 (Dependencies)

實作端須依下表載入對應之 FHIR 套件版本。本表由建置工具依實際依賴自動產生。







嚼檳榔相關 CodeSystem／ValueSet 係以**外部 canonical URL** 引用臺灣癌症登記短表實作指引 (TWCR_SF)，屬非套件層級之引用，故不會出現於上表；其現況與限制見 [智慧財產權與授權聲明 §2.5](ip-statements.md)。

-------

## 4. 全域 Profile 適用範圍 (Global Profiles)

下表列出本指引宣告之全域 profile（若有），即不限特定 artifact、對所有相應資源型別均適用者。

*There are no Global profiles defined*

-------

## 5. 跨 FHIR 版本相容性 (Cross-Version Analysis)

本指引以 **FHIR R4 (4.0.1)** 為基礎。下列分析說明本指引所用元素在其他 FHIR 版本之對應情形， 供未來升版評估參考。

This is an R4 IG. None of the features it uses are changed in R4B, so it can be used as is with R4B systems. Packages for both [R4 (mohw.tw.twha.r4)](../package.r4.tgz) and [R4B (mohw.tw.twha.r4b)](../package.r4b.tgz) are available.

-------

## 6. 上傳介接契約 (Upload Interface Contract)

本節定義健檢機構向主管機關平台上傳資料之介接契約（JOB-04）。 **平台端 API 之實際實作不在本 IG 範圍**；本節為雙方之最低共同約定。

### 6.1 端點與方法

| | |
| :--- | :--- |
| 端點 | `POST [base]/Bundle/$submit`（見[Bundle-submit](OperationDefinition-Bundle-submit.md)），或逕以`POST [base]`送出交易封包 |
| 輸入 | [TWHA-Bundle-Transaction](StructureDefinition-TWHA-Bundle-Transaction.md)：每個 entry 具`request.method`與`request.url`，內部參照以`urn:uuid`表達 |
| 成功 | HTTP 200 ＋`type = transaction-response`之 Bundle，逐 entry 回報`response.status`與伺服器指派位址 |
| 驗證失敗 | HTTP 422 ＋`OperationOutcome`，`issue.expression`指向出錯之 entry 路徑 |

### 6.2 去重與冪等重傳

上傳必須可安全重試（網路逾時後重送不得產生重複資料）。判重鍵如下：

| | | | |
| :--- | :--- | :--- | :--- |
| `Patient` | 病歷號（機構內識別碼） | `request.ifNoneExist`（條件式建立） | [UC-008](Bundle-UC-008.md)entry[0] |
| `Organization` | 醫事機構代碼 | `request.ifNoneExist` | [UC-008](Bundle-UC-008.md)entry[1] |
| `DiagnosticReport` | 報告識別碼（[sid/report-id](NamingSystem-NS-ReportIdentifier.md)） | 首次上傳`ifNoneExist`；重傳`PUT`＋ 查詢式 URL（條件式更新＝覆寫） | [UC-008](Bundle-UC-008.md)entry[3]、[UC-009](Bundle-UC-009.md)entry[5] |
| `Practitioner` | **暫無**——證書字號命名空間未定（[T-2](open-issues.md#t-2)） | 一般`POST`；T-2 定案後改條件式建立 | [UC-009](Bundle-UC-009.md)entry[2] |

「同一次健檢」之判定以**報告識別碼**為準：`sid/report-id` 之值在發行機構內須唯一且不得回收 （見 [NS-ReportIdentifier](NamingSystem-NS-ReportIdentifier.md) 之描述）。

### 6.3 整包處理語意——未決（M-9）

FHIR 對上傳封包有兩種處理語意，**對實作端的錯誤處理設計完全不同**：

| | | |
| :--- | :--- | :--- |
| 語意 | **全有全無**：任一 entry 失敗，整包回滾 | 逐 entry 獨立處理，**允許部分成功** |
| 機構端重試 | 整包重送即可（配合 §6.2 之冪等機制安全） | 須解析 response 逐筆判斷哪些要重送 |
| 平台端負擔 | 需交易性儲存 | 無交易性要求，但對帳複雜 |
| entry 結構 | 相同（本 IG 範例之 entry 寫法**兩者通用**） | 相同 |

現行 profile（`TWHA-Bundle-Transaction`）固定 `type = #transaction`， **此為暫行預設，非最終決策**——定案屬平台端，登記於 [未決事項 M-9](open-issues.md#m-9)。若定案採 `batch`，需調整者僅： profile 之 `type` 固定值、本節之錯誤處理敘述、`$submit` 之回應定義； 範例之 entry 結構不變。**定案前，平台端不得依任一語意實作錯誤處理**。

### 6.4 平台端能力宣告

本 IG 之 [CapabilityStatement](CapabilityStatement-TWHA-CapabilityStatement.md) 為 `kind = requirements`（規範要求）：宣告平台**應**支援之互動與查詢參數 （`Patient.identifier`、`Observation.patient/code/date`、`DiagnosticReport.patient/date/identifier`）。 平台實際上線後，應另行發佈 `kind = capability` 之實例宣告供機構端探測； 該實例由平台端維護，不在本 IG 內。

