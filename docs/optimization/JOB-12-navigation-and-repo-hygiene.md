# JOB-12｜資訊架構與 repo 整理（孤兒頁、下載區、文件歸檔、CLAUDE.md）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P2**（低風險、見效快，適合與 JOB-02／JOB-03 併做） |
| **類別** | 文件／工程整理 |
| **預估** | S（1 人日） |
| **主要影響檔案** | `sushi-config.yaml`（menu）、`input/pagecontent/downloads.md`、`scripts/check-pagecontent-refs.js`、新增 `CLAUDE.md`、新增 `docs/history/`、`.gitignore` |

---

## 1. 問題（證據）

### (1) `conformance.html` 是孤兒頁

`input/pagecontent/conformance.md` 存在且有建置產出（`en/conformance.html`），
但 `sushi-config.yaml` 的 `menu`（L41–62）**未列入**。
讀者只能經由 `toc.html` 才可能找到——而「遵從性要求」是實作端最該讀的頁面之一。

（JOB-03 也需要一個放 dependency-table／globals-table 的頁面，正好就是這頁，兩者可一起解決。）

### (2) 下載區內容過期／不完整

`downloads.md` 列出 UC-001 ~ UC-006，但：

- **缺 UC-007**（職業健康急診友善摘要，2026-07-23 新增）；
- `input/assets/` 中的 `display-verification-report.csv`（60KB，術語稽核報告）與
  `extended-ucum-reference.csv`（44KB，UCUM 單位對照）**未在下載區出現**——
  這兩份對實作端很有價值，卻只有翻 repo 才找得到；
- 發佈站根目錄有 `Appendix10-to-HazardType.xlsx`，同樣未列入下載區。

### (3) `check-pagecontent-refs.js` 產生假警報

執行結果：

```
Unresolved pagecontent references (no matching FSH definition found):
  input/pagecontent/background.md: ext-retention-period
  input/pagecontent/general-exam.md: VS-Appendix9-RequiredSet
  input/pagecontent/index.md: VS-Appendix9
```

三筆**全部**是文件中已明示的 backlog 項目（原文即寫「列為 backlog：`ext-retention-period`」）。
腳本無法區分「失效引用」與「刻意標註的待辦」，導致每次執行都有噪音，
久了就會被忽略，失去防護價值。

### (4) 根目錄雜亂

```
implementation_plan_0615.md      ← 歷史計畫
implementation_plan_0622.md      ← 歷史計畫
implementation_plan_0622b.md     ← 歷史計畫
Requirements-fromNarrative.json  ← 用途不明（417 bytes）
download.js / get_links.js       ← 用途不明的一次性腳本
附表八/九/十/十一 *.PDF            ← 法規原始檔（JOB-07 的來源資料，應保留但宜歸位）
template/                        ← 整份 IG 模板 commit 進版控（見 JOB-09）
```

新接手者（含 AI 助手）看不出哪些是現行、哪些是歷史。

### (5) 無 `CLAUDE.md`

repo 已有 `.claude/skills/fhir-tx-audit/SKILL.md`（品質很好），但沒有 `CLAUDE.md`。
考量本專案有多條**非顯而易見的鐵則**（離線建置不得送審、display 不符可能代表用錯碼、
①②③ 三層資料集不可混用、Preferred ≠ binding strength preferred），
沒有 `CLAUDE.md` 會讓每次新對話都要重新解釋這些前提，且容易被違反。

### (6) 描述與約束不一致（與 JOB-04 重疊，此處僅登記）

`TWHA-Bundle-Document` 描述聲明「第一個 entry 必須為 Composition」，FSH 無對應約束。
→ 交由 **JOB-04** 處理。

---

## 2. 目標與驗收標準

1. `conformance.html` 納入 `menu`（建議置於「FHIR 資源」之後或「術語與安全」群組內）。
2. `downloads.md` 補齊 UC-007、`display-verification-report.csv`、`extended-ucum-reference.csv`、
   `Appendix10-to-HazardType.xlsx`，並補上各檔案的一句說明（避免讀者不知道那是什麼）。
3. `check-pagecontent-refs.js` 支援 backlog 白名單（建議：辨識同行出現 `backlog` 字樣即略過，
   或改用外部 `scripts/refs-allowlist.json`），執行後**0 筆假警報**。
