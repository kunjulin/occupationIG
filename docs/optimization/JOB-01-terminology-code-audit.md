# JOB-01｜術語稽核：133 筆 display 不符之錯碼分流與修正

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（送審阻斷級） |
| **類別** | 術語正確性 |
| **預估** | L（1–2 人週） |
| **相依** | 建議先完成 JOB-08（CI tx 建置），以便逐批驗收 |
| **主要影響檔案** | `input/fsh/valuesets/VS-ExtendedDataset.fsh`、`VS-CoreDataset.fsh`、`VS-OccHealthCheck-Required.fsh`、`input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh`、`input/pagecontent/terminology.md`、`input/assets/display-verification-report.csv`、`input/assets/snomed-loinc-mappings.csv` |
| **既有程序** | `.claude/skills/fhir-tx-audit/SKILL.md`（本 JOB 應沿用，不另立流程） |

---

## 1. 問題（證據）

2026-07-26 tx 建置回報：

- **`Wrong Display Name` × 133**（130 筆在 `VS-ExtendedDataset`，3 筆在 `VS-OccHealthCheck-Required`）
- **`has a status of DISCOURAGED` × 6**

這些訊息是 **INFORMATION／WARNING**，且相關值集已列入 `sushi-config.yaml` 的
`parameters.no-validate`，因此**建置仍是 0 Error**。這正是 `README.md` 自己揭露的盲區。
IG Publisher 訊息本身也寫明其用意：

> this check exists to help check that it's not accidentally the wrong code

專案已於 2026-07-26 依此查出並移除 16 個錯碼（commit `fee90e9`、`7169521`）。
**但仍有至少 8 個代碼的官方語意與 IG 標示根本不同**，最明顯的一筆：

```
14390-9
  IG 標示：Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P
  LOINC  ：Amylase [Enzymatic activity/volume] in Dialysis fluid
```

即以「透析液澱粉酶」的代碼承載「血清 ALT」。同類問題另見
`14409-7`（AST → 胸膜液）、`19199-9`（PSA → 精液）、`1783-0`（ALP → 全血）、
`46986-6`（VLDL-C → VLDL 3 次分群）。

另有 4 筆**量綱不符**（質量濃度 ↔ 莫耳濃度），其中 `42221-2`（尿錳）、`34304-6`（尿氟）
屬附表十具名危害作業之指標，臨床可致誤判。

