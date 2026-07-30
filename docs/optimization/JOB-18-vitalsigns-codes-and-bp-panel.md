# JOB-18｜生理量測方法特化碼補列、血壓 panel 汰換與吸菸量單位更正

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（正確性：含一個 DISCOURAGED 碼位於法定必驗子集、一個量綱不符之 UCUM） |
| **類別** | 術語正確性／院際差異容納 |
| **預估** | S（0.5–1 人日） |
| **相依** | 無 |
| **主要影響檔案** | `input/fsh/valuesets/VS-TWHAVitalSigns.fsh`、`VS-OccHealthCheck-Required.fsh`、`input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh`、`input/pagecontent/terminology.md`、`input/assets/snomed-loinc-mappings.csv` |
| **來源** | 委託單位提問後之延伸查證（2026-07-30，loinc.org 官方頁面逐碼） |

---

## 1. 問題（證據）

本 JOB 處理三個各自獨立、但同屬生理量測與社會史範圍之缺陷。

### 1.1 身高／體重缺方法特化之 Acceptable 碼（院際差異容納缺口）

經 loinc.org 官方頁面查證（查證日 2026-07-30）：

| 代碼 | Long Common Name | 狀態 | 六軸與 Preferred 之差異 |
|:--|:--|:--|:--|
| `8302-2`（現行 Preferred） | Body height | Active | — |
| **`3137-7`** | **Body height Measured** | **Active** | **僅 Method 軸不同**（`Measured` vs 未指定） |
| `29463-7`（現行 Preferred） | Body weight | Active | — |
| **`3141-9`** | **Body weight Measured** | **Active** | **僅 Method 軸不同** |

`3137-7` 之 FSN 為 `Body height:Len:Pt:^Patient:Qn:Measured`；
`3141-9` 之 Component／Property／Scale 分別為 Body weight／Mass／Qn，Method 為 Measured。

此二碼與其 Preferred 之關係，**與本指引低密度脂蛋白膽固醇之處理完全同型**：

```
2089-1   Cholesterol in LDL ... in Serum or Plasma       ← Preferred（方法未指定）
13457-7  Cholesterol in LDL ... by calculation           ← Acceptable，narrower
18262-6  Cholesterol in LDL ... by Direct assay          ← Acceptable，narrower
```

ConceptMap `element[7]` 之 comment 即「source 指定計算法，target 方法未指定」。

**現況缺口**：`VS-TWHAVitalSigns` 僅收 `8302-2`、`29463-7`；ConceptMap **完全無身高、體重之歸一組**
（腰圍已有 `56086-2 → 8280-0`）。以 `Measured` 方法碼上傳之機構，無歸一路徑。

### 1.2 血壓 panel 使用 DISCOURAGED 碼，且兩值集不一致

| 代碼 | 官方顯示名 | 狀態 |
|:--|:--|:--|
| `55284-4` | Blood pressure systolic and diastolic | **DISCOURAGED** |
| `85354-9` | Blood pressure panel with all children optional | **ACTIVE** |

同一「血壓 panel」概念，在指引中用了兩個不同代碼：

| 位置 | 用碼 |
|:--|:--|
| `VS-Appendix9-RequiredSet.fsh:34` | `85354-9`（ACTIVE） |
| **`VS-OccHealthCheck-Required.fsh:16`** | **`55284-4`（DISCOURAGED）** |
| `terminology.md:162` 對照表 | `55284-4` |
| `input/assets/snomed-loinc-mappings.csv:30` | `55284-4` |
| `input/fsh/examples/02-vitals-and-physical.fsh:59` | `85354-9` |
| `input/pagecontent/datamodel.md:78` | `85354-9` |

`VS-OccHealthCheck-Required` 為**法定必驗項目子集**，於此使用 DISCOURAGED 碼較 Extended 更不妥。

**且該碼無保留理由。** 全指引 6 個 DISCOURAGED 碼中，`33914-3`（MDRD eGFR，具國健署公文依據）
與 `5671-3`（血中鉛，院內 LIS 相容）均有明載理由；`55284-4` 僅為漏改。

### 1.3 吸菸量之 UCUM 量綱不符

`64218-1` 經 loinc.org 查證（2026-07-30）：

```
Long Common Name : How many cigarettes do you smoke per day now [PhenX]
FSN              : How many cigarettes do you smoke per D now:NRat:Pt:^Patient:Qn:
Property         : NRat（Number rate ＝ Count/Time）
Method           : NULL（LOINC 2.72 移除，因該概念非 PhenX 專屬）
Example UCUM     : /d
Status           : Active
```

本指引與交付文件（附件 v7.1、修訂案 v1.0／v2.0）均將其 UCUM 標為 **`{pack}/d`（包／日）**，
且修訂案 v1.0 之註記載「支數/20 換算 packs/day」。

