# 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG)

## 1. 導言 (Introduction)

歡迎使用**臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG)**。本指引由衛生福利部委託財團法人工業技術研究院、長庚紀念醫院執行規劃研製，旨在利用 **HL7 FHIR (Fast Healthcare Interoperability Resources)** 國際標準，以**勞工健康檢查為核心**，建立可向特殊職類與一般健康檢查／成人預防保健需求擴充之 FHIR 資料交換標準。

本實作指引遵循衛生福利部資訊處最新之資訊安全與技術治理規範，**與國家最新核心標準「臺灣核心實作指引 (TW Core IG v1.0.0)」對齊與繼承**，以確保各級臨床端、事業單位與政府主管機關（勞動部職業安全衛生署、國民健康署、衛生福利部等）之間的健檢資料傳輸無縫對接。

---

## 2. 計畫背景與定位 (Project Background & Position)

### 2.1 國內健康檢查資料之痛點
近年衛生福利部積極推動數位健康基礎建設，然而國內健康檢查資料目前仍普遍存在下列問題：
1. **資料格式不一致**：不同醫院與健檢機構分別使用 PDF、Excel、CSV 或院內私有資料庫等格式儲存健檢結果，缺乏共通結構。
2. **無法跨院交換**：受檢者於各級醫療機構或健檢診所完成檢查後，結果難以透過標準化格式跨機構交換，亦無法回饋至「健康存摺」。
3. **政府資料整合困難**：勞工健康檢查、成人預防保健、企業自費健檢等各類資料缺乏一致標準，造成中央主管機關（如衛福部、國健署、勞動部職安署）彙整、監測與流行病學分析之困難。

### 2.2 計畫定位
為解決上述問題，本計畫建立「臺灣勞工健康檢查交換實作指引（TWHA IG）」，以**勞工健康檢查為核心主體**，作為勞工健康檢查資料交換之 FHIR 標準，並向特殊職類與一般健康檢查／成人預防保健需求開放擴充，使各機構之健檢資料能以標準化、可驗證之格式進行交換與上傳。

> **範疇聲明**　本指引之主管機關為**國民健康署**；勞工健康檢查項目係依《勞工健康保護規則》
> 附表之項目表建立之**結構化表達**，**非另立勞工健檢之規範，亦未受勞動部職業安全衛生署委任或授權**。
> 全文見[遵從性要求 §7.0](conformance.html)，該節並定義 Level 1（Core 上傳合規）與
> Level 2（勞工健檢涵蓋）兩個合規層級。

---

## 3. 整體架構 (Overall Architecture)
本指引以 `TW Core IG` 為母規範，以**勞工健康檢查（Core）為核心主體**，並以**不修改核心、加掛擴充**之方式向兩個方向延伸。**Core ＝ 主管機關（國健署）制定之最小共通上傳集（21 列，USCDI regulator-defined minimum model）**，其餘一律歸 Extended；IG 整體範疇 ＝ **Core ∪ Extended**：

```
臺灣勞工健康檢查交換實作指引 (TWHA IG)
├── Core 主管機關最小共通上傳集 (國健署原案 21 列；全集群組 = VS-CoreUploadSet)
│   ├── Social History (生活習慣)  --> 吸菸狀態/量/戒菸月數 / 嚼檳狀態
│   ├── Vital Signs (生理量測)     --> 身高 / 體重 / 腰圍 / 血壓（VS-TWHAVitalSigns）
│   ├── Laboratory (實驗室檢驗)    --> 血脂 / 飯前血糖 / 肌酸酐 / 尿蛋白 / 肝炎（VS-CoreDataset，10 項）
│   └── (CBC、ALT、視聽力、胸X、尿潛血等附表九非上傳項 --> 歸 Extended)
├── 擴充一：特殊職類 (Special Occupational Extension，開放式擴充)
│   └── 對應《勞工健康保護規則》附表十危害作業（噪音／鉛／粉塵／有機溶劑／輻射／特定化學物質…）
│       以 CS-HazardType ＋ TWHA-LabResult-Special ＋ 各職類值集承載；新增職類僅需擴充值集／新增 Profile，不影響 Core
└── 擴充二：一般健檢／預防保健 (General & Preventive Care Extension)
    ├── Health Taiwan (成人預防保健)  --> 對應國民健康署成人預防保健服務，重用 Core 共通臨床項目
    └── SDOH (社會決定因素)          --> 精簡版 PRAPARE 社會風險問卷
```

> 本指引之核心主體為勞工健康檢查；「特殊職類」與「一般健檢／預防保健」為其可擴充方向，並非與 Core 並列之獨立領域。

### 三個不同層次的「資料集」概念（請勿混用）

實作前請先辨明以下三者，**避免將「Core 與 Extended 之聯集」逕行推論為某一法定情境之完整需求**：

