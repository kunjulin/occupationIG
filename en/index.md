# Home - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Home

# 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG)

## 1. 導言 (Introduction)

歡迎使用**臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG)**。本指引由衛生福利部委託長庚紀念醫院規劃研製，旨在利用 **HL7 FHIR (Fast Healthcare Interoperability Resources)** 國際標準，建立一般健康檢查、勞工健康檢查及成人預防保健之 FHIR 資料交換標準。

本實作指引遵循衛生福利部資訊處最新之資訊安全與技術治理規範，**與國家最新核心標準「臺灣核心實作指引 (TW Core IG v1.0.0)」對齊與繼承**，以確保各級臨床端、事業單位與政府主管機關（勞動部職業安全衛生署、國民健康署、衛生福利部等）之間的健檢資料傳輸無縫對接。

-------

## 2. 計畫背景與定位 (Project Background & Position)

### 2.1 國內健康檢查資料之痛點

近年衛生福利部積極推動數位健康基礎建設，然而國內健康檢查資料目前仍普遍存在下列問題：

1. **資料格式不一致**：不同醫院與健檢機構分別使用 PDF、Excel、CSV 或院內私有資料庫等格式儲存健檢結果，缺乏共通結構。
1. **無法跨院交換**：受檢者於各級醫療機構或健檢診所完成檢查後，結果難以透過標準化格式跨機構交換，亦無法回饋至「健康存摺」。
1. **政府資料整合困難**：勞工健康檢查、成人預防保健、企業自費健檢等各類資料缺乏一致標準，造成中央主管機關（如衛福部、國健署、勞動部職安署）彙整、監測與流行病學分析之困難。

### 2.2 計畫定位

為解決上述問題，本計畫建立「臺灣健康檢查資料交換實作指引（TWHA IG）」，作為全國健康檢查之 FHIR 交換標準，使各機構之健檢資料能以標準化、可驗證之格式進行交換與上傳，奠定全國健康檢查資料互操作之基礎。

-------

## 3. 整體架構 (Overall Architecture)

本指引以 `TW Core IG` 為母規範，採**兩層架構**進行設計：以 **Foundation Layer（全國共通核心）** 承載全國共通健檢之核心指標，再以 **Domain Supplement（領域擴充）** 承接特定政策與情境之擴充：

```
TW Health Assessment IG (TWHA IG)
├── Foundation Layer 全國共通核心 (Core Assessment)
│   ├── Social History (生活習慣)  --> 吸菸 / 飲酒 / 嚼檳榔 / 睡眠
│   ├── Vital Signs (生理量測)     --> 身高 / 體重 / BMI / 腰圍 / 血壓
│   ├── Laboratory (實驗室檢驗)    --> 全血球計數 (CBC) / 生化 / 血脂 / 尿液
│   └── Screening (篩檢與生理功能)  --> 視力 / 聽力 / 胸部 X 光
└── Domain Supplement 領域擴充 (Extended Extensions)
    ├── Occupational Health Check (勞工健康檢查) --> 對應《勞工健康保護規則》附表八~十一
    ├── Health Taiwan (成人預防保健)            --> 對應國民健康署成人預防保健服務
    └── SDOH (社會決定因素)                     --> 精簡版 PRAPARE 社會風險問卷

```

-------

## 4. Exchange Package 與資料治理 (Exchange Package & Governance)

### 4.1 Exchange Package 設計

本計畫除建立個別 FHIR Profiles 外，亦定義了跨機構之交換封包格式 **「TW Health Assessment Exchange Package (TWHA-EP)」**。其技術組成主要為 `Bundle Profile`（報告用 `type=document`，上傳用 `type=transaction`）搭配 `CapabilityStatement`：

* **OHC Exchange Package（勞工健檢）**：組成資源包含 `Patient`、`Observation`、`DiagnosticReport`、`ClinicalImpression`、`Composition`、`Bundle`。
* **Health Taiwan Exchange Package（成人預防保健）**：組成資源包含 `Patient`、`Observation`、`DiagnosticReport`、`QuestionnaireResponse`、`Composition`、`Bundle`。

### 4.2 資料治理原則

1. **Must Support**：發送端須能建立、儲存與傳送該欄位；接收端須能接收、保存與查詢，且不得因資料缺失而報錯（呈現為 Should Display）。
1. **DataAbsentReason (必要)**：在 Observation 無檢驗數值或受檢者拒答時，必須填寫`dataAbsentReason`（如`not-performed`、`refused`），以確保缺項資料仍能通過驗證。
1. **極簡化 ValueSet**：僅維護 Core 與 Extended 兩組主體 ValueSet，供所有 Domain Supplement 共用，避免代碼重複。

-------

## 5. 指引閱讀指引 (How to Read this IG)

本指引網頁架構包含以下主題區段，請點選連結進行詳細閱讀：

* [背景與計畫目標 (Background)](background.md)：詳述國內健檢資料痛點、本計畫定位、以及法規背景。
* [使用情境 (Use Cases)](usecases.md)：描述本 IG 之 6 大核心使用情境 (UC-001 ~ UC-006)。
* [資料模型與映射 (Data Model)](datamodel.md)：說明 Foundation Layer 與 Domain Supplement 之欄位與資源映射關係。
* [一般健康檢查 (General Exam)](general-exam.md)：說明全國共通核心 (Foundation Layer) 之一般體檢與健康檢查 FHIR 實作細節。
* [特殊危害健康作業 (Special Exam)](special-exam.md)：說明勞工特殊健檢之 12 大類危害作業與 LOINC 映射。
* [成人預防保健 (Adult Preventive Care)](adult-preventive-care.md)：說明國健署成人預防保健自填問卷與理學生化檢查項目。
* [勞工健康服務執行紀錄 (Service Record)](service-record.md)：附表八臨場健康服務之 FHIR 建模與 Procedure/Task 設計。
* [健康管理分級與配工 (Health Management)](health-management.md)：醫師分級判定（一～四級）及適性配工計畫。
* [術語與代碼系統 (Terminology)](terminology.md)：定義本 IG 使用之 CodeSystems 與 ValueSets。
* [安全與個資保護 (Security)](security.md)：健檢敏感個資之去識別化與傳輸安全規範。
* [下載專區 (Downloads)](downloads.md)：提供 FSH 原始碼、JSON 範例打包下載。

