# JOB-25｜頁面標題中文化：全站 `<title>`／H1／麵包屑仍為英文

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（對外一致性；工研院明示提案要求一致性） |
| **類別** | 發佈呈現／i18n |
| **預估** | S（0.5 人日） |
| **主要影響檔案** | `sushi-config.yaml`（新增 `pages:`）、`scripts/check-menu.js`（新增 R-6）、`README.md`、`package-list.json` |
| **緣起** | 2026-08-14 工研院生醫所李建儒經理：「格式可能還是要對標一下 TW Core IG，風格不大一樣，提案有要求一致性」。JOB-23／JOB-24 完成後於 2026-08-17 實地查閱已發佈站台，發現尚有本項未對標 |
| **狀態** | ✅ **已執行（v0.2.5，2026-08-17）**——待建置發佈後複核 §4 之 N-2 |

---

## 0. 一句話結論

導覽列（JOB-23）與頁尾字串（JOB-24）已對標，但**每一頁的頁面標題本身仍是英文**——瀏覽器分頁顯示 `Home`、`Examples`、`Security`，麵包屑顯示 `Table of Contents / Open Issues`。TW Core 對應位置為「應用說明」「範例」「安全性」「目錄」。這是讀者最先看到、也是搜尋結果會呈現的一層，須一併中文化。

---

## 1. 證據（2026-08-17 實地查閱 <https://kunjulin.github.io/occupationIG/> v0.2.4）

站台狀態確認：網址已為 `/zh-TW/`、`<html lang="zh-TW">`、頁尾為「IG © 2026+ …／套件 mohw.tw.twha#0.2.4，基於 FHIR 4.0.1。／產生日期 2026-08-17／連結: 目錄 | QA 報告」——**JOB-24 之修復確認生效**。導覽列為 8 項、純中文，**JOB-23 確認生效**。

惟逐頁抽查之標題如下：

| 頁面 | 現況 `<title>`／H1／麵包屑 | TW Core 對應頁 |
|:--|:--|:--|
| `index.html` | **Home** | 應用說明 |
| `toc.html` | **Table of Contents** | 目錄 |
| `artifacts.html` | **Artifacts Summary** | 規範文件 |
| `examples.html` | **Examples** | 範例 |
| `profiles-and-extensions.html` | **Profiles and Extensions** | FHIR Profiles及Extensions |
| `downloads.html` | **Downloads** | 結構定義與範例檔下載頁 |
| `security.html` | **Security** | 安全性 |
| `open-issues.html` | **Open Issues** | （TW Core 無對應頁） |
| `quickstart.html` | **Quickstart** | （TW Core 無對應頁） |
| `general-exam.html` | **General Exam** | （TW Core 無對應頁） |

麵包屑亦同：`examples.html` 顯示為 `Table of Contents / Examples`。

### 1.1 為何 JOB-24 沒有修掉這一項

JOB-24 補的是**模板字串**（`stringsBase.json` 之 126 個介面標籤，如「連結」「目錄」「QA 報告」）。本項則是**頁面自身的標題**，其來源完全不同：

> **SUSHI 在 `sushi-config.yaml` 未宣告 `pages:` 時，會自動收錄 `input/pagecontent/*.md` 全部檔案，並以「檔名去除副檔名後轉為 Title Case」推導頁面標題。**
> 故 `general-exam.md` → `General Exam`、`open-issues.md` → `Open Issues`、`index.md` → `Home`。
> 該標題寫入 `ImplementationGuide.definition.page.title`，再由模板填入 `<title>`、頁首 H1 與麵包屑。

`stringsBase.json` 之 `TableOfContents` 鍵已譯為「目錄」且**確實生效**（頁尾即顯示「連結: 目錄」），可證兩者為不同來源——同一份字串在頁尾是中文、在麵包屑是英文。

---

## 2. 修正方式

於 `sushi-config.yaml` 宣告 `pages:` 並逐頁指定 `title`。

> ⚠️ **一旦宣告 `pages:`，SUSHI 即停止自動收錄**——**未列於其中的 pagecontent 檔案會從建置產出中靜默消失**，不會有任何錯誤訊息。
> 這與 JOB-23 之位移型錨點、JOB-24 之缺語系字串同屬「靜默失效」型缺陷，故 §3 一併加閘門。

