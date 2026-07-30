# JOB-19 線 A｜SNOMED–LOINC 對照表逐筆覆核紀錄

> 稽核日 2026-07-30｜方向：**以值集為真、重建衍生資產**｜對象：`input/assets/snomed-loinc-mappings.csv`（33 列）

## 1. 方法

以 `scripts/check-asset-consistency.js` 之同一邏輯，收集全部 `input/fsh/valuesets/*.fsh`
之 LOINC 成員（去重 326 碼），逐筆比對 CSV 之 `loinc_preferred` 是否存在於某一 IG 值集。
**SNOMED CT 代碼本身之語意正確性不在本次程序範圍**（需 SNOMED 術語伺服器，另案）。

## 2. LOINC 側一致性結果

33 筆中，2 筆之 `loinc_preferred` 不存在於任何 IG 值集：

| 項目 | CSV 原值 | IG 本體實際 | 處置 |
|:--|:--|:--|:--|
| 視力 Panel | `79880-1` | `98497-1`（Visual acuity panel；於 `VS-ExtendedDataset`／`VS-Appendix9-RequiredSet`） | 更正為 `98497-1` |
| 腰臀比 WHR | `73708-3` | 無有效碼（經 tx 驗證為無效碼，已自值集移除） | 標為 `(-確定無合適碼)` 哨符 |

`79880-1` 之官方語意為 `Visual acuity best corrected Right eye by Snellen eye chart`
（單眼、限最佳矯正、NEI eyeGENE 專案碼，附 20 級答案清單 `LL3784-7`），
無法表達附表九「視力」之左眼、裸視，屬語意錯誤。

## 3. 本次之前已修正之同型不符（納入基準案例）

| # | 項目 | 曾標 | 修正為 | 修正時點 |
|--:|:--|:--|:--|:--|
| 1 | eGFR（CKD-EPI） | `88293-6` VERIFIED | `98979-8` | JOB-01 批 1 附錄 A |
| 2 | 血壓 Panel | `55284-4`（DISCOURAGED）VERIFIED | `85354-9` | JOB-18 |
| 3 | 視力 Panel | `79880-1` VERIFIED | `98497-1` | 本次（JOB-19 線 A） |
| （+）| 腰臀比 WHR | `73708-3` VERIFIED | `(-確定無合適碼)` | 本次（JOB-19 線 A） |

**四度出錯而 `snomed_status` 一律標 `VERIFIED` 從未被質疑**，證實該欄係人工填寫、無驗證程序支撐。

## 4. `snomed_status` 之處置

本次程序僅能確認 **LOINC 側**之一致性，無法確認 SNOMED CT 代碼本身。
`terminology.md` §4.1 所載唯一之 SNOMED `$validate-code` 覆核（2026-07-26）僅涵蓋
4 個社會史／臨場服務碼（`698188003`、`266919005`、`17458004`、`406221003`），
**均不在本 CSV 之 33 個實驗室對映碼中**。

故依 JOB-19 §3.2.3「不得因 LOINC 側對了就標 VERIFIED」：
**33 列之 `snomed_status` 全數改為 `待覆核`**，待 SNOMED 術語伺服器逐碼覆核之另案完成後再回填。

## 5. 閘門化

新增 `scripts/check-asset-consistency.js` 並納入 `npm run check:assets`：
每個非哨符之 `loinc_preferred` 須存在於某 IG 值集，否則建置失敗。
負向測試：將任一 `loinc_preferred` 改為值集外之碼（如 `99999-9`），`check:assets` 即失敗。

## 6. UCUM 不符（線 B 處理，非本檔範圍）

吸菸量 `64218-1` 之 UCUM 曾標 `{pack}/d`（實為 `/d`，見 JOB-18）為 UCUM 側之基準案例；
UCUM 271 列之四態稽核與 `UCUM mismatch` 閘門屬 **JOB-19 線 B**，另一 PR 以 CI（tx `$lookup`）為 oracle 執行。
