# JOB-17｜下載區試算表資產漂移之修正（`loinc-valuesets.xlsx`／`snomed-mappings.xlsx`）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（送審阻斷級：公開下載區提供之檔案含已查證移除之語意錯碼） |
| **類別** | 工程／發布正確性 |
| **預估** | S（0.5–1 人日） |
| **相依** | 無。已有 `fsh-source.zip` 之同類修正可直接沿用其模式 |
| **主要影響檔案** | `input/assets/loinc-valuesets.xlsx`、`input/assets/snomed-mappings.xlsx`、新增 `scripts/build-download-xlsx.js`、`package.json`（`check:assets`）、`.github/workflows/build-ig.yml` |
| **來源** | 委託單位（工研院）115.07.30 提問 |

---

## 1. 問題（證據）

### 1.1 兩個下載用試算表為手工快照，已嚴重漂移

```
input/assets/loinc-valuesets.xlsx   最後更新 44a01a5  2026-07-10
input/assets/snomed-mappings.xlsx   最後更新 44a01a5  2026-07-10
```

該日期早於全部 Wave 與 JOB 工作。逐碼比對結果：

| 分頁 | 下載檔 | 現行 FSH | 差異 |
|:--|--:|--:|:--|
| `VS-CoreDataset` | **193 碼** | **21 碼** | 下載檔獨有 174、FSH 獨有 2 |
| `VS-ExtendedDataset` | **123 碼** | **288 碼** | 下載檔獨有 6、FSH 獨有 171 |

### 1.2 下載檔仍含 11 個已移除之語意錯碼

`22326-3`（實為 HCV 5-1-1 Ab）、`49154-8`（實為 Rickettsia conorii IgG）、
`14390-9`（透析液澱粉酶）、`14409-7`（胸膜液 AST）、`19199-9`（精液 PSA）、
`1783-0`（全血 ALP）、`46986-6`（VLDL 3）、`20627-6`（尿液濁度）、
`70028-6`（巨核細胞核）、`13705-9`（24 小時尿 ACR）、`47365-2`（捐血者情境碼）。

`snomed-mappings.xlsx` 之 eGFR 一列仍為 `88293-6`（現行已統一為 `98979-8`）。

### 1.3 根因：CI 之資產檢查未涵蓋此二檔

本案已於 JOB-05 發現**同類缺陷**並修正 `fsh-source.zip`。該次修正之註解已明載：

> 「downloads.md 對外提供 fsh-source.zip，宣稱『可直接以 SUSHI 重新編譯』。
> 該檔原為手工快照，實測落後數週……改為由 `scripts/build-fsh-source-zip.js` 產生
> （固定時間戳，位元組可重現），此處只驗證提交進版控的那份與當前原始碼一致，
> **忘了重建就擋下來**。」

三個 CSV 資產（`display-verification-report.csv`、`extended-ucum-reference.csv`、
`snomed-loinc-mappings.csv`）因屬實際維護中之工作檔，均為 7/26–7/29 之最新版。

**惟 `npm run check:assets` 未涵蓋上開兩個 xlsx**，致漏網。此為既有機制之
涵蓋範圍缺口，非機制本身失效。

---

## 2. 目標與驗收標準

**目標**：使兩個下載用試算表由值集自動產生，並納入 CI 攔阻，杜絕再度漂移。

驗收標準（**一律以 CI 實測**）：

1. `loinc-valuesets.xlsx` 之 `VS-CoreDataset` 分頁 = **21 碼**、
   `VS-ExtendedDataset` 分頁 = **288 碼**。
2. 該檔**不含** §1.2 所列 11 個代碼中之任何一個。
3. `snomed-mappings.xlsx` 之 eGFR 列為 `98979-8`，且與
   `input/assets/snomed-loinc-mappings.csv` 內容一致。
4. `npm run check:assets` 涵蓋此二檔；**故意改動值集而未重建時，CI 必須失敗**
   （請實測此一負向案例，不得只驗證正向）。
5. `err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` 成員數維持 288。
6. 發佈後，`https://kunjulin.github.io/occupationIG/zh-TW/loinc-valuesets.xlsx`
   之內容與 §1 表格之「現行 FSH」欄相符。

---

## 3. 工作項目

### 3.1 產生腳本

