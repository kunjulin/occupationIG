# 遵從性與依賴 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.2

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

本節定義健檢機構向主管機關平台上傳資料之介接契約。 **平台端 API 之實際實作不在本 IG 範圍**；本節為雙方之最低共同約定。

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
| `Practitioner` | **暫無**——證書字號命名空間未定（[T-2](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#t-2)） | 一般`POST`；T-2 定案後改條件式建立 | [UC-009](Bundle-UC-009.md)entry[2] |

「同一次健檢」之判定以**報告識別碼**為準：`sid/report-id` 之值在發行機構內須唯一且不得回收 （見 [NS-ReportIdentifier](NamingSystem-NS-ReportIdentifier.md) 之描述）。

### 6.3 整包處理語意——未決（M-9）

FHIR 對上傳封包有兩種處理語意，**對實作端的錯誤處理設計完全不同**：

| | | |
| :--- | :--- | :--- |
| 語意 | **全有全無**：任一 entry 失敗，整包回滾 | 逐 entry 獨立處理，**允許部分成功** |
| 機構端重試 | 整包重送即可（配合 §6.2 之冪等機制安全） | 須解析 response 逐筆判斷哪些要重送 |
| 平台端負擔 | 需交易性儲存 | 無交易性要求，但對帳複雜 |
| entry 結構 | 相同（本 IG 範例之 entry 寫法**兩者通用**） | 相同 |

現行 profile（`TWHA-Bundle-Transaction`）固定 `type = #transaction`， **此為暫行預設，非最終決策**——定案屬平台端，登記於 [未決事項 M-9](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#m-9)。若定案採 `batch`，需調整者僅： profile 之 `type` 固定值、本節之錯誤處理敘述、`$submit` 之回應定義； 範例之 entry 結構不變。**定案前，平台端不得依任一語意實作錯誤處理**。

### 6.4 平台端能力宣告

本 IG 之 [CapabilityStatement](CapabilityStatement-TWHA-CapabilityStatement.md) 為 `kind = requirements`（規範要求）：宣告平台**應**支援之互動與查詢參數 （`Patient.identifier`、`Observation.patient/code/date`、`DiagnosticReport.patient/date/identifier`）。 平台實際上線後，應另行發佈 `kind = capability` 之實例宣告供機構端探測； 該實例由平台端維護，不在本 IG 內。

-------

## 7. 合規層級 (Conformance Levels)

### 7.0 範疇聲明

> 本指引之主管機關為**國民健康署**。勞工健康檢查項目係**依《勞工健康保護規則》 附表九／十／十一之項目表建立之結構化表達**，目的在於使勞工健檢資料得以同一標準交換， **非另立勞工健檢之規範，亦未受勞動部職業安全衛生署委任或授權**。 凡涉及該規則之法定解釋（保存期限起算點、附表十新增作業之施行日、 情境資料集③之範疇），本指引一律**僅載明規則要素並指向待釋示**，不代該署認定。

本節之層級係本指引之**技術符合性層級，不構成主管機關之認證或採認** （與[已知限制與試用須知 G-2](index.md#before-you-start) 一致）。宣告符合某一層級， 僅表示該系統之資料結構通過本指引對應 artifact 之驗證，**不表示任何機關已審閱、 採認或背書該系統**。

### 7.1 兩個層級

| | | | |
| :--- | :--- | :--- | :--- |
| **Level 1｜Core 上傳合規** | Core 最小共通上傳集之 Profile 與值集 ＋ 上傳封包結構（[UC-008](Bundle-UC-008.md)／[UC-009](Bundle-UC-009.md)） | 「本系統符合 TWHA IG Level 1」 | 國民健康署健檢上傳欄位規範（工作原案，待公告，見[M-5](index.md#before-you-start)） |
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
| 9 | `30907X-1` | 嚼檳狀態 | **無 LOINC、亦無 SNOMED observable**（均已查證）；本指引自訂問句碼`CS-BetelNutObservable#betel-quid-chewing-status` | — | [TWHA-SocialHistory-BetelNut](StructureDefinition-TWHA-SocialHistory-BetelNut.md)．`value[x]` |
| 10 | `30907X-2` | 嚼檳量 | 無代碼 | `{個}/d` | 同上．`component[amount]`（本指引用`{quid}/d`，見下註 ③） |
| 11 | `30907X-3` | 嚼檳月數 | 無代碼 | `mo` | 同上．`component[durationYears]`（＝**嚼食持續期間**，見下註 ②） |
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

**16 主項／21 列**之關係：「主項」＝**不重複之健保醫令代碼**，「列」＝填報欄位。 16 項中**僅 3 項展開為多列**——吸菸 `30906X` 3 列、嚼檳 `30907X` 3 列、尿蛋白 `06003C` 2 列， 其餘 13 項各 1 列。核算 `13 + 3 + 3 + 2 = 21`。

> ⚠️ **血壓不是「1 主項 2 列」**：收縮壓 `30904X` 與舒張壓 `30905X` 是**兩個獨立醫令**， 各自為一個主項、各 1 列。兩者在 FHIR 中同屬一個 `BloodPressure` Observation 的兩個 component，**但那是本指引的建模方式，不是原案的計列方式**——兩者不可互推。

> ⚠️ **`VS-CoreUploadSet` 不等於本表，兩者相差三項——引用時務必分清。** [VS-CoreUploadSet](ValueSet-VS-CoreUploadSet.md) 是**跨值集之群組**， 逐碼展開為 **20 個 preferred 代碼**，與本表之 21 列有三處差異：

| | |
| :--- | :--- |
| ＋ BMI`39156-5` | **不是 Core 列**。它來自`VS-TWHAVitalSigns`——該值集另有生理量測之綁定用途，故一併被群組帶入。**不得據 `VS-CoreUploadSet` 推論 BMI 屬最小上傳集。** |
| − 嚼檳量（第 10 列） | 官方原案為獨立一列，本指引以**同一 Observation 之 `component[amount]`**承載，非獨立`Observation.code`，故群組值集中無對應碼。 |
| − 嚼檳月數（第 11 列） | 同上，以`component`承載。 |

核算：`20 − 1（BMI） + 2（嚼檳量、嚼檳月數） = 21`。 **故「21 列」是對的，`VS-CoreUploadSet` 展開為 20 碼也是對的**——兩者計的不是同一件事。

**三項差異已獲主管機關答覆**（2026-08-20）：

| | | | |
| :--- | :--- | :--- | :--- |
| ① | BMI 是否納入 | **不在 21 列內** | 維持現況：`39156-5`留在`VS-TWHAVitalSigns`（生理量測用），**不屬最小上傳集** |
| ② | 第 11 列「嚼檳月數」之語意 | **指「嚼了多久」**，即嚼食持續期間 | 對映至`component[durationYears]`（**非**`cessationDuration`）；單位由固定`a`放寬為`a`或`mo` |
| ③ | 嚼檳量之單位標記 | **同意轉換為標準的 `{quid}/d`** | 維持現況 |

> ⚠️ **上開答覆目前為口頭／轉述，書面依據待補**（見〈已知限制與試用須知〉M-5）。 依本指引既定立場，**在取得可引用之書面依據前，M-5 之狀態、嚼檳系列之 `experimental` 旗標與 Level 1 之成熟度一律不變更**。本節所載之處置屬**技術相容性調整** （單位放寬、語意對映、敘述更正），不涉及上述三者，故先行實作。

> 📌 **②之處置說明**：原案欄名「嚼檳月數」與吸菸列之「戒菸月數」形式對稱， 易被讀成「戒檳月數」；經確認其語意為**嚼食持續期間**，兩者方向相反，故特此載明。 單位放寬為 `a` 或 `mo` 而**不做強制換算**——把「嚼 18 個月」寫成「1.5 年」 同樣會偽造精度。`component[cessationDuration]`（戒除期間）仍保留， 但**不屬最小上傳集之欄位**。`CS-BetelNutComponent` 之代碼 id 保留 `duration-years`（含 "years" 字樣）： 該碼已於 v0.4.0 發佈，改名屬破壞性變更。**真實語意以顯示名與定義為準， 不以代碼 id 為準**——代碼 id 只是識別字。

**Level 1 之 artifact 清單**（共 24 件，可由 `node scripts/check-governance-tags.js` 機器核對； 清單本體登記於 `scripts/governance-map.js`）：

`VS-CoreUploadSet`、`VS-CoreDataset`、`VS-TWHAVitalSigns`、`TWHA-LabResult-General`、 `TWHA-VitalSigns`、`TWHA-SocialHistory-Smoking`、`TWHA-SocialHistory-BetelNut`、 `CS-SmokingStatus`、`VS-SmokingStatus`、`CS-BetelNutStatus`、`VS-BetelNutStatus`、 `CS-BetelNutComponent`、`CS-BetelNutAdditive`、`VS-BetelNutAdditive`、`CS-BetelNutLime`、 `VS-BetelNutLime`、`CS-BetelNutInfoSource`、`VS-BetelNutInfoSource`、 `CS-BetelNutHpaCategory`、`VS-BetelNutHpaCategory`、`VS-TimeUnitYearMonth`、 `ext-smoking-quantity`、`ext-cessation-duration`、`TWHA-Bundle-Transaction`。

驗證用範例封包：[UC-008](Bundle-UC-008.md)（一般健檢上傳）、 [UC-009](Bundle-UC-009.md)（特殊健檢上傳）。

### 7.3 Level 2 之範圍

Level 2 涵蓋附表九／十／十一之法定應執行項目值集、特別危害健康作業之危害因子與暴露史、 健康管理分級與適性配工、臨場健康服務之執行紀錄，**共 50 件 artifact** （清單同樣登記於 `scripts/governance-map.js`，以閘門逐件核對）。

⚠️ 附表十尚有**八個未審家族**未納入 `VS-Appendix10-RequiredSet` （見 [M-8](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#m-8)）；宣告 Level 2 者遇未納入之家族， **應保留原始 coding 照常交換，接收端不得因此拒收**。

### 7.4 artifact 之權責標籤與成熟度

每支 Profile／Extension／值集／代碼系統之 `Description` 起首標示其**內容依據**：

| | | |
| :--- | :--- | :--- |
| `【主管機關：國民健康署】` | 內容依據為該署之健檢上傳欄位規範或該署表單 | 26 |
| `【依據：勞工健康保護規則附表】` | 項目取自該規則附表八～十二 | 51 |
| `【技術規格】` | 本團隊之技術決定，無外部內容依據 | 28 |

> ⚠️ **上表件數於 v0.9.0 更正**（原記 24／50／27，合計 101）。落差有二，皆非本表誤植： 一是 v0.7.2 將 ConceptMap 與 NamingSystem 共 3 件納入登記（101 → 104）時未同步本頁； 二是 v0.9.0 新增 `CS-BetelNutObservable`（104 → 105）。 現值 **26／51／28 ＝ 105**，係自 `scripts/governance-map.js` 逐件數出，非沿用文件所載。

**標籤陳述的是內容依據與誰有權決定，不是任何機關已審閱或採認。** 《勞工健康保護規則》之主管機關為勞動部職業安全衛生署，**惟本指引未受其委任或授權**， 故該標籤寫「依據」而非治理或主管機關（§7.0）。

成熟度以 HL7 `structuredefinition-standards-status` extension 標示：

| | | |
| :--- | :--- | :--- |
| **Level 1**（26 件） | `trial-use` | `active` |
| **Level 2**（51 件） | `draft` | **`draft`** |
| 共用技術結構（28 件） | 不標 | `active` |

> ⚠️ **成熟度件數同於 v0.9.0 更正**（原記 24／50／27）。與上表之標籤件數同源脫鉤， 且**是新增的 G-5 閘門抓出來的**——v0.9.0 手動更正時只改了標籤表，這張原封不動留著。 兩表之合計相同（105）純屬邊際巧合，**兩者並非同一種分類**： 標籤分的是「內容依據為何」，層級分的是「成熟度」。 交叉分佈為 hpa/L1 25、tech/L1 1、hpa/L0 1、reg/L2 51、tech/L0 27——**不是一對一對應**。

**IG 層之 `status` 不變**——FHIR IG 一次只能發佈一個版本， 故「兩區塊各走各的節奏」無法靠版次達成，只能靠層級與 artifact 標籤。

> ⚠️ **Level 2 之 `status` 併同改為 `draft`，屬本版之規範性中繼資料變更。** IG Publisher 會交叉檢查 `standards-status` 與資源自身之 `status` （`draft` ↔ `status = draft`；`trial-use` ↔ `status = active`），兩者不一致即發出 「The resource status and the standards status are not consistent」。 v0.5.0 曾只標 `standards-status` 而未動 `status`，實測**命中 71 件自相矛盾**， 故當時暫採「Level 2 不標」並登記待裁示；**PI 已於 2026-08-20 裁示勞工區塊須以 機器可讀方式標為 `draft`**，本版依裁示併同調整 `status`。**對實作端的意義**：Level 2 之 artifact 其 `status` 為 `draft`， 表示**尚未定稿、內容可能變動**；實作端據此判斷是否納入正式系統。 Level 1 之 `status` 維持 `active`，不受影響——**這正是分軌的目的**。

> 嚼檳系列之 `experimental` 維持 `true`：其理由為所綁本地值集皆為 provisional、 待 [M-5](index.md#before-you-start)。**不得為使 Core 之外觀較佳而改標 `false`** ——那等於宣稱未經核定之代碼已定案。

-------

## 8. 版本遷移說明 (Migration Notes)

### 8.1 v0.9.0：嚼檳狀態之 Observation.code 變更（Level 1 破壞性變更）

| | | |
| :--- | :--- | :--- |
| `Observation.code` | `http://snomed.info/sct#698188003`「Chews betel quid」 | `https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutObservable#betel-quid-chewing-status`「嚼檳榔狀態」 |
| `value[x]` | `VS-BetelNutStatus`四碼 | **不變** |
| `component[*]` | UCUM`Quantity`等 | **不變** |

**受影響對象**：已依 v0.4.0–v0.8.6 實作並送出 `code = 698188003` 之系統。 其資料在 v0.9.0 之 `TWHA-SocialHistory-BetelNut` 下**不再通過驗證**（`code` 為 `1..1` 固定值）。

**為何非改不可**：`698188003` 是**肯定式 finding**（斷言「此人嚼檳」）， 放在問題位使「從未嚼食」之紀錄自相矛盾——已發佈之 `obs-betelnut-never` 即 `code` 說嚼、`value` 說從未。以 `Observation?code=698188003` 檢索會把**從未嚼檳者一併撈出**， 屬偽陽性資料風險，直接影響上傳之下游統計與癌症登記勾稽。 建置 `err = 0` 不代表沒問題——驗證器不檢查 `code` 與 `value` 之語意相容性。

**遷移步驟**

1. 將送出之`Observation.code`由`698188003`換為`CS-BetelNutObservable#betel-quid-chewing-status`。
1. `value[x]`、`component[*]`**不需任何調整**。
1. 若原本以`code = 698188003`建立索引或查詢，改以新問句碼查詢；**需要「此人嚼檳」之語意時，改查 `value` 為 `1-occasional` 或 `2-daily`**。
1. 歷史資料之處置由各系統自行決定：本指引**不要求**回溯改寫既有紀錄， 但同一資料集內混用兩種`code`時，查詢端須同時涵蓋。

⚠️ **`698188003` 並未被廢棄**，只是換了位置：它改列為肯定式狀態 （`1-occasional`／`2-daily`）之 SNOMED 對應，見[術語頁 §6.2b-3](terminology.md)。

⚠️ **本次未變更之事項**（避免誤讀為一併調整）： 主管機關最小上傳集之**欄位**（醫令 `30907X-1`）未變，變的只是承載該欄位之 FHIR 代碼； M-5 之狀態、嚼檳系列之 `experimental` 旗標、Level 1 之成熟度**三者皆未動**。