`pages:` 之排列順序同時決定 `toc.html` 之章節順序，故刻意排成與導覽列一致，使兩者互相對應。

---

## 3. 新增閘門 R-6（併入 `scripts/check-menu.js`）

| 規則 | 判定 | 失敗行為 |
|:--|:--|:--|
| **R-6a** | `input/pagecontent/*.md` 之每個檔案，均須出現於 `pages:` | `exit 1`（漏列＝該頁靜默消失） |
| **R-6b** | `pages:` 之每個條目，均須有對應之實體檔案 | `exit 1` |
| **R-6c** | `pages:` 之每個條目均須有非空之 `title` | `exit 1` |
| **R-6d** | `title` 不得為 SUSHI 由檔名推導之 Title Case 預設值（如 `general-exam.md` → `General Exam`） | 警告 |
| **R-6e** | `index.md` 須為 `pages:` 之第一項 | 警告 |

負向測試新增三組（漏列一個 pagecontent 檔／`pages:` 指向不存在之檔／`title` 為空），與既有 R-1／R-2／R-5 三組合計六組。

---

## 4. 待建置後複核

| 代號 | 事項 | 說明 |
|:--|:--|:--|
| **N-1** | 19 個 pagecontent 頁之 `<title>`／H1／麵包屑轉為中文 | 由本 JOB 之 `pages:` 直接決定，預期必然生效 |
| **N-2** | **`toc.html` 自身之標題與麵包屑首段** | `toc.html` **非 pagecontent 檔案**，其標題不受 `pages:` 影響。其「Table of Contents」可能來自 IG Publisher 內建字串而非模板字串（因 `stringsBase.json` 之 `TableOfContents` 已譯且於頁尾生效，卻未套用於此處）。**本容器無法建置，不宜憑猜測改動**——須於建置後自 `output/` 實際產出判定來源再處置。若確為 Publisher 內建字串，屬上游限制，於文件中說明即可，不強行 workaround |

> N-2 之處理原則沿用 [JOB-09](JOB-09-build-config-hardening.md) 對模板釘版之裁示：**不可連線驗證者不憑猜測寫入**。

---

## 5. 對標盤點總表（本 JOB 完成後之狀態）

| 面向 | TW Core IG v1.0.0 | TWHA IG | 狀態 |
|:--|:--|:--|:--|
| 導覽列頂層項數 | 8 | 8 | ✅ JOB-23 |
| 導覽列排列邏輯 | 文件類型導向 | 文件類型導向 | ✅ JOB-23 |
| 導覽列語言 | 純中文 | 純中文 | ✅ JOB-23 |
| 〈目錄〉〈範例〉入口 | 有 | 有 | ✅ JOB-23 |
| 規範文件策展頁 | 有（依 resource 分節） | 有（依 resource 分節） | ✅ JOB-23 |
| 頁面語言宣告 | `zh-TW` | `zh-TW` | ✅ JOB-02 |
| 介面字串（頁尾／標籤） | 中文 | 中文 | ✅ JOB-24 |
| **頁面標題／H1／麵包屑** | **中文** | **中文** | ✅ **本 JOB** |
| publish box 敘述 | 英文（HL7 產生） | 英文（HL7 產生） | ✅ 相同，非差異 |
| header logo／配色 | MOHW 視覺識別 | 無客製 | ⏸ 刻意不比照（JOB-23 B-4：須授權，且 canonical 仍為 provisional） |
| 〈驗證教學〉頁 | 有 | 無 | ⏸ JOB-23 C-1，列後續評估 |
| 〈TWCDI〉頁 | 有 | 無 | ⏸ 刻意不比照（JOB-23 B-3：本案無對應物） |
| 〈快速入門〉〈未決事項〉 | 無 | 有 | ⏸ 刻意保留（JOB-23 B-1：專案型 IG 之審查需求） |

---

## 6. 交給 Claude 規劃用提示

```
請依 docs/optimization/JOB-25-page-titles-zh-tw.md 處理 toc.html 標題（N-2）。
前置條件：需有一次完整建置之 output/ 與 input-cache/publisher-run.log。
先自產出判定 "Table of Contents" 之實際來源（模板 Liquid 取字 vs Publisher 內建字串），
再決定處置；來源不明時不得憑猜測改動，改為於文件說明。
```
