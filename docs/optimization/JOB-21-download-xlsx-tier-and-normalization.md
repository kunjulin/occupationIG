# JOB-21｜下載用值集試算表補列層級與歸一資訊，並修正 12 筆層級標示不一致

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（可實作性；另附帶查出 1 筆語意矛盾與 9 筆標註缺漏） |
| **類別** | 可實作性／術語正確性 |
| **預估** | S–M（1–2 人日） |
| **相依** | JOB-17（`build-download-xlsx.js` 已建立）、JOB-19／20（閘門模式）、**JOB-22（equivalence 方向修正——本 JOB 之 equivalence 欄輸出須待其完成）** |
| **主要影響檔案** | `scripts/build-download-xlsx.js`、`input/assets/loinc-valuesets.xlsx`、`input/fsh/valuesets/VS-CoreDataset.fsh`、`VS-ExtendedDataset.fsh`、`input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh`、`input/pagecontent/downloads.md`、`scripts/check-asset-consistency.js` |
| **來源** | 主持人檢視發佈站下載檔後提出（2026-07-30）；查證時另發現層級標示不一致 |

---

## 1. 問題（證據）

### 1.1 下載檔無法區辨 Preferred 與 Acceptable

`loinc-valuesets.xlsx` 現為三欄（`Section` / `LOINC Code` / `Display Name`）。
**acceptable 碼確實都在檔內**，但無欄位標明層級，且 `Section` 欄係 FSH 之區塊註解，
故 acceptable 列之 Section 也顯示「— Preferred ○○○」：

```
2093-3    09001C 總膽固醇 — Preferred 2093-3      ← 這是 Preferred
35200-5   09001C 總膽固醇 — Preferred 2093-3      ← 這是 Acceptable，Section 卻寫 Preferred
```

讀者只能靠「同一 Section 之第一列才是 preferred」此一**隱含且未載明**之規則反推。
LDL 三列最易誤讀（`2089-1`／`13457-7`／`18262-6` 之 Section 皆為「Preferred 2089-1（方法通用碼…」）。

### 1.2 歸一關係不在任何下載檔

acceptable → preferred 之對映共 **39 組**（含 equivalence 為 `narrower` 或 `relatedto` 之區別），
僅存在於網站之 ConceptMap 資源頁，**未出現於任何可下載之結構化檔案**。

實作端要判斷「送 `13457-7` 能否視為 `2089-1`、數值可否直接比較」，須自行翻頁比對。
`relatedto`（需換算、不可直接比較）與 `narrower`（方法特化、可比較）之差別對資料正確性
影響甚大——尿沉渣 9 組即為 `relatedto`。

### 1.3 ⚠️ 層級標示之兩個來源不一致（12 筆）

本 JOB 規劃時交叉比對「FSH 之 `// Acceptable` 註解」與「ConceptMap 之 source 碼集」，
發現二者不一致。此為新發現，非原提問範圍：

```
FSH 標 // Acceptable            : 33 碼
ConceptMap source（acceptable）: 39 碼
交集                            : 30 碼
```

#### A 類：FSH 標 Acceptable 但 ConceptMap 無歸一（3 筆）——**真缺漏**

| 代碼 | 項目 | 應歸一至 |
|:--|:--|:--|
| `57735-3` | 尿蛋白試紙（自動）| `5804-0`（尿蛋白定性 Preferred） |
| `63557-3` | B 肝表面抗原免疫法定量 | `5196-1`（HBsAg Preferred） |
| `19876-2` | FVC pre-bronchodilation | `19868-9`（FVC Preferred） |

標為 acceptable 卻無歸一路徑，**實作端送出該三碼時無法歸一**。

#### B 類：ConceptMap 有歸一但 FSH 未標 Acceptable（9 筆）

| 代碼 | 歸一至 | equivalence | 性質 |
|:--|:--|:--|:--|
| `1744-2` | `1742-6` | narrower | ALT 無 P-5'-P 法，**應補 `// Acceptable` 註解** |
| `88112-8` | `1920-8` | narrower | AST 無 P-5'-P 法，同上 |
| `83082-8` | `10334-1` | narrower | CA-125 免疫法，同上 |
| `83085-1` | `2039-6` | narrower | CEA 免疫法，同上 |
| `23749-5` | `77307-7` | relatedto | 血鉛 Specimen 泛稱碼，同上 |
| `26508-2` | `770-8` | relatedto | 嗜中性球手工計數，同上 |
| `33914-3` | `98979-8` | relatedto | MDRD eGFR，**附件已標 Acceptable，FSH 漏註** |
| `56086-2` | `8280-0` | relatedto | 腰圍 PhenX protocol 碼，**不在任何值集**——刻意保留歸一以容納院所送舊碼，屬正常，**應排除於檢查** |
| **`2888-6`** | **`5804-0`** | **relatedto** | **⚠️ 語意矛盾，須裁示（見 §1.4）** |

### 1.4 ⚠️ `2888-6` → `5804-0` 之矛盾（須裁示）

