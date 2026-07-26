# JOB-02｜發佈語言（zh-TW）、網址結構與版本歷程正式化

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（第一印象／可引用性） |
| **類別** | 發佈組態 |
| **預估** | S（1–2 人日） |
| **相依** | 無（可與 JOB-03、JOB-12 一併做成一個「發佈整備」批次） |
| **主要影響檔案** | `sushi-config.yaml`、`ig.ini`、新增 `package-list.json`、`input/pagecontent/index.md` |

---

## 1. 問題（證據）

審閱網址是 `https://kunjulin.github.io/occupationIG/en/index.html`——**`/en/` 這件事本身就是問題**。

實際檢視 gh-pages（`9fd146f`）：

**(1) 根目錄不是內容，是轉址殘骸**（`index.html` 全文僅 560 bytes）

```html
<html><body>
<!--ReleaseHeader--><p id="publish-box">臺灣勞工健康檢查交換實作指引 ... - Local Development build (v0.1.0)
built by the FHIR (HL7® FHIR® Standard) Build Tools. See the
<a href='https://twcore.mohw.gov.tw/ig/twha/history.html'>Directory of published versions</a></p><!--EndReleaseHeader-->
<script type="text/javascript">
langs=["en"]
</script>
<script type="text/javascript" src="assets/js/lang-redirects.js"></script>
</body></html>
```

根目錄下 **1012 個 html 檔全部都是這種 560 bytes 的轉址殘骸**（實際內容都在 `en/` 下）。
後果：

- 直接開 `https://kunjulin.github.io/occupationIG/` 需靠 JavaScript 才能看到內容；
- 任何人分享的連結都會帶著 `/en/`，語意與內容不符；
- 搜尋引擎與 FHIR registry 抓到的是空殼頁。

**(2) 語言標記錯誤**——內容為繁體中文，但：

```html
<html xml:lang="en" xmlns="..." lang="en" dir="ltr">
<title>Home - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0</title>
```

`sushi-config.yaml` 未宣告 `language`，IG Publisher 預設為 `en`，於是把整份中文 IG 放進 `en/` 子目錄。
這會影響螢幕閱讀器、瀏覽器翻譯提示、以及 `ImplementationGuide.language` 之正確性。

**(3) publish box 顯示為本機測試版**

`Local Development build (v0.1.0)` ＋ 指向不存在的 `https://twcore.mohw.gov.tw/ig/twha/history.html`。
gh-pages 上**沒有 `package-list.json`**（只有 `sub-package-list.json`，以及 template 自帶的樣本
`template/package/package-list.json`，那不是本 IG 的）。因此「Directory of published versions」必定 404。

---

## 2. 目標與驗收標準

1. `sushi-config.yaml` 宣告 `language: zh-TW`（同步 `ImplementationGuide.language`）。
2. 網站根 URL（`https://kunjulin.github.io/occupationIG/`）**直接呈現首頁內容**，不再需要 JS 轉址。
3. 輸出頁面為 `<html lang="zh-TW">`。
4. `package-list.json` 建立且 `history.html` 可達；publish box 不再顯示 `Local Development build`。
5. `<title>` 語言一致（決定是否保留英文全稱，見 §3.4）。
6. gh-pages 上不再有 1000+ 個 560 bytes 的空殼頁（或若採多語佈局，則根目錄轉址頁需為 `<noscript>` 可用之 meta refresh）。

---

## 3. 工作項目

### 3.1 宣告語言

於 `sushi-config.yaml` 加入：

```yaml
language: zh-TW
```

並確認 `ig.ini` / IG Publisher 參數未另行覆寫語言。重建後檢查：

- 輸出是否落在根目錄（單語言時應如此），或落在 `zh-TW/`；
- `en/` 目錄是否應保留（見 §3.3）。

### 3.2 建立 `package-list.json`

放在 repo 根（IG Publisher 會複製到輸出）：