4. 歷史文件歸檔至 `docs/history/`；法規 PDF 移至 `docs/regulations/`（並更新 JOB-07 中的引用路徑）。
5. 新增 `CLAUDE.md`，內容至少包含：專案定位、建置兩種模式與送審規則、術語稽核鐵則、
   ①②③ 三層資料集定義、常犯錯誤清單、以及本優化目錄的導引。
6. 釐清 `Requirements-fromNarrative.json`、`download.js`、`get_links.js` 之用途：保留（加註）或移除。

---

## 3. 工作項目

1. 調整 `sushi-config.yaml` 之 `menu`（注意：menu 改動會影響所有頁面導覽，重建後目視確認）。
2. 更新 `downloads.md`，每個下載項目加一句用途說明。
3. 改寫 `check-pagecontent-refs.js` 的 backlog 辨識邏輯，並加上 `--strict` 選項供 CI 使用（JOB-08）。
4. 建立 `docs/history/`、`docs/regulations/`，搬移檔案並在 `README.md` 說明新結構。
5. 撰寫 `CLAUDE.md`。**內容應從既有文件擷取，不要另創說法**——
   README 與 `fhir-tx-audit/SKILL.md` 已有完整的鐵則描述，`CLAUDE.md` 是索引與摘要，不是新規範。
6. 逐一確認三個用途不明的檔案；若確為一次性工具，移至 `scripts/` 並加註，或刪除。

---

## 4. 不在本 JOB 範圍

- `template/` 目錄之處理（JOB-09）。
- Bundle-Document 約束修正（JOB-04）。
- 新增內容頁面（JOB-03、JOB-13 各自負責其新頁）。

---

## 5. 風險與注意事項

- 搬移法規 PDF 會影響 JOB-07 的來源路徑，兩個 JOB 需同步（建議 JOB-12 先做）。
- `menu` 是 `sushi-config.yaml` 的一部分，改動會觸發全站重建；確認 JOB-02 的語言決策已定案後再改，
  避免重工。
- 刪除任何檔案前先確認是否被 `.gitignore` 例外規則引用
  （例如 `!input/assets/fsh-source.zip`）。

---

## 7. 執行紀錄（2026-07-26）

### 已完成

| # | 變更 | 檔案 |
|--:|:--|:--|
| 1 | `conformance.html` 納入 `menu`（於 JOB-03 一併完成），孤兒頁問題解除 | `sushi-config.yaml` |
| 2 | 下載區改寫為表格並補齊：UC-007、`display-verification-report.csv`、`extended-ucum-reference.csv`、`snomed-loinc-mappings.csv`、附表十 ConceptMap 連結；每項加用途說明；標註「七個封包皆為 document，上傳範例待補（JOB-04）」 | `input/pagecontent/downloads.md` |
| 3 | 參照檢查器改為區分「失效引用」與「同行標註 `backlog` 之刻意待辦」，預設 exit 0 可作為 CI 閘門；新增 `--strict` 供釋出前檢查 | `scripts/check-pagecontent-refs.js` |
| 4 | 三份歷史規劃文件歸檔 ＋ 說明檔 | `docs/history/` |
| 5 | 四份法規附表 PDF 歸檔 ＋ 說明檔（含「須逐項核對原文」之使用原則） | `docs/regulations/` |
| 6 | `Requirements-fromNarrative.json` 歸檔 ＋ 說明檔（見下） | `docs/drafts/` |
| 7 | `download.js`／`get_links.js` 移入 `scripts/` 並加註來歷（見下） | `scripts/` |
| 8 | 新增作業前提索引（五條鐵則、常犯錯誤、檢查指令、未決事項） | `CLAUDE.md` |
| 9 | 目錄結構說明更新 | `README.md`、`docs/optimization/JOB-07`（PDF 路徑） |

檢查器修正前後：

```
（修正前）exit 1，三筆全為假警報 —— 因此無法作為閘門
（修正後）exit 0；NOTE 列出 3 筆 backlog 標註並附行號；--strict 時 exit 1
```

### 三個「用途不明」檔案的真相

