# 智慧財產權與授權聲明 (Intellectual Property & Licensing)

本頁彙整本指引所引用之外部術語系統與規範之著作權與使用條件。

> ⚠️ **實作前請先確認授權**：本指引**引用**下列術語系統，但**不代表**授予實作端任何使用權。
> 實作機構須自行取得各術語系統所需之授權。

---

## 1. 工具產生之聲明（權威內容）

下列內容由 HL7 IG Publisher 依本指引實際引用之術語系統自動產生。
**以下原文為權威版本**；本頁其餘中文說明僅為導讀，不取代原文條款。

{% include ip-statements.xhtml %}

---

## 2. 中文導讀

### 2.1 LOINC

本指引以 **LOINC** 作為檢驗、生理量測與部分檢查項目之主要代碼系統
（`VS-CoreDataset`、`VS-ExtendedDataset`、`VS-OccHealthCheck-Required` 等值集）。
LOINC 由 **Regenstrief Institute, Inc.** 所有並授權，需依其授權條款使用。
本指引中之 LOINC 代碼與顯示名僅為對照與實作指引之用。

> 本指引之 LOINC 顯示名以官方 display 為準。若發現本指引所載顯示名與 LOINC 官方不符，
> 應以 LOINC 官方為準，並回報至本指引之議題追蹤
> （相關稽核作業見本專案 [GitHub 之優化工作文件](https://github.com/kunjulin/occupationIG/tree/main/docs/optimization)）。

### 2.2 SNOMED CT

本指引於生活習慣、危害類別等處引用 **SNOMED CT**（見[術語定義](terminology.html)）。
SNOMED CT 為 **SNOMED International (IHTSDO)** 之註冊商標與著作，
其使用須符合該組織之授權規範。

> ⚠️ **本指引不就臺灣境內 SNOMED CT 之授權管道、涵蓋範圍或費用作任何陳述。**
> 實作機構應自行向主管機關或 SNOMED International 確認其授權狀態。
> 本項已登記為未決事項，待正式確認後補述。

### 2.3 UCUM

本指引之量值單位採 **UCUM (Unified Code for Units of Measure)**，
由 Regenstrief Institute, Inc. 與 UCUM Organization 所有。
單位對照參見 `extended-ucum-reference.csv`（[下載專區](downloads.html)）。

### 2.4 HL7 FHIR

本指引為 **HL7® FHIR®** 實作指引。HL7、FHIR 及 FHIR 標誌為
**Health Level Seven International** 之註冊商標。

### 2.5 繼承與引用之國內指引

| 來源 | 引用方式 |
|:--|:--|
| **臺灣核心實作指引 (TW Core IG)** `tw.gov.mohw.twcore 1.0.0` | 套件層級依賴，本指引之 Profiles 繼承自此 |
| **臺灣癌症登記短表實作指引 (TWCR_SF)** | 嚼檳榔相關 CodeSystem／ValueSet 之外部 canonical 引用。**以正式相依宣告承載**（`fhir.TWCRSF`），本指引不自行定義該命名空間之資源；授權條款 CC0-1.0。詳見[術語定義](terminology.html) |

### 2.6 法規來源

本指引依據中華民國《勞工健康保護規則》（115.06.26 修正）及其附表八、九、十、十一設計。
法規原文之著作權依《著作權法》第 9 條，法律、命令不得為著作權之標的。

---

## 3. 本指引自身之授權條件

| 項目 | 狀態 |
|:--|:--|
| 本指引自訂之 CodeSystem／ValueSet／Profile／Extension（`CS-*`、`VS-*`、`TWHA-*`、`ext-*`） | **授權條件待確認** |
| 著作權年份 | 2026+ |
| 發布者 | 衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院 |

> ⚠️ **本指引尚未宣告授權條款（`license`）。** 見[未決事項 P-2](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#p-2)。
> 本指引為工業技術研究院委託研擬中之草案，其著作權歸屬與再利用條件涉及委託契約，
> **尚待確認**，故 `sushi-config.yaml` 刻意未填 `license` 欄位——
> 填入未經確認之授權條款，比留空更容易造成誤用。
>
> 在授權條款正式確認前，第三方**不宜**假設本指引之自訂術語可自由再散布。
