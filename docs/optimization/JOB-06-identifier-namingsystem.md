# JOB-06｜識別碼命名系統（NamingSystem）定義與範例對齊

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1** |
| **類別** | 術語／治理 |
| **預估** | S（1–2 人日） |
| **相依** | 與 JOB-04（去重規則）、JOB-05（範例）對齊 |
| **主要影響檔案** | 新增 `input/fsh/namingsystems/`、`input/fsh/examples/examples.fsh`、`input/fsh/profiles/TWHA-Patient.fsh`、`TWHA-Practitioner.fsh`、`TWHA-Organization.fsh`、`input/pagecontent/terminology.md` |

---

## 1. 問題（證據）

qa.txt 有 **24 筆** `No definition could be found for URL value`，分布：

```
7 × Bundle/UC-N: Bundle.identifier.system
7 × Bundle/UC-N: ... Practitioner/example-doctor .identifier[N].system
6 × Bundle/UC-N: ... Patient/example-worker  .identifier[N].system
（其餘為 Organization 等）
```

另有 **7 筆** INFORMATION：

```
Bundle.entry[N].resource/*Practitioner/example-doctor*/.identifier[N]: This element does not match
any known slice defined in the profile .../TWHA-Practitioner (this may not be a problem, but you
should check that it's not intended to match a slice)
```

意義：範例中使用了 identifier system URI，但 IG **沒有任何地方定義這些 URI 是什麼**。
對實作端而言，這是最實際的痛點之一——「勞工的身分識別要放在哪個 system 下？」
「事業單位要用統一編號還是勞保投保單位編號？」目前 IG 沒有答案。

而這件事對本 IG 尤其關鍵，因為：

- **跨機構交換**需要一致的病人識別（`index.md §2.1` 列為痛點之一）；
- **上傳去重**需要穩定的封包識別（JOB-04）；
- `security.md` 提到「身分證字號改以雜湊 Token 代替」，那個 Token 的 system 也需定義；
- 保存期限推導（第 19 條）需要能追溯執行者，執行者識別必須可解析。

---

## 2. 目標與驗收標準

1. tx 建置後 `No definition could be found for URL value` **= 0**。
2. `Practitioner.identifier` 的 slice 不匹配 INFORMATION 訊息消除（或明確說明為刻意允許之額外 identifier）。
3. 建立 NamingSystem 定義，至少涵蓋下列識別碼（實際清單請於 plan 中確認）：

| 識別對象 | 用途 | 備註 |
|:--|:--|:--|
| 國民身分證統一編號 | 勞工身分識別 | 應確認是否已由 TW Core IG 定義；**若有，直接沿用，不要重複定義** |
| 居留證號／統一證號 | 外籍勞工 | 特殊健檢族群中占比不低 |
| 去識別化雜湊 Token | 上傳監理系統用 | 與 `security.md` §2 呼應 |
| 事業單位統一編號 | 雇主識別 | 需決定統編 vs 勞保投保單位編號 |
| 醫事機構代號 | 健檢機構識別 | 衛福部醫事機構代號 |
| 醫事人員證書字號 | 醫師／護理師／職業衛生護理師 | 對應第 19 條稽核追溯 |
| 健檢報告／封包識別 | `Bundle.identifier` | 上傳去重之基礎（JOB-04） |
| 勞工通報代碼 | `ext-labor-report-code` | 已有 extension，但 system 未定義 |

4. `terminology.md` 新增「識別碼命名系統」一節，列出每個 system URI、發放機關、格式規則、
   是否可用於跨機構比對、以及去識別化時的處置。
5. 所有範例改用已定義之 system URI。

---

## 3. 工作項目

### 3.1 先查 TW Core IG（重要，避免重複定義）

