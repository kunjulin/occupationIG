# JOB-24｜頁尾與頁面 chrome 標籤全空白：補齊模板 zh-TW 字串

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（對外觀感；長官與委員直接看得到，且遍及全站每一頁） |
| **類別** | 發佈呈現／國際化 (i18n) |
| **預估** | S（0.5–1 人日） |
| **主要影響檔案** | 新增 `input/data/stringsBase.json`、新增 `scripts/check-translations.js`、`package.json`、`.github/workflows/build-ig.yml`、`README.md`、`package-list.json`、`sushi-config.yaml`｜**v0.9.3 追加**：新增 `input/data/stringsArtifacts.json` |
| **緣起** | 2026-08-17 使用者回報：v0.2.3 發佈後頁尾之 `Links: Table of Contents \| QA Report` 一列只剩 `: \|`，文字全部不見 |
| **狀態** | ✅ **已執行（v0.2.4）**；⚠️ **當時只處置了一半，v0.9.3 補齊——見 §7** |

---

## 0. 一句話結論

**不是 JOB-23 弄壞的，是 JOB-02 宣告 `language: zh-TW` 之後就一直如此**——模板的
`translations/stringsBase.json` **只含 `en` 一種語言**，頁面模板以
`site.data.stringsBase['zh-TW']['<Key>']` 取字時查無此語系，Liquid 回傳空字串，
於是**全站每一頁的 chrome 標籤都渲染為空白**（連結與版面都在，只是沒有文字）。
對策是本 IG 自備一份含 `zh-TW` 的 `input/data/stringsBase.json`，並加閘門防止日後與上游脫鉤。

> ⚠️ **本結論只對了一半，見 §7。** 模板隨附的 strings 檔**不只一個**：另有
> `stringsArtifacts.json`（78 鍵），同樣只含 `en`。本 JOB 之 §1.3 誤將其列為
> 「已有 zh-TW ✅」而排除在處置外，導致 `artifacts.html` 之分類名空白至 v0.9.3 才修。

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
| ~~`stringsArtifacts.json`~~ | ~~IG Publisher 依本 IG 之語言產生~~ | ~~**zh-TW** ✅~~ |
| `stringsBase.json` | 模板套件 `fhir2.base.template` 隨附 | **僅 en** ❌ |

> 🔴 **更正（v0.9.3）——上表第一列整列都是錯的，而且這一句就是本 JOB 漏掉一半的原因。**
>
> `stringsArtifacts.json` **不是** IG Publisher 依本 IG 語言產生的，它與 `stringsBase.json`
> 一樣由模板 `fhir2.base.template` 隨附於 `translations/`，而且**同樣只含 `en`**
> （78 鍵；實測 `Object.keys(require('template/translations/stringsArtifacts.json'))` → `['en']`）。
>
> 當時把它列為「已有 zh-TW ✅」，等於**在根因分析階段就把它排除在處置範圍外**，
> 於是 A-1 只補了 `stringsBase`、A-2 之閘門也只比對 `stringsBase`。
> 後果見 §7：`artifacts.html` 之 9 個分類標題與 9 個目錄連結**空白了四個多月**，
> 而閘門每一輪都是綠燈。
>
> ⚠️ 這個錯誤的形態值得記下來：**它不是「漏看了一個檔案」，是「看到了、但斷言它沒問題」。**
> 前者會在盤點時被抓到，後者不會——因為表格上寫著 ✅，下一個人不會再去查。
> 與 `qa-baseline.json` 中那兩處把基準線值寫成「實測」的錯誤同型
> （見該檔 `_job31Note`／`_v080Note` 之 🔴 更正）：**一個標成已驗證的錯值，
> 比一個空白危險得多。**

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

> 🔴 **更正（v0.9.3）：本節低估了影響範圍。** 受影響的不只 `stringsBase` 之 126 鍵，
> 還有 `stringsArtifacts` 之 **78 鍵**，合計 204 鍵。本 JOB 當時只處置了前者。
> 完整範圍見 §7。

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

