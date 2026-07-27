# JOB-04｜上傳路徑（Transaction Bundle ＋ `$submit`）契約與端到端範例

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（可實作性最大缺口） |
| **類別** | 可實作性／遵從性 |
| **預估** | M（3–5 人日） |
| **相依** | 無；JOB-05、JOB-06 會用到本 JOB 的成果 |
| **主要影響檔案** | `input/fsh/profiles/TWHA-Bundle.fsh`、`input/fsh/profiles/TWHA-CapabilityStatement.fsh`、`input/fsh/examples/examples.fsh`、`input/pagecontent/conformance.md`、`input/pagecontent/datamodel.md` |

---

## 1. 問題（證據）

IG 的核心價值主張之一是「事業單位／健檢機構 → 主管機關平台」的**上傳**。
`index.md §4.1` 也明確寫了「上傳用 `type=transaction`」。但實際檢視：

### (1) 上傳路徑零範例

qa.txt：

```
WARNING: StructureDefinition.where(url = '.../TWHA-Bundle-Transaction'): The Implementation Guide contains no examples for this profile
```

`examples.fsh` 中 `InstanceOf` 統計：`TWHABundleDocumentProfile` **7 個**（UC-001~007）、
`TWHABundleTransactionProfile` **0 個**。

即：**七個使用情境全部是報告封包（document），沒有任何一個示範上傳（transaction）。**
平台端拿到這份 IG，沒有可照抄的 request body。

### (2) `$submit` 契約不完整

`input/fsh/profiles/TWHA-CapabilityStatement.fsh` L21–37：

```fsh
Instance: Bundle-submit
InstanceOf: OperationDefinition
Title: "Submit Bundle Operation"
Usage: #definition
* url = "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit"
* name = "Submit"
...
* parameter[0].name = #content
* parameter[0].use = #in
* parameter[0].min = 1
* parameter[0].max = "1"
* parameter[0].type = #Bundle
```

缺漏：

- **無 `description`**（qa.txt 有對應 WARNING：`Unable to find ImplementationGuide.definition.resource.description for the resource OperationDefinition/Bundle-submit`）；
- **無 `use = #out` 參數**——呼叫方不知道成功回什麼、失敗回什麼；
- 無 `parameter[0].profile` 指向 `TWHA-Bundle-Transaction`，所以「submit 什麼」沒有型別約束；
- 未定義錯誤語意（部分成功如何表達？重複上傳是否 idempotent？以什麼識別去重？）。

### (3) CapabilityStatement 不足以做遵從性測試

- `kind = #requirements`，但**未宣告任何 `searchParam`**——`interaction[1].code = #read` 之外，平台端要如何查詢已上傳資料？
- `rest[0].security.description` 只有一句「採用 OAuth 2.0 與 TLS 1.3 安全傳輸協定」，
  無 `security.service`、無 SMART scope（與 JOB-11 相關）。
- 無 `implementationGuide` 欄位回指本 IG。

### (4) Profile 描述與約束不一致

`input/fsh/profiles/TWHA-Bundle.fsh`：

```fsh
Profile: TWHABundleDocumentProfile
Description: "用於健檢報告交換的 Document Bundle，其第一個 entry 必須為 Composition，且型態 (type) 必須為 document。"
* type = #document
* entry 1..*
* entry.resource 1..1
```

描述聲明「**第一個 entry 必須為 Composition**」，但 FSH 中**沒有任何對應約束**
（既無 `entry[0].resource only Composition`，亦無 invariant）。
文件寫了一條規則、機器不檢查——這是委員最容易點出的類型。

---

## 2. 目標與驗收標準

1. `TWHA-Bundle-Transaction` 至少 **2 個**通過驗證的範例：
   - UC-008（假設編號）：一般健檢結果批次上傳（含 Patient + Observation + DiagnosticReport）；
   - UC-009：特殊健檢結果上傳（含危害類別與 LabResult-Special）。
2. `Bundle-submit` OperationDefinition 具備 `description`、`parameter[in].profile`、
   `parameter[out]`（回傳 `OperationOutcome` 或含 issue 之 Bundle）。
3. `TWHA-CapabilityStatement` 宣告可查詢之 `searchParam`（至少 `Patient` 身分識別、
   `Observation.code`、`Observation.date`、`DiagnosticReport.date`），並補 `implementationGuide`。
4. `TWHA-Bundle-Document` 之「第一個 entry 為 Composition」以**可驗證方式**表達
   （`entry[0].resource only Composition`，或 FHIRPath invariant），或修正描述使其與約束一致。
