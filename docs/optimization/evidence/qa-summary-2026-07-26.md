# 證據附件：2026-07-26 tx 建置 QA 摘要

> 來源：gh-pages `9fd146f` 之 `qa.txt`
> `TWHAIG : Validation Results — err = 0, warn = 208, info = 257`
> `IG Publisher Version: 2.2.11`
> `Generated Sun Jul 26 18:51:12 CST 2026. FHIR version 4.0.1 for mohw.tw.twha#0.1.0`
> 建置路徑：`C:\repo\occupationIG-main\...`（Windows 本機建置，非 CI）

本檔為各 JOB 的共用證據來源。**重跑 tx 建置後請一併更新本檔**，
使 JOB 驗收有可比對的基準線。

---

## 1. 訊息分類統計

以訊息特徵字串計數（同一筆訊息可能同時落入多類，故不等於 warn+info 總數）：

| 訊息特徵 | 筆數 | 等級 | 對應 JOB |
|:--|--:|:--|:--|
| `Wrong Display Name` | **133** | INFORMATION | JOB-01 |
| `has a status of DISCOURAGED` | 6 | WARNING | JOB-01 |
| `should have an OID assigned` | 40 | WARNING | JOB-09 |
| `should have a performer`（Best Practice） | 47 | WARNING | JOB-05 |
| `There are multiple different potential matches`（缺 `pin-canonicals`） | 29 | WARNING | JOB-09 |
| `No definition could be found for URL value`（identifier.system） | 24 | WARNING | JOB-06 |
| `contains no examples for this profile` | 9 | WARNING | JOB-05 |
| `contains no examples for this extension` | 5 | WARNING | JOB-05 |
| `binds to the value set ... which is experimental, but this structure is not labeled as experimental` | 11 | WARNING | JOB-09 |
| `HTML fragment ... is not included anywhere` | 4 | WARNING | JOB-03 |
| `SHOULD conform to the ShareableValueSet profile`（`experimental` 缺漏） | 4 | WARNING | JOB-10 |
| `Constraint failed: vsd-0`（ValueSet.name 非 UpperCamelCase） | 4 | WARNING | JOB-10 |
| `Unable to find ImplementationGuide.definition.resource.description`（`OperationDefinition/Bundle-submit`） | 1 | WARNING | JOB-04 |

### 缺漏之 HTML fragment（JOB-03）

```
WARNING: 1: The HTML fragment 'ip-statements.xhtml' is not included anywhere in the produced implementation guide
WARNING: 2: An HTML fragment from the set [cross-version-analysis.xhtml, cross-version-analysis-inline.xhtml] is not included anywhere ...
WARNING: 3: An HTML fragment from the set [dependency-table.xhtml, dependency-table-short.xhtml, dependency-table-nontech.xhtml] is not included anywhere ...
WARNING: 4: The HTML fragment 'globals-table.xhtml' is not included anywhere in the produced implementation guide
```

已於 `input/pagecontent/*.md` 全域搜尋 `{%`，**無任何 Jekyll include**，確認四者皆未納入。

---

## 2. 無範例之 Profile／Extension（JOB-05）

**Profiles（9）**

```
TWHA-Bundle-Transaction      ← 最關鍵：上傳路徑無任何範例
TWHA-CarePlan
TWHA-DiagnosticReport
TWHA-ECG
TWHA-HealthManagementLevel
TWHA-ImagingStudy
TWHA-Occupation
TWHA-ServiceRequest
TWHA-SocialHistory-Alcohol
```

**Extensions（5）**

```
ext-cessation-duration
ext-fitness-for-work
ext-hazard-type
ext-labor-report-code
ext-smoking-quantity
```

`input/fsh/examples/examples.fsh` 現有 53 個 Instance，`InstanceOf` 分布中
`TWHABundleDocumentProfile` 有 7 個、`TWHABundleTransactionProfile` **0 個**。

---

## 3. 術語稽核明細（JOB-01 主要輸入）

### 3.1 重要前提

`Wrong Display Name` 在 IG Publisher 中是 **INFORMATION 等級**，
且 `sushi-config.yaml` 之 `parameters.no-validate` 已列入
`VS-ExtendedDataset`、`VS-CoreDataset`、`VS-OccHealthCheck-Required` 等 6 個值集。
因此這 133 筆**不會**讓建置失敗——這正是 `README.md` 已自我揭露的盲區：

> 語法合法但語意錯誤的代碼在離線建置下完全不會報錯

訊息自身也提醒：

> Note that the display in the ValueSet does not have to match;
> **this check exists to help check that it's not accidentally the wrong code**

所以處理原則是：**每一筆都要判斷「是 display 漂移，還是用錯碼」，不可一律改 display 了事。**

### 3.2 A 類｜高度可疑「用錯碼」（分析物／檢體／概念根本不同）

