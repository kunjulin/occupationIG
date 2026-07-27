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
