# JOB-11｜安全與隱私章節深化（可驗證化，非僅原則宣示）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P2** |
| **類別** | 內容／治理 |
| **預估** | M（3–5 人日） |
| **相依** | JOB-06（識別碼與去識別化 system）、JOB-04（CapabilityStatement security） |
| **主要影響檔案** | `input/pagecontent/security.md`、`input/pagecontent/background.md`（§3.1.1 保存期限）、`input/fsh/profiles/TWHA-CapabilityStatement.fsh`、可能新增 `TWHA-Consent`／`TWHA-Provenance`／`TWHA-AuditEvent` profile |

---

## 1. 問題（證據）

`input/pagecontent/security.md` 全長 **26 行**，內容為三段原則宣示：
傳輸通道（TLS 1.3）、身分驗證（OAuth 2.0 / OIDC）、RBAC 三類角色、去識別化、稽核追蹤。

方向都對，但**沒有任何一項對應到 FHIR 機制**，因此無法實作、也無法驗證。具體落差：

| security.md 現有宣示 | 缺什麼 |
|:--|:--|
| 「採用 OAuth 2.0 及 OpenID Connect」 | 無 SMART on FHIR scope 定義。平台端不知道要發哪些 scope（`patient/Observation.rs`？`system/Bundle.c`？） |
| 「使用智慧醫療憑證進行醫師電子簽章確認」 | 簽章放在 FHIR 的哪裡？`Bundle.signature`？`Provenance`？完全未定 |
| RBAC 三類角色（醫護／職安人員雇主／政府監理） | **這是本 IG 最有價值的安全設計**——雇主不得看檢驗細項——但沒有對應到任何可執行機制（scope、`Consent`、或 Bundle 分層設計）。目前只是文字承諾 |
| 「獲得勞工書面個資授權同意」 | 無 `Consent` 資源建模。同意書怎麼表達、怎麼查核、怎麼撤回，皆未定義 |
| 「稽核軌跡不可被竄改」 | 無 `AuditEvent` 建模，也未說明應記錄哪些欄位 |
| 「身分證字號改以雜湊 Token 代替」 | 無 system URI（JOB-06）、無演算法要求、未說明去識別化後是否可跨機構比對 |
| 「出生日期僅保留年份與月份」 | FHIR `Patient.birthDate` 支援 `YYYY-MM`，但 IG 未在 profile 中允許／要求此精度 |

另有一項與安全直接相關的未決事項在 `background.md §3.1.1`：

> ⚠️ 起算點之解釋尚待確認（M-6）：保存期間應自「檢查日」「報告日」或「勞工離職日」起算…
> 不以 extension 結構化保存期限（列為 backlog：`ext-retention-period`）

即**保存期限目前無法以資料表達**，只能靠實作端各自推導——對「至少保存七年／三十年」這種
法定義務，缺乏結構化表達會讓稽核無法自動化。

---

## 2. 目標與驗收標準

1. `security.md` 由「原則宣示」升級為「可實作規範」，每一條安全要求都對應到：
   FHIR 機制 ／ OAuth scope ／ 實作端責任 ／ 驗證方式。
2. **RBAC 三類角色落實**：至少提出一種可執行機制（建議 SMART scope + Bundle 分層），
   並明確說明「雇主端封包」與「醫護端封包」的內容差異（可用 Composition section 或不同 Bundle profile）。
3. `TWHA-CapabilityStatement` 之 `rest.security` 補 `service`（如 `SMART-on-FHIR`）與 scope 說明。
4. 決定 `Consent`／`Provenance`／`AuditEvent` 是否納入本期範圍：
   - 若納入 → 建立 profile 與範例；
   - 若不納入 → 在 `security.md` 明確說明「本期不定義，實作端應依 X 原則自行處理」，
     並登記 JOB-13。**不可留在「提到但未定義」的中間狀態**。
5. `Patient.birthDate` 之精度處理明確化（去識別化情境下允許 `YYYY-MM`）。
6. 保存期限：決定是否實作 `ext-retention-period`（`background.md` 已預留名稱）。
   若不實作，`background.md` 的 backlog 標記需與 JOB-13 對齊。

---

## 3. 工作項目

### 3.1 SMART scope 對照表

為三類角色各定義 scope 集合，例如（示意，需依平台實際架構確認）：

