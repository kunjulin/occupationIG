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

```bash
# 1) 重新產生分流（以最新 CI 之 qa.txt 為準）
node scripts/triage-display-mismatches.js --qa output/qa.txt \
     --csv docs/optimization/evidence/display-triage-<date>.csv

# 2) 對 A(54) + B(20) 逐碼取六軸
curl "https://tx.fhir.org/r4/CodeSystem/\$lookup?system=http://loinc.org&code=<code>&property=*"
```

逐碼填寫 CSV 之 `action`／`replacement_code`／`rationale`／`verified_by`／`verified_date`，
再據以修改值集、ConceptMap、`terminology.md` 與受影響範例。
C 類 57 筆於 A/B 決策完成後一併處理（其中若干碼可能因 A/B 之換碼而連帶變動）。

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
</content>
