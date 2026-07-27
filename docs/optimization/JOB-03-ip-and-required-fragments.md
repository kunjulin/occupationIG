# JOB-03｜LOINC/SNOMED 授權聲明與四個必要 HTML fragment 補納

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（智財合規） |
| **類別** | 合規／文件 |
| **預估** | S（1 人日） |
| **相依** | 無 |
| **主要影響檔案** | `input/pagecontent/index.md`、`input/pagecontent/conformance.md`、`input/pagecontent/terminology.md`、`sushi-config.yaml`（menu） |

---

## 1. 問題（證據）

2026-07-26 tx 建置回報四筆 WARNING：

```
WARNING: 1: The HTML fragment 'ip-statements.xhtml' is not included anywhere in the produced implementation guide
WARNING: 2: An HTML fragment from the set [cross-version-analysis.xhtml, cross-version-analysis-inline.xhtml] is not included anywhere ...
WARNING: 3: An HTML fragment from the set [dependency-table.xhtml, dependency-table-short.xhtml, dependency-table-nontech.xhtml] is not included anywhere ...
WARNING: 4: The HTML fragment 'globals-table.xhtml' is not included anywhere in the produced implementation guide
```

已全域搜尋 `input/pagecontent/*.md` 中的 `{%`，確認**沒有任何 Jekyll include**。

### 為何 `ip-statements` 是 P0 而非美化項

本 IG 大量引用 **LOINC**（數百碼）與 **SNOMED CT**。IG Publisher 會自動產生
`ip-statements.xhtml`，內含各外部術語系統的著作權與使用條件聲明
（LOINC 之 Regenstrief 授權條款、SNOMED CT 之 affiliate licence 提示等）。

目前該 fragment **未被任何頁面納入**，等於發佈網站上**看不到 LOINC 與 SNOMED CT 的授權聲明**。
對一份由主管機關委託、將對外發佈並供全國醫療機構實作的 IG，這是**合規缺漏**，
且是四筆中唯一有法律面風險的一筆。

### 其餘三筆的實務影響

| Fragment | 缺漏後果 |
|:--|:--|
| `dependency-table` | 讀者看不到本 IG 依賴 `tw.gov.mohw.twcore 1.0.0` 及其版本；實作端無法確認要載入哪些套件 |
| `globals-table` | 看不到全域 profile 適用範圍 |
| `cross-version-analysis` | 缺少跨 FHIR 版本（R4/R4B/R5）相容性分析，未來升版時無基準 |

---

## 2. 目標與驗收標準

1. tx 建置後上述四筆 WARNING **= 0**。
2. 網站可見 LOINC 與 SNOMED CT 授權聲明，且位置容易找到（建議獨立頁或 `terminology.md` 明顯段落）。
3. 網站可見依賴表與全域表。
4. 新增／調整之頁面已納入 `sushi-config.yaml` 之 `menu`（避免又產生孤兒頁，參見 JOB-12）。

---

## 3. 工作項目

### 3.1 決定納入位置

建議配置（plan 時可調整，但需明確）：

| Fragment | 建議位置 | 理由 |
|:--|:--|:--|
| `ip-statements.xhtml` | 新增 `input/pagecontent/ip-statements.md`，選單置於「術語與安全」下 | 授權聲明需獨立、易引用、可單獨連結 |
| `dependency-table.xhtml` | `conformance.md`（同時解決 JOB-12 的孤兒頁問題） | 依賴屬遵從性資訊 |
| `globals-table.xhtml` | `conformance.md` | 同上 |
| `cross-version-analysis-inline.xhtml` | `conformance.md` 末段，或獨立 `cross-version.md` | 技術性較強，適合放遵從性頁尾 |

### 3.2 納入語法

在 markdown 中使用 Jekyll include：

```liquid
{% include ip-statements.xhtml %}
{% include dependency-table.xhtml %}
{% include globals-table.xhtml %}
{% include cross-version-analysis-inline.xhtml %}
```

> 注意：`dependency-table` 有三個變體（`dependency-table.xhtml`／`-short`／`-nontech`），
> **只需納入其中之一**即可消除警告。考量本 IG 讀者含非技術之職安承辦人員，
> 可同時提供 `-nontech` 於背景頁、`dependency-table` 於遵從性頁。

### 3.3 授權聲明之中文說明

`ip-statements.xhtml` 由工具產出、內容為英文。建議在該頁上方補一段中文說明：

- 本 IG 引用 LOINC 之授權狀態與實作端應自行取得之授權；
- SNOMED CT 在臺灣之使用須符合 IHTSDO/SNOMED International 之會員國授權
  （臺灣之 SNOMED CT 授權管道與現況——若不確定，列入 JOB-13 未決事項，勿臆測）；
- 本 IG 自訂之 `CS-*` CodeSystem 的著作權歸屬與再利用條件
  （目前 `sushi-config.yaml` 有 `copyrightYear: 2026+` 但**未見 `license` 欄位**，本 JOB 應一併補上）。

### 3.4 補 `license`

`sushi-config.yaml` 目前無 `license`。建議明確宣告（例如 `CC0-1.0`／`CC-BY-4.0`），
或若因委託關係尚未確定，則列入 JOB-13 未決事項並在 `ip-statements.md` 註明「授權條件待確認」。

---