逐一讀過內容後，這三個檔案都不是無用檔案，而是**既有問題的證據**：

| 檔案 | 實際用途 | 處置 |
|:--|:--|:--|
| `download.js` | 嘗試下載 `https://mitw.dicom.org.tw/IG/TWCR_SF/package.tgz` | 移入 `scripts/` 並加註：這是**取得 TWCR_SF 正式套件失敗**的遺留物，正因為失敗才有了 `TWCRSF-mocks.fsh`。檔內位址是 **JOB-10** 查證的起點，故保留 |
| `get_links.js` | 抓取 `https://twcore.mohw.gov.tw/ig/twcrsf/downloads.html` 找 `package.tgz` 位址 | 同上，兩者為同一件工作的兩半 |
| `Requirements-fromNarrative.json` | `Requirements` 資源空殼，意圖是把敘述中的遵從性陳述收攏為可計算資源 | 移至 `docs/drafts/`。**原置於根目錄、不在 `input/` 之下，故從未被建置讀取**；且無任何 `statement`。接入或移除屬設計決策，已登記待與 JOB-04 一併評估 |

### 更正：`Appendix10-to-HazardType.xlsx` 並非無源檔案

初步檢視時發現該檔存在於 gh-pages 根目錄，卻在 repo 全部歷史中查無
（`git log --all -- '*Appendix10-to-HazardType.xlsx'` 僅命中 gh-pages 的 deploy commit），
故當時判定為「發佈站上有無法由原始碼重現的檔案」，並據此**不**將其列入下載區。

**該判定有誤。** 2026-07-26 之 CI 建置（run 30209412428）在乾淨環境中由原始碼建置後，
`output/` 根層即含 `Appendix10-to-HazardType.xlsx`——它是 **IG Publisher 依
`ConceptMap-Appendix10-to-HazardType` 自動產生**的試算表產出物，
本來就不該存在於原始碼中，也完全可重現。

因此：

* 該檔**可以**安全連結，已補入 `downloads.md` §4；
* 原先「此為 JOB-08 發佈可重現性之額外證據」的推論**撤回**——
  JOB-08 的可重現性問題成立，但依據是建置來源為 `C:\repo\...` 之本機建置且
  gh-pages 與 main 無血緣關係，與本檔無關。

### 尚待在可建置環境驗證

* `menu` 改動後導覽是否正常、`conformance.html` 與 `ip-statements.html` 是否可達；
* `downloads.md` 新增之三個 CSV 連結是否確實可下載
  （`input/assets/` 之檔案在既有建置中會落到輸出根目錄，既有 `.xlsx` 連結即為此模式，
  故預期可行，但仍需確認）。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-12-navigation-and-repo-hygiene.md，並檢視 sushi-config.yaml 的 menu、
input/pagecontent/downloads.md、input/assets/ 內容、scripts/check-pagecontent-refs.js、
以及 repo 根目錄的檔案清單，為這個 JOB 產出實作計畫。

要求：
1. 把 conformance.html 納入 menu（與 JOB-03 要放 dependency-table 的位置協調）。
2. 更新 downloads.md：補 UC-007、display-verification-report.csv、extended-ucum-reference.csv、
   Appendix10-to-HazardType.xlsx，每項加一句用途說明。
3. 修改 check-pagecontent-refs.js，讓它能辨識文件中明示的 backlog 標記而不誤報
   （目前 3 筆全是假警報），並加 --strict 選項給 CI 用。
4. 規劃 docs/history/ 與 docs/regulations/ 的歸檔，並注意法規 PDF 是 JOB-07 的來源，路徑變更要一併記錄。
5. 撰寫 CLAUDE.md。內容請從 README.md 與 .claude/skills/fhir-tx-audit/SKILL.md 擷取既有鐵則，
   不要自創新規範。至少涵蓋：兩種建置模式與送審規則、「display 不符可能代表用錯碼」、
   ①②③ 三層資料集不可混用、Preferred（代碼層級）≠ binding strength preferred、
   以及 docs/optimization/ 的導引。
6. 確認 Requirements-fromNarrative.json、download.js、get_links.js 的用途後再決定保留或移除，
   不要在不清楚用途的情況下刪檔。
```
</content>
