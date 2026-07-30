# JOB-20｜T-12 結案：Scale 未對映之三個 part 代碼查證與稽核範圍調整

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（解除 T-12 之外部輸入阻塞；使 `--max-unknown` 得以歸零） |
| **類別** | 術語正確性／工程 |
| **預估** | S（0.5 人日） |
| **相依** | JOB-19 及其補充事項（已完成，main `f242e823`） |
| **主要影響檔案** | `scripts/audit-ucum.js`（`SCALE_BY_LP` 與納入判準）、`input/assets/extended-ucum-reference.csv`、`input/pagecontent/open-issues.md`（T-12）、`input/pagecontent/terminology.md` §6.1、`qa-baseline.json`、`docs/optimization/evidence/job-19-line-b-ucum-audit.md` |
| **外部輸入** | 已取得。三個 part 代碼之官方 Scale 經 loinc.org 查證（2026-07-30，於可連外環境執行；本容器之 proxy 封鎖 loinc.org） |
| **來源** | T-12 §「所需輸入」之委外查證回報 |

---

## 1. 問題（證據）與結論

T-12 §「所需輸入」載明需於可連外環境查詢三個 part 代碼之正式 Scale 名稱。
已完成，結果如下：

| Part 代碼 | 官方 Part Name | 中譯 | 筆數 | 判定 |
|:--|:--|:--|--:|:--|
| `LP32888-7` | **`Doc`** | 文件型 | 17 | **非量值型 → 明確排除** |
| `LP436123-6` | **`SemiQn`** | 半定量型 | 10 | **量值型 → 應納入稽核** |
| `LP7747-1` | **`-`** | （多重）| 2 | **非量值型 → 明確排除** |

**你在 T-12 中對 `LP436123-6` 之研判正確。** 該處寫「研判可能為 SemiQn；惟此係由項目性質推得，
未經權威查證，故不逕行納入」——官方確認即為 `SemiQn`。**未經查證即不納入之處置是對的**，
本次僅補上該道查證。

---

## 2. 逐碼官方資料（證據）

### 2.1 `LP32888-7` ＝ `Doc`（文件型）

```
Part Name          : Doc
Part Display Name  : Doc
Part Type          : Scale (Describes the scale of the measurement)
Status             : Active
Created On         : 2003-11-10
Description        : Document Source: Regenstrief LOINC
Short Name 構件     : Doc
中譯（zh-CN）       : 文档型（臨床文件型）
```

**判定：非量值型。** Document scale 之觀測值為文件內容，無測量單位。
該 17 筆應歸為「不適用 UCUM」，與現行 `Nom`／`Nar` 同類處理。

### 2.2 `LP436123-6` ＝ `SemiQn`（半定量型）

```
Part Name          : SemiQn
Part Display Name  : SemiQn
Part Type          : Scale
Status             : Active
Created On         : 2023-07-05
Short Name 構件     : SmQn
中譯（zh-CN）       : 半定量型
其他語言           : semikwantitatief (nl) / Semicuantitativo (es) / Ημιποσοτική (el)
```

**判定：量值型，應納入 UCUM 稽核。** 半定量結果仍具單位
（如試紙尿蛋白之 `mg/dL` 半定量分級）。T-12 已指出 `5804-0` 確有官方
`EXAMPLE_UCUM_UNITS` ＝ `mg/dL`，與此判定一致。

> 附註：該 part 建立於 2023-07-05，屬較新之 Scale 值，此即現有
> `SCALE_BY_LP` 對映表未涵蓋之原因。

### 2.3 `LP7747-1` ＝ `-`（多重）

```
Part Name          : -
Part Display Name  : -
Part Type          : Scale
Status             : Active
Created On         : 2000-05-03
Description        : Used for panels when the panel elements are reported
                     in different fashions
                     Source: Regenstrief LOINC
中譯（zh-CN）       : -（多重／多重標尺類型）
```

**判定：非量值型。** 官方描述明確：**用於 panel，其成員以不同方式報告**。
panel 本身不承載數值，故無單位。該 2 筆（`89015-2` 純音聽力 panel、
`98497-1` 視力 panel）應歸為「不適用 UCUM」。

> 此判定與本 IG 之建模一致：兩者均以 `component` 承載各成員值，
> panel 層之 `Observation.value` 為空。

---

## 3. 工作項目

### 3.1 `SCALE_BY_LP` 補三筆對映

```
LP32888-7   → Doc      （非量值型）
LP436123-6  → SemiQn   （量值型，納入稽核）
LP7747-1    → -        （非量值型，panel 多重報告方式）
```

### 3.2 稽核範圍調整

- **納入判準由 `Scale ∈ {Qn, OrdQn}` 擴為 `{Qn, OrdQn, SemiQn}`。**
- `Doc` 與 `-` 併入現行之主動排除類（`Nom`／`Nar` 等），並比照記錄其 Scale。

