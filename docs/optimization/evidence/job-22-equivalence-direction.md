# JOB-22｜ConceptMap equivalence 方向修正紀錄

> 執行日 2026-07-30｜對象 `ConceptMap-TWHealthCheckLaboratoryMap`（39 組，組數未變）

## 1. 根因：一致的偏移，非隨機標錯

16 組之 comment **全部正確描述了語意關係**，錯的只是所選代碼：13 組 comment 皆為
「source 指定…／target 未指定」而全標 `narrower`、3 組皆為「source 較 target 廣」而全標 `wider`
——**方向一律反向、零例外**。這是依「文件二 §5.4 之 source-relative 定義」對正確判斷做了
系統性符號翻轉；若係隨機標錯，不可能呈現此種整齊偏移。故可機械翻轉，無須重新判斷語意。

獨立驗證：以 comment 語型分類之規則命中 **16 組**，與 JOB-22 §1.2 之計數完全一致。

## 2. 規範依據

FHIR R4（[ConceptMapEquivalence](https://hl7.org/fhir/R4/codesystem-concept-map-equivalence.html)，v4.0.1）：

> `narrower` — The **target** mapping is narrower in meaning than the source concept.
> `wider` — The **target** mapping is wider in meaning than the source concept.

主詞為 **target**。R5 改名 `source-is-narrower-than-target`／`source-is-broader-than-target`，
因裸用 `narrower`／`wider` 未把主詞寫入代碼名稱，實作者極易依直覺讀成 source-relative
——本專案即為實例。R5 把主詞編進代碼名，歧義從根本消除。

## 3. 自動翻轉 12 組（`scripts/fix-conceptmap-equivalence.js`，dry-run 覆核後 `--apply`）

`narrower → wider`（10）：`[7]` 13457-7→2089-1、`[15]` 30239-8→1920-8、`[16]` 1743-4→1742-6、
`[19]` 83082-8→10334-1、`[20]` 83085-1→2039-6、`[21]` 88112-8→1920-8、`[22]` 1744-2→1742-6、
`[24]` 18262-6→2089-1、`[37]` 3137-7→8302-2、`[38]` 3141-9→29463-7

`wider → narrower`（2）：`[5]` 35200-5→2093-3、`[23]` 2345-7→1558-6

## 4. 個別處理 6 組（comment 與 display 矛盾者，不可機械翻轉）

| element | equivalence | comment 前 → 後 |
|:--:|:--|:--|
| `[0]` 804-5→6690-2 | `narrower` → **`relatedto`** | 「source 指定 Manual count，target 方法未指定，source 為其特化」→「Manual 與 Automated 為不同具體方法，無包含關係；數值不可直接比較（比照 element[6]）」 |
| `[1]` 26464-8→6690-2 | `equivalent` → **`narrower`** | 「同概念、同檢體、方法均未指定」→「source 方法未指定，target 指定 Automated count；target 語意較窄」 |
| `[3]` 2339-0→1558-6 | `wider` → **`relatedto`** | 「source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣；另檢體不同」→「空腹狀態與檢體均不同…全血與血漿葡萄糖數值不可直接比較（比照 element[6]）」 |
| `[11]` 26515-7→777-3 | `narrower`（**值不變**） | 「source 指定 Automated count，target 方法未指定」→「source 方法未指定，target 指定 Automated count；target 語意較窄」 |
| `[13]` 28539-5→785-6 | `equivalent` → **`narrower`** | 「同概念、同方法(Automated count)，僅顯示名長短不同」→「source 方法未指定（MCH [Entitic mass]），target 指定 Automated count；target 語意較窄」 |
| `[18]` 3016-3→11580-8 | `narrower`（**值不變**） | 「source 指定 3rd IS 標準品，target 未指定」→「source 為一般 TSH（未指定偵測極限），target 指定高敏感度…；target 語意較窄」 |

`[11]`／`[18]` **現值本已正確**——此即不可盲目自動翻轉之實證（若一併翻轉反而改壞）。

`[0]` 與 `[3]` 皆比照既有之 `[6]`（26508-2→770-8／3043-7→2571-8）：**軸不同（不同具體方法、
不同檢體）即不存在包含關係**，而 `narrower`／`wider` 是在主張包含關係，故只能用 `relatedto`。
同一種情形不應有兩種標法，否則實作端無從判斷數值可否直接比較。
（`[3]` 之改判經主持人裁示，2026-07-30。）

## 5. 一致性檢查（§3.4）之防誤判設計

| 規則 | 條件 | 期望值 |
|:--|:--|:--|
| R1（最高優先） | 含非方向性語彙（`不可直接比較`／`需換算`／`不同具體方法`／`無包含關係`／`不同量測方式`／`非包含關係`／`互有寬窄`／`性質不同`／`非單純包含`／`Unit conversion required`／`不同估算公式`／`檢體不同`） | `relatedto` |
| R2 | `source…指定` **且** `target…未指定` | `wider` |
| R3 | (`source…未指定` **且** `target…(?<!未)指定`) 或 `語意較 target…廣` | `narrower` |
| — | 無方向簽章 → **「未涵蓋」，不算違反** | — |

三項關鍵設計（皆有實測支撐）：

1. **`relatedto` 永不被要求含關鍵詞**——21 組措辭高度多樣，7 組原本不含任何常見關鍵詞
   （如 `[17]` 只寫換算公式 `NGSP(%) = IFCC * 0.9148 + 2.152`）。故僅在其 comment
   **明確主張包含關係**時才視為違反。實測誤判 **0**。
2. **必須用連接條件，且「指定」須排除「未指定」**（負向前瞻）：`[9]`／`[10]` 含
   「target…且**指定** Immunoassay」、`[27]` 含「source 之檢體為**未指定**之 Blood」，
   單邊比對會誤射。
3. **無簽章 ≠ 違反**：否則 `[6]`「檢體不同(Blood vs Serum/Plasma)」這類極短 comment 會被誤殺。
4. 另設**涵蓋率下限** `--min-coverage 0.5`，且涵蓋為 0 時無條件失敗（延續 JOB-20 §5 之教訓：
   規則全未命中卻一片綠，與本專案一路查出的缺陷同型）。

**負向測試**（皆如期失敗）：
- A：把 `[7]` 之 `wider` 改回 `narrower`（方向回歸）→ `exit 1`，指出「依 R2 應為 wider」。
- B：改 comment 卻不改 equivalence（**即 JOB-01 之殘留模式**）→ `exit 1`。

## 6. 實測結果

| 項目 | 值 |
|:--|:--|
| ConceptMap element | **39**（未增減） |
| `VS-ExtendedDataset` | **288**（未動值集） |
| equivalence 分佈 | `wider` **10**／`narrower` **6**／`relatedto` **23**／`equivalent` **0** |
| 一致性檢查 | **0 違反**，涵蓋率 **38／39 = 97.4%**（未涵蓋僅 `[27]`，無方向簽章） |

> ⚠️ JOB-22 §2 第 7 項之預期分佈（`relatedto` 22／`wider` 13／`narrower` 5）**合計為 40**，
> 與 39 組不符：係將「13 組 narrower 全翻 wider」與「`[0][11][18]` 另行處置」重複計算。
> 依 §5 之要求，本 JOB 一律以實測回報，未以該預期值反推。

## 7. 根因之文件端修正

除資料值外，**產生錯誤的判準本身**亦已更正，否則會繼續複製：
- `terminology.md` §3.2.1：新增 R4／R5 對照表、明載 R4 為 target-relative、揭露 `relatedto`
  為 Level 1「確切關係未知」不得自動換算，並載明舊版方向為錯誤值。
- `ConceptMap` 之 `Description`「equivalence 使用原則」原載 source-relative 規則（**根因**），
  已改寫為 target-relative 並加註舊版錯誤之揭露。
