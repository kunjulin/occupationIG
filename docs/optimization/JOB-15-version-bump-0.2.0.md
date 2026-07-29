# JOB-15｜指引進版 0.1.0 → 0.2.0（STU1 草案，建議版）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（交付一致性：結案報告已載明指引版本為 0.2.0） |
| **類別** | 發布組態／治理 |
| **預估** | S（0.5 人日） |
| **相依** | JOB-01～14 均已完成；本 JOB 為送審前之最後一步 |
| **主要影響檔案** | `sushi-config.yaml`、`package-list.json`、`input/pagecontent/history.md`、`docs/optimization/README.md` |

---

## 1. 問題（證據）

指引目前版本為 `0.1.0`（`sushi-config.yaml` 第 7 行），該版本號係 2026-07-26 之狀態
（`package-list.json` 之 `date` 欄）。其後經 JOB-01 至 JOB-14 共 96 個 commit，異動包括：

| 面向 | 0.1.0 | 現況 |
|:--|:--|:--|
| `Wrong Display Name` | 133 | **0** |
| `VS-ExtendedDataset` | 277 碼 | **288 碼**（換碼 19、移除 8、回收 9；另 113 碼更正 display） |
| ConceptMap 歸一 | 31 組 | **37 組** |
| 法定情境值集 | 無（僅 markdown 對照表） | **新增** `VS-Appendix9-RequiredSet`、`VS-Appendix10-*-RequiredSet` |
| 發布組態 | 本機建置、`lang=en`、無 history | CI 建置、`zh-TW`、history 與 IP 聲明齊備 |
| CI 品質閘門 | 無 | 有（`Wrong Display Name > 0` 即失敗） |

此一幅度已逾 patch 層級。且**結案報告 v1.2 第 5.3.1 節已載明指引版本為 0.2.0**，
若原始碼與發布站仍為 0.1.0，將與交付文件不一致。

---

## 2. 目標與驗收標準

**目標**：將指引版本由 `0.1.0` 進版為 `0.2.0`，維持 `releaseLabel: STU1`，並補齊版本歷程。

驗收標準：

1. `sushi-config.yaml` 之 `version` = `0.2.0`；`releaseLabel` 維持 `STU1`；`status` 維持 `active`。
2. `package-list.json` 新增 `0.2.0` 條目（`status: draft`、`sequence: STU 1`、`fhirversion: 4.0.1`、
   `date` 為實際發布日），且 `0.1.0` 條目**保留**（版本歷程不得刪除既有版本）。
3. `input/pagecontent/history.md` 新增 0.2.0 之異動摘要，內容對應本文件 §1 之表格。
4. CI tx 建置：`err = 0`、`Wrong Display Name = 0`、`VS-ExtendedDataset` 288 碼（**進版不得改動任何代碼**）。
5. 發布站標題顯示 `0.2.0 - STU1`。
6. `docs/optimization/README.md` 追加一列 JOB-15 並標記完成。

---

## 3. 工作項目

### 3.1 `sushi-config.yaml`

```yaml
version: 0.2.0        # 原 0.1.0
releaseLabel: STU1    # 不變
status: active        # 不變
```

### 3.2 `package-list.json`

於 `list` 陣列中，`current` 條目之後、`0.1.0` 條目之前，插入：

```json
{
  "version": "0.2.0",
  "date": "<實際發布日，格式 YYYY-MM-DD>",
  "desc": "STU1 草案（建議版）。完成術語稽核（顯示名不符 133→0）、擴充層調整為 288 碼、法定情境值集落地、發布組態正式化與 CI 品質閘門。工業技術研究院委託研擬中，尚未定稿。",
  "path": "https://kunjulin.github.io/occupationIG",
  "status": "draft",
  "sequence": "STU 1",
  "fhirversion": "4.0.1"
}
```

**`0.1.0` 條目保留不動。** 版本歷程之既有條目不得刪除或改寫。

### 3.3 `input/pagecontent/history.md`

新增 0.2.0 段落，載明 §1 表格之六項異動，並註明對應之 JOB 編號與 commit 範圍
（`7169521a..bb554ce1`，96 個 commit）。0.1.0 之既有敘述保留。

### 3.4 版本標籤

建立 git tag **`v0.2.0`** 指向本 JOB 完成後之 commit。

> ⚠️ **不要使用 `v1.0-final`。** 指引為 0.2.0 STU1 草案，該標籤名稱會使審查者
> 誤認為 1.0 正式定版，與 `status`／`releaseLabel`／文件狀態聲明自相矛盾。

---

## 4. 不在本 JOB 範圍

- **不得變更任何代碼、值集成員或 Profile 定義。** 本 JOB 純為版本標記與歷程補齊；
  若建置後 `VS-ExtendedDataset` 不等於 288 碼，即代表誤動內容，須回退。
- 不處理正式 canonical namespace（仍為 provisional，受 M-3／T-5 所限）。
- 不調整 `status: active` 為其他值——`active` 指 ImplementationGuide 資源本身之狀態，
  與「是否為正式標準」無涉；草案性質已由主版本號 0、`releaseLabel: STU1`
  及文件狀態聲明表達。

---

## 5. 風險與注意事項

- **版本號散落**：`0.1.0` 目前出現於 `sushi-config.yaml`、`package-list.json`、
  `input/pagecontent/history.md` 三處。請確認無遺漏（`git grep "0\.1\.0"`），
  但**不得**盲目全域取代——`history.md` 中描述 0.1.0 歷史之處必須保留原值。
- **發布站快取**：更新後須重新觸發 gh-pages 發布 job（目前為手動觸發），
  否則網站仍顯示 0.2.0 以前之內容。
- **交付文件已引用**：結案報告 v1.2、交付清單 v1.2、提交 email v1.2 均已載明
  指引版本 0.2.0 與 tag `v0.2.0`。本 JOB 完成後請回報實際 commit 與發布日，
  以便核對。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-15-version-bump-0.2.0.md，為該 JOB 產出實作計畫並執行。

要求：
1. 這是純版本標記工作。請在計畫中明確說明你將動哪幾個檔案的哪幾行，
   並確認不會觸及任何 FSH 檔案。若計畫中出現 input/fsh/ 之下的檔案，即為理解錯誤。
2. package-list.json 的 0.1.0 條目必須保留。請說明你如何確保既有版本歷程不被覆寫。
3. history.md 中描述 0.1.0 歷史的文字必須保留原值，不得被全域取代波及。
   請先 git grep "0\.1\.0" 列出所有出現位置，逐一判斷該改或該留，再動手。
4. 建置驗收：err = 0、Wrong Display Name = 0、VS-ExtendedDataset 成員數 = 288。
   第三項是本 JOB 的防呆——碼數若變動代表誤動內容，必須回退。
5. 完成後建立 tag v0.2.0（不是 v1.0-final），並觸發 gh-pages 發布。
6. 回報：實際 commit、CI run id、發布日期、發布站標題是否顯示 0.2.0 - STU1。
```
