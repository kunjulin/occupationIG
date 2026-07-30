# JOB-19｜術語資產稽核與閘門化（UCUM 單位、SNOMED 對映）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（既有品質閘門之結構盲區；已實際漏出 2 個錯誤並流入交付文件） |
| **類別** | 術語正確性／工程 |
| **預估** | M（3–5 人日） |
| **相依** | 建議於 JOB-17（下載資產）、JOB-18（生理量測碼）之後，避免同時改動同一批檔案 |
| **主要影響檔案** | `input/assets/extended-ucum-reference.csv`、`input/assets/snomed-loinc-mappings.csv`、`scripts/lookup-loinc.js`、新增 `scripts/audit-ucum.js`、`scripts/qa-gate.js`、`qa-baseline.json`、`input/pagecontent/terminology.md` |
| **來源** | 委託單位查核提問後之延伸自查（2026-07-30） |

---

## 1. 問題（證據）

### 1.1 品質閘門之涵蓋範圍缺口

JOB-01 建立之「代碼驗證三要件」與 CI 閘門，僅涵蓋 **display 語意**一項：

| 欄位 | 是否納入 CI 閘門 | 現況 |
|:--|:--|:--|
| 代碼存在性 | ✅ | tx 建置自動攔阻 |
| 代碼狀態（ACTIVE／DISCOURAGED） | ✅ | 具名類別追蹤 |
| **display 語意相符** | ✅ | `Wrong Display Name > 0` 即失敗（JOB-01） |
| **UCUM 建議單位** | ❌ | **無任何檢核** |
| **SNOMED CT 對映** | ❌ | **無任何檢核** |

### 1.2 UCUM：271 筆全部標「需覆核」，零筆確認

`input/assets/extended-ucum-reference.csv` 之 `verification` 欄：

```
需覆核  271 筆（100%）
```

其中 **197 筆有建議單位值**，且該值已被交付文件（附件 v7.x）採用為「UCUM」欄。
**即：對外提供之單位建議，無一經過確認。**

**已實際出錯之案例**：吸菸量 `64218-1` 之 UCUM 標為 `{pack}/d`（包／日），
而該碼官方 Component 為「How many cigarettes … per D now」、Property 為 `NRat`、
官方建議單位為 **`/d`（支／日）**。以「支／日」之碼承載「包／日」之值，
實作端將把 20 支讀為 20 包。該錯誤同時流入附件 v7.1 與建議修訂案 v1.0／v2.0，
於 2026-07-30 始由外部查核觸發而發現。

**此與 JOB-01 之發現完全同型**：`err = 0` 但代碼錯 → 現為「閘門全綠但單位錯」。

### 1.3 SNOMED 對映：`VERIFIED` 標記已三度與 IG 本體不符

`input/assets/snomed-loinc-mappings.csv` 共 33 筆，`snomed_status` 全部標 `VERIFIED`。
惟該標記已三度被證實不可信：

| # | 項目 | CSV 標示 | IG 本體實際 | 發現時點 |
|--:|:--|:--|:--|:--|
| 1 | eGFR（CKD-EPI） | `88293-6`，VERIFIED | `98979-8` | JOB-01 批 1 附錄 A |
| 2 | 血壓 Panel | `55284-4`，VERIFIED | `85354-9`（`55284-4` 為 DISCOURAGED） | JOB-18 |
| 3 | **視力 Panel** | **`79880-1`，VERIFIED** | **`98497-1`** | **本次（2026-07-30）** |

第 3 項尤須注意：`79880-1` 之官方語意為
`Visual acuity best corrected Right eye by Snellen eye chart`
——**單眼（右眼）、限最佳矯正、屬 NEI eyeGENE 專案碼**（Class `EYE.REFRACTION.NEI`），
並附 20 級標準答案清單 `LL3784-7`。以之表達附表九之「視力」，
既無法表達左眼、亦無法表達裸視，屬語意錯誤。

> 該檔為**公開下載資產**（`https://kunjulin.github.io/occupationIG/zh-TW/snomed-loinc-mappings.csv`），
> 三度出錯而其 `VERIFIED` 欄從未被質疑，顯示該標記係人工填寫且無驗證程序支撐。

### 1.4 附帶查出之無效碼