> 🔴 **更新（v0.9.3）：本節所述之「單一檔案」設計已被推翻。**
> 閘門現為**資料驅動**——掃描 `template/translations/strings*.json`，對**每一個**檔案
> 執行下表規則，並新增 T-0。原設計把檔名寫死，正是 §7.3 之缺陷來源。
> 下表之 T-1～T-5 語意不變，惟「模板」與「我方」均改為指**當前受檢之該檔**。

| 規則 | 判定 | 失敗行為 |
|:--|:--|:--|
| **T-0**（v0.9.3 新增） | 模板 `translations/` 下每個 `strings*.json`，我方 `input/data/` 必須有同名檔 | `exit 1` |
| **T-1** | 模板 `en` 之每個鍵，我方 `en` 與 `zh-TW` 均須存在 | `exit 1` |
| **T-2** | 我方 `en` 之值須與模板 `en` **逐字相同**（防止無意間改動英文原文） | `exit 1` |
| **T-3** | 同一鍵之 `%PLACEHOLDER%` 集合，`en` 與 `zh-TW` 須一致（漏掉 `%DATE%` 會少印資料） | `exit 1` |
| **T-4** | `zh-TW` 不得留有空字串（空白標籤正是本 JOB 要消滅的症狀） | `exit 1` |
| **T-5** | 我方多出、模板已無之鍵 | 警告（`--strict` 時失敗） |

模板來源檔在建置後才存在。找不到時**跳過 T-1／T-2／T-5 並明白告知**——
不可因為「沒東西可比」就靜默通過。CI 一律先建置再跑本閘門，故比對必定執行。

負向測試（`--self-test`）內建四組必失敗案例：模板新增鍵未收錄／擅改英文原文／
譯文漏佔位符／譯文為空字串。

> **v0.9.3 追加三案**（以真實檔案系統執行，見 §7.5）：
> T-0 缺檔須失敗／兩檔齊備不得誤報（正向對照）／兩邊皆無 strings 檔須判為
> 「形同未執行」而非通過。

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

---

## 7. 後續發現（v0.9.3，2026-08-21）——同一個缺陷，第二個字串檔

| 欄位 | 內容 |
|:--|:--|
| **緣起** | 使用者回報 `zh-TW/artifacts.html` 右側「內容」框之項目全空 |
| **狀態** | ✅ 已修復並發佈（v0.9.3，gh-pages `24bdf5b1`，sourceCommit `39a3dcc7`） |
| **潛伏期** | **自 v0.2.4（2026-08-17）至 v0.9.3（2026-08-21），中間經過 27 個版次**（自 `package-list.json` 逐項數出：0.2.5～0.9.2 共 27 版，非估計） |

### 7.1 實際範圍比回報的更廣

使用者只提到右側目錄框。實測整頁：

| 元素 | 修復前 | 修復後 |
|:--|--:|--:|
| 空的分類標題 `<h3>` | **9** | 0 |
| 空的目錄連結 | **9** | 0 |
| 分類說明段落 | **9 段皆空** | 9 段皆有字 |

頁面上只看得到 `20.0.1`／`20.0.2` 這種編號與表格，看不到「行為：服務宣告」
「結構：資源 Profile」「術語：值集」等分類名。

### 7.2 成因：與 §1.3 完全相同，只是換一個檔

`template/scripts/createArtifactSummary.xslt` 取字之三處：

```
27:  <a href="#{position()}">{{site.data.stringsArtifacts[lang]['<Type>Name']}}</a>
59:  <h3>{{site.data.stringsArtifacts[lang]['<Type>Name']}} </h3>
66:  {% capture grouping_desc %}{{site.data.stringsArtifacts[lang]['<Type>Desc']}}
```

**同一頁即可自證機制**——這是本次診斷中最有說服力的一點：