完整分流表見 [`evidence/qa-summary-2026-07-26.md` §3](evidence/qa-summary-2026-07-26.md#3-術語稽核明細job-01-主要輸入)。

---

## 2. 目標與驗收標準

**目標**：把 133 筆訊息收斂到 0，且每一筆都留下「為什麼這樣改」的可追溯紀錄。

驗收標準：

1. `_genonce_tx.bat` 重建後 `qa.txt` 之 `Wrong Display Name` **= 0**。
2. 6 筆 DISCOURAGED 代碼皆有明確處置（移除／降級為 Acceptable 並附註原因／保留並在 `terminology.md` 說明為何仍需保留）。
3. `input/assets/display-verification-report.csv` 更新為本次全量稽核結果，欄位至少含：
   `code, ig_display, official_display, verdict(A/B/C/D), action(replace/rewrite-display/remove/keep), replacement_code, rationale, verified_by, verified_date`。
4. 凡「換碼」者，`ConceptMap-TWHealthCheckLaboratoryMap.fsh` 之對映與 `terminology.md` §4 對照表同步更新，**不得只改值集**。
5. `input/pagecontent/terminology.md` 新增一節，說明本次稽核之範圍、方法與結果統計（供委員檢視）。
6. `README.md` 更新記錄追加本次稽核條目。

---

## 3. 工作項目

### 3.1 分流（先分流，後修正）

依 `evidence/qa-summary-2026-07-26.md` 之 A/B/C/D 分類逐筆判定：

| 類別 | 處置原則 |
|:--|:--|
| **A 類**（分析物／檢體／概念不同） | **換碼**。以 `$lookup` 確認候選碼之 `COMPONENT/SYSTEM/PROPERTY/METHOD`，再改值集＋ConceptMap＋文件 |
| **B 類**（量綱不符） | 決定「改碼」或「改宣告單位」。若院內以 mg/L、µg/L 報告 → 換質量濃度碼；若確以莫耳濃度報告 → 保留碼並修正 `terminology.md` 之建議單位與 `extended-ucum-reference.csv` |
| **C 類**（display 漂移） | 以官方 display 覆寫。**但檢體範圍不同者（如 `10834-0` Serum vs Serum or Plasma）須另行判斷是否為選碼問題** |
| **D 類**（DISCOURAGED） | 逐碼決定移除／降級／保留＋理由 |

### 3.2 查證方法（沿用既有 skill）

對每個待查代碼執行：

```
GET https://tx.fhir.org/r4/CodeSystem/$lookup?system=http://loinc.org&code=<code>&property=*
```

需同時比對 LOINC 六軸（COMPONENT／PROPERTY／TIME／SYSTEM／SCALE／METHOD），
**不可只看 display 字串相似度**——`14390-9` 的字串長度與 ALT 相近，但六軸完全不同。

### 3.3 換碼候選之覆核（重要）

`evidence` 檔中列出的候選代碼（如 `1743-4`、`1916-6`、`2857-1`、`13458-5`、`6768-6`、`1834-1`、`13965-9`）
**均未經 tx 覆核**，僅為加速查證之提示。實作時**必須**逐一 `$lookup` 確認後才可採用。

### 3.4 回歸防護

- 將 `.claude/skills/fhir-tx-audit/SKILL.md` 之查證步驟固化為可重複執行的腳本
  （例如 `scripts/verify-loinc-displays.js`：讀取值集 → 批次 `$lookup` → 產出 diff 報告）。
- 於 JOB-08 之 CI 中把 `Wrong Display Name > 0` 設為**失敗條件**，防止再度累積。

---

## 4. 不在本 JOB 範圍

- SNOMED CT 代碼之語意稽核（本次 qa 未回報 SNOMED display 問題；若要做，另立 JOB）。
- 值集的分層調整（Core ↔ Extended 搬遷）——屬內容決策，不在術語正確性範圍。
- 新增法規項目對應之代碼（屬 JOB-07）。

---

## 5. 風險與注意事項

- **不要為了消掉訊息而改 display**。133 筆中約 20 筆改 display 是錯的處置，會把錯碼固定下來。
- 換碼會**破壞既有 ConceptMap 與範例**，須同步更新 `examples.fsh` 中引用該碼的 Instance。
- `no-validate` 目前遮蔽了這些值集的部分驗證（JOB-09 處理）；本 JOB 完成後應評估是否可移除 `no-validate`，讓 CI 真正把關。
- `5671-3`（血中鉛）狀態為 DISCOURAGED，但 `VS-OccHealthCheck-Required` 是**法定必驗項目子集**；移除前需確認院內 LIS 實際報告碼，否則會造成實作端無法對應。

---

## 7. 執行紀錄（2026-07-26）— 第一階段：分流

### 關鍵發現：分流毋須連線術語伺服器

`Wrong Display Name` 訊息**本身即含術語伺服器回報的官方 display**：

```
Wrong Display Name 'ALT ... by UV with P5P' for http://loinc.org#14390-9.
Valid display is one of 3 choices: 'Amylase [Enzymatic activity/volume] in Dialysis fluid' (en-US), ...
```

亦即 tx.fhir.org 的權威答案已經寫在 qa.txt 裡。因此**分流階段可完全離線完成**，
只有「A/B 類確認後要換成哪一個碼」才需要 `$lookup`。

### 已完成

| # | 產出 | 說明 |
|--:|:--|:--|
| 1 | `scripts/triage-display-mismatches.js` | 可重複執行之分流工具。解析 qa.txt → 拆解 LOINC 六軸 → 分為 A/B/C/D 四類 → 輸出 CSV |
| 2 | `docs/optimization/evidence/display-triage-2026-07-26.csv` | 131 筆之完整分流工作清單，含每筆的軸差異旗標與待填欄位（`action`／`replacement_code`／`rationale`／`verified_by`／`verified_date`） |

### 分流結果

| 類別 | 判準 | 筆數 |
|:--|:--|--:|
| **A** | COMPONENT 或 SYSTEM 不同 → 高度可疑用錯碼 | **54** |
| **B** | PROPERTY（量綱）不同 → 質量／莫耳濃度互換等 | **20** |
| **C** | 僅 METHOD 或用語差異 → 代碼正確、display 漂移 | **57** |
| D | 無法自動判定 | 0 |

（qa.txt 共 133 筆訊息，去除跨值集重複後為 131 個不同的「代碼＋IG display」組合。）

A 類 54 筆包含先前人工挑出的全部高度可疑者
（`14390-9` ALT→透析液澱粉酶、`14409-7` AST→胸膜液、`19199-9` PSA→精液、
`1783-0` ALP→全血、`46986-6` VLDL-C→VLDL 3、`26505-8`、`26508-2`、`70028-6`、`9633-9`、`19048-8`）。

### 工具的設計取捨（重要）

* **刻意偏向多報**：寧可把 54 筆送人工檢視，也不要漏掉一個錯碼。
  A 類必然包含純命名差異之偽陽性（例如放射科代碼之長名本就精簡），這是可接受的成本。
* **候選挑選**：LOINC 同時提供長名與短名（`RBC # Bld Auto`、`Sp Gr Ur Refractometry`）。
  初版以字串長度挑選比對基準，導致大量假陽性（A 類一度達 64 筆）；已改為
  以與 IG 標示之詞彙重疊度挑選，同分取較長者。
* **已知同義詞**：`WBC↔Leukocytes`、`RBC↔Erythrocytes`、`Uric acid↔Urate`、
  `CYFRA 21-1↔Cytokeratin 19`、以及 LOINC 舊式 `/100 leukocytes` → 現行 `/Leukocytes`，
  皆不視為 COMPONENT 不同。

### 刻意未做

1. **未套用任何 display 覆寫**，即使 C 類看似可批次處理。理由：
   分流器是**篩選工具而非權威**，且 C 類仍可能含「檢體範圍不同」
   （如 `10834-0` Serum or Plasma vs Serum）這類實為選碼問題的案例。
   本 JOB 的核心鐵則正是「顯示名不符可能代表用錯碼」——由一個未經人工覆核的
   啟發式分類器直接改檔，恰好會犯下該鐵則所警告的錯誤。
2. **未覆寫 `input/assets/display-verification-report.csv`**。該檔為已發佈之資產，
   內含既有稽核成果；以不完整的自動分流蓋掉並不恰當。本次產出改置於
   `docs/optimization/evidence/`，待人工覆核完成後再合併回發佈資產。
3. **未決定 A/B 類之替代碼**。本環境無法連線 `tx.fhir.org`（見 JOB-08 §7 之網路限制表），
   無從執行 `$lookup` 覆核。

### 下一步（需可連外環境）

已備妥 `scripts/lookup-loinc.js`——讀取分流 CSV、對 A／B 類 74 碼依序執行 `$lookup`、
解析六軸後併回 CSV。**本工具只取事實不做判斷**，`verdict` 欄一律留空。

完整步驟、可直接複製的提示詞、以及「哪些不是 AI 該決定的」清單，
見 [`RUNBOOK-JOB-01-lookup.md`](RUNBOOK-JOB-01-lookup.md)。

一句話版本（在可連 tx 的機器上）：

```powershell
node scripts/lookup-loinc.js --classes A,B ^
  --csv-out docs/optimization/evidence/display-triage-with-lookup.csv
```

推上分支後即可回主工作流套用變更（值集 ＋ ConceptMap ＋ `terminology.md` ＋ 範例）。
C 類 57 筆於 A/B 決策完成後一併處理（其中若干碼可能因 A/B 之換碼而連帶變動）。

---

## 8. 執行紀錄（2026-07-26）— 第二階段：查證與判定

### 查證結果

於可連外環境執行 `scripts/lookup-loinc.js --classes A,B`（commit `e0be4faa`）：
**74/74 全部成功，零失敗**，即 74 個代碼在 LOINC 中皆存在。
產出 `evidence/lookup-2026-07-26.json`（含官方 display、六軸 LOINC part 代碼、STATUS）。

> 註：tx.fhir.org 對 LOINC 六軸回傳的是 part 代碼（`LP7576-4`）而非可讀文字，
> 故實質判定依據為**官方 display 全文 ＋ STATUS ＋ 代碼存在性**。

### 判定結果（74 筆）

| 判定 | 筆數 | 意義 |
|:--|--:|:--|
| **`confirmed-wrong`** | **10** | 分析物或檢體根本不同，確認用錯碼 |
| **`needs-clinical`** | **23** | 須檢驗科或職業醫學科決定，AI 不得代決 |
| `rewrite-display` | 41 | 代碼正確，僅官方用語與 IG 標示不同 |

判定與逐筆理由已寫入 `evidence/display-triage-with-lookup.csv`
（131 列 × 21 欄，含 `lookup_*` 欄位）。判定表本身固化於
`scripts/apply-job01-verdicts.py`，可重複執行且可審查。

### 確認用錯碼：10 筆

| 代碼 | IG 標示 | LOINC 官方 | 性質 |
|:--|:--|:--|:--|
| `14390-9` | 血清 ALT（UV with P5P） | **Amylase in Dialysis fluid** | 分析物＋檢體皆不同 |
| `14409-7` | AST in Serum or Plasma | AST in **Pleural fluid** | 檢體 |
| `19199-9` | PSA in Serum or Plasma | PSA in **Semen** | 檢體 |
| `1783-0` | ALP in Serum or Plasma | ALP in **Blood** | 檢體 |
| `46986-6` | VLDL-C（計算法） | Cholesterol in **VLDL 3** | 次分群非總量 |
| **`20627-6`** | **Color of Urine（尿液顏色）** | **Turbidity of Urine（濁度）** | **分析物完全不同** |
| **`13705-9`** | Albumin/Creatinine in **Urine** | in **24 hour Urine** | **檢體：隨機尿 vs 24 小時尿** |
| `26505-8` | Hypersegmented neutrophils | **Segmented** neutrophils | 概念 |
| `26508-2` | Neutrophils by Manual count | **Band form** neutrophils | 概念 |
| **`26511-6`** | Neutrophils.**segmented** | Neutrophils（**總量**） | 概念 |

### 本階段新查出、先前未察覺者

1. **`20627-6`「尿液顏色」實為「尿液濁度」** —— 兩個不同的檢驗項目。
2. **`13705-9` 白蛋白／肌酸酐比值實為 24 小時尿** —— 健檢採隨機單次尿，
   採檢方式與臨床判讀皆不同，屬臨床可致誤判之錯誤。
3. **`26511-6` 完成了嗜中性球分類的錯置全貌** —— 與 `26505-8`、`26508-2` 合觀，
   分葉核／帶狀核／總量三者整組錯置，須一併重排而非逐碼修補。
4. **`22322-2` 與 `5193-8` 之標示疑似對調** —— 兩者皆為 B 型肝炎表面抗體：
   `22322-2` 官方為 `[Presence]` 卻被標為 Units/volume；
   `5193-8` 官方為 `[Units/volume]` 卻被標為 Presence。恰好互換。
5. **`50551-1` 與 `5770-3` 在本 IG 中 display 完全相同** —— 但為兩個不同代碼
   （Automated test strip vs Test strip），須確認是否兩者皆需保留。
6. **尿沉渣自動化計數 9 碼之系統性量綱問題** —— `33218-9`／`33219-7`／`33223-9`／
   `33342-7`／`43755-8`／`46419-8`／`46702-7`／`50235-1`／`53324-0` 全部標
   `[#/volume]`，官方皆為 `[#/area]`。屬**同一個決策**（院內儀器報每 µL 或每視野），
   不必逐碼討論。
7. **`33914-3` 為 74 碼中唯一 STATUS ≠ ACTIVE 者**（DISCOURAGED），與既有 D 類判斷一致。

### 過程中修正的自身缺陷

`triage-display-mismatches.js` 之 CSV 輸出損毀：JavaScript 的 `&&`
**回傳最後一個運算元而非布林值**，故 `sysDiff` 在條件成立時變成
`'Serum, Plasma or Blood'` 這類字串；該欄又未經 escape，字串中的逗號
把 `33863-2` 那一列撐成 22 欄（標頭 21 欄）。

分類邏輯以 truthy 判斷，**A/B/C 分類結果不受影響**，損毀的只有 CSV 結構與 diff 欄位。
已修正兩處（強制 `Boolean()` 轉型、所有欄位一律 `esc()`）並重新產生；
現為 131 列 × 21 欄、無殘列。

此缺陷是**下游步驟大聲失敗**才浮現的——若當初 CSV 是靜默地少一欄，
錯誤會一路帶到判定階段。

### 下一步：找 10 個替代碼

`confirmed-wrong` 之 `replacement_code` **一律留空**，因為替代碼必須實際查證而非憑印象。
`scripts/lookup-loinc.js` 已加入 `--search` 模式（`ValueSet/$expand`），
10 道搜尋指令見 [`RUNBOOK-JOB-01-lookup.md`](RUNBOOK-JOB-01-lookup.md) §2b。

流程：搜尋取候選 → 由人挑選 → 對選定碼跑 `--codes` 做 `$lookup` 六軸覆核 → 才填入 CSV。

### 第三階段（2026-07-26）：搜尋候選替代碼

首輪 10 道搜尋 9 道落空——`$expand` 之 `filter` 為**連續子字串**比對而非逐詞 AND，
我給的多詞查詢全部違反此點。改用單一片語後 7 道全部命中。

#### 候選替代碼（**尚待 `$lookup` 六軸覆核**）

| 原碼 | IG 意圖 | 候選替代 | 依據（搜尋回傳之官方 display） |
|:--|:--|:--|:--|
| `14390-9` | ALT with P-5'-P, Ser/Plas | **`1743-4`** | `Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P` |
| `14409-7` | AST with P-5'-P, Ser/Plas | **`30239-8`** | `Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P` |
| `19199-9` | 總 PSA, Ser/Plas | **`2857-1`** | `Prostate specific Ag [Mass/volume] in Serum or Plasma` |
| `1783-0` | ALP, Ser/Plas | **`6768-6`** | `Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma` |
| `46986-6` | VLDL-C 計算法 | **`13458-5`** | `Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation` |
| `20627-6` | 尿液顏色 | **`5778-6`** | `Color of Urine` |
| `13705-9` | ACR 隨機尿 | **`9318-7`** | `Albumin/Creatinine [Mass Ratio] in Urine` |

#### ⚠️ 先前之未覆核候選有誤

第一階段 evidence 檔曾列 `1916-6` 為 AST-with-P5P 之候選。搜尋結果顯示

```
1916-6   Aspartate aminotransferase/Alanine aminotransferase [Enzymatic activity ratio] in Serum or Plasma
```

即 **AST/ALT 比值**，非 AST。若當初照填，等於以「比值」之碼承載 AST 數值——
與原本 `14390-9` 屬同一類錯誤。正確者為 `30239-8`。

這證實了「候選碼一律留空、必須經查證才填入」不是形式主義。

#### 嗜中性球三碼：改判為 `rewrite-display`

比對值集第 224–226 行（手工分類計數區塊）之意圖與官方 display 後發現，
三碼**恰好覆蓋標準 differential 之三個概念**：

| 碼 | IG 標示 | 官方 | 實為 |
|:--|:--|:--|:--|
| `26505-8` | Hypersegmented neutrophils | Segmented neutrophils | 分葉核 |
| `26508-2` | Neutrophils by Manual count | Band form neutrophils | 帶狀核 |
| `26511-6` | Neutrophils.segmented | Neutrophils | 總數 |

即**代碼皆正確，錯的是三個 display 互相錯位**，只需改標籤、毋須換碼。
`confirmed-wrong` 因此由 10 筆降為 **7 筆**。

兩個附帶問題（須臨床決定，已寫入 CSV rationale）：

* 改後 IG 將不再有「過度分葉核」項目——須確認是否真需要
  （巨球性貧血之形態學所見，一般健檢 CBC 不常規報告）。
* 若確需「手工計數」之總嗜中性球，應另採 `23761-0`
  （`Neutrophils/Leukocytes in Blood by Manual count`）。

#### 現況統計

| 判定 | 筆數 |
|:--|--:|
| `confirmed-wrong`（候選已備，待覆核） | **7** |
| `needs-clinical` | 23 |
| `rewrite-display` | 44 |

---

### 23 筆須臨床決定者之歸納（可一次問完）

| 問題 | 涉及代碼 | 問誰 |
|:--|:--|:--|
| 尿液金屬／代謝物以質量或莫耳濃度報告？ | `42221-2` 尿錳、`34304-6` 尿氟、`19177-5` AFP、`2428-1` 同半胱胺酸 | 檢驗科 |
| 自動尿液分析儀報每 µL 或每視野？ | 尿沉渣 9 碼 | 檢驗科 |
| B 肝表面抗體報定性或定量？（兩碼疑似對調） | `22322-2`、`5193-8` | 檢驗科 |
| 血清學項目報定性、定量或效價？ | `5176-3` 幽門桿菌、`9633-9` EBV、`43371-4` 糞便培養 | 檢驗科 |
| 試紙尿糖／尿酮採定性判讀？ | `5792-7`、`5797-6` | 檢驗科 |
| 維生素 D 報總量或僅 D3？ | `62292-8` | 檢驗科 |
| 巨核細胞或巨核細胞核？ | `70028-6` | 檢驗科 |
| MDRD eGFR（DISCOURAGED）移除或保留？ | `33914-3` | 職業醫學科 |

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-01-terminology-code-audit.md 與
docs/optimization/evidence/qa-summary-2026-07-26.md，並依 .claude/skills/fhir-tx-audit/SKILL.md
的程序，為這個 JOB 產出實作計畫。

要求：
1. 先做分流，不要直接改檔。針對 evidence §3.2 的 A 類 10 筆與 §3.3 的 B 類 4 筆，
   逐碼以 tx.fhir.org $lookup 取得六軸（COMPONENT/PROPERTY/TIME/SYSTEM/SCALE/METHOD），
   列出「確認錯碼／確認正確／需臨床決策」三種結論，並提出經查證的替代碼。
   evidence 檔中的候選碼未經覆核，請勿直接採用。
2. C 類約 110 筆請提出可批次執行的方式（腳本或逐檔 edit 清單），但要標出其中
   「檢體範圍不同」的案例需人工判斷，不可批次覆寫。
3. D 類 6 筆 DISCOURAGED 請各給處置建議與理由，特別是 5671-3（血中鉛，在法定必驗子集內）
   與 33914-3（MDRD eGFR）。
4. 計畫須包含：ConceptMap 同步、terminology.md 同步、examples.fsh 受影響 Instance、
   display-verification-report.csv 更新格式、以及一個可重複執行的驗證腳本。
5. 分批提交，每批一個 commit，並說明每批如何以 _genonce_tx.bat 驗收。

注意：本環境可能無法連外至 tx.fhir.org。若無法連線，請改為產出「逐碼查證工作清單」
（含要打的 $lookup URL 與判定準則），由我在可連外環境執行後回報結果，你再據以修正。
```

---

## 9. 執行紀錄（2026-07-26）— 第四階段：套用變更

### 第一批：7 筆錯碼（CI run 30224842336）

換碼 5 筆、移除 2 筆、嗜中性球三碼改 display。
`Wrong Display Name` **133 → 123（−10）**，恰為本批動到之代碼數。

動手前查出兩筆不能「換」只能「移除」：`2857-1`（PSA Preferred）與
`6768-6`（ALP Preferred）**本來就在值集中**，逕行替換會產生重複代碼。

### 第二批：97 個代碼之 display（CI run 30227494797）

`Wrong Display Name` **123 → 23（−100）**、`info` 494 → 394。
（97 個代碼產生 100 筆訊息，因部分代碼同時出現於多個值集。）

覆寫 113 處：`VS-ExtendedDataset` 97、`VS-OccHealthCheck-Required` 3、
`ConceptMap` 13。工具為 `scripts/apply-job01-displays.py`（可重複執行、含 `--dry-run`）。

順帶揭露：**ConceptMap 中 Acceptable／Preferred 配對的方法學後綴一路貼反**，
例如 `26515-7` 標「by Automated count」而官方無方法、`777-3` 標無方法而官方為
「by Automated count」；`3016-3` 標「by 3rd IS」而官方為一般 TSH、`11580-8` 標
一般 TSH 而官方為高敏感度。實作者照原標示會誤判哪一個才是自動化／高敏感度版本。
Preferred/Acceptable 之**指派**經檢視為正確，錯的僅是標籤。

### 累計成果

| 指標 | 起始 | 現在 | 降幅 |
|:--|--:|--:|--:|
| `Wrong Display Name` | 133 | **23** | **−110（−83%）** |
| `TOTAL info` | 257 → 504（語言／釘版之連帶） | 394 | — |
| `TOTAL warn` | 208 | 165 | −43 |
| `TOTAL err` | 0 | 0 | — |

**剩餘 23 筆恰等於 `needs-clinical` 之筆數**——即已無可由本專案逕行處理之項目，
全數待檢驗科／職業醫學科決定。該 23 筆之 display 不符是未決問題的訊號，
**刻意保留不覆寫**；決策完成後方可處理。

### 尚待外部決策（8 個問題，涵蓋 23 筆）

見 §8 末之歸納表。其中「自動尿液分析儀報每 µL 或每視野」一題即涵蓋 9 筆，
建議優先確認。