新增 `scripts/build-download-xlsx.js`，自 FSH（或 `fsh-generated/resources/`
之 ValueSet JSON）產生兩個試算表。設計要求比照 `build-fsh-source-zip.js`：

- **位元組可重現**：固定時間戳、固定列序（依值集內順序，勿另行排序）、
  固定樣式，使同一輸入必產生同一檔案，方能以雜湊比對。
- `loinc-valuesets.xlsx` 維持現有三欄結構（`Section` / `LOINC Code` /
  `Display Name`），`Section` 取自 FSH 之區塊註解，與現行下載檔之欄位相容。
- `snomed-mappings.xlsx` 之「LOINC-SNOMED 對照」分頁應自
  `snomed-loinc-mappings.csv` 產生，避免兩處各自維護。

### 3.2 納入 CI 攔阻

擴充 `check:assets`，比對版控中之兩個 xlsx 與即時產生者是否位元組相同；
不同即失敗，訊息須指出「請執行 `npm run build:assets` 後重新提交」。

### 3.3 重建並提交

執行腳本重建二檔後提交。**提交前請以 §2 之 1～3 項自行核對數值**。

### 3.4 `downloads.md` 補註

於下載區各項目補註「本檔由建置流程自值集自動產生，與本頁指引版本一致」，
並標明指引版本（0.2.0）。避免使用者無從判斷檔案新鮮度。

---

## 4. 不在本 JOB 範圍

- **不得變更任何值集內容。** 本 JOB 係使下載檔追上值集，非相反。
  若建置後 `VS-ExtendedDataset` 不等於 288 碼，即代表方向做反了，須回退。
- 不處理 `ai.zip`（用途與內容另議）。
- 不調整 downloads 頁之資訊架構（屬 JOB-12 範圍，已完成）。

---

## 5. 風險與注意事項

- **方向性風險（最重要）**：本 JOB 之正確方向是「**以值集為真，重建下載檔**」。
  若誤將下載檔之 193／123 碼視為基準去回填值集，將把 11 個已移除之語意錯碼
  重新寫回 IG，造成嚴重退步。§2 驗收條件第 5 項即為此設之防呆。
- **`Section` 欄之取得**：現行下載檔之 `Section` 來自 FSH 區塊註解
  （如「1.1 高溫作業 (high-temp) — 心血管、腎功能、電解質、尿液」）。
  解析時請沿用 `scripts/` 既有之區塊註解解析邏輯，勿另立規則。
- **Core 分頁之語意變更**：舊檔之 `VS-CoreDataset` 為 193 碼（重構前），
  新檔為 21 碼。使用者若比對新舊會看到大幅縮減，屬正常——該值集已於
  v3.0 重構為「主管機關最小上傳集之檢驗子集」，其餘移入 Extended。
  建議於 `downloads.md` 或試算表首列加註此一說明。
- 本 JOB 完成後應回報予委託單位（工研院 115.07.30 提問）。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-17-download-assets-drift.md，為該 JOB 產出實作計畫並執行。

要求：
1. 先確認方向。本 JOB 是「以值集為真、重建下載檔」，不是拿下載檔回填值集。
   請在計畫開頭一句話寫明方向，並說明若做反了會發生什麼（11 個已移除的語意錯碼
   會被寫回 IG）。方向寫錯即為理解錯誤。
2. 請先參考 scripts/build-fsh-source-zip.js 與 package.json 之 check:assets，
   說明你將如何沿用同一模式（位元組可重現 + CI 攔阻），而非另立一套。
3. Section 欄之解析請沿用既有之 FSH 區塊註解解析邏輯，勿新寫規則。
   請指出你打算重用哪一支腳本的哪一段。
4. 驗收必須包含一個負向測試：故意改動值集但不重建 xlsx，確認 CI 會失敗。
   只做正向驗證不算完成。
5. 驗收數值：loinc-valuesets.xlsx 之 Core 分頁 = 21 碼、Extended 分頁 = 288 碼；
   且不含 22326-3、49154-8、14390-9、14409-7、19199-9、1783-0、46986-6、
   20627-6、70028-6、13705-9、47365-2 任一碼。
   snomed-mappings.xlsx 之 eGFR 列須為 98979-8。
6. 完成後觸發 gh-pages 發布，並回報：commit、CI run id、上述驗收數值、
   以及發布站該檔之實際內容筆數。
```