| 元素 | 取自 | 結果 |
|:--|:--|:--|
| 「內容:」 | `stringsBase['Contents']` | ✅ 有字（本 JOB 已補） |
| 頁面導言 | `stringsBase['ArtifactsIntro']` | ✅ 有字 |
| 9 個分類名與說明 | `stringsArtifacts[…]` | ❌ 全空（本 JOB **未**補） |

同一個頁面、同一種取字語法、兩個資料檔，一好一壞。

### 7.3 為何拖了四個多月都沒人發現

**閘門存在、每輪都跑、每輪都綠。** `scripts/check-translations.js` 原第 40–41 行：

```js
const OURS     = path.join(ROOT, 'input', 'data', 'stringsBase.json');
const TEMPLATE = path.join(ROOT, 'template', 'translations', 'stringsBase.json');
```

**路徑寫死成單一檔案**，對 `stringsArtifacts` 完全沒有視野。

⚠️ 這比「閘門沒接到 CI」更難察覺。沒接 CI 至少是**沒有訊號**；
這種是**持續發出錯誤的通過訊號**——有閘門、在跑、每次都說沒問題。
本 repo 同期另有兩件同族缺陷（`check:gov`／`check:intref` 只在本機 `verify`、
從未進 CI），三者已一併記入 [`CLAUDE.md`](../../CLAUDE.md) §4。

### 7.4 處置

| 編號 | 措施 |
|:--|:--|
| **C-1** | 新增 `input/data/stringsArtifacts.json`：78 鍵，`en` 逐字照抄模板（由 T-2 看管）、`zh-TW` 全譯 |
| **C-2** | `check-translations.js` 改為**資料驅動**：掃描 `template/translations/strings*.json`，**逐檔**執行 T-1～T-5，不再寫死檔名 |
| **C-3** | 新增 **T-0**：模板有的 strings 檔，我方 `input/data/` 必須也有——缺一即 `exit 1`。日後模板再新增字串檔會直接紅燈 |
| **C-4** | 順帶補一處**反向**漂移：`check:i18n` 在 CI 裡卻不在 `npm run verify` 裡（與 `check:gov` 的漏法方向相反），已加入 verify |

### 7.5 T-0 之負向測試

T-0 無法只靠 `check()` 測——「整個檔案不存在」發生在 `main()` 的掃描階段，
不在單檔比對邏輯內。故改以**真實檔案系統**測試：於暫存目錄重建
`template/translations` ＋ `input/data` 結構後，以 `child_process` 實跑本腳本。

```
✓ T-0 模板有 strings 檔、我方沒有 → 失敗
✓ T-0 兩個檔都備妥 → 不誤報（正向對照）
✓ 模板與我方皆無 strings 檔 → 判為未執行，不得靜默通過
```

**另以真實檔案反向驗證**（不只靠 fixture）：把新增的
`input/data/stringsArtifacts.json` 移走後實跑閘門，確實轉紅並印出 T-0。

### 7.6 線上複驗

以**修復前用過的同一支解析程式**跑已發佈之 `zh-TW/artifacts.html`，數字見 §7.1。

⚠️ **除了計數，另逐項核對分類名確為中文。** 若模板日後改為「缺語系時退回 `en`」，
計數同樣會變成 9，但那代表 `zh-TW` 區塊根本沒被讀到——**是另一種壞法，只數數字看不出來**。
實測為「行為：服務宣告 (Capability Statements)」等九項中英並列，與我方譯文相符。

### 7.7 本節給下一個人的三條

1. **「看到了但斷言它沒問題」比「沒看到」更難修**——§1.3 的 ✅ 讓這個檔案被跳過了 27 個版次。
   盤點時對每一個標成「已 OK」的項目，要問「這個 ✅ 是量出來的還是推的」。
2. **訂閘門範圍時要問「這一類東西有幾個」**，不要只處理眼前踩到的那一個。
   能資料驅動就不要寫死檔名。
3. **凡是「上游有、我方自備」的機制，都要有一條「上游有而我方沒有 → 失敗」**。
   T-1～T-5 管的是「檔案內容對不對」，管不到「檔案存不存在」——那是兩個不同的問題。