`48024-3`（附件曾標為辨色力）經 loinc.org 查證，**該代碼不存在**
（頁面全欄位 NULL、FSN 為 `:::::`、無狀態）。與 `5605-7`（尿氟質量濃度）、
`73708-3`（腰臀比）同型。IG 本體實際採用 `46673-0` Color vision [RFC]，未受影響。

---

## 2. 目標與驗收標準

**目標**：將 UCUM 與 SNOMED 對映納入可重複執行之稽核與 CI 閘門，
使此二欄之錯誤與 display 錯誤一樣於建置階段即被攔阻。

驗收標準：

1. 新增 `scripts/audit-ucum.js`：讀取值集 → 對每個量值型代碼執行 `$lookup` →
   取 `EXAMPLE_UCUM_UNITS` 與 `PROPERTY` → 與 `extended-ucum-reference.csv`
   之 `ucum_suggested` 逐筆比對 → 產出 diff 報告。
2. `extended-ucum-reference.csv` 之 `verification` 欄改為實際結果
   （`相符` / `不符` / `LOINC 未提供` / `待人工判定`），**不得再全部為「需覆核」**。
3. CI 閘門新增具名類別 **`UCUM mismatch`**，基準線設為稽核後之實際值；
   **該值上升即建置失敗**。
4. `snomed-loinc-mappings.csv` 之 33 筆逐筆覆核：`loinc_preferred` 欄須與
   IG 值集實際採用之代碼一致；不一致者更正並記錄。`snomed_status` 之
   `VERIFIED` 僅得用於**經本次程序確認者**，其餘改為 `待覆核`。
5. 新增 `scripts/check-asset-consistency.js`：驗證 `snomed-loinc-mappings.csv`
   之每個 `loinc_preferred` 均存在於某一 IG 值集；不存在即失敗。
   納入 `npm run check:assets`。
6. `err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` 成員數維持 288
   （本 JOB 不改值集內容）。
7. `qa-baseline.json` 新增之類別須具名說明。

---

## 3. 工作項目

### 3.1 UCUM 稽核（§2 之 1–3）

`scripts/lookup-loinc.js` 已能取回 `$lookup` 之 property 陣列。請擴充或新增腳本，
針對值集中**量值型（Scale = Qn）**之代碼取 `EXAMPLE_UCUM_UNITS`，
與現行 CSV 比對，輸出四態分類。

**判定原則**（請寫入腳本註解）：

- `相符`：CSV 值出現於官方 EXAMPLE_UCUM_UNITS 清單中
- `不符`：CSV 有值但不在官方清單 → **須人工判定係選用差異或量綱錯誤**
- `LOINC 未提供`：官方無 EXAMPLE_UCUM_UNITS（現有 74 筆屬此類）
- `待人工判定`：官方清單有多個單位而 CSV 擇一，需確認是否為院內實際使用者

> ⚠️ **`不符` 不等於「改成官方值即可」。** 吸菸量之案例顯示，
> 有時錯的是「用了語意不對的代碼」而非「填錯單位」——`{pack}/d` 若要成立，
> 需要的是另一個代碼，不是把 `64218-1` 的單位改掉。
> 故 `不符` 一律進人工判定，腳本不得自動覆寫。

### 3.2 SNOMED 對映覆核（§2 之 4–5）

1. 逐筆比對 `snomed-loinc-mappings.csv` 之 `loinc_preferred` 與 IG 值集實際採用者。
2. 不一致者以 IG 值集為準更正（IG 本體為真，CSV 為衍生資產）。
3. `snomed_status` 之處理：本次程序**僅能確認 LOINC 側之一致性**，
   SNOMED CT 代碼本身之語意正確性不在本 JOB 範圍
   （需 SNOMED 術語伺服器，另案）。故：
   - LOINC 側一致且 SNOMED 曾經人工覆核者 → 維持 `VERIFIED` 並註明覆核日
   - 其餘 → 改為 `待覆核`
   - **不得因 LOINC 側對了就標 VERIFIED**——那正是本次出錯之成因

### 3.3 `terminology.md` 同步

於術語治理章補述本次建立之二項稽核機制，並更新「代碼驗證三要件」為
**「代碼驗證五要件」**（存在性、狀態、display 語意、**建議單位**、**跨術語對映一致性**），
註明前三者已閘門化、後二者由本 JOB 閘門化。

### 3.4 已知錯誤之更正紀錄

