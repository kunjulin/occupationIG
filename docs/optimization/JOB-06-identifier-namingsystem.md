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

## 7. 執行紀錄（2026-07-27）— 第一階段

### 7.1 本 IG 實際使用的 identifier.system（全部盤點）

只有 **5 個**，不是 §2 表格所列的 8 類：

| system URI | 用處 | 出現次數 | 歸屬 |
|:--|:--|--:|:--|
| `…/ig/twha/bundle-id` | `Bundle.identifier` | 7 | **本 IG** |
| `…/ig/twcore/CodeSystem/practitioner-license-tw` | 醫師證書字號 | 1 | TW Core？ |
| `…/ig/twcore/CodeSystem/organization-identifier-tw` | 醫事機構代號 | 1 | TW Core？ |
| `https://gcis.nat.gov.tw` | 事業單位統一編號 | 1 | 經濟部商業司 |
| `https://www.cgmh.org.tw/tw/patient-id` | 受檢者病歷號 | 1 | 單一醫院本地 |

### 7.2 更正 §2 表格的一項誤列

§2 把「勞工通報代碼」列為待定義之識別碼。**這是誤列**：`ext-labor-report-code`
的 `value[x]` 為 `CodeableConcept`，綁定 `VS_LaborReportCode`——它是**代碼值**，
不是識別碼，沒有 `identifier.system` 可言，本 JOB 不需為它定義命名空間。

同理，「去識別化雜湊 Token」目前**未在任何範例或 profile 中出現**，
`security.md` 只是前瞻性提及。在其使用方式定案前定義命名空間是空轉。

### 7.3 已做：`NS-ReportIdentifier`

新增 `input/fsh/namingsystems/NS-ReportIdentifier.fsh`，並將 7 處範例的
`…/ig/twha/bundle-id` 改為 `…/ig/twha/sid/report-id`。

改用 `/sid/` 路徑的理由：原值與 artifact canonical
（`…/ig/twha/StructureDefinition/…`）混在同一層命名空間，分不出這是識別碼命名空間
還是某個 artifact 的 canonical。`/sid/`（system identifier）是 FHIR 慣例。
canonical 目前仍為 provisional，此時改動的成本遠低於日後。

NamingSystem 的 `description` 寫入三項實作端真正需要的規範，而非只是名稱：

- **唯一性**——值在同一健檢機構內唯一；跨機構唯一性由「命名空間＋值」達成。
- **穩定性**——同一份報告更正後重送**應沿用相同識別碼**，否則監理端無從分辨
  「更正」與「新的一筆」。這正是 JOB-04 上傳去重的基礎。
- **不得**以可回推受檢者身分之內容組成（身分證號、病歷號）。

`responsible` 標為「產生封包之健檢機構」而非本 IG 發布者——本 IG 只規範命名空間，
不集中發放識別碼。

### 7.4 未做：其餘 4 個 system，卡在 TW Core 盤點

§3.1 已載明「最大風險是重複定義 TW Core 已有的 system」。身分證統一編號、
統一編號、醫事機構代號、醫事人員證書字號**極可能已由 TW Core 定義**，
在盤點完成前自行另定，會製造同一識別碼兩個 canonical——比現況更糟。

**本環境無法盤點**：`packages.fhir.org`、`packages2.fhir.org`、
`packages.simplifier.net`、`twcore.mohw.gov.tw` 全部連線失敗（實測 HTTP 000）。
CI runner 連得到，故改由 CI 執行：

- `scripts/inspect-package.js` — 吃已解壓的套件目錄，列出其 NamingSystem
  （含 `uniqueId`）、profile 中固定之 `identifier.system`、以及 CodeSystem 清單。
  本檔**不碰網路**，任何環境都能重跑。
- `.github/workflows/inspect-package.yml` — `workflow_dispatch` 專用，下載並解壓後
  呼叫上述腳本，結果寫進 Step Summary。約 1 分鐘。三個 registry 依序重試。

> ⚠️ `workflow_dispatch` 要求 workflow 檔**存在於預設分支**才能觸發。
> 故本工具須先合併至 `main`，盤點才跑得起來。這是本 JOB 第二階段的前置條件。

JOB-10（TWCR_SF mock 依賴治理）同樣需要盤點上游套件，故工具不寫死套件 ID。

### 7.5 待盤點後確認的兩個疑點

**(a) 以 CodeSystem canonical 充當 identifier.system。**
`practitioner-license-tw` 與 `organization-identifier-tw` 兩個 URL 的路徑是
`/CodeSystem/`。`Identifier.system` 的語意是「該識別碼值所屬的命名空間」，
而 CodeSystem 定義的是**代碼**。若 TW Core 的原意是提供識別碼**類別**的代碼，
正確模型應為 `identifier.type.coding.system = <CodeSystem>` ＋
`identifier.system = <命名空間 URI>`，兩者不可混用。
**但這需要看過 TW Core 實際定義才能斷言**——TW Core 也可能同時以 NamingSystem
宣告了同一個 URL。盤點時一併確認。

