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

兩個選項，請在 plan 中比較後選一：

| 選項 | 做法 | 適用 |
|:--|:--|:--|
| **A（建議）單語言** | 只宣告 `zh-TW`，輸出回到根目錄，移除 `en/` 與空殼轉址頁 | 本 IG 讀者為國內醫院／事業單位／主管機關，且目前**沒有英文敘述內容** |
| **B 雙語** | 保留語言子目錄，並實際提供英譯（`input/pagecontent/` 之翻譯供給檔） | 需要送 HL7 international 或供國外檢視時 |

**現況等於「選了 B 卻沒做翻譯」**——這是最差的組合。若短期不打算翻譯，應改為 A。

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