於 `docs/optimization/evidence/` 留存本次稽核之逐筆結果，並記錄已發現之
3 項 SNOMED CSV 不符（`88293-6`、`55284-4`、`79880-1`）與
1 項 UCUM 不符（`64218-1`）作為基準案例。

---

## 4. 不在本 JOB 範圍

- **不得變更任何值集之成員代碼。** 本 JOB 係使衍生資產追上值集，非相反。
  若建置後 `VS-ExtendedDataset` 不等於 288 碼，即代表方向做反了，須回退。
- SNOMED CT 代碼本身之語意稽核（需 SNOMED 術語伺服器，另立 JOB）。
- 為 `{pack}/d` 尋找 pack-year／packs-per-day 之替代代碼（另案，須經查證）。
- `48024-3` 無須處理——該碼未收錄於任何值集，僅曾誤載於交付附件，已於附件 v7.3 更正。

---

## 5. 風險與注意事項

- **方向性風險**：與 JOB-17 相同，本 JOB 之正確方向是「**以值集為真、重建衍生資產**」。
  切勿以 CSV 回填值集。
- **`不符` 不得自動覆寫**：見 §3.1 之警示。吸菸量案例即為「代碼選錯」而非「單位填錯」，
  自動改單位會把錯誤固定下來。
- **`VERIFIED` 標記之紀律**：本 JOB 之核心教訓是「未經程序支撐之 VERIFIED 比沒有標記更糟」——
  它會讓後續讀者停止懷疑。新規則：`VERIFIED` 必須可追溯至具體之驗證執行紀錄。
- **與 JOB-17／18 之檔案衝突**：三者均會改動 `input/assets/` 下之檔案。
  建議依 17 → 18 → 19 之順序執行，勿平行。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-19-ucum-snomed-asset-audit.md，為該 JOB 產出實作計畫。

要求：
1. 先確認方向：本 JOB 是「以值集為真、重建衍生資產」，不是拿 CSV 回填值集。
   請在計畫開頭寫明方向，並說明做反了會發生什麼。
2. 本 JOB 有兩條獨立工作線（UCUM、SNOMED 對映），請分開規劃，勿混為一談。
3. UCUM 稽核之「不符」一律進人工判定，腳本不得自動覆寫。請說明你如何在腳本中
   確保這一點，並解釋為什麼——以吸菸量 64218-1 之 {pack}/d 為例說明
   「代碼選錯」與「單位填錯」之差別。這一題答錯即為理解錯誤。
4. snomed_status 之 VERIFIED 僅得用於經本次程序確認者。請說明你如何避免
   「LOINC 側對了就標 VERIFIED」——那正是本次三度出錯之成因。
5. 請先參考 scripts/lookup-loinc.js 與 package.json 之 check:assets，
   說明你將如何沿用既有模式，而非另立一套。
6. 驗收須含負向測試：故意於 CSV 填一個錯誤單位，確認 CI 會失敗。
7. 驗收數值：err = 0、Wrong Display Name = 0、VS-ExtendedDataset 成員數 = 288、
   extended-ucum-reference.csv 之 verification 欄不再有任何一筆為「需覆核」。
8. 回報：commit、CI run id、上述數值、UCUM 四態分類之各別筆數、
   以及 SNOMED CSV 覆核後 VERIFIED 與待覆核之筆數。
```

---

## 附錄　本次查證之官方頁面摘錄（loinc.org，查證日 2026-07-30）

| 代碼 | Long Common Name | 關鍵軸 | 狀態 | 判定 |
|:--|:--|:--|:--|:--|
| `79880-1` | Visual acuity best corrected Right eye by Snellen eye chart | System `Eye.right`；Challenge `best corrected`；Method `Snellen eye chart`；Class `EYE.REFRACTION.NEI`；答案清單 `LL3784-7`（20 級） | Active | **非 Panel，語意錯誤** |
| `98497-1` | Visual acuity panel | — | Active | IG 本體採用者，正確 |
| `46673-0` | Color vision [RFC] | — | Active | IG 之辨色力 component，正確 |
| `48024-3` | （全欄位 NULL，FSN 為 `:::::`） | — | **不存在** | **無效碼** |
| `64218-1` | How many cigarettes do you smoke per day now [PhenX] | Property `NRat`；官方單位 **`/d`** | Active | UCUM 應為 `/d` |

> LOINC 內容版權屬 Regenstrief Institute, Inc.，本表僅為查證紀錄之摘要引用。