### 3.3 補列 10 筆 SemiQn 之官方建議單位

該 10 筆須逐碼 `$lookup` 取 `EXAMPLE_UCUM_UNITS` 後補入
`extended-ucum-reference.csv`。已知 `5804-0` ＝ `mg/dL`；其餘請由 CI 之 tx 取回，
**勿由項目性質推定**。

> 若其中有官方未提供單位者，標「LOINC 未提供」即可，不必臆造。

### 3.4 基準線歸零

`--max-unknown` 由 **29 降為 0**。T-12 §「若決策不同」已載明兩種判定結果
**都應使該基準歸零**——本次為混合結果（10 納入、19 排除），故仍應歸零。

### 3.5 文件同步

| 檔案 | 更新內容 |
|:--|:--|
| `input/pagecontent/open-issues.md` | T-12 標記為**已解決**，載明三碼之官方 Scale、查證來源與日期；若 10 筆補列後尚有官方未提供單位者，另記為已知情形而非未決 |
| `input/pagecontent/terminology.md` §6.1 | 統計表更新：Scale 未知 29 → 0；納入比對之量值碼數由 231 增為 241；相符／未提供筆數依實測調整 |
| `docs/optimization/evidence/job-19-line-b-ucum-audit.md` | 追加本次查證結果與 §8.1 之後續 |

## 4. 驗收標準

1. `err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` ＝ **288**（不動值集）。
2. **`Scale 未知` ＝ 0**，`--max-unknown 0`。
3. `未列於對照檔` ＝ 0（新納入之 10 筆補列後仍須維持）。
4. `不符` ＝ 0。
5. 對照檔列數應由 307 增至 **約 317**（視官方是否提供單位而定，未提供者仍應列入並標「LOINC 未提供」）。

---

## 4.1 不在本 JOB 範圍

- **不得變更任何值集之成員代碼**（`VS-ExtendedDataset` 維持 288）。本 JOB 僅調整稽核腳本之
  Scale 判準與對照檔內容。
- 不處理 SNOMED CT 側之語意稽核（需 SNOMED 術語伺服器，另案）。
- 10 筆 SemiQn 之官方單位**須由 CI 之 tx `$lookup` 取回**，不得由項目性質推定；
  官方未提供者標「LOINC 未提供」即可。

---

## 5. 一項回饋（關於首輪之分類失效）

你主動揭露首輪（run `30533847567`）「320 碼全判不適用而閘門空過」，
原因為 tx 以答案清單碼回傳 `SCALE_TYP` 而腳本原優先取 `code`——**這個揭露有價值，
且該錯誤與本專案一路查出的缺陷同型**：閘門全綠，但實際上一碼未驗。

與 JOB-01 的「`err = 0` 但 133 筆 display 錯」、JOB-17 的「`check:assets` 綠但漏兩個
xlsx」、JOB-19 的「`需覆核 0` 但分母是舊碼集」屬同一類——**綠燈不等於有驗**。

建議於 `audit-ucum.js` 加一道自我檢查：**若「納入比對之量值碼數」為 0 或低於某門檻
（例如全集之 50%），即視為分類失效而失敗**，而非回報「全部不適用」後通過。
這樣同型錯誤下次會自己現形，不必靠人核對分類筆數。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-20-t12-scale-parts-resolution.md，據以結案 open-issues 之 T-12。

要求：
1. 三個 part 代碼之官方 Scale 已查證：LP32888-7=Doc（非量值型）、
   LP436123-6=SemiQn（量值型，納入）、LP7747-1=-（panel 多重，非量值型）。
   請勿再自行推定，直接依此更新 SCALE_BY_LP。
2. 納入判準擴為 {Qn, OrdQn, SemiQn}。10 筆 SemiQn 之官方建議單位須由 CI 之 tx
   逐碼 $lookup 取回後補列，已知 5804-0 = mg/dL；其餘不得由項目性質推定，
   官方未提供者標「LOINC 未提供」。
3. --max-unknown 必須降為 0。T-12 已載明兩種判定結果都應使該基準歸零，
   本次為混合結果（10 納入、19 排除），仍應歸零。
4. 請一併實作該檔 §5 所建議之自我檢查：若「納入比對之量值碼數」為 0 或低於全集之
   50%，即視為 Scale 分類失效而失敗。這是為了讓你首輪犯過的那類錯誤下次自己現形。
   請說明你打算把門檻設在哪裡、為什麼。
5. 驗收：err = 0、Wrong Display Name = 0、VS-ExtendedDataset = 288、
   Scale 未知 = 0、未列於對照檔 = 0、不符 = 0、對照檔列數約 317。
6. 完成後回報：commit、CI run id、上述數值、10 筆 SemiQn 各自之官方建議單位、
   以及自我檢查之門檻設定。
```