本 IG 繼承 `tw.gov.mohw.twcore 1.0.0`。**身分證號、醫事機構代號等很可能已由 TW Core 定義**。
第一步必須是盤點 TW Core 已提供的 identifier system 與 NamingSystem，
**能沿用的一律沿用**——自行另定會造成同一個識別碼有兩個 canonical，是比現況更糟的結果。

盤點方式：檢視 `input-cache` 或 `.fhir` 套件快取中的 `tw.gov.mohw.twcore` 內容，
或查 TW Core IG 發佈站之 Artifacts 頁。

### 3.2 定義本 IG 專屬的 NamingSystem

只針對 TW Core 未涵蓋、且屬勞工健檢領域特有者，例如：

- 健檢報告／上傳封包識別；
- 勞工通報代碼；
- 去識別化雜湊 Token。

FSH 形式（示意）：

```fsh
Instance: ns-twha-report-id
InstanceOf: NamingSystem
Usage: #definition
* name = "TWHAReportIdentifier"
* status = #draft
* kind = #identifier
* date = "2026-07-26"
* responsible = "..."
* description = "健檢報告／上傳封包之識別碼；用於上傳去重與跨機構參照。"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* uniqueId[0].preferred = true
```

### 3.3 收緊 Profile 的 identifier slicing

`TWHA-Patient`（現僅 510 bytes）、`TWHA-Practitioner`（312 bytes）、
`TWHA-Organization` 目前對 identifier 幾乎沒有約束，因此範例的 identifier 落在 slice 之外。
需依 §3.1／§3.2 的結論加上 slicing 與 `patternIdentifier`／`system` 固定值。

### 3.4 去識別化與識別碼的關係

`security.md` 說「身分證字號改以雜湊 Token 代替」。本 JOB 應把這句話落實為：
哪個 system、什麼雜湊演算法（或至少要求「不可逆且加鹽」）、salt 由誰保管、
以及**去識別化後是否仍可跨機構比對**（這是個重要取捨，需明確表態）。

若無法決定，登記為 JOB-13 未決事項，但 system URI 仍應先定義。

---

## 4. 不在本 JOB 範圍

- 實際的雜湊實作與 salt 管理機制（屬平台建置，非 IG）。
- 統編 vs 勞保投保單位編號之政策決定（若無法確認，登記未決事項並同時定義兩者）。

---

## 5. 風險與注意事項

- **最大風險是重複定義 TW Core 已有的 system**。務必先盤點再定義。
- NamingSystem 的 `status` 在正式 canonical 核定前應為 `draft`，並與 JOB-13 的 provisional 聲明一致。
- 改動 identifier slicing 會使既有範例驗證失敗，須與 JOB-05 同步排程。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-06-identifier-namingsystem.md，並檢視
input/fsh/profiles/TWHA-Patient.fsh、TWHA-Practitioner.fsh、TWHA-Organization.fsh
與 input/fsh/examples/examples.fsh 中實際使用的 identifier.system，為這個 JOB 產出實作計畫。

要求：
1. 第一步是盤點 tw.gov.mohw.twcore 1.0.0 已定義的 identifier system / NamingSystem
   （查套件快取或 TW Core IG 發佈站）。能沿用的一律沿用，明確列出「沿用」與「本 IG 自訂」兩份清單。
   不要重複定義身分證號這類 TW Core 很可能已有的識別碼。
2. 為本 IG 自訂者撰寫 NamingSystem（FSH），並規劃 Patient/Practitioner/Organization 的
   identifier slicing 收緊方式。
3. 規劃 terminology.md 的「識別碼命名系統」新章節內容結構。
4. 針對 security.md 提到的「身分證字號改以雜湊 Token」，規劃如何落實為可實作的規範
   （system URI、不可逆要求、是否保留跨機構可比對性）。無法決定的政策問題請登記為未決事項。
5. 列出改動 identifier slicing 後會失效的範例，以及與 JOB-05 的協調順序。
6. 驗收：qa.txt 之 "No definition could be found for URL value" 歸零。
```
</content>