| 層次 | 意義 | 對應產物 |
|:---|:---|:---|
| **① IG scope（本 IG 涵蓋範圍）** | 本指引所定義之全部代碼與結構，即 **Core ∪ Extended**。屬「本 IG 能表達什麼」。 | `VS-CoreDataset` ∪ `VS-ExtendedDataset` 等 |
| **② Core upload set（主管機關最小交換集）** | 主管機關（國健署）制定之**最小共通上傳欄位**（21 列）。屬「至少要交換什麼」。 | [VS-CoreUploadSet](ValueSet-VS-CoreUploadSet.html) |
| **③ 情境資料集（法定情境需求）** | 特定法定情境（如附表九一般健檢、附表十某一危害作業）**依法應執行之完整檢查項目**。屬「該情境依法要做什麼」。 | [VS-Appendix9-RequiredSet](ValueSet-VS-Appendix9-RequiredSet.html)（附表九，完整）；[VS-Appendix10-RequiredSet](ValueSet-VS-Appendix10-RequiredSet.html)（附表十，已落地噪音／鉛／粉塵／有機溶劑四家族，餘待臨床確認） |

> ⚠️ **① ≠ ② ≠ ③**。本 IG 涵蓋範圍（①）不等於任一法定情境之完整需求（③）；
> 亦**不得**以「某項目不在 Core（②）」推論該項目不重要或非 Must Support。
> 附表九各法定項目如何由 Core ＋ Extended 組合滿足，見[一般體格及健康檢查](general-exam.html)之對照說明。

> **Core 之來源與效力（M-5）**：本 IG 之 Core 係依據國民健康署健檢上傳欄位之**工作原案**建立，
> **正式公告版本尚待確認**；其內容得依主管機關正式公告調整。
> 決策所需輸入與影響範圍見[未決事項 M-5](open-issues.html#m-5)。

---

## 4. Exchange Package 與資料治理 (Exchange Package & Governance)

### 4.1 Exchange Package 設計
本計畫除建立個別 FHIR Profiles 外，亦定義了跨機構之交換封包格式 **「Taiwan Labor Health Examination Exchange Package (TWHA-EP)」**。其技術組成主要為 `Bundle Profile`（報告用 `type=document`，上傳用 `type=transaction`）搭配 `CapabilityStatement`：
*   **勞工健康檢查 Exchange Package（Core + 特殊職類擴充）**：組成資源包含 `Patient`、`Observation`、`DiagnosticReport`、`ClinicalImpression`、`Composition`、`Bundle`。
*   **一般健檢／預防保健 Exchange Package（一般健檢／預防保健擴充）**：組成資源包含 `Patient`、`Observation`、`DiagnosticReport`、`QuestionnaireResponse`、`Composition`、`Bundle`。

### 4.2 資料治理原則
1. **Must Support**：發送端須能建立、儲存與傳送該欄位；接收端須能接收、保存與查詢，且不得因資料缺失而報錯（呈現為 Should Display）。
2. **DataAbsentReason (必要)**：在 Observation 無檢驗數值或受檢者拒答時，必須填寫 `dataAbsentReason`（如 `not-performed`、`refused`），以確保缺項資料仍能通過驗證。
3. **極簡化 ValueSet**：綁定值集以 Core 檢驗子集（VS-CoreDataset）與 Extended（VS-ExtendedDataset）兩組為主體，供 Core 及所有擴充共用；另以 VS-CoreUploadSet 群組值集具體化「主管機關最小上傳集 21 列」供完整度參照（不作綁定）。

---

## 5. 指引閱讀指引 (How to Read this IG)
本指引網頁架構包含以下主題區段，請點選連結進行詳細閱讀：

*   [背景與計畫目標 (Background)](background.html)：詳述國內健檢資料痛點、本計畫定位、以及法規背景。
*   [使用情境 (Use Cases)](usecases.html)：描述本 IG 之 6 大核心使用情境 (UC-001 ~ UC-006)。
*   [資料模型與映射 (Data Model)](datamodel.html)：說明 Core 與擴充（特殊職類／一般健檢）之欄位與資源映射關係。
*   [一般健康檢查 (General Exam)](general-exam.html)：說明勞工健康檢查共通核心 (Core) 之一般體檢與健康檢查 FHIR 實作細節。
*   [特殊危害健康作業 (Special Exam)](special-exam.html)：說明勞工特殊健檢之 12 大類危害作業與 LOINC 映射。
*   [成人預防保健 (Adult Preventive Care)](adult-preventive-care.html)：說明國健署成人預防保健自填問卷與理學生化檢查項目。
*   [勞工健康服務執行紀錄 (Service Record)](service-record.html)：附表八臨場健康服務之 FHIR 建模與 Procedure/Task 設計。
*   [健康管理分級與配工 (Health Management)](health-management.html)：醫師分級判定（一～四級）及適性配工計畫。
*   [術語與代碼系統 (Terminology)](terminology.html)：定義本 IG 使用之 CodeSystems 與 ValueSets。
*   [安全與個資保護 (Security)](security.html)：健檢敏感個資之去識別化與傳輸安全規範。
*   [下載專區 (Downloads)](downloads.html)：提供 FSH 原始碼、JSON 範例打包下載。
