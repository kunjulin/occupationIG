# JOB-22｜ConceptMap equivalence 方向修正、comment 覆核與 R4／R5 對照表

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（16 組 equivalence 方向與 FHIR R4 規範相反；該值已對外發佈） |
| **類別** | 術語正確性／規範符合性 |
| **預估** | S（1 人日） |
| **相依** | 無。**JOB-21 之 equivalence 欄輸出須待本 JOB 完成後方可進行** |
| **主要影響檔案** | `input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh`、`input/pagecontent/terminology.md`、`qa-baseline.json`、（文件端：文件二 §5.4） |
| **來源** | 主持人詢問「國際上如何處理 relatedto」後之規範查證（2026-07-30） |

---

## 1. 問題（證據）

### 1.1 根因：文件之判準定義與 FHIR R4 相反

文件二 §5.4「equivalence 重新分類」之定義表載明：

```
narrower | 來源碼語意較窄（如指定方法之碼歸一至方法通用碼）
wider    | 來源碼語意較廣
```

即以 **source 為主詞**（source-relative）。惟 FHIR R4 之官方定義為 **target-relative**
（查證來源：`https://hl7.org/fhir/R4/codesystem-concept-map-equivalence.html`，v4.0.1）：

> `narrower` — The **target** mapping is narrower in meaning than the source concept.
> `wider` — The **target** mapping is wider in meaning than the source concept.

**ConceptMap 完全依照本專案文件之定義執行，內部一致；但該定義與 R4 規範相反。**
故 16 組之 equivalence 值方向顛倒。

> 此為一致性偏移而非隨機錯誤——所有 comment 之敘述均正確描述了語意關係，
> 錯的只是所選用之代碼。故可機械翻轉，不需重新判斷語意。

### 1.2 影響範圍：16 組

| 現值 | 應為 | 組數 | 判別依據（comment 之敘述） |
|:--|:--|--:|:--|
| `narrower` | **`wider`** | **13** | 「source 指定○○方法，target 方法未指定」→ target 較 wider |
| `wider` | **`narrower`** | **3** | 「source 為未指定…語意較 target 廣」→ target 較 narrower |

不受影響者 23 組（`relatedto` 21、`equivalent` 2）。

### 1.3 附帶查出：5 組 comment 與 display 相互矛盾

**此 5 組不可只翻轉 equivalence，須先修正 comment 並重新判定語意關係。**

| element | source → target | comment 主張 | display 事實 |
|:--:|:--|:--|:--|
| `[11]` | `26515-7` → `777-3` | 「source 指定 Automated count，target 方法未指定」 | **相反**：source 未指定、target 為 `by Automated count` |
| `[18]` | `3016-3` → `11580-8` | 「source 指定 3rd IS 標準品，target 未指定」 | **相反**：source 未指定、target 為 `by Detection limit <= 0.0…`（高敏感度） |
| `[0]` | `804-5` → `6690-2` | 「source 指定 Manual count，**target 方法未指定**」 | target 實為 `by Automated count`（**亦為具名方法**） |
| `[1]` | `26464-8` → `6690-2` | 「同概念、同檢體、**方法均未指定**」 | target 為 `by Automated count`（**已指定**） |
| `[13]` | `28539-5` → `785-6` | 「同概念、**同方法(Automated count)**」 | source 為 `MCH [Entitic mass]`（**未指定方法**） |

此為 JOB-01 批 2 所揭露「Acceptable／Preferred 方法學後綴一路貼反」之**殘留**——
當時修正了 display，comment 未同步修正。

**其中 `[0]`、`[1]`、`[13]` 三組之 equivalence 選擇本身亦須重新判定：**

- `[0]` `804-5`（Manual count）→ `6690-2`（Automated count）：**兩者皆為具名且不同之方法**，
  不存在包含關係，**應為 `relatedto`**（比照 `[6]` `26508-2 → 770-8` 之處理：
  「Manual 與 Automated 為不同具體方法，無包含關係」）。
- `[1]` `26464-8`（方法未指定）→ `6690-2`（Automated count）：source 較廣、target 較窄，
  **應為 `narrower`**（R4：target 較 narrower），非 `equivalent`。
- `[13]` `28539-5`（方法未指定）→ `785-6`（Automated count）：同上，**應為 `narrower`**。

---

## 2. 目標與驗收標準

1. 16 組方向顛倒者依 §3.1 翻轉。
2. §1.3 之 5 組 comment 修正為與 display 相符；其中 `[0]`、`[1]`、`[13]` 之 equivalence
   依 §1.3 末段重新判定。
