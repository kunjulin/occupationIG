# JOB-24｜頁尾與頁面 chrome 標籤全空白：補齊模板 zh-TW 字串

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（對外觀感；長官與委員直接看得到，且遍及全站每一頁） |
| **類別** | 發佈呈現／國際化 (i18n) |
| **預估** | S（0.5–1 人日） |
| **主要影響檔案** | 新增 `input/data/stringsBase.json`、新增 `scripts/check-translations.js`、`package.json`、`.github/workflows/build-ig.yml`、`README.md`、`package-list.json`、`sushi-config.yaml` |
| **緣起** | 2026-08-17 使用者回報：v0.2.3 發佈後頁尾之 `Links: Table of Contents \| QA Report` 一列只剩 `: \|`，文字全部不見 |
| **狀態** | ✅ **已執行（v0.2.4）** |

---

## 0. 一句話結論

**不是 JOB-23 弄壞的，是 JOB-02 宣告 `language: zh-TW` 之後就一直如此**——模板的
`translations/stringsBase.json` **只含 `en` 一種語言**，頁面模板以
`site.data.stringsBase['zh-TW']['<Key>']` 取字時查無此語系，Liquid 回傳空字串，
於是**全站每一頁的 chrome 標籤都渲染為空白**（連結與版面都在，只是沒有文字）。
對策是本 IG 自備一份含 `zh-TW` 的 `input/data/stringsBase.json`，並加閘門防止日後與上游脫鉤。

---

## 1. 證據

### 1.1 症狀

`https://kunjulin.github.io/occupationIG/zh-TW/index.html` 之頁尾原始碼：

```html
<span style="color: var(--footer-highlight-text-color)">
            : <a ... href="toc.html"></a> |
       <a ... href="../qa.html"></a>
</span>
```

`href` 正確、`<a>` 內文為空。應呈現為
`Links: Table of Contents | QA Report`（比較對象 TW Core IG）。
頁尾上半之 `IG © %YEAR%`、`Package %PKG% based on %FHIRVER%.`、`Generated %DATE%`
三行同樣消失——三者亦取自 `stringsBase`（見 `template/includes/fragment-pageend.html`）。

### 1.2 **不是本次變更引入**（已排除 JOB-23）

自 `gh-pages` 取 JOB-23 **之前**那一版已發佈站台（commit `781a6566`，發佈的是 `f956dfbf`）之
`zh-TW/index.html`，其頁尾**與現況逐字相同**。故本缺陷早於 JOB-23。

### 1.3 根因

| 資料檔 | 來源 | 含有之語系 |
|:--|:--|:--|
| `stringsArtifacts.json` | IG Publisher 依本 IG 之語言產生 | **zh-TW** ✅ |
| `stringsBase.json` | 模板套件 `fhir2.base.template` 隨附 | **僅 en** ❌ |

模板雖附有 `stringsBase-{ar,de,es,fr,lt,nl,pt,ru,sv,uz}.po`，但**未編入該 JSON**，
執行期只有 `en` 可用。模板 `scripts/ant.xml` 之複製區塊自己留了 TODO：

```xml
<copy todir="${ig.temp}/_data" failonerror="false">
  <!-- TODO: Replace this copy with something that will default missing translations to English -->
  <fileset dir="${ig.template}/translations" includes="*.json"/>
</copy>
```

亦即**上游明知缺語系不會退回英文**，尚未處理。

> 為何 TW Core IG 看起來正常：其頁尾標籤為英文（`Links`／`Table of Contents`／`QA Report`），
> 代表 TW Core 之 `lang` 解析為 `en`，未宣告 `i18n-default-lang: zh-TW`。本 IG 宣告了，
> 反而落入這個缺口。**這是「做對了 i18n 宣告卻被模板反咬」，不是設定錯誤**，
> 故不採「把 `language` 改回 en」之走回頭路解法。

### 1.4 影響範圍

`stringsBase.en` 共 **126 個鍵**，並非只有頁尾。實測 profile 頁上
`Official URL`／`Version`／`Computable Name` 等標籤同樣為空。
換言之**全站每一頁都受影響**，只是頁尾最顯眼。

---

## 2. 方案

### 2.1 採用

| 編號 | 措施 |
|:--|:--|
| **A-1** | 新增 `input/data/stringsBase.json`，含 `en`（**逐字複製自模板**）與 `zh-TW`（126 鍵全數翻譯）。IG Publisher 會將 `input/data` 併入 Jekyll 之 `_data`（模板 `ant.xml` 註記：「input/data already works」） |
| **A-2** | 新增 `scripts/check-translations.js` 閘門（規格見 §5），掛入 `npm run verify` 與 CI |
| **A-3** | 翻譯採**繁體中文（臺灣）**，術語與本 IG 既有頁面一致（如 `ArtifactsSummary` 譯為「資源總覽」，與導覽列同字） |

### 2.2 不採用

