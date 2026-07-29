# 安全性與個資保護 (Security & Privacy)

勞工健康檢查紀錄與臨場服務資料屬高度敏感之個人醫療健康個資，其存取、傳輸與儲存必須符合
《個人資料保護法》與衛福部資訊安全相關規範。

本頁不僅陳述原則，並將每一項安全要求對應至**可實作、可驗證**之 FHIR 機制。
凡涉及主管機關或平台端架構決定者，一律指向[未決事項](open-issues.html)，不於本 IG 片面認定。

> **本節之定位**：本 IG 定義「資料如何表達以支持安全控制」；**存取控制之實際執行**
> （IdP、授權伺服器、金鑰管理）屬平台端，不在本 IG 範圍。下表「驗證方式」欄指的是
> 「本 IG 之產物如何被機器檢查」，非平台端之滲透測試。

---

## 1. 安全要求 → FHIR 機制對照

| 安全要求 | FHIR／標準機制 | 實作端責任 | 於本 IG 之驗證方式 |
|:--|:--|:--|:--|
| 傳輸通道加密 | HTTPS / **TLS 1.3** | 平台與機構端 | 不由 IG 驗證（傳輸層） |
| 身分驗證與授權 | **SMART on FHIR**（OAuth 2.0 / OIDC） | 平台端發 token | `CapabilityStatement.rest.security.service` 宣告；scope 見 §2 |
| 角色存取控制（欄位級隔離） | **雇主版 Composition**（[TWHA-Composition-EmployerSummary](StructureDefinition-TWHA-Composition-EmployerSummary.html)）＋ scope | 機構端產出對應封包 | Profile 之 closed slicing 結構性保證不含檢驗 section（§2） |
| 醫師電子簽章 | **`Provenance.signature`** | 簽署端 | §3；簽署者身分繫於醫事人員證書字號（[T-2](open-issues.html#t-2)） |
| 去識別化 | 雜湊 identifier ＋ 欄位降精度 | 通報端 | §4；`Patient.birthDate` 精度 |
| 緊急存取（break-the-glass） | [TWHA-Composition-EmergencySummary](StructureDefinition-TWHA-Composition-EmergencySummary.html) ＋ 稽核 | 平台端 | §5 |
| 稽核軌跡 | `AuditEvent`（本期不建模，見 §6） | 平台端 | 本期不驗證，見 M-10 |
| 同意管理 | `Consent`（本期不建模，見 §6） | 平台端 | 本期不驗證，見 M-10 |

---

## 2. 角色存取控制與欄位級隔離 (RBAC & Field-Level Isolation)

本 IG 之核心隱私結構是：**雇主是資料使用者，但不應看到檢驗細項**。這是勞工健檢領域
特有的張力，也是本節之重點。

### 2.1 三類角色

| 角色 | 可存取內容 | 不可存取 |
|:--|:--|:--|
| 特約醫護人員 | 完整健檢紀錄（病史、理學、檢驗數值、影像、總評） | — |
| 職安人員／雇主主管 | 健康管理分級、適性配工建議、臨場服務發現問題 | **檢驗數值明細**（血糖、肝功能等）、詳細病史、影像 |
| 政府監理機關 | 去識別化統計；或基於職業病調查之特定法定個案 | 非必要之個人識別資料（見 §4） |

### 2.2 為何以「雇主版封包」而非僅以 scope 達成隔離

SMART on FHIR scope 之顆粒度到**資源型別**為止（如 `patient/Observation.rs`）。
但「雇主可看分級、不可看檢驗值」是**同一資源型別內的欄位級**區分——分級與檢驗值
都是 `Observation`。單以 scope 無法乾淨表達「可讀分級 Observation、不可讀檢驗 Observation」。

故本 IG 之欄位級隔離改由**產出不同的 Composition** 達成：

- 醫護端：完整封包（含 `keyLabs` 等 section），或 [TWHA-Composition-EmergencySummary](StructureDefinition-TWHA-Composition-EmergencySummary.html)。
- 雇主端：[**TWHA-Composition-EmployerSummary**](StructureDefinition-TWHA-Composition-EmployerSummary.html)——其 `section` 為
  **closed slicing**，結構上**只能**含「健康管理分級／適性配工」與「臨場服務發現」兩個
  section，且各 section 之 `entry` 以 profile 限定，**檢驗類 Observation 與 DiagnosticReport
  無從置入**。

> **這是可驗證的**：雇主端封包若宣告符合 `TWHA-Composition-EmployerSummary`，
> FHIR 驗證器即可證明其不含檢驗細項——這是「文字承諾」做不到、而 profile 能做到的。
> 範例見 [example-composition-employer-summary](Composition-example-composition-employer-summary.html)，
> 對照醫護端之 [composition-emergency-summary](Composition-composition-emergency-summary.html)（含 `keyLabs`）即見差異。

scope 仍作為**第一道**粗粒度控制（限制資源型別），欄位級隔離則由封包型別達成——兩者互補。

### 2.3 SMART scope 對照（示意，平台端確認）

下表為建議之最小 scope 集合；**實際 scope 由平台端授權伺服器定義**，本表供對齊。

| 角色 | 建議 scope（示意） |
|:--|:--|
| 特約醫護人員 | `patient/Observation.rs patient/DiagnosticReport.rs patient/Condition.rs patient/CarePlan.rs patient/Composition.rs` |
| 職安人員／雇主 | `patient/Composition.rs`（限 EmployerSummary 型別）；**不授** `DiagnosticReport`／檢驗 `Observation` 之讀取 |
| 政府監理 | `system/Bundle.c`（去識別化上傳端點）；統計查詢另循專用端點 |

`CapabilityStatement.rest.security.service` 宣告 SMART-on-FHIR；scope 之細部語法與
授權流程屬平台端（M-10）。

---

## 3. 電子簽章 (Electronic Signature)

醫師對健檢報告之簽章以 **`Provenance.signature`** 表達（而非 `Bundle.signature`），
理由：`Provenance` 可獨立描述「誰、何時、對哪個 target、以何角色」簽署，且可於資源
更新時保留簽署歷程；`Bundle.signature` 僅簽整包、不利於個別報告之追溯。

- `Provenance.target`：指向被簽署之 `DiagnosticReport`／`Composition`。
- `Provenance.signature.type`：採 `urn:iso-astm:E1762-95:2013` 之簽章目的碼
  （如 `1.2.840.10065.1.12.1.1` Author's Signature）。
- `Provenance.signature.who`：簽署醫師，繫至其醫事人員證書字號——**該識別碼之命名空間
  尚未定案（[T-2](open-issues.html#t-2)）**，故簽署者之機器可比對身分待 T-2 解決後方能完備。
- **智慧醫療憑證**之簽章格式與法律效力屬主管機關規範，本 IG 不認定，登記關聯於 T-2。

> 本期**不強制** `Provenance`（屬建議機制）；平台端若採用，應依上述結構。

---

## 4. 去識別化與資料最小化 (De-identification & Minimization)

### 4.1 最小化原則

事業單位系統若僅為健康分級管理之目的儲存資料，應僅保留分級標籤與配工內容
（即 §2.2 之雇主版封包），不儲存檢驗明細。

### 4.2 去識別化欄位處理

當上傳至非醫療之行政監理系統或進行群體流行病學統計時：

| 欄位 | 處理 |
|:--|:--|
| 姓名 | 移除 |
| 身分證字號 | 以**不可逆雜湊 Token** 取代（見 §4.3） |
| `Patient.birthDate` | 降精度為 **`YYYY-MM`**（FHIR `date` 原生支援部分日期，profile 不禁止此精度） |
| 地址 | 降精度至郵遞區號層級或移除 |
| `Organization`（事業單位） | 依監理需求保留或雜湊 |

### 4.3 雜湊 Token 之跨機構可比對性——必須明白的取捨

去識別化後**是否仍需跨機構比對同一人**（如同一勞工在不同機構之健檢串接），
決定了雜湊策略，且兩者不可兼得：

- **需跨機構比對** → 各機構須以**共用 salt** 雜湊，同一身分證字號才會產生相同 Token。
  代價：共用 salt 一旦外洩，全體 Token 可被離線碰撞還原，**安全性顯著降低**。
- **不需跨機構比對** → 各機構用**獨立 salt**，安全性高，但無法串接同一人跨機構之紀錄。

**本 IG 不替此取捨定案**——它涉及監理需求與資安風險之權衡，屬主管機關／平台端決定
（見 [M-10](open-issues.html#m-10)）。本節之責任是把取捨寫明，不是迴避。

---

## 5. 緊急存取 (Break-the-Glass)

急診情境為 RBAC 之法定例外：急診醫師於緊急時得存取勞工之職業暴露史與關鍵檢驗，
以判斷症狀是否與職業暴露相關。此存取以 [TWHA-Composition-EmergencySummary](StructureDefinition-TWHA-Composition-EmergencySummary.html)
承載（該 profile 已定義負向表列使用限制）。

緊急存取之控制要求：

- **事由記錄**：每次 break-the-glass 存取須記錄事由與存取者身分（平台端 `AuditEvent`，§6）。
- **事後可稽核**：緊急存取應可於事後被審視，非常規授權。
- **範圍最小**：僅取急診判斷所需之暴露史與關鍵檢驗，非完整病歷。

> 緊急存取之授權流程與稽核為平台端機制（M-10）；本 IG 之責任是提供對應之資料封包
> （EmergencySummary）與使用限制。

---

## 6. 本期不建模者（明確聲明，非遺漏）

下列機制**本期不以 profile 建模**，因其執行細節屬平台端架構決定，於本 IG 建模會
過早固化未定之選擇。**明確聲明優於「提到但未定義」的中間狀態**：

- **`Consent`（同意管理）**：勞工書面個資授權同意之表達、查核與撤回。
- **`AuditEvent`（稽核軌跡）**：查詢／新增／修改／刪除之不可竄改日誌與應記錄欄位。
- **`Provenance`（完整溯源）**：§3 之簽章為建議用法，非完整 Provenance 建模。

以上三者之落地屬「雇主端資料隔離之實作機制」範疇，統一登記於
[未決事項 M-10](open-issues.html#m-10)。實作端在該項定案前，應依《個資法》與衛福部規範
自行處理，並保留可日後對接之欄位。

**保存期限**（第 19 條）之結構化亦未於本期實作——其起算點之法定解釋尚未確定
（[M-6](open-issues.html#m-6)），在解釋確定前結構化等於把未定之法律解釋寫死；
詳見[背景與法規](background.html) §3.1.1 與 [M-7](open-issues.html#m-7)。