## 4. 不在本 JOB 範圍

- 實際取得 LOINC／SNOMED CT 授權（行政作業，非技術工作）。
- 判定本 IG 之最終著作權歸屬（委託契約層面，登記為未決事項）。

---

## 5. 風險與注意事項

- **不要自行撰寫 LOINC/SNOMED 的授權文字**——必須使用工具產生的 `ip-statements.xhtml`，
  自撰版本可能與實際授權條款不符。中文說明只作為導讀，不取代原文。
- 若不確定臺灣之 SNOMED CT 授權現況，**寧可標為「待確認」也不要寫入可能錯誤的斷言**。
- 新增頁面務必同步 `menu`，否則會變成另一個 `conformance.html` 式的孤兒頁。

---

## 7. 執行紀錄（2026-07-26）

### 已完成

| # | 變更 | 檔案 |
|--:|:--|:--|
| 1 | 新增智慧財產權與授權聲明頁：`{% raw %}{% include ip-statements.xhtml %}{% endraw %}` ＋ LOINC／SNOMED CT／UCUM／HL7 FHIR／TW Core／TWCR_SF／法規來源之中文導讀 | `input/pagecontent/ip-statements.md` |
| 2 | 於遵從性頁納入 `dependency-table.xhtml`、`globals-table.xhtml`、`cross-version-analysis-inline.xhtml`，並補「驗證通過之意義界定」警語 | `input/pagecontent/conformance.md` |
| 3 | `menu` 新增「遵從性與依賴」與「智慧財產權聲明」兩項——**同時解決 JOB-12 之 `conformance.html` 孤兒頁問題** | `sushi-config.yaml` |

四個 fragment 各納入一次，對應 qa.txt 之四筆 WARNING：

| Fragment | 納入位置 |
|:--|:--|
| `ip-statements.xhtml` | `ip-statements.md` §1 |
| `dependency-table.xhtml` | `conformance.md` §3 |
| `globals-table.xhtml` | `conformance.md` §4 |
| `cross-version-analysis-inline.xhtml` | `conformance.md` §5 |

### 刻意未做的兩件事

1. **未填 `sushi-config.yaml` 之 `license`**。本指引之著作權歸屬涉及工研院委託契約，
   尚待確認。填入未經確認之授權條款比留空更危險（會讓第三方誤以為可自由再散布），
   故改為在 `ip-statements.md` §3 明確標示「授權條件待確認」並說明為何留空。
   → 待登記至 JOB-13。
2. **未就臺灣境內 SNOMED CT 之授權管道作任何陳述**。`ip-statements.md` §2.2 明文
   「本指引不就臺灣境內 SNOMED CT 之授權管道、涵蓋範圍或費用作任何陳述」，
   並要求實作機構自行確認。→ 待登記至 JOB-13。

### ✅ 已由 CI 實證（run 30208978845，commit `083c807b`）

第一次 CI tx 建置（`--expect-tx` 通過）之 QA 閘門結果：

```
is not included anywhere in the produced implementation guide            4      0      -4  OK  改善
TOTAL warn                                                            208    204      -4  OK  改善
TOTAL err                                                               0      0       0  OK
```

四筆 fragment 警告**確實歸零**，且 warn 總數正好降 4，未連帶影響其他類別。
`qa-baseline.json` 已據此下調（fragment `4 → 0`、warn `208 → 204`），
故此改善已被閘門鎖定——以修正前之 qa.txt 重跑會被判為退步並失敗。

`cross-version-analysis-inline.xhtml` 在此模板版本**存在且可用**，無須改用備援名稱。

### 尚待確認（次要）

1. ~~qa.txt 之四筆 `The HTML fragment ... is not included anywhere` 歸零~~ → **已完成**；
2. `ip-statements.xhtml` 之產出內容確實包含 LOINC 與 SNOMED CT 聲明
   （若某術語系統未出現，表示 IG Publisher 未偵測到引用，需回頭確認該系統是否真的被引用）；
3. `cross-version-analysis-inline.xhtml` 若在此模板版本不存在，改用
   `cross-version-analysis.xhtml`（兩者同屬一組，納入其一即可消除警告）；
4. `globals-table.xhtml` 在本指引未宣告全域 profile 時可能產出空表——
   若為空表且視覺突兀，可改將該 include 移至頁尾或加註說明，但**不可移除**，
   否則警告會再度出現。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-03-ip-and-required-fragments.md，為這個 JOB 產出實作計畫。

要求：
1. 確認 IG Publisher 2.2.11 產生的 ip-statements.xhtml / dependency-table*.xhtml /
   globals-table.xhtml / cross-version-analysis*.xhtml 之正確 include 用法與可用變體，
   並決定各自要放在哪個 pagecontent 頁。
2. 規劃新增的 ip-statements 頁（含中文導讀段落），並同步 sushi-config.yaml 的 menu。
3. sushi-config.yaml 目前沒有 license 欄位，請提出處理方式；若授權條件未定，
   規劃如何在頁面上標示「待確認」並登記到 JOB-13。
4. 不要自行撰寫 LOINC/SNOMED 授權條文；也不要對臺灣的 SNOMED CT 授權現況作未經查證的斷言，
   不確定就標為待確認。
5. 給出重建後如何確認那四筆 WARNING 歸零的驗收步驟。
```