| 編號 | 事項 | 理由 |
|:--|:--|:--|
| **B-1** | 不把 `language` 改回 `en` | 那會讓整份中文內容重新被標記為 `lang="en"` 並輸出至 `en/` 子目錄——正是 JOB-02 修掉的問題。以退回錯誤設定來換頁尾好看，是拿規範正確性換外觀 |
| **B-2** | 不直接改 repo 根目錄之 `template/` | 該目錄是 IG Publisher 解壓 `fhir2.base.template#current` 的產物，**每次建置都會被覆蓋**，CI 更是重新下載。改它等於沒改 |
| **B-3** | 不翻譯純技術符號 | `XML`／`JSON`／`TTL`／`CSV`／`Excel`／`Schematron`／`ADL` 維持原文；`Profile`／`Extension` 亦保留英文，與本 IG 既有頁面（〈Profiles 與 Extensions〉）用字一致 |

### 2.3 自備檔案之風險與對策

自備即與上游脫鉤：模板日後**新增**字串鍵時，我方檔案不會自動跟上，
那些新鍵會在 `zh-TW` **與 `en` 兩邊都變成空白**，且不會有任何錯誤訊息——
與 JOB-23 之位移型錨點屬**同型的「靜默失效」**。
故 A-2 之閘門不是可選項，是本方案成立的前提。

---

## 3. 驗收標準

1. 頁尾呈現 `連結: 目錄 | QA 報告`，且 `IG © …`／`套件 …`／`產生日期 …` 三行皆有文字。
2. `npm run check:i18n` 通過；`npm run check:i18n:selftest` 四組負向測試全數被攔。
3. CI 之翻譯閘門排在 IG Publisher **之後**（T-1／T-2 需要解壓後的模板才能比對）。
4. `err = 0`，QA 閘門不退步。
5. `README.md`、`package-list.json`、`sushi-config.yaml` 三處版本一致。

---

## 4. 工作項目

| 序 | 項目 | 產出 |
|:--|:--|:--|
| 1 | 產生 `input/data/stringsBase.json`（en 逐字複製 ＋ zh-TW 126 鍵） | ✅ 新檔 |
| 2 | 新增 `scripts/check-translations.js`（T-1～T-5 ＋ 負向自我測試） | ✅ 腳本 |
| 3 | 掛入 `npm run check:i18n{,:strict,:selftest}` 與 `verify`；CI 加步驟 | ✅ `package.json`＋workflow |
| 4 | 本機建置驗證頁尾實際渲染 | ✅ 見 §6 |
| 5 | 版次 0.2.4、README 更新記錄、`package-list.json` 條目、重建 `fsh-source.zip` | ✅ |

---

## 5. `scripts/check-translations.js` 規格

| 規則 | 判定 | 失敗行為 |
|:--|:--|:--|
| **T-1** | 模板 `en` 之每個鍵，我方 `en` 與 `zh-TW` 均須存在 | `exit 1` |
| **T-2** | 我方 `en` 之值須與模板 `en` **逐字相同**（防止無意間改動英文原文） | `exit 1` |
| **T-3** | 同一鍵之 `%PLACEHOLDER%` 集合，`en` 與 `zh-TW` 須一致（漏掉 `%DATE%` 會少印資料） | `exit 1` |
| **T-4** | `zh-TW` 不得留有空字串（空白標籤正是本 JOB 要消滅的症狀） | `exit 1` |
| **T-5** | 我方多出、模板已無之鍵 | 警告（`--strict` 時失敗） |

模板來源檔在建置後才存在。找不到時**跳過 T-1／T-2／T-5 並明白告知**——
不可因為「沒東西可比」就靜默通過。CI 一律先建置再跑本閘門，故比對必定執行。

負向測試（`--self-test`）內建四組必失敗案例：模板新增鍵未收錄／擅改英文原文／
譯文漏佔位符／譯文為空字串。

---

## 6. 執行紀錄

### 6.1 驗證

| 驗證 | 結果 |
|:--|:--|
| `npm run check:i18n:selftest` | 四組負向測試全數通過 |
| `npm run check:i18n` | OK：zh-TW 126 字串全數非空、佔位符與 en 一致、與模板 en（126 鍵）完全對齊 |
| SUSHI | 0 Errors |
| 本機離線建置後之頁尾渲染 | 見 §6.2 |

### 6.2 機制確認

`input/data/stringsBase.json` 確實被併入 `temp/pages/_data/`，且 `zh-TW` 生效——
頁尾標籤自空白恢復為中文。**此為本方案唯一的未知數**（ant.xml 之
`input/data` 複製區塊是註解掉的，僅以註記聲稱「already works」），故以實建置確認而非採信註記。

### 6.3 附帶說明

- 本次**未變更**任何 Profile／ValueSet／CodeSystem／Extension／範例之定義，亦未變更任何頁面檔名。
- `input/data/` 為本 repo 首次使用之目錄；其內容不進入 `fsh-source.zip`
  （該封包只收 `input/fsh/`＋`sushi-config.yaml`＋`ig.ini`），但 `sushi-config.yaml` 之版次變更
  仍會使該封包過期，故本次一併重建。