| 角色 | 可存取 | scope（示意） |
|:--|:--|:--|
| 特約醫護人員 | 完整健檢紀錄 | `patient/Observation.rs patient/Condition.rs patient/DiagnosticReport.rs ...` |
| 職安人員／雇主 | 僅分級、配工、服務發現 | `patient/Observation.rs?category=...` 或改以**專用 Bundle profile** 限制內容 |
| 政府監理 | 去識別化統計／法定個案 | `system/Bundle.c` + 專用端點 |

**重要判斷**：FHIR scope 難以精確表達「同一資源類型的部分欄位可見」。
雇主不得看檢驗數值這件事，用 scope 很難乾淨達成，**更可行的是產出不同的 Bundle／Composition**
（即「雇主版摘要」）。建議在 plan 中比較兩種做法並擇一，這是本 JOB 的核心設計決策。

### 3.2 電子簽章

決定簽章位置（`Bundle.signature` vs `Provenance.signature`）並定義：
簽章類型（`urn:iso-astm:E1762-95:2013` 之 `1.2.840.10065.1.12.1.1` 等）、
簽署者身分如何表達（連結 JOB-06 之醫事人員證書字號）。

### 3.3 去識別化規範化

- 明訂雜湊要求（不可逆、加鹽、salt 由誰保管、是否跨機構共用 salt）；
- 明訂哪些欄位必須移除／降精度（姓名、地址、`birthDate` 精度、`Organization` 是否保留）；
- 說明**去識別化後是否仍需可跨機構比對**——若需要，就必須共用 salt，
  而共用 salt 會降低安全性。這個取捨必須明白寫出來，不能迴避。

### 3.4 與 `Composition-EmergencySummary` 的一致性

本 IG 已有「職業健康急診友善摘要」profile。急診情境下的**緊急存取（break-the-glass）**
是 RBAC 的重要例外，`security.md` 目前完全未提。應補上緊急存取之條件與稽核要求。

---

## 4. 不在本 JOB 範圍

- 平台端的實際 IdP／授權伺服器建置。
- 個資法之法律意見（如需，登記未決事項）。
- 資安等級分類（依衛福部規範，屬行政作業）。

---

## 5. 風險與注意事項

- **不要照抄一般性資安建議**。這一節的價值在於「勞工健檢特有的隱私結構」——
  雇主是資料使用者但不應看到全部內容，這是本領域獨有的張力，也是委員最會關注的地方。
- 若決定不納入 `Consent`／`AuditEvent`，寫清楚「不納入」比含糊提及更好。
- 涉及法規解釋（個資法、勞工健康保護規則第 19 條）時，**不要臆測**，登記為未決事項。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-11-security-privacy-depth.md、input/pagecontent/security.md、
input/pagecontent/background.md §3.1.1（保存期限與 M-6）、
input/fsh/profiles/TWHA-CapabilityStatement.fsh 與 TWHA-Composition-EmergencySummary.fsh，
為這個 JOB 產出實作計畫。

要求：
1. 核心設計決策：security.md 說「職安人員／雇主不得存取詳細檢驗數值」。
   請比較兩種落實方式——(a) SMART on FHIR scope 限制，(b) 產出「雇主版」專用
   Bundle/Composition profile——分析各自能否真正達成欄位級隔離，並給出建議。
2. 為三類角色（醫護／職安雇主／政府監理）規劃 scope 對照表，並補 CapabilityStatement 的
   rest.security.service 與 scope 說明。
3. 決定 Consent / Provenance / AuditEvent 是否納入本期。納入就規劃 profile 與範例；
   不納入就規劃如何在 security.md 明確聲明並登記到 JOB-13。不要留在「提到但未定義」的狀態。
4. 電子簽章：決定放在 Bundle.signature 還是 Provenance.signature，並定義簽署者身分表達方式
   （連結 JOB-06 的醫事人員證書字號）。
5. 去識別化：明訂雜湊要求與欄位處理，並明白寫出「去識別化後是否保留跨機構可比對性」
   這個取捨（共用 salt 的安全代價），不要迴避。
6. 補上急診情境的緊急存取（break-the-glass）規範，與既有 EmergencySummary profile 對齊。
7. 保存期限：評估是否實作 background.md 預留的 ext-retention-period。
8. 遇到法規解釋問題（個資法、第 19 條起算點 M-6）不要臆測，登記為未決事項。
```
</content>
