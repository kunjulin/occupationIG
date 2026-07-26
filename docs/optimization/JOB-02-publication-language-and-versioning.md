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
> 因此無論如何設定語言，**根目錄都會是轉址殼頁**；要讓內容直接落在裸根目錄，
> 必須換用未宣告 `multilanguage-format` 的模板。
>
> ⚠️ 但**改變語言目錄名稱的參數不是 `language:`**——實測證明僅設 `language: zh-TW`
> 輸出仍為 `en/`。正確參數為 `parameters.i18n-default-lang`，考證過程見 §7。

三個選項：

| 選項 | 做法 | 結果 | 風險 |
|:--|:--|:--|:--|
| **A 宣告 zh-TW（已採用）** | `language: zh-TW` **＋ `parameters.i18n-default-lang: zh-TW`**，保留現行模板 | 內容至 `/zh-TW/`，`lang="zh-TW"`；根目錄仍為轉址殼頁 | 低。已執行。⚠️ 僅設 `language:` 不足，見 §7 |
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

### ⚠️ 第一次嘗試不足：`language:` 不改變輸出目錄（2026-07-26 實測）

**原假設有誤。** 我原本認為宣告 `language: zh-TW` 會使輸出由 `en/` 變為 `zh-TW/`。
CI 建置（run 30209833825）之診斷輸出否定了這個假設：

```
--- output/ 一層子目錄 ---
assets/
en/
--- index.html 位置與大小 ---
output/en/index.html  26954 bytes
output/index.html       603 bytes
```

即 `language: zh-TW` **只設定了 `ImplementationGuide.language`（資源本身的語言），
不影響 IG Publisher 產出頁面的語言目錄**。

#### 真正的參數（自 publisher.jar 求證，非臆測）

於 `input-cache/publisher.jar` 掃描 `org/hl7/fhir/igtools/publisher/PublisherIGLoader.class`
（載入 IG 參數之類別）之字串常數，取得完整 IG 參數清單，其中與語言相關者：

| 參數 | 對應之類別欄位 | 作用 |
|:--|:--|:--|
| **`i18n-default-lang`** | `defaultTranslationLang` | **預設翻譯語言——決定輸出語言目錄名稱** |
| `i18n-lang` | `translationLangs` | 追加其他語言 |
| `translation-supplements` | — | 翻譯供給檔來源 |
| `language-translations-mode` / `lang-pack` / `resource-language-policy` | — | 翻譯行為細節 |
| `multilanguage-format`（模板端） | `setNewMultiLangTemplateFormat` | 印證 §3.3 之發現：語言子目錄佈局由模板旗標驅動 |

（`default-language` 亦出現於 jar 中，但屬 Saxon XSLT 函式，與 IG 無關。）

#### 修正

`sushi-config.yaml` 之 `parameters` 增列 `i18n-default-lang: zh-TW`，
與 `language: zh-TW` 並存——前者宣告產出頁面的預設語言，後者宣告 IG 資源本身的語言。

#### ✅ 已由 CI 驗證（run 30210248444，commit `f202a26a`）

`Verify publication layout` 步驟**通過**，即三項斷言全部成立：

* `output/zh-TW/{index,history,ip-statements,conformance}.html` 皆存在；
* `output/en` **不存在**；
* 內容首頁 `<html ... lang="zh-TW">`。

`i18n-default-lang` 確為正確參數。JOB-02 之語言與網址結構目標達成。

#### ⚠️ 連帶效應：INFORMATION 訊息由 257 增為 475（+218）

同一次執行之 QA 閘門於 `TOTAL info` 判定退步。`err` 維持 0、`warn` 維持 204，
12 個具名類別全部持平，**僅 info 總數增加**。

**已查明組成**（run 30210656956 之退步明細，共 475 筆／202 種形態）：

```
  129 × Wrong Display Name（既有，未變）
   28 × obs-hearing .component[N].code.coding[N].display:
        There are no valid display names found for the code ...
   15 × TWHA-HearingTest snapshot pattern ... （同上）
   15 × TWHA-HearingTest differential pattern ... （同上）
   14 × Observation/obs-hearing ... （同上）
    8 × obs-bloodpressure component ... （同上）
  5,5 × Encounter.class / Encounter.class.display ... （同上）
  4×4 × obs-height／obs-weight／obs-bloodpressure／obs-lab-glucose .code.coding.display（同上）
```

新增者**全屬同一種訊息**：`There are no valid display names found for the code ... for language(s)`。

**成因**：宣告 `i18n-default-lang: zh-TW` 後，IG Publisher 會檢查各代碼在 **zh-TW** 下是否有顯示名。
LOINC／SNOMED CT／v3 等外部代碼系統並無繁體中文 designation，故逐筆回報。

**判定：預期且無從修正。** 這是宣告中文為預設語言的必然結果，非本 IG 之缺陷；
本專案無法為 LOINC 補中文顯示名。等級為 INFORMATION，`err` 與 `warn` 均未受影響。

**處置**：`qa-baseline.json` 之 `info` 由 257 調為 475，**並具名追蹤**
`There are no valid display names found for the code`（值 218），
且於檔內以 `_infoNote`／`_categoriesNote` 記錄理由與推導方式——
避免日後只看到一個放大的總數而不知其來由，也避免此類訊息掩蓋其他 info 增長。

> 218 係由總數差額（475 − 257）推得而非直接量測（該類訊息在切換語言前並不存在，故差額即其筆數）。
> 若實際值較低，閘門會標示「改善」並提示下調；若較高則會失敗，代表另有其他新增 info 需個別檢視。

### 本環境之驗證限制

本環境無法執行 IG Publisher：`packages.fhir.org` 與 `tx.fhir.org` 皆不可連線，
且未安裝 Jekyll（`github.com` 可連，故 publisher.jar 本身取得得到——上述參數查證即以此進行）。
故語言相關變更一律須由 CI 驗收。

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