5. `conformance.md` 新增「上傳介接契約」一節：端點、方法、去重規則、回應碼、部分失敗處理。
6. tx 建置後 `contains no examples for this profile` 不再包含 `TWHA-Bundle-Transaction`。

---

## 3. 工作項目

### 3.1 上傳範例（Transaction Bundle）

每個 entry 需含 `request.method` 與 `request.url`。至少示範：

| 情境 | 要點 |
|:--|:--|
| 首次上傳 | `POST` + `fullUrl` 用 `urn:uuid:`，示範內部參照如何解析 |
| 更新既有紀錄 | `PUT` 或 `POST` + `ifNoneExist`（條件式建立），示範**去重**如何達成 |
| 缺值處理 | 至少一個 Observation 使用 `dataAbsentReason`（與治理原則 §4.2.2 呼應，現有 `obs-lab-egfr-absent` 可重用） |

### 3.2 `$submit` 契約定義

補齊 OperationDefinition：

```fsh
* description = "..."   // 說明用途、去重規則、部分失敗語意
* parameter[0].profile = Canonical(TWHABundleTransactionProfile)
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].type = #Bundle          // transaction-response
```

並在 `conformance.md` 定義（這部分是**設計決策，需與平台端確認**）：

- 成功：HTTP 200 + `transaction-response` Bundle；
- 驗證失敗：HTTP 422 + `OperationOutcome`，`issue.expression` 指向出錯的 entry；
- 部分成功是否允許？FHIR transaction 語意為**全有全無**，若平台需要部分成功，
  應改用 `batch` 而非 `transaction`——**這是必須明確決策的點**，目前 IG 未表態。

### 3.3 CapabilityStatement 補強

- 補 `searchParam`（含 `definition` 指向標準 SearchParameter canonical）；
- 補 `implementationGuide = "https://twcore.mohw.gov.tw/ig/twha/ImplementationGuide/mohw.tw.twha"`；
- 考慮拆為兩份：`kind = #requirements`（規範要求）與 `kind = #capability`（平台實際能力），
  現行單一份混用兩種語意。

### 3.4 修正 Bundle-Document 之描述／約束落差

擇一：
- **收緊約束**（建議）：`* entry[0].resource only Composition`，並加 invariant 檢查 `Bundle.entry.first().resource is Composition`；
- 或**放寬描述**：把「必須」改為「建議」，並說明為何不以 profile 強制。

無論哪一種，`datamodel.md` 之對應敘述需同步。

---

## 4. 不在本 JOB 範圍

- 實際平台端 API 實作（本 JOB 只定義契約）。
- OAuth／SMART scope 之完整定義（JOB-11）。
- 其餘 8 個無範例 profile（JOB-05）。

---

## 5. 風險與注意事項

- **`transaction` vs `batch` 的選擇是架構決策**，會影響平台端錯誤處理設計。
  不要在沒有與平台端確認的情況下逕行決定；若無法確認，兩者都定義並註明適用條件。
- 去重規則（以什麼識別判定「同一次健檢」）牽涉 JOB-06 的 NamingSystem；兩個 JOB 需對齊。
- 新增 UC 編號請延續現有 UC-001~007，並同步 `usecases.md` 與 `downloads.md`。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-04-upload-path-conformance.md，並實際檢視
input/fsh/profiles/TWHA-Bundle.fsh、input/fsh/profiles/TWHA-CapabilityStatement.fsh、
input/fsh/examples/examples.fsh、input/pagecontent/conformance.md 與 usecases.md，
為這個 JOB 產出實作計畫。

要求：
1. 設計 2 個 Transaction Bundle 範例（延續 UC 編號），涵蓋首次上傳、條件式建立去重、
   以及 dataAbsentReason 缺值案例。列出每個 entry 的 request.method/url 與 fullUrl 策略。
2. 補齊 Bundle-submit OperationDefinition（description、in 參數的 profile、out 參數）。
3. 提出 transaction 與 batch 語意的比較與建議，明確指出這是需要與平台端確認的架構決策，
   並規劃「無法確認時」的雙軌寫法。
4. 規劃 CapabilityStatement 的 searchParam 宣告清單與 kind 拆分（requirements vs capability）。
5. TWHA-Bundle-Document 的描述說「第一個 entry 必須為 Composition」但沒有對應約束，
   請提出收緊約束或修正描述的方案，並列出需同步的文件段落。
6. 說明每一項如何以 _genonce_tx.bat 的 qa.txt 驗收。
```