```
Core FSH:
  // 06003C 尿蛋白定量 — Preferred 2888-6
  * LNC#2888-6 "Protein [Mass/volume] in Urine"       ← 醫令 06003C-1 之 Preferred
  // 06003C 尿蛋白定性 — Preferred 5804-0
  * LNC#5804-0 "Protein [Presence] in Urine by Test strip"  ← 醫令 06003C-2 之 Preferred

ConceptMap element:
  2888-6 → 5804-0   equivalence = relatedto
  comment = "定量(Mass/volume)與試紙法屬不同量測方式，非包含關係"
```

**二者皆為各自醫令項目之 Preferred**（06003C-1 定量、06003C-2 定性），
於 Core 主表為兩個獨立列。既為獨立項目，**不應存在 acceptable→preferred 之歸一關係**——
歸一之語意為「送 A 時視為 B」，而定量與定性係不同檢驗、不同醫令代碼，不可互相取代。

該 element 之 comment 自身即載明「非包含關係」，equivalence 亦為 `relatedto`，
與「歸一」之用途相牴觸。

**請勿自行決定，此項須主持人裁示。** 兩個選項見 §3.4。

---

## 2. 目標與驗收標準

**目標**：使下載檔具備層級與歸一資訊，並使「FSH 註解」與「ConceptMap」二來源之
層級標示達成一致且由閘門維持。

驗收標準（**一律以 CI 實測**）：

1. `loinc-valuesets.xlsx` 之 Core／Extended 分頁欄位擴為：
   `Section` / `LOINC Code` / `Display Name` / **`層級 Tier`** / **`歸一至 Normalizes To`** /
   **`equivalence`** / **`備註 Note`**。
2. 新增第三分頁 **`ConceptMap 歸一`**，列出全部 39 組（source／source display／target／
   target display／equivalence／comment）。
3. 檔案維持**位元組可重現**，並仍受 `check:assets` 攔阻。
4. **新增閘門類別 `層級標示不一致`**：值集內標 `// Acceptable` 之碼集，與 ConceptMap
   之 source 碼集（排除不在任何值集者）**必須一致**；不一致筆數 `> 0` 即失敗。
5. §1.3 之 A 類 3 筆補歸一、B 類 8 筆補註解（`56086-2` 除外，列為允許清單）。
6. `2888-6` 依 §3.4 之裁示處置。
7. `err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` ＝ **288**（不動值集成員）。
8. ConceptMap element 總數 ＝ **41**（現行 39 − `2888-6` 1 組 ＋ A 類 3 組）。

---

## 3. 工作項目

### 3.1 `build-download-xlsx.js` 加欄

- **`層級 Tier`**：判定來源以 **ConceptMap 為準**（結構化資料優於註解）——
  代碼為 ConceptMap source 者標 `Acceptable`、為 target 者標 `Preferred`、
  二者皆非者標 `（單一碼）`。
- **`歸一至 Normalizes To`** 與 **`equivalence`**：自 ConceptMap 取得。
- **`備註 Note`**：取 FSH 該行之行內註解（去除 `// ` 前綴），該註解已載明為何為 acceptable。
- `Section` 欄**維持原樣**（係 FSH 區塊註解，變動會影響位元組可重現性之基準），
  惟新增之 `層級` 欄已足以解除歧義。

### 3.2 新增 `ConceptMap 歸一` 分頁

> ⚠️ **`equivalence` 欄之輸出須待 JOB-22 完成後方可進行。**
> 現行 ConceptMap 有 16 組之 equivalence 方向與 FHIR R4 規範相反
> （文件之判準定義為 source-relative，R4 為 target-relative），另有 5 組之
> comment 與 display 相互矛盾。**若於 JOB-22 前輸出，等於將 16 個錯誤值公開於下載檔。**
>
> **執行順序**：先完成 JOB-22（修正 equivalence 與 comment），再執行本 JOB 之 §3.2。
> 本 JOB 之其餘工作項目（§3.1 層級欄、§3.3 一致性閘門、§3.4 `2888-6`、§3.5 文件）
> 不受影響，可先行。

39 組全列。`equivalence` 欄請以顯著格式標示 `relatedto`——
該值意為**需換算、數值不可直接比較**，是本檔對實作端最關鍵之資訊。

建議於該分頁首列或 `downloads.md` 加一行說明：

> `narrower`＝source 為 target 之方法特化，數值可直接比較；
> `relatedto`＝二者關聯但需換算或屬不同量測方式，**數值不可直接比較**。

### 3.3 一致性閘門

於 `check-asset-consistency.js`（或新增腳本）加入：

```
A = { 值集內標 // Acceptable 之碼 }
B = { ConceptMap source 碼 } ∩ { 值集內之碼 }
A △ B 必須為空集合（對稱差）
```

`56086-2` 等**刻意保留於 ConceptMap 但已移出值集**者，因已被 `∩ 值集內之碼` 排除，
無須另設允許清單；若日後出現值集內之例外，須以具名允許清單處理並附理由。

### 3.4 `2888-6` 之處置（**已裁示：甲案，移除該 element**）

> **主持人裁示（2026-07-30）：採甲案——移除 `2888-6 → 5804-0` 之 element。**

**裁示理由**（供實作時寫入 commit message 與 `terminology.md`）：

