# 遵從性要求 (Conformance Requirements)

本指引定義了健康檢查（包含一般健康檢查、勞工健康檢查與成人預防保健）資料交換之最低遵從性要求。

## 1. 繼承與相容性要求

*   本指引之 Profiles 繼承自 `TW Core IG v1.0.0`。所有符合本指引的實作系統，亦必須相容於 `TW Core IG` 相關要求。
*   當 Profiles 間有重複定義之元素時，以本指引之約束為優先。

---

## 2. 驗證與錯誤等級

*   系統產出之 FHIR 實例 (Instances) 必須通過 [HL7 FHIR Validator](https://validator.fhir.org/) 或 IG Publisher 的驗證。
*   驗證結果不得包含 **Errors** (錯誤) 等級之阻斷性問題。若有 **Warnings** (警告) 或 **Information** (提示)，開發團隊應評估其合理性並進行修正。

> ⚠️ **驗證通過之意義界定**：IG Publisher 之驗證通過，僅證明**語法正確**且**已被引用之術語**
> 通過代碼有效性檢查；**不包含臨床適切性、法規符合性與情境完整性之保證**。
> 尤須注意：驗證**不檢查 ValueSet 內之 `display` 是否與代碼真實語意相符**，
> 故語意錯誤之代碼可能通過 0 Error 建置。詳見
> [README 之驗證結果意義界定](https://github.com/kunjulin/occupationIG#建置與編譯步驟)。

---

## 3. 依賴之實作指引與套件 (Dependencies)

實作端須依下表載入對應之 FHIR 套件版本。本表由建置工具依實際依賴自動產生。

{% include dependency-table.xhtml %}

嚼檳榔相關 CodeSystem／ValueSet 係以**外部 canonical URL** 引用臺灣癌症登記短表實作指引
(TWCR_SF)，屬非套件層級之引用，故不會出現於上表；其現況與限制見
[智慧財產權與授權聲明 §2.5](ip-statements.html)。

---

## 4. 全域 Profile 適用範圍 (Global Profiles)

下表列出本指引宣告之全域 profile（若有），即不限特定 artifact、對所有相應資源型別均適用者。

{% include globals-table.xhtml %}

---

## 5. 跨 FHIR 版本相容性 (Cross-Version Analysis)

本指引以 **FHIR R4 (4.0.1)** 為基礎。下列分析說明本指引所用元素在其他 FHIR 版本之對應情形，
供未來升版評估參考。

{% include cross-version-analysis-inline.xhtml %}

---

## 6. 上傳介接契約 (Upload Interface Contract)

本節定義健檢機構向主管機關平台上傳資料之介接契約（JOB-04）。
**平台端 API 之實際實作不在本 IG 範圍**；本節為雙方之最低共同約定。

### 6.1 端點與方法

| 項目 | 約定 |
|:--|:--|
| 端點 | `POST [base]/Bundle/$submit`（見 [Bundle-submit](OperationDefinition-Bundle-submit.html)），或逕以 `POST [base]` 送出交易封包 |
| 輸入 | [TWHA-Bundle-Transaction](StructureDefinition-TWHA-Bundle-Transaction.html)：每個 entry 具 `request.method` 與 `request.url`，內部參照以 `urn:uuid` 表達 |
| 成功 | HTTP 200 ＋ `type = transaction-response` 之 Bundle，逐 entry 回報 `response.status` 與伺服器指派位址 |
| 驗證失敗 | HTTP 422 ＋ `OperationOutcome`，`issue.expression` 指向出錯之 entry 路徑 |

### 6.2 去重與冪等重傳

上傳必須可安全重試（網路逾時後重送不得產生重複資料）。判重鍵如下：

| 資源 | 判重鍵 | 機制 | 範例 |
|:--|:--|:--|:--|
| `Patient` | 病歷號（機構內識別碼） | `request.ifNoneExist`（條件式建立） | [UC-008](Bundle-UC-008.html) entry[0] |
| `Organization` | 醫事機構代碼 | `request.ifNoneExist` | [UC-008](Bundle-UC-008.html) entry[1] |
| `DiagnosticReport` | 報告識別碼（[sid/report-id](NamingSystem-NS-ReportIdentifier.html)） | 首次上傳 `ifNoneExist`；重傳 `PUT` ＋ 查詢式 URL（條件式更新＝覆寫） | [UC-008](Bundle-UC-008.html) entry[3]、[UC-009](Bundle-UC-009.html) entry[5] |
| `Practitioner` | **暫無**——證書字號命名空間未定（[T-2](open-issues.html#t-2)） | 一般 `POST`；T-2 定案後改條件式建立 | [UC-009](Bundle-UC-009.html) entry[2] |

「同一次健檢」之判定以**報告識別碼**為準：`sid/report-id` 之值在發行機構內須唯一且不得回收
（見 [NS-ReportIdentifier](NamingSystem-NS-ReportIdentifier.html) 之描述）。

### 6.3 整包處理語意——未決（M-9）

FHIR 對上傳封包有兩種處理語意，**對實作端的錯誤處理設計完全不同**：

| | `transaction` | `batch` |
|:--|:--|:--|
| 語意 | **全有全無**：任一 entry 失敗，整包回滾 | 逐 entry 獨立處理，**允許部分成功** |
| 機構端重試 | 整包重送即可（配合 §6.2 之冪等機制安全） | 須解析 response 逐筆判斷哪些要重送 |
| 平台端負擔 | 需交易性儲存 | 無交易性要求，但對帳複雜 |
| entry 結構 | 相同（本 IG 範例之 entry 寫法**兩者通用**） | 相同 |

現行 profile（`TWHA-Bundle-Transaction`）固定 `type = #transaction`，
**此為暫行預設，非最終決策**——定案屬平台端，登記於
[未決事項 M-9](open-issues.html#m-9)。若定案採 `batch`，需調整者僅：
profile 之 `type` 固定值、本節之錯誤處理敘述、`$submit` 之回應定義；
範例之 entry 結構不變。**定案前，平台端不得依任一語意實作錯誤處理**。

### 6.4 平台端能力宣告

本 IG 之 [CapabilityStatement](CapabilityStatement-TWHA-CapabilityStatement.html) 為
`kind = requirements`（規範要求）：宣告平台**應**支援之互動與查詢參數
（`Patient.identifier`、`Observation.patient/code/date`、`DiagnosticReport.patient/date/identifier`）。
平台實際上線後，應另行發佈 `kind = capability` 之實例宣告供機構端探測；
該實例由平台端維護，不在本 IG 內。

---

## 7. 合規層級 (Conformance Levels)

### 7.0 範疇聲明

> 本指引之主管機關為**國民健康署**。勞工健康檢查項目係**依《勞工健康保護規則》
> 附表九／十／十一之項目表建立之結構化表達**，目的在於使勞工健檢資料得以同一標準交換，
> **非另立勞工健檢之規範，亦未受勞動部職業安全衛生署委任或授權**。
> 凡涉及該規則之法定解釋（保存期限起算點、附表十新增作業之施行日、
> 情境資料集③之範疇），本指引一律**僅載明規則要素並指向待釋示**，不代該署認定。

本節之層級係本指引之**技術符合性層級，不構成主管機關之認證或採認**
（與[已知限制與試用須知 G-2](open-issues.html#g-2) 一致）。宣告符合某一層級，
僅表示該系統之資料結構通過本指引對應 artifact 之驗證，**不表示任何機關已審閱、
採認或背書該系統**。

### 7.1 兩個層級

| 層級 | 範圍 | 宣告者可主張 | 內容依據 |
|:--|:--|:--|:--|
| **Level 1｜Core 上傳合規** | Core 最小共通上傳集之 Profile 與值集 ＋ 上傳封包結構（[UC-008](Bundle-UC-008.html)／[UC-009](Bundle-UC-009.html)） | 「本系統符合 TWHA IG Level 1」 | 國民健康署健檢上傳欄位規範（工作原案，待公告，見 [M-5](open-issues.html#m-5)） |
| **Level 2｜勞工健檢涵蓋** | 附表九／十／十一之應執行項目、健康管理分級與適性配工、臨場健康服務執行紀錄 | 「本系統符合 TWHA IG Level 2」 | 《勞工健康保護規則》附表（**非受委任**，見 §7.0） |

**Level 2 以 Level 1 為前提，Level 1 不以 Level 2 為前提。**
院所與平台端得**僅實作並宣告 Level 1**；主管機關亦得僅就 Level 1 要求符合性。
勞工區塊之**範圍與節奏均不變**——分層改變的是「可以分開宣告」，不是刪減內容。

### 7.2 Level 1 逐列清單（自 `VS-CoreUploadSet` 展開）

下表由 [VS-CoreUploadSet](ValueSet-VS-CoreUploadSet.html) 逐列展開，
每列取該項目之 **Preferred 代碼**；acceptable 變異碼經
[ConceptMap](ConceptMap-TWHealthCheckLaboratoryMap.html) 歸一，不另計列。

| # | 主項 | 列 | Preferred 代碼 | 承載 Profile |
|--:|:--|:--|:--|:--|
| 1 | 總膽固醇 | 總膽固醇 | LOINC `2093-3` | [TWHA-LabResult-General](StructureDefinition-TWHA-LabResult-General.html) |
| 2 | 飯前血糖 | 飯前血糖 | LOINC `1558-6` | 同上 |
| 3 | 三酸甘油酯 | 三酸甘油酯 | LOINC `2571-8` | 同上 |
| 4 | 高密度脂蛋白膽固醇 | HDL-C | LOINC `2085-9` | 同上 |
| 5 | 低密度脂蛋白膽固醇 | LDL-C | LOINC `2089-1` | 同上 |
| 6 | 肌酸酐 | 肌酸酐 | LOINC `2160-0` | 同上 |
| 7 | 尿蛋白 | 尿蛋白定量 | LOINC `2888-6` | 同上 |
| 8 | 尿蛋白 | 尿蛋白定性 | LOINC `5804-0` | 同上 |
| 9 | B 型肝炎表面抗原 | HBsAg | LOINC `5196-1` | 同上 |
| 10 | C 型肝炎抗體 | anti-HCV | LOINC `13955-0` | 同上 |
| 11 | 身高 | 身高 | LOINC `8302-2` | [TWHA-VitalSigns](StructureDefinition-TWHA-VitalSigns.html) |
| 12 | 體重 | 體重 | LOINC `29463-7` | 同上 |
| 13 | 腰圍 | 腰圍 | LOINC `8280-0` | 同上 |
| 14 | 血壓 | 收縮壓 | LOINC `8480-6` | `TWCoreBloodPressure` |
| 15 | 血壓 | 舒張壓 | LOINC `8462-4` | 同上 |
| 16 | 身體質量指數 | BMI | LOINC `39156-5` | [TWHA-VitalSigns](StructureDefinition-TWHA-VitalSigns.html) |
| 17 | 吸菸 | 吸菸狀態 | LOINC `72166-2` | [TWHA-SocialHistory-Smoking](StructureDefinition-TWHA-SocialHistory-Smoking.html) |
| 18 | 吸菸 | 吸菸量 | LOINC `64218-1` | 同上（`ext-smoking-quantity`） |
| 19 | 吸菸 | 戒菸月數 | LOINC `63632-4` | 同上（`ext-cessation-duration`） |
| 20 | 嚼檳榔 | 嚼檳狀態 | SNOMED CT `698188003` | [TWHA-SocialHistory-BetelNut](StructureDefinition-TWHA-SocialHistory-BetelNut.html) |

> ⚠️ **逐列核對結果：16 主項相符，惟實得 20 列，與各處所載之「21 列」差 1 列。**
> 本表係自 `VS-CoreUploadSet.fsh` 實際展開（檢驗子集 10 ＋ 生理量測 6 ＋ 社會史 4），
> **非沿用既有文件之數字**。主項數 16 與原案相符（尿蛋白 2 列、血壓 2 列、吸菸 3 列）。
>
> **本指引不逕自補足該列**——差異可能是本指引漏收一列，也可能是原案之計列口徑不同
> （例如嚼檳除狀態外另計一列嚼檳量；本指引之嚼檳量以 `component[amount]`
> 承載於同一 Observation，不另立一列）。兩者對「必填欄位有哪些」的結論不同，
> **屬 [M-5](open-issues.html#m-5) 待國民健康署確認之事項**，已列為送簽確認單第 4 項。

**Level 1 之 artifact 清單**（共 24 件，可由 `node scripts/check-governance-tags.js` 機器核對；
清單本體登記於 `scripts/governance-map.js`）：

`VS-CoreUploadSet`、`VS-CoreDataset`、`VS-TWHAVitalSigns`、`TWHA-LabResult-General`、
`TWHA-VitalSigns`、`TWHA-SocialHistory-Smoking`、`TWHA-SocialHistory-BetelNut`、
`CS-SmokingStatus`、`VS-SmokingStatus`、`CS-BetelNutStatus`、`VS-BetelNutStatus`、
`CS-BetelNutComponent`、`CS-BetelNutAdditive`、`VS-BetelNutAdditive`、`CS-BetelNutLime`、
`VS-BetelNutLime`、`CS-BetelNutInfoSource`、`VS-BetelNutInfoSource`、
`CS-BetelNutHpaCategory`、`VS-BetelNutHpaCategory`、`VS-TimeUnitYearMonth`、
`ext-smoking-quantity`、`ext-cessation-duration`、`TWHA-Bundle-Transaction`。

驗證用範例封包：[UC-008](Bundle-UC-008.html)（一般健檢上傳）、
[UC-009](Bundle-UC-009.html)（特殊健檢上傳）。

### 7.3 Level 2 之範圍

Level 2 涵蓋附表九／十／十一之法定應執行項目值集、特別危害健康作業之危害因子與暴露史、
健康管理分級與適性配工、臨場健康服務之執行紀錄，**共 50 件 artifact**
（清單同樣登記於 `scripts/governance-map.js`，以閘門逐件核對）。

⚠️ 附表十尚有**八個未審家族**未納入 `VS-Appendix10-RequiredSet`
（見 [M-8](open-issues.html#m-8)）；宣告 Level 2 者遇未納入之家族，
**應保留原始 coding 照常交換，接收端不得因此拒收**。

### 7.4 artifact 之權責標籤與成熟度

每支 Profile／Extension／值集／代碼系統之 `Description` 起首標示其**內容依據**：

| 標籤 | 意義 | 件數 |
|:--|:--|--:|
| `【主管機關：國民健康署】` | 內容依據為該署之健檢上傳欄位規範或該署表單 | 24 |
| `【依據：勞工健康保護規則附表】` | 項目取自該規則附表八～十二 | 50 |
| `【技術規格】` | 本團隊之技術決定，無外部內容依據 | 27 |

**標籤陳述的是內容依據與誰有權決定，不是任何機關已審閱或採認。**
《勞工健康保護規則》之主管機關為勞動部職業安全衛生署，**惟本指引未受其委任或授權**，
故該標籤寫「依據」而非治理或主管機關（§7.0）。

成熟度以 HL7 `structuredefinition-standards-status` extension 標示：
**Level 1 之 artifact 標 `trial-use`，其餘標 `draft`**；
**IG 層之 `status` 不變**——FHIR IG 一次只能發佈一個版本，
故「兩區塊各走各的節奏」無法靠版次達成，只能靠層級與 artifact 標籤。

> 嚼檳系列之 `experimental` 維持 `true`：其理由為所綁本地值集皆為 provisional、
> 待 [M-5](open-issues.html#m-5)。**不得為使 Core 之外觀較佳而改標 `false`**
> ——那等於宣稱未經核定之代碼已定案。