**(b) 全國性 IG 的範例使用單一醫院的本地命名空間。**
`example-worker` 的病歷號用 `https://www.cgmh.org.tw/tw/patient-id`。
病歷號本就是機構本地識別碼，這件事本身沒錯；問題在於**一份全國性規範的示範資料**
若用特定醫院的命名空間，讀者容易誤讀為建議值。
（附帶發現：IG Publisher 對 `isExampleUrl()` 命中的網址會跳過此項檢查，
故改用明確的範例命名空間可能同時消除該 6 筆警告——待實測。）

### 7.6 尚未量測

`No definition could be found for URL value` 目前基準線 **24**。
定義 NamingSystem 是否足以讓 IG Publisher 視該 URL 為「已定義」，
反編譯未能定論（`isKnownSpace()` 只白名單 `hl7.org`／`terminology.hl7.org`／
`fhir.org/guides`，但那是另一條分支）。**由 CI 實測認定，不預先宣稱**。
若有效，預期降至 17。

---

## 8. 交給 Claude 規劃用提示（可直接複製）

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

---

## 8. TW Core 盤點結果（2026-07-27，run 30280799257）

`tw.gov.mohw.twcore#1.0.0`，以 `scripts/inspect-package.js` 實測。**25 秒完成。**

### 8.1 最重要的一項：TW Core 沒有用 NamingSystem

```
NamingSystem：0 個
```

它把 `identifier.system` **直接固定在 profile 的 element 上**（34 處）：

| system URI | 固定於 | 對應本 JOB §2 之待決項目 |
|:--|:--|:--|
| `http://www.moi.gov.tw` | `Patient-twcore`／`Practitioner-twcore` `.identifier.system` | **國民身分證統一編號** |
| `http://www.immigration.gov.tw` | 同上 | **居留證／統一證號** |
| `http://hl7.org/fhir/sid/passport-TWN` | 同上 | 護照號碼（§2 未列） |
| `https://gcis.nat.gov.tw` | `Organization-co-twcore` | **事業單位統一編號** |
| `https://oid.nat.gov.tw/` | `Organization-govt-twcore` | 政府機關（§2 未列） |
| `…/CodeSystem/organization-identifier-tw` | `Organization-hosp-twcore` | **醫事機構代號** |

另有 `http://terminology.hl7.org/CodeSystem/v2-0203` 固定於
`Patient/Practitioner.identifier.type.coding.system`——TW Core 以 v2-0203
標示識別碼**類別**，與 `identifier.system`（命名空間）分屬兩軸。

**結論：§2 表格 8 項中，身分證號、居留證號、統一編號、醫事機構代號四項
全部由 TW Core 定義，一律沿用，本 IG 不得另定。**
§3.2「定義本 IG 專屬的 NamingSystem」之範圍因此收斂為僅報告封包識別碼一項（已完成）。

### 8.2 §4(a) 之疑慮：撤回

先前質疑「以 CodeSystem canonical 充當 `identifier.system` 是模型錯誤」。
盤點證實 **`organization-identifier-tw` 正是 TW Core 自己用作
`Organization-hosp-twcore.identifier.system` 的值**。

本 IG 的用法與上游一致，**不改**。單方面偏離上游會造成同一識別碼在
TW Core 與本 IG 有兩種表達方式，比現況更糟。

該疑慮於 FHIR 模型層面仍成立（`Identifier.system` 應為命名空間而非代碼系統），
但那是**應向 TW Core 反映的上游議題**，不是本 IG 可片面處置者。
登記為未決事項。

### 8.3 `practitioner-license-tw` 不存在於 TW Core 1.0.0

範例原以 `…/ig/twcore/CodeSystem/practitioner-license-tw` 作為醫師證書字號之
`identifier.system`。盤點實測：

- TW Core 的 **30 個 CodeSystem 中沒有這一項**；
- `Practitioner-twcore` 固定的 `identifier.system` 只有 moi／immigration／passport
  三者，皆為「人別」識別碼，非專業證書字號。

即**上游沒有提供醫事人員證書字號的命名空間**。

**處置（使用者決定）：暫時留空。** 已移除該 `identifier.system`，保留 value
並於範例中註明理由。自行另定會製造同一識別碼兩個 canonical（§5 之最大風險），
且證書字號之發放機關為衛福部，命名空間應由主管機關或 TW Core 決定。

**留空的代價須明載**：此 identifier 不具跨機構唯一性，僅機構內可辨識。
第 19 條之稽核追溯若需跨機構識別執行者，此項必須先解決。

---

## 9. 尚待處理

| # | 項目 | 卡在哪 |
|--:|:--|:--|
| 1 | `Patient`／`Practitioner`／`Organization` 之 identifier slicing 收緊 | 可做——依 §8.1 之 TW Core 固定值對齊 |
| 2 | 範例改用 TW Core 之 system（受檢者身分證號等） | 可做，須與 JOB-05 協調 |
| 3 | 醫事人員證書字號之命名空間 | **未決**——上游未提供，待主管機關／TW Core |
| 4 | 去識別化雜湊 Token | **未決**——使用方式未定案（§3.4） |
| 5 | 全國性 IG 範例使用單一醫院病歷號命名空間 | 待決：改用範例命名空間或保留 |
| 6 | 向 TW Core 反映 CodeSystem-as-identifier.system | 上游議題 |