`2888-6`（尿蛋白定量，醫令 06003C-1）與 `5804-0`（尿蛋白定性，醫令 06003C-2）
**各為獨立醫令項目之 Preferred**，於主管機關最小上傳集為兩個獨立列。

acceptable→preferred 之歸一，其語意為「送 A 時視為 B」。定量與定性係**不同檢驗、
不同醫令代碼、不同 Property（Mass/volume vs Presence）**，不可互相取代——
該 element 自身之 comment 即載明「非包含關係」，與「歸一」之用途相牴觸。

進一步言，本 IG 之 acceptable 實含三種性質不同之情形：

| 實際關係 | 可否歸一 | 例 |
|:--|:--|:--|
| 方法特化／通用 | 可，數值可比較 | `13457-7` → `2089-1` |
| 不同量綱，需換算 | 可交換但須換算（`relatedto`） | 尿沉渣 `33218-9` → `51480-2` |
| **不同檢驗項目** | **不可，非 acceptable** | **`2888-6` vs `5804-0`** |

`2888-6` 屬第三類，故不應存在於 acceptable→preferred 之 ConceptMap 中。

**處置**：移除該 element。ConceptMap 組數 39 → 38；再加 §1.3 A 類 3 組 → **41**。
`2888-6` 於新增之 `層級` 欄回歸 `Preferred`（與 Core 主表一致）。

> 二者之臨床關聯（同一醫令 06003C 之定量與定性兩子項）如仍需說明，
> 請於 `terminology.md` 之敘述段落記載，**不得放回 ConceptMap**。

### 3.5 `downloads.md` 補註

說明新增欄位之意義，並載明「層級判定以 ConceptMap 為準」及 equivalence 之判讀方式。

---

## 4. 不在本 JOB 範圍

- **不得變更任何值集之成員代碼**（`VS-ExtendedDataset` 維持 288）。本 JOB 僅動註解、
  ConceptMap 之組數，以及下載檔之欄位。
- 不處理 SNOMED CT 之下載檔（`snomed-mappings.xlsx`）之欄位擴充——其 33 列
  `snomed_status` 現為「待覆核」，待 SNOMED 側稽核另案處理後再議。
- 不新增任何 LOINC 代碼。A 類之 3 組歸一使用**既有**碼，B 類僅補註解。

---

## 5. 風險與注意事項

- **層級判定之來源選擇**：本 JOB 明定以 **ConceptMap 為準**而非 FSH 註解。
  理由為註解不受任何檢查、易漏（本次即查出 9 筆漏註），而 ConceptMap 是結構化資源
  且已受 `check-asset-consistency.js` 檢查。§3.3 之閘門則反向確保註解跟上。
- **位元組可重現性**：加欄後須重新產生並提交，否則 `check:assets` 會失敗。
  請確認固定列序、固定樣式之設計未被破壞。
- **`relatedto` 之顯示**：勿將 `relatedto` 與 `narrower` 以相同樣式呈現。
  尿沉渣 9 組、eGFR、血鉛均為 `relatedto`，若實作端誤以為可直接比較數值，
  屬臨床可致誤判之風險。
- **`2888-6` 勿自行裁示**。這是設計層之判斷，涉及主管機關最小上傳集之兩個獨立醫令項目。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-21-download-xlsx-tier-and-normalization.md，產出實作計畫。

要求：
1. 本 JOB 有兩部分：(a) 下載檔加欄與新增 ConceptMap 分頁（原提問範圍）；
   (b) 修正規劃時查出之 12 筆層級標示不一致（新發現）。請分開規劃。
2. 層級判定必須以 ConceptMap 為準，不以 FSH 之 // Acceptable 註解為準。
   請說明為什麼——提示：本次即查出 9 筆漏註，而註解不受任何檢查。
3. §3.3 之一致性閘門是本 JOB 的核心產出，不是附屬品。請說明你將如何計算
   對稱差、以及為何 56086-2 不需要允許清單。
4. 2888-6 → 5804-0 已由主持人裁示採甲案（移除該 element），理由見 §3.4。
   請依該裁示執行，並將理由寫入 commit message 與 terminology.md。
   移除後 2888-6 於層級欄應回歸 Preferred。
5. equivalence 欄之 relatedto 必須與 narrower 有視覺區別。請說明你的作法，
   並解釋為什麼這對臨床安全有意義。
6. ⚠️ 執行順序：§3.2 之 equivalence 欄輸出須待 JOB-22 完成。現行有 16 組
   equivalence 方向與 R4 相反，先輸出等於把錯誤值公開。其餘項目可先行。
   請在計畫中明確標示此一相依。
7. 驗收：err = 0、Wrong Display Name = 0、VS-ExtendedDataset = 288、
   層級標示不一致 = 0、下載檔位元組可重現且通過 check:assets、
   ConceptMap element 總數 = 41。
8. 完成後回報：commit、CI run id、上述數值、以及 A 類 3 組歸一之 equivalence 選擇與理由
   （請注意：A 類 3 組之 equivalence 選擇須依 JOB-22 §3.3 之 R4 target-relative 判準）。
```