**此為量綱不符（JOB-01 之 B 類）**：以「支／日」之代碼承載「包／日」之值，
實作端將把 20 支誤讀為 20 包。交付文件已更正為附件 v7.2 與修訂案 v2.1，
**指引本體之 UCUM 標示須一併更正**。

> 若確有交換 pack-year 或 packs/day 之需求，須另尋對應代碼並經 `$lookup` 查證，
> **不得沿用 `64218-1`**。

---

## 2. 目標與驗收標準

驗收標準（**一律以 CI 實測**）：

1. `VS-TWHAVitalSigns` 收錄 `3137-7`、`3141-9`，display 逐字採官方 Long Common Name
   （`Body height Measured`、`Body weight Measured`）。
2. ConceptMap 新增 2 組：`3137-7 → 8302-2`、`3141-9 → 29463-7`，
   equivalence 均為 **`#narrower`**，comment 沿用 LDL 組之句式。
   ConceptMap `element` 總數由 37 增為 **39**。
3. `VS-OccHealthCheck-Required` 之 `55284-4` 改為 `85354-9`；
   `terminology.md` 與 `snomed-loinc-mappings.csv` 之對照列同步更正。
4. `terminology.md` 之 UCUM 對照表中，`64218-1` 之建議單位由 `{pack}/d` 改為 `/d`，
   並註明「若需 pack-year 須另尋代碼」。
5. **DISCOURAGED 代碼數由 6 降為 5**（`1709-5`、`2532-0`、`33914-3`、`35200-5`、`5671-3`），
   `55284-4` 不再出現於任何值集。
6. `err = 0`、**`Wrong Display Name = 0`**（新增 2 碼之 display 若非逐字官方字串即會破功）。
7. `VS-ExtendedDataset` 成員數維持 **288**（本 JOB 不動 Extended）。
8. `qa-baseline.json` 之變動須具名歸因。

---

## 3. 工作項目

### 3.1 `VS-TWHAVitalSigns.fsh`

於 `8302-2`、`29463-7` 之後分別加入：

```
* LNC#8302-2 "Body height"
* LNC#3137-7 "Body height Measured"      // Acceptable：方法特化碼（Method = Measured）；經 ConceptMap 歸一至 8302-2
* LNC#29463-7 "Body weight"
* LNC#3141-9 "Body weight Measured"      // Acceptable：方法特化碼（Method = Measured）；經 ConceptMap 歸一至 29463-7
```

> display 必須逐字為 `Body height Measured` 與 `Body weight Measured`
> （loinc.org 之 Long Common Name）。任何增減字元都會使 `Wrong Display Name` 由 0 變非 0。

### 3.2 ConceptMap 新增 2 組

現有 `element[0]`–`element[36]`（共 37）。新增 `element[37]`、`element[38]`：

| element | source | target | equivalence |
|:--|:--|:--|:--|
| `[37]` | `3137-7` Body height Measured | `8302-2` Body height | `#narrower` |
| `[38]` | `3141-9` Body weight Measured | `29463-7` Body weight | `#narrower` |

comment 請沿用 LDL 組之句式，例如「source 指定量測方法（Measured），target 方法未指定」。

> equivalence 為 `#narrower` 而非 `#relatedto`：二者為同一概念之方法特化與通用之關係，
> 數值可直接比較，屬包含關係。此與尿沉渣（量綱不同、需換算，故用 `relatedto`）不同，
> **請勿混用**。

### 3.3 血壓 panel 汰換

1. `VS-OccHealthCheck-Required.fsh` 第 16 行：`55284-4` → `85354-9`，
   display 為 `Blood pressure panel with all children optional`。
2. `terminology.md` 第 162 行對照表之血壓 Panel 列同步更正。
3. `input/assets/snomed-loinc-mappings.csv` 第 30 行之 `loinc_preferred` 由
   `55284-4` 改為 `85354-9`（SNOMED `75367002` 不變）。
4. 於 `terminology.md` 加註本次汰換理由（`55284-4` 狀態為 DISCOURAGED；
   指引其餘處已採 `85354-9`，本次統一）。

### 3.4 吸菸量 UCUM 更正

`terminology.md` 之 UCUM 建議單位表中，`64218-1` 由 `{pack}/d` 改為 `/d`，
並加註：「官方 Property 為 NRat（Count/Time），單位為支／日。若需交換 pack-year 或
packs/day，須另尋對應代碼並經查證，不得沿用本碼。」

同時檢查 `input/fsh/profiles/` 與 `input/fsh/examples/` 是否有以 `{pack}/d` 表達
`64218-1` 之範例；若有，一併更正並確認範例仍通過驗證。

---