3. `terminology.md` 新增 **R4／R5 equivalence 對照表**（§3.3），明訂本 IG 之判準
   並載明 R4 為 target-relative。
4. **全組自我檢查**：comment 中「source 指定…／target 未指定」之敘述方向，須與
   equivalence 值一致；不一致即失敗（§3.4）。
5. `err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` ＝ **288**（不動值集）。
6. ConceptMap element 總數 ＝ **39**（本 JOB 不增減組數）。
7. equivalence 分佈預期為：`relatedto` 22（21 ＋ `[0]` 改判）、`wider` 13、
   `narrower` 5（3 翻轉 ＋ `[1]`、`[13]` 改判）、`equivalent` 0 — **請以實作後實測值為準，
   勿以本表為目標反推**。

---

## 3. 工作項目

### 3.1 方向翻轉（16 組）

以 comment 之敘述為判準：

```
comment 含「source 指定…，target …未指定」→ target 較 wider  → equivalence = #wider
comment 含「source 為未指定…語意較 target 廣」→ target 較 narrower → equivalence = #narrower
```

**請以腳本產生變更清單供覆核後再套用**，勿逐行手改（16 組易漏）。
`[11]`、`[18]`、`[0]`、`[1]`、`[13]` 五組**排除於自動翻轉**，依 §3.2 個別處理。

### 3.2 五組 comment 與語意重判

| element | 處置 |
|:--:|:--|
| `[11]` `26515-7 → 777-3` | comment 改為「source 方法未指定，target 指定 Automated count」；equivalence 依 R4 為 **`narrower`**（target 較窄） |
| `[18]` `3016-3 → 11580-8` | comment 改為「source 為一般 TSH（未指定偵測極限），target 指定高敏感度」；equivalence **`narrower`** |
| `[0]` `804-5 → 6690-2` | comment 改為「Manual 與 Automated 為不同具體方法，無包含關係」；equivalence 改 **`relatedto`** |
| `[1]` `26464-8 → 6690-2` | comment 改為「source 方法未指定，target 指定 Automated count」；equivalence 改 **`narrower`** |
| `[13]` `28539-5 → 785-6` | comment 改為「source 方法未指定，target 指定 Automated count」；equivalence 改 **`narrower`** |

> `[0]` 之處理請與既有之 `[6]` `26508-2 → 770-8`（已標 `relatedto`，comment
> 「Manual 與 Automated 為不同具體方法，無包含關係」）保持一致——同一種情形不應有兩種標法。

### 3.3 `terminology.md` 新增 R4／R5 對照表

於 equivalence 判準段落，將現行敘述替換為下表並明載 R4 為 target-relative：

| 本 IG 之語意意圖 | R4（現行，`equivalence`） | R5（未來，`relationship`） | 數值可否直接比較 |
|:--|:--|:--|:--|
| source 為方法特化、target 為通用碼 | **`wider`** | `source-is-narrower-than-target` | 可 |
| source 較廣、target 較窄（如空腹指定） | **`narrower`** | `source-is-broader-than-target` | 須注意條件差異 |
| 不同量綱／不同具體方法，需換算 | `relatedto` | `related-to` | **不可** |
| 完全等義 | `equivalent` | `equivalent` | 可 |

並加註兩點：

1. **R4 之 `narrower`／`wider` 以 target 為主詞**（「target 較 narrower／wider」），
   與直覺相反；R5 已改為 `source-is-…-than-target` 之明確表述。**本表即為升 R5 之遷移對照。**
2. **R4 之 `relatedto` 為階層頂點（Level 1），其官方定義為「關係存在但確切關係未知」。**
   本 IG 以之承載「需換算／不同量測方式」，係因 R4 無「需單位換算」之專用代碼；
   此一用法之限制應予揭露，俾實作端知悉不可據以自動換算。

### 3.4 一致性自我檢查

新增檢查（可併入 `check-asset-consistency.js` 或新腳本）：

- 若 comment 含「source 指定」且含「target…未指定」→ equivalence 必須為 `wider`
- 若 comment 含「source…未指定」且含「target 指定」→ equivalence 必須為 `narrower`
- 若 comment 含「不同具體方法」「無包含關係」「需換算」「不可直接比較」→ 必須為 `relatedto`
- 違反者列出並失敗

> 此檢查之目的不是取代人工判斷，而是**防止 comment 與 equivalence 再次脫節**——
> 本次 5 組矛盾即因 JOB-01 只修 display 未修 comment 而殘留至今。

---

## 4. 不在本 JOB 範圍