```json
{
  "package-id": "mohw.tw.twha",
  "title": "臺灣勞工健康檢查交換實作指引 (TWHA IG)",
  "canonical": "https://twcore.mohw.gov.tw/ig/twha",
  "introduction": "以勞工健康檢查為核心之 FHIR 資料交換標準，繼承臺灣核心實作指引 (TW Core IG)。",
  "list": [
    {
      "version": "current",
      "desc": "Continuous integration build (研製中草案)",
      "path": "https://kunjulin.github.io/occupationIG",
      "status": "ci-build",
      "current": true
    },
    {
      "version": "0.1.0",
      "date": "2026-07-26",
      "desc": "STU1 草案（工研院委託研製中，尚未定稿）",
      "path": "https://kunjulin.github.io/occupationIG",
      "status": "draft",
      "sequence": "STU 1",
      "fhirversion": "4.0.1"
    }
  ]
}
```

> ⚠️ `canonical` 目前為 provisional（正式命名空間未核定，見 JOB-13）。
> `path` 暫用 GitHub Pages 位址；待正式 canonical 核定後需一併更新，**這點必須在檔案內註記**，
> 否則之後容易漏改而造成版本歷程指向錯誤主機。

同時在 `sushi-config.yaml` 加上 `parameters.path-history`，讓 publish box 的
「Directory of published versions」連到實際可達的 `history.html`。

### 3.3 決定語言佈局

> 🔍 **已查明根因（2026-07-26）**：語言子目錄**不是**因為缺少設定，而是模板主動要求的。
> `template/config.json`（`fhir2.base.template`）第 4 行：
>
> ```json
> "multilanguage-format": true,
> ```
>
> 只要模板宣告此旗標，IG Publisher 就會把內容輸出到語言子目錄，
> 並在根目錄產生 `lang-redirects.js` 轉址殼頁（見 `template/content/assets/js/lang-redirects.js`，
> 內容為 `window.location.replace(langs[0]+"/"+pageName)`），**與語言數量無關**。
>
> 因此宣告 `language: zh-TW` 的效果是 **`/en/` → `/zh-TW/`**（語言標記與目錄名皆正確），
> 但**根目錄仍會是轉址殼頁**。要讓內容直接落在裸根目錄，必須換用未宣告
> `multilanguage-format` 的模板。

三個選項：

| 選項 | 做法 | 結果 | 風險 |
|:--|:--|:--|:--|
| **A 宣告 zh-TW（已採用）** | `language: zh-TW`，保留現行模板 | 內容至 `/zh-TW/`，`lang="zh-TW"` 正確；根目錄仍為轉址殼頁 | 低。已執行 |
| **B 換模板** | 改用未宣告 `multilanguage-format` 之模板 | 內容回到裸根目錄 | **中高**。會改變全站樣式與可用 fragment（JOB-03 依賴其中四個），且**必須實際建置後目視比對才能確認**。不宜在未建置驗證前變更送審文件之模板 |
| **C 雙語** | 保留語言子目錄並實際提供英譯 | 真正的雙語站 | 高成本，且本期無英譯需求 |

**現況（改前）等於「選了 C 卻沒做翻譯」**——最差的組合。
本次採 **A**：先讓語言標記與目錄名誠實，把 B 留為需建置驗證的後續決策（見 §7 執行紀錄）。

### 3.4 標題語言一致性

`<title>` 現為中英夾雜。建議：中文標題為主，英文全稱移至 `index.md` 首段
（現行 `index.md` 已有英文全稱，屬合理保留），或維持現狀但在 plan 中明確記錄此為刻意設計。

### 3.5 gh-pages 發佈方式

現況為本機建置後手動推送（qa.txt 顯示建置路徑 `C:\repo\occupationIG-main`）。
本 JOB 只需確保推送內容正確；自動化交由 **JOB-08**。

---

## 4. 不在本 JOB 範圍

- **英文敘述內容之翻譯**（若需要，另立 JOB；本 JOB 只處理語言標記與網址結構）。
- 正式 canonical namespace 之核定（JOB-13 登記為未決事項）。
- CI 自動發佈（JOB-08）。

---

## 5. 風險與注意事項

- 改語言會改變**所有輸出頁面的路徑**。若已有人引用 `/en/xxx.html`，需在根目錄留下轉址
  （建議用 `<meta http-equiv="refresh">` 而非純 JS，以支援無 JS 環境）。
- `package-list.json` 之 `path` 一旦寫入錯誤主機，publish box 與 registry 都會沿用；請與 JOB-13 的 canonical 決議一起確認。
- `status: ci-build` 與 `draft` 的選擇會影響 FHIR registry 是否收錄；本 IG 為「研製中草案」，
  不宜標為 `release`。