## 4. 不在本 JOB 範圍

- **不得變更 `VS-ExtendedDataset`**（維持 288 碼）。
- 不處理 `63632-4`（戒菸月數）之代碼替換。該碼為 TUS-CPS 調查工具情境碼，
  經治理裁示依「與官方對齊並揭露」原則**保留**，僅需於 `terminology.md`
  加註其 Class 為 PHENX、Method 為 TUS-CPS 之性質。
- 不新增 `63924-5`。該碼官方語意為「嘗試戒菸期間曾最長停止多久 [PLCO]」
  且附 7 級序數選項清單，與「戒菸至今多久」語意及量表雙重不符，**確認為語意錯碼**。
- 不處理 pack-year／packs/day 之代碼尋找（須另案並經查證）。

---

## 5. 風險與注意事項

- **display 逐字**是本 JOB 唯一的高風險點。`3137-7`／`3141-9` 之官方 Long Common Name
  為 `Body height Measured`／`Body weight Measured`——不含 `[...]`、不含逗號。
- **equivalence 勿混用**：本 JOB 之 2 組為 `#narrower`（方法特化，可比較）；
  JOB-14 之尿沉渣 9 組為 `#relatedto`（量綱不同，需換算）。混用會使實作端誤判
  數值是否可直接比較。
- **`55284-4` 汰換須四處同步**（值集、`terminology.md`、`snomed-loinc-mappings.csv`、
  以及檢查是否有範例引用）。JOB-01 之教訓即「不得只改值集」。
- 本 JOB 完成後，交付文件（附件 v7.2、修訂案 v2.1）與指引本體即完全一致；
  在此之前，兩者於吸菸量 UCUM 一項存在已知落差（文件為 `/d`、指引為 `{pack}/d`），
  該落差方向為「文件已正確、指引待更正」。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-18-vitalsigns-codes-and-bp-panel.md，為該 JOB 產出實作計畫並執行。

要求：
1. 本 JOB 含三件互相獨立的事：(a) 補列身高／體重之方法特化 Acceptable 碼並建歸一，
   (b) 血壓 panel 由 55284-4（DISCOURAGED）改為 85354-9（ACTIVE），
   (c) 更正 64218-1 之 UCUM 由 {pack}/d 為 /d。
   請在計畫中分別說明，勿混為一談。
2. 新增之 2 個代碼 display 必須逐字為 "Body height Measured" 與 "Body weight Measured"。
   請在計畫中先寫出你將寫入的兩行 FSH 全文供覆核，再動手。
3. equivalence 必須為 #narrower（方法特化與通用之包含關係，數值可比較），
   不是 #relatedto。請說明你如何區辨此二者，並指出 JOB-14 之尿沉渣為何用 relatedto。
   這一題答錯即為理解錯誤。
4. 55284-4 之汰換須四處同步：值集、terminology.md 對照表、
   input/assets/snomed-loinc-mappings.csv、以及檢查 examples 是否引用。
   只改值集不算完成（JOB-01 §2 驗收條件第 4 點）。
5. 驗收：err = 0、Wrong Display Name = 0、ConceptMap element 總數 = 39、
   VS-ExtendedDataset 成員數 = 288、且全指引之 DISCOURAGED 代碼數由 6 降為 5
   （55284-4 不再出現）。最後兩項為本 JOB 之防呆。
6. 回報：commit、CI run id、上述五項驗收數值。
```

---

## 附錄　本次查證之官方頁面摘錄（loinc.org，查證日 2026-07-30）

| 代碼 | Long Common Name | Class | Method | 狀態 | 例示單位 | 判定 |
|:--|:--|:--|:--|:--|:--|:--|
| `3137-7` | Body height Measured | BDYHGT.ATOM | Measured | Active | — | 收為 Acceptable |
| `3141-9` | Body weight Measured | BDYWGT.ATOM | Measured | Active | kg、lb | 收為 Acceptable |
| `64218-1` | How many cigarettes do you smoke per day now [PhenX] | PHENX | NULL | Active | **`/d`** | UCUM 更正 |
| `63632-4` | About how long has it been since you completely quit smoking cigarettes [TUS-CPS] | PHENX | TUS-CPS | Active | d、wk、mo、a | 保留並揭露 |
| `63924-5` | What was the longest length of time you stopped smoking because you were trying to quit [PLCO] | PHENX | PLCO | Active | d、wk、mo、a | **語意錯碼，不採** |
| `55284-4` | Blood pressure systolic and diastolic | — | — | **DISCOURAGED** | — | 汰換 |
| `85354-9` | Blood pressure panel with all children optional | — | — | Active | — | 採用 |

> LOINC 內容版權屬 Regenstrief Institute, Inc.，本表僅為查證紀錄之摘要引用。