> ⚠️ 下表「官方 display」欄取自 tx.fhir.org 於本次建置之回報，為可信證據。
> 「候選代碼」欄**未經 `$lookup` 覆核**，僅供加速查證，**不得直接採用**。

| # | 代碼 | IG 目前標示 | LOINC 官方 display | 判讀 | 候選（待覆核） |
|--:|:--|:--|:--|:--|:--|
| 1 | `14390-9` | ALT ... in Serum or Plasma by UV with P5P | **Amylase** [Enzymatic activity/volume] in **Dialysis fluid** | 分析物與檢體皆不同，確定錯碼 | ALT with P-5'-P：`1743-4` |
| 2 | `14409-7` | AST ... in Serum or Plasma by UV with P5P | AST ... in **Pleural fluid** | 檢體錯誤 | AST with P-5'-P：`1916-6` |
| 3 | `19199-9` | Prostate specific Ag ... in Serum or Plasma | Prostate specific Ag ... in **Semen** | 檢體錯誤 | 總 PSA：`2857-1` |
| 4 | `46986-6` | Cholesterol in VLDL ... by calculation | Cholesterol in **VLDL 3** | 次分群而非總 VLDL-C | VLDL-C 計算：`13458-5` |
| 5 | `1783-0` | ALP ... in Serum or Plasma | ALP ... in **Blood** | 檢體不同 | ALP S/P：`6768-6` |
| 6 | `26505-8` | **Hypersegmented** neutrophils/100 leukocytes | **Segmented** neutrophils/Leukocytes | 概念不同 | 需查證 |
| 7 | `26508-2` | Neutrophils/100 leukocytes by Manual count | **Band form** neutrophils/Leukocytes | 概念不同（帶狀核 vs 總嗜中性球） | 需查證 |
| 8 | `70028-6` | Megakaryocytes/100 leukocytes | Megakaryocytic **nuclei**/Leukocytes by Manual count | 需覆核是否為所欲之概念 | 需查證 |
| 9 | `9633-9` | EBV VCA IgA Ab **[Presence]** in Serum | EBV capsid IgA Ab **[Titer]** by Immunofluorescence | 量表型別不同（定性 vs 效價） | 需查證 |
| 10 | `19048-8` | Erythroblasts/100 leukocytes **by Automated count** | Nucleated erythrocytes/Leukocytes **[Ratio]**（無方法） | 需覆核 | 需查證 |

### 3.3 B 類｜量綱／單位不符（會導致 `Quantity.unit` 與數值誤讀）

質量濃度（Mass/volume）與莫耳濃度（Moles/volume）互換是**臨床可致誤判**的錯誤，
其中尿錳為附表十具名危害作業（錳及其化合物）之指標，優先處理。

| # | 代碼 | IG 目前標示 | LOINC 官方 display | 判讀 |
|--:|:--|:--|:--|:--|
| 1 | `42221-2` | Manganese **[Mass/volume]** in Urine | Manganese **[Moles/volume]** in Urine | 特殊健檢指標，需改用質量濃度碼或改宣告單位 |
| 2 | `34304-6` | Fluoride **[Mass/volume]** in Urine | Fluoride **[Moles/volume]** in Urine | 同上（氟化物作業） |
| 3 | `19177-5` | Alpha-1-fetoprotein **[Mass/volume]** | Alpha-1-Fetoprotein **[Moles/volume]** | AFP 國內以 ng/mL 報告，應改 `1834-1`（待覆核） |
| 4 | `2428-1` | Homocysteine **[Moles/volume]** | Homocysteine **[Mass/volume]** | 反向不符 |

### 3.4 C 類｜display 漂移（代碼判定正確，僅顯示名未同步官方用語）

約 110 筆屬此類，可**機械式**以官方 display 覆寫。典型型態：

| 型態 | 例 |
|:--|:--|
| 省略方法學後綴 | `789-8` IG:`Erythrocytes [#/volume] in Blood` → 官方 `... by Automated count` |
| 沿用舊式 `/100 leukocytes` 命名 | `26478-8`、`26485-3`、`30180-4` 等 CBC 分類計數共約 20 筆 → 官方已改 `/Leukocytes` |
| 使用縮寫別名 | `6690-2` IG:`WBC ...` → 官方 `Leukocytes ...`；`3084-1` IG:`Uric acid` → 官方 `Urate` |
| 檢體描述寬鬆 | `10834-0` IG:`Serum or Plasma` → 官方 `Serum`；`33863-2` IG:`Serum, Plasma or Blood` → 官方 `Serum or Plasma` |
| 方法學細節有出入 | `11580-8`、`3016-3`、`59261-8`、`33914-3` |

> C 類仍須逐筆過目：`10834-0`、`33863-2` 這類「檢體範圍不同」的案例，
> 若院內實際以 plasma 報告，就不只是 display 問題，而是**代碼選擇**問題。

### 3.5 D 類｜LOINC 狀態為 DISCOURAGED（6 碼，WARNING）

