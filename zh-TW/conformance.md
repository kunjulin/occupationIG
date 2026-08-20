# 遵從性與依賴 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

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

-------

## 7. 合規層級 (Conformance Levels)

### 7.0 範疇聲明

> 本指引之主管機關為**國民健康署**。勞工健康檢查項目係**依《勞工健康保護規則》 附表九／十／十一之項目表建立之結構化表達**，目的在於使勞工健檢資料得以同一標準交換， **非另立勞工健檢之規範，亦未受勞動部職業安全衛生署委任或授權**。 凡涉及該規則之法定解釋（保存期限起算點、附表十新增作業之施行日、 情境資料集③之範疇），本指引一律**僅載明規則要素並指向待釋示**，不代該署認定。

本節之層級係本指引之**技術符合性層級，不構成主管機關之認證或採認** （與[已知限制與試用須知 G-2](open-issues.md#g-2) 一致）。宣告符合某一層級， 僅表示該系統之資料結構通過本指引對應 artifact 之驗證，**不表示任何機關已審閱、 採認或背書該系統**。

### 7.1 兩個層級

| | | | |
| :--- | :--- | :--- | :--- |
| **Level 1｜Core 上傳合規** | Core 最小共通上傳集之 Profile 與值集 ＋ 上傳封包結構（[UC-008](Bundle-UC-008.md)／[UC-009](Bundle-UC-009.md)） | 「本系統符合 TWHA IG Level 1」 | 國民健康署健檢上傳欄位規範（工作原案，待公告，見[M-5](open-issues.md#m-5)） |
| **Level 2｜勞工健檢涵蓋** | 附表九／十／十一之應執行項目、健康管理分級與適性配工、臨場健康服務執行紀錄 | 「本系統符合 TWHA IG Level 2」 | 《勞工健康保護規則》附表（**非受委任**，見 §7.0） |

**Level 2 以 Level 1 為前提，Level 1 不以 Level 2 為前提。** 院所與平台端得**僅實作並宣告 Level 1**；主管機關亦得僅就 Level 1 要求符合性。 勞工區塊之**範圍與節奏均不變**——分層改變的是「可以分開宣告」，不是刪減內容。

### 7.2 Level 1 逐列清單（21 列）

下表逐列取自**主管機關上傳欄位原案**（TWHA IG 完整編碼附件 v7.6〈Core 主管機關最小集(21)〉）， 以**健保醫令代碼**為鍵值；「本指引承載」欄說明各列於本指引中實際落在哪個元素。 acceptable 變異碼經 [ConceptMap](ConceptMap-TWHealthCheckLaboratoryMap.md) 歸一，不另計列。

| | | | | | |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | `30901X` | 身高 | LOINC`8302-2` | `cm` | [TWHA-VitalSigns](StructureDefinition-TWHA-VitalSigns.md) |
| 2 | `30902X` | 體重 | LOINC`29463-7` | `kg` | 同上 |
| 3 | `30903X` | 腰圍 | LOINC`8280-0` | `cm` | 同上 |
| 4 | `30904X` | 血壓＿收縮壓 | LOINC`8480-6` | `mm[Hg]` | `TWCoreBloodPressure` |
| 5 | `30905X` | 血壓＿舒張壓 | LOINC`8462-4` | `mm[Hg]` | 同上 |
| 6 | `30906X-1` | 吸菸狀態 | LOINC`72166-2` | — | [TWHA-SocialHistory-Smoking](StructureDefinition-TWHA-SocialHistory-Smoking.md)．`value[x]` |
| 7 | `30906X-2` | 吸菸量 | LOINC`64218-1` | `/d`（支／日） | 同上．`extension[smokingQuantity]` |
| 8 | `30906X-3` | 戒菸月數 | LOINC`63632-4` | `mo` | 同上．`extension[cessationDuration]` |
| 9 | `30907X-1` | 嚼檳狀態 | **無 LOINC**；SNOMED CT`698188003` | — | [TWHA-SocialHistory-BetelNut](StructureDefinition-TWHA-SocialHistory-BetelNut.md)．`value[x]` |
| 10 | `30907X-2` | 嚼檳量 | 無代碼 | `{個}/d` | 同上．`component[amount]`（本指引用`{quid}/d`，見下註 ③） |
| 11 | `30907X-3` | 嚼檳月數 | 無代碼 | `mo` | 同上．`component[cessationDuration]`或`component[durationYears]`（**語意待確認，見下註 ②**） |
| 12 | `09001C` | 總膽固醇 | LOINC`2093-3` | `mg/dL` | [TWHA-LabResult-General](StructureDefinition-TWHA-LabResult-General.md) |
| 13 | `09005C` | 飯前血糖 | LOINC`1558-6` | `mg/dL` | 同上 |
| 14 | `09004C` | 三酸甘油酯 | LOINC`2571-8` | `mg/dL` | 同上 |
| 15 | `09043C` | HDL-C | LOINC`2085-9` | `mg/dL` | 同上 |
| 16 | `09044C` | LDL-C（方法通用碼） | LOINC`2089-1` | `mg/dL` | 同上 |
| 17 | `09015C` | 肌酸酐 | LOINC`2160-0` | `mg/dL` | 同上 |
| 18 | `06003C-1` | 尿蛋白＿定量 | LOINC`2888-6` | `mg/dL` | 同上 |
| 19 | `06003C-2` | 尿蛋白＿定性 | LOINC`5804-0` | — | 同上 |
| 20 | `14032C` | B 型肝炎表面抗原 | LOINC`5196-1` | — | 同上 |
| 21 | `14051C` | C 型肝炎抗體 | LOINC`13955-0` | — | 同上 |

**主項 16**（以醫令前綴計）：血壓 2 列、吸菸 3 列、嚼檳 3 列、尿蛋白 2 列，其餘一項一列。

> ⚠️ **`VS-CoreUploadSet` 不等於本表，兩者相差三項——引用時務必分清。** [VS-CoreUploadSet](ValueSet-VS-CoreUploadSet.md) 是**跨值集之群組**， 逐碼展開為 **20 個 preferred 代碼**，與本表之 21 列有三處差異：

| | |
| :--- | :--- |
| ＋ BMI`39156-5` | **不是 Core 列**。它來自`VS-TWHAVitalSigns`——該值集另有生理量測之綁定用途，故一併被群組帶入。**不得據 `VS-CoreUploadSet` 推論 BMI 屬最小上傳集。** |
| − 嚼檳量（第 10 列） | 官方原案為獨立一列，本指引以**同一 Observation 之 `component[amount]`**承載，非獨立`Observation.code`，故群組值集中無對應碼。 |
| − 嚼檳月數（第 11 列） | 同上，以`component`承載。 |

核算：`20 − 1（BMI） + 2（嚼檳量、嚼檳月數） = 21`。 **故「21 列」是對的，`VS-CoreUploadSet` 展開為 20 碼也是對的**——兩者計的不是同一件事。

**三項待主管機關確認**（已列入送簽確認單）：

① **BMI 是否納入最小上傳集**。原案 21 列未收 BMI，本指引之 `VS-TWHAVitalSigns` 收錄之。 ② **第 11 列「嚼檳月數」之語意**。與吸菸列對稱者應為「**戒**檳月數」 （對應 `component[cessationDuration]`），惟原案欄名為「嚼檳月數」， 亦可讀為「嚼食持續月數」（對應 `component[durationYears]`，本指引以年計）。 **兩者語意相反，不得臆測**——本指引兩個 component 皆已備妥，待確認後對映。 ③ **嚼檳量之單位**。原案記 `{個}/d`，本指引用 **`{quid}/d`**：UCUM 之 annotation 僅接受 ASCII，`{個}` 為非 ASCII，**不是合法 UCUM**（JOB-29 §A）。 數值語意相同（顆／日），僅標記法不同。

**Level 1 之 artifact 清單**（共 24 件，可由 `node scripts/check-governance-tags.js` 機器核對； 清單本體登記於 `scripts/governance-map.js`）：

`VS-CoreUploadSet`、`VS-CoreDataset`、`VS-TWHAVitalSigns`、`TWHA-LabResult-General`、 `TWHA-VitalSigns`、`TWHA-SocialHistory-Smoking`、`TWHA-SocialHistory-BetelNut`、 `CS-SmokingStatus`、`VS-SmokingStatus`、`CS-BetelNutStatus`、`VS-BetelNutStatus`、 `CS-BetelNutComponent`、`CS-BetelNutAdditive`、`VS-BetelNutAdditive`、`CS-BetelNutLime`、 `VS-BetelNutLime`、`CS-BetelNutInfoSource`、`VS-BetelNutInfoSource`、 `CS-BetelNutHpaCategory`、`VS-BetelNutHpaCategory`、`VS-TimeUnitYearMonth`、 `ext-smoking-quantity`、`ext-cessation-duration`、`TWHA-Bundle-Transaction`。

驗證用範例封包：[UC-008](Bundle-UC-008.md)（一般健檢上傳）、 [UC-009](Bundle-UC-009.md)（特殊健檢上傳）。

### 7.3 Level 2 之範圍

Level 2 涵蓋附表九／十／十一之法定應執行項目值集、特別危害健康作業之危害因子與暴露史、 健康管理分級與適性配工、臨場健康服務之執行紀錄，**共 50 件 artifact** （清單同樣登記於 `scripts/governance-map.js`，以閘門逐件核對）。

⚠️ 附表十尚有**八個未審家族**未納入 `VS-Appendix10-RequiredSet` （見 [M-8](open-issues.md#m-8)）；宣告 Level 2 者遇未納入之家族， **應保留原始 coding 照常交換，接收端不得因此拒收**。

### 7.4 artifact 之權責標籤與成熟度

每支 Profile／Extension／值集／代碼系統之 `Description` 起首標示其**內容依據**：

| | | |
| :--- | :--- | :--- |
| `【主管機關：國民健康署】` | 內容依據為該署之健檢上傳欄位規範或該署表單 | 24 |
| `【依據：勞工健康保護規則附表】` | 項目取自該規則附表八～十二 | 50 |
| `【技術規格】` | 本團隊之技術決定，無外部內容依據 | 27 |

**標籤陳述的是內容依據與誰有權決定，不是任何機關已審閱或採認。** 《勞工健康保護規則》之主管機關為勞動部職業安全衛生署，**惟本指引未受其委任或授權**， 故該標籤寫「依據」而非治理或主管機關（§7.0）。

成熟度以 HL7 `structuredefinition-standards-status` extension 標示： **Level 1 之 24 件 artifact 標 `trial-use`；Level 2 與共用技術結構不標**。 **IG 層之 `status` 不變**——FHIR IG 一次只能發佈一個版本， 故「兩區塊各走各的節奏」無法靠版次達成，只能靠層級與 artifact 標籤。

> ⚠️ **為何 Level 2 不標 `draft`**：IG Publisher 會交叉檢查 `standards-status` 與資源本身之 `status`（`draft` ↔ `status = draft`、`trial-use` ↔ `status = active`）。本指引之 artifact 一律繼承 `status: active`，故標 `draft` 會使該 artifact **自相矛盾** ——CI 實測命中 **71 件**。要讓 `draft` 成立，須把該 71 件之 `status` 改為 `draft`， 屬**已發佈中繼資料之規範性變更**，超出本版範圍，待裁示。 在此之前，Level 2 之較低成熟度由**本節之層級定義與權責標籤**表達， **不以自相矛盾的中繼資料表達**。

> 嚼檳系列之 `experimental` 維持 `true`：其理由為所綁本地值集皆為 provisional、 待 [M-5](open-issues.md#m-5)。**不得為使 Core 之外觀較佳而改標 `false`** ——那等於宣稱未經核定之代碼已定案。