---

## 7. 執行紀錄（2026-07-26）

### 已完成

| # | 變更 | 檔案 |
|--:|:--|:--|
| 1 | 宣告 `language: zh-TW`（附註說明未宣告時的後果） | `sushi-config.yaml` |
| 2 | 新增 `parameters.path-history`，指向實際可達之 GitHub Pages 位址 | `sushi-config.yaml` |
| 3 | 新增 `package-list.json`（`current` ci-build ＋ `0.1.0` draft／STU 1） | `package-list.json` |
| 4 | 新增版本歷程頁，使 publish box 之「Directory of published versions」不再 404；頁內揭露 canonical 與實際發佈位址不一致、以及建置來源不可追溯 | `input/pagecontent/history.md` |
| 5 | 查明並記錄 `/en/` 之根因為模板之 `multilanguage-format: true`（見 §3.3） | 本檔 |

`history.md` 刻意**不列入 `menu`**——HL7 IG 慣例是版本歷程僅由 publish box 連結，
不佔用主導覽；該頁仍會出現於 `toc.html`，故非孤兒頁。

### 尚待在可建置環境驗證（本環境無法建置）

本環境無法執行 IG Publisher：`packages.fhir.org` 與 `tx.fhir.org` 皆不可連線，
且未安裝 Jekyll。已完成的驗證僅到 **SUSHI 成功解析 `sushi-config.yaml`**
（改動前後皆僅剩套件下載之網路錯誤，無新增組態錯誤）。

請在可連外的 Windows／CI 環境執行 `_genonce_tx.bat` 後確認：

1. 輸出目錄由 `output/en/` 變為 `output/zh-TW/`，且頁面為 `<html lang="zh-TW">`；
2. `output/zh-TW/history.html` 存在，且 publish box 之「Directory of published versions」可點達；
3. publish box 是否仍顯示 `Local Development build`——**預期仍會顯示**，
   因該字串來自「非 CI 建置」而非缺少 `package-list.json`；真正的修正是改由 CI 建置（**JOB-08**）。
   本 JOB 只保證版本歷程連結可達；
4. gh-pages 上舊的 `en/` 目錄與 1012 個根目錄殼頁需在下次發佈時清理
   （建議由 JOB-08 之發佈流程以全量覆蓋處理，而非增量推送）。

### 未處理（需決策）

- **選項 B（換模板讓內容回到裸根目錄）**：需先建置比對樣式與 fragment 可用性，
  且與 JOB-09 之模板釘版決策相關，故未執行。
- ~~**舊 `/en/` 路徑之轉址**~~ → **已決定不保留**（2026-07-26 使用者確認）。
  改為 `/zh-TW/` 後舊 `/en/...` 連結直接失效，不另設轉址頁。
  發佈時舊 `en/` 目錄與根目錄殼頁應以**全量覆蓋**清除（併入 JOB-08 之發佈階段）。
- `package-list.json` 之 `canonical`（`twcore.mohw.gov.tw`）與 `path`（GitHub Pages）
  目前刻意不一致，反映 provisional 現況；正式命名空間核定後須一併更新（JOB-13）。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-02-publication-language-and-versioning.md 與
docs/optimization/evidence/qa-summary-2026-07-26.md §4，為這個 JOB 產出實作計畫。

重點：
1. 確認在 sushi-config.yaml 宣告 language: zh-TW 後，IG Publisher 2.2.11 的輸出路徑會如何變化
   （回到根目錄，或變成 zh-TW/ 子目錄），並據此決定 §3.3 的選項 A 或 B。請說明判斷依據，
   必要時查 IG Publisher 的 i18n 文件確認，不要猜。
2. 撰寫 package-list.json，並在 sushi-config.yaml 補 parameters.path-history。
   canonical 目前是 provisional，請在檔案與文件中留下明確的「待正式命名空間核定後需更新」註記。
3. 規劃舊 /en/ 路徑的轉址處理（需支援無 JavaScript 環境）。
4. 列出改語言後需要一併檢查的項目（title 語言一致性、publish box 文字、
   gh-pages 上 1012 個空殼頁的清理方式）。
5. 明確排除英譯工作。
```
</content>