| 代碼 | 出現位置 | 備註 |
|:--|:--|:--|
| `5671-3` | `VS-OccHealthCheck-Required`、`VS-ExtendedDataset`、`ConceptMap-TWHealthCheckLaboratoryMap` | **血中鉛**。已於 `7169521` 將 Preferred 改為 `77307-7`，但 `5671-3` 仍以 Acceptable 保留且狀態為 DISCOURAGED，須決定是否降級／移除 |
| `33914-3` | `VS-ExtendedDataset`、ConceptMap | eGFR（MDRD 公式）。臨床已改採 CKD-EPI；Core 已收 `88293-6`，宜評估移除 MDRD |
| `35200-5` | `VS-CoreDataset`、ConceptMap | 總膽固醇（無方法學）。Core 值集內含 DISCOURAGED 碼需特別說明 |
| `55284-4` | `VS-OccHealthCheck-Required` | 血壓 panel |
| `1709-5` | `VS-ExtendedDataset` | — |
| `2532-0` | `VS-ExtendedDataset` | LDH |

---

## 4. 其他已確認之現況（非 qa.txt，來自原始碼檢視）

| # | 現況 | 證據 | JOB |
|--:|:--|:--|:--|
| 1 | 網站根 `index.html` 僅 560 bytes，內容為 `langs=["en"]` ＋ `lang-redirects.js` 轉址殘骸 | `git show origin/gh-pages:index.html` | JOB-02 |
| 2 | `en/index.html` 為 `<html lang="en">`，但 `<title>` 與全文為繁體中文 | `git show origin/gh-pages:en/index.html` | JOB-02 |
| 3 | publish box 文字為 `Local Development build (v0.1.0) built by the FHIR ... Build Tools`，並連向不存在的 `https://twcore.mohw.gov.tw/ig/twha/history.html` | 同上 | JOB-02 |
| 4 | gh-pages 無 `package-list.json`（僅有 `sub-package-list.json` 與 template 自帶樣本 `template/package/package-list.json`） | `git ls-tree -r origin/gh-pages` | JOB-02 |
| 5 | `ig.ini` 之 `template = fhir2.base.template#current` 未釘版 | `ig.ini` | JOB-09 |
| 6 | `conformance.html` 有建置產出，但 `sushi-config.yaml` 之 `menu` 未列入 → 孤兒頁 | `sushi-config.yaml` L41–62 vs `en/conformance.html` | JOB-12 |
| 7 | `downloads.md` 只列 UC-001~006，缺 UC-007（急診友善摘要）；`display-verification-report.csv`、`extended-ucum-reference.csv`、`Appendix10-to-HazardType.xlsx` 未列 | `input/pagecontent/downloads.md` vs `input/assets/` | JOB-12 |
| 8 | `TWHA-Bundle-Document` 描述聲明「第一個 entry 必須為 Composition」，但 FSH 內**無對應約束** | `input/fsh/profiles/TWHA-Bundle.fsh` | JOB-04 |
| 9 | `Bundle-submit` OperationDefinition 無 `description`、無 `parameter[out]`／回傳定義 | `input/fsh/profiles/TWHA-CapabilityStatement.fsh` L21–37 | JOB-04 |
| 10 | `TWHA-CapabilityStatement` 未宣告任何 `searchParam`，`kind = #requirements` | 同上 | JOB-04 |
| 11 | `TWCRSF-mocks.fsh` 在 `https://hapi.fhir.tw/...`（他方 canonical）下定義 5 CodeSystem ＋ 4 ValueSet，且為全 repo 唯一未標 `experimental` 的術語檔 | `input/fsh/codesystems/TWCRSF-mocks.fsh` | JOB-10 |
| 12 | `scripts/check-pagecontent-refs.js` 回報 3 筆未解析引用，其中 3/3 皆為文件已明示之 backlog 標記（`ext-retention-period`、`VS-Appendix9-RequiredSet`、`VS-Appendix9/10-RequiredSet`）→ 檢查器產生假警報 | 執行結果 | JOB-12 |
| 13 | `input/ignoreWarnings.txt` 以泛用字串抑制 `No server available`、`PKIX path building failed` → 在 tx 建置中會**一併吞掉真實的術語伺服器連線失敗** | `input/ignoreWarnings.txt` | JOB-09 |
| 14 | `security.md` 僅 26 行，全為原則宣示；未對應到任何 FHIR 機制（Consent／Provenance／AuditEvent／SMART scope） | `input/pagecontent/security.md` | JOB-11 |
| 15 | 根目錄有 `implementation_plan_0615.md`、`_0622.md`、`_0622b.md` 三份歷史計畫；4 個 PDF 附表原始檔亦置於根目錄 | `ls` | JOB-12 |
| 16 | repo 無 `CLAUDE.md`、無 `.github/workflows/` | `ls -a` | JOB-08 / JOB-12 |
</content>
