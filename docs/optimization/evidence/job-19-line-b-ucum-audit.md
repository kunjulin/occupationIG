# JOB-19 線 B｜UCUM 建議單位稽核紀錄

> 稽核日 2026-07-30｜方向：**以值集為真**｜對象：`input/assets/extended-ucum-reference.csv`（271 列）
> 稽核工具：`scripts/audit-ucum.js`（tx 於本容器被封鎖，以 CI 為 `$lookup` oracle）

## 1. 方法

對 CSV 之每個 LOINC 代碼以 `$lookup?property=*` 取官方 `EXAMPLE_UCUM_UNITS`，
與 `ucum_suggested` 逐筆四態比對。CSV 之 `ucum_suggested` 與官方單位皆可能為多值
（以 `;` 分隔），故兩側均切成集合後以子集判定，不可拿整串比對（見 §3）。

## 2. 四態分類結果（CI run 30525243319，tx.fhir.org/r4）

| 四態 | 筆數 | 說明 |
|:--|--:|:--|
| 相符 | **197** | `ucum_suggested` 之單位皆為官方 `EXAMPLE_UCUM_UNITS` 所列 |
| 不符 | **0** | — |
| LOINC 未提供 | **74** | 官方無 `EXAMPLE_UCUM_UNITS`（多為定性／影像／鏡檢項目） |
| 待人工判定 | **0** | 無「官方多值而 CSV 空白／擇一」之情形 |

CSV `verification` 欄由 100% 「需覆核」改為上述實測結果（197 相符、74 LOINC 未提供）。

## 3. Round 1 之比對邏輯修正（重要）

Round 1 之 informational 稽核回報 **4 筆「不符」**：`10334-1`、`14957-5`、`1869-7`、`24108-3`。
逐筆檢視發現此四筆之 `ucum_suggested` 與官方 `EXAMPLE_UCUM_UNITS` **字串完全相同**
（如 `10334-1`：兩側皆為 `[arb'U];[arb'U]/mL`），係比對邏輯將「CSV 多值整串」對「官方切分後之清單」
比對所致之**偽陽性**。修正 `classify()` 使 CSV 側亦切成集合後以子集判定，四筆歸為「相符」，
genuine 不符為 **0**。修正後之單元測試涵蓋此四筆及負向案例（`BOGUS/x`、`{pack}/d` → 不符）。

## 4. 閘門化（§2.3）

`build-ig.yml` 之 UCUM 步驟改為 `node scripts/audit-ucum.js --gate --max 0`：
任一列之 `ucum_suggested` 出現官方清單外之單位（不符 > 0）即建置失敗。

**核心紀律（§3.1／§5）**：「不符」一律列出供人工判定，腳本**不自動覆寫** CSV。
吸菸量 `64218-1` 之 `{pack}/d`（實為 `/d`）為「代碼選錯」而非「單位填錯」之基準案例
（已於 JOB-18 處理；該碼屬社會史，不在本 Extended 量值 CSV 內）。

## 5. 負向測試

因 tx 於本容器被封鎖，負向以 `classify()` 之單元測試證明機制：
`classify("BOGUS/x", ["mg/dL"]) → 不符`、`classify("{pack}/d", ["/d"]) → 不符`，
且閘門決策 `不符(1) > max(0) → exit 1`。CI 中 `--gate --max 0` 即據此對真實 tx 結果攔阻：
任何人將 `ucum_suggested` 改為官方清單外之單位，`UCUM 稽核閘門` 步驟即失敗。

## 6. 結論

`extended-ucum-reference.csv` 之 197 個有值列，其建議單位**全數與官方 LOINC `EXAMPLE_UCUM_UNITS` 相符**；
原「需覆核」之全域標記係過度保守，經本次程序確認後去除。UCUM 一致性自此納入 CI 閘門，
與 display 語意（JOB-01）、跨術語對映一致性（線 A）同為建置階段之自動攔阻項。