- **不得變更任何值集成員**（`VS-ExtendedDataset` 維持 288、Core 維持 21）。
- **不得增減 ConceptMap 組數**（維持 39）。`2888-6` 之移除屬 JOB-21 §3.4，
  A 類 3 組之補建亦屬 JOB-21。
- 不進行 R5 升版。本 JOB 僅產出對照表供日後遷移。
- 不變更 preferred／acceptable 之三軸設計。**該設計本身無問題**——
  本 JOB 修正的是描述兩碼關係之 equivalence 值，與層級治理無關。

---

## 5. 風險與注意事項

- **勿以 §2 第 7 項之預期分佈為目標反推。** 那是依 §3.1／§3.2 推得之預期值，
  實作後應以實測為準；若不符，先檢查是否有本文件未列出之情形，而非調整資料湊數。
- **`relatedto` 之 21 組不要動。** 尿沉渣 9 組、eGFR、血鉛等均為刻意選用，
  其 comment 已載明「不可直接比較數值」，方向無誤（`relatedto` 無方向性）。
- **文件端連動**：文件二 §5.4 之定義表兩行須更正，其分類統計（現載 4/11/13/3）
  本已過期（實際 39 組）。此屬文件端工作，由主持人處理，本 JOB 僅需在
  `terminology.md` 建立正確判準。
- **對外影響之揭露**：錯誤之 equivalence 值已隨 gh-pages 發佈。修正後宜於
  `open-issues.md` 或 `terminology.md` 之版本註記載明本次更正，
  俾已下載舊版者知悉。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-22-conceptmap-equivalence-direction.md，產出實作計畫。

要求：
1. 先確認你理解根因。請用一句話回答：為什麼 16 組 equivalence 是「一致的偏移」
   而不是「隨機標錯」？答不出來就不要動手。
2. FHIR R4 之 narrower／wider 以 target 為主詞。請引用規範原文（該檔 §1.1 有）
   說明，並解釋為何 R5 改名為 source-is-narrower-than-target。
3. 16 組請以腳本產生變更清單供覆核後再套用，勿逐行手改。
   [11][18][0][1][13] 五組排除於自動翻轉，依 §3.2 個別處理——這五組的
   comment 與 display 相互矛盾，只翻轉 equivalence 會把錯誤固定下來。
4. [0] 之處理須與既有之 [6]（26508-2 → 770-8）保持一致。請說明為什麼。
5. §3.4 之一致性檢查是本 JOB 的核心產出。請說明你的規則如何避免誤判
   （例如 relatedto 之 comment 措辭多樣）。
6. 不得變更值集成員（288）與 ConceptMap 組數（39）。2888-6 與 A 類 3 組屬 JOB-21。
7. 驗收：err = 0、Wrong Display Name = 0、VS-ExtendedDataset = 288、
   ConceptMap element = 39、一致性檢查 = 0 違反、equivalence 分佈以實測回報
   （勿以 §2 第 7 項之預期值反推）。
8. 回報：commit、CI run id、上述數值、16 組翻轉清單、5 組個別處理之前後對照。
```

---

## 附錄　規範查證紀錄（2026-07-30）

**FHIR R4 `ConceptMapEquivalence`**（`http://hl7.org/fhir/concept-map-equivalence`，v4.0.1）

| Lvl | Code | 官方定義（節錄） |
|:--:|:--|:--|
| 1 | `relatedto` | The concepts are related to each other, and have at least some overlap in meaning, but the exact relationship is not known. |
| 2 | `equivalent` | The definitions of the concepts mean the same thing… |
| 2 | `wider` | The **target** mapping is wider in meaning than the source concept. |
| 2 | `narrower` | The **target** mapping is narrower in meaning than the source concept. The sense in which the mapping is narrower SHALL be described in the comments… |
| 2 | `inexact` | …applications should be careful when attempting to use these mappings operationally. |
| 1 | `unmatched` | There is no match for this concept in the target code system. |
| 2 | `disjoint` | …explicit assertion that there is no mapping… |

**FHIR R5 `ConceptMapRelationship`**（`http://hl7.org/fhir/concept-map-relationship`，v5.0.0）
—— 由 10 碼精簡為 5 碼：

| Lvl | Code |
|:--:|:--|
| 1 | `related-to` |
| 2 | `equivalent` |
| 2 | `source-is-narrower-than-target` |
| 2 | `source-is-broader-than-target` |
| 1 | `not-related-to` |

R5 移除 `equal`、`wider`、`subsumes`、`specializes`、`inexact`、`disjoint`。
