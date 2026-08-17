# JOB-23｜導覽列（頁籤內容與順序）比照 TW Core IG 之差異分析與調整方案

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（對外觀感與可尋性；其中 §1.3 錨點位移為**實質缺陷**，屬 P0 性質） |
| **類別** | 資訊架構／發佈呈現 |
| **預估** | S–M（1.5–2 人日；不含新增策展頁之內容撰寫） |
| **主要影響檔案** | `sushi-config.yaml`（`menu`）、`ig.ini`（template 釘版）、新增 `input/pagecontent/examples.md`、新增 `input/pagecontent/profiles-and-extensions.md`、新增 `scripts/check-menu.js`、`.github/workflows/build-ig.yml`、`README.md`、`package-list.json` |
| **緣起** | 2026-08-16 主管指示：頁籤內容與順序請參考 [TW Core IG](https://twcore.mohw.gov.tw/ig/twcore/) 之樣式調整 |
| **狀態** | ✅ **已執行（v0.2.3，2026-08-16）**——§2.4 menu 草案經核准後套用；A-1～A-6 完成，**A-7（模板釘版）移列 JOB-09 續辦**（見 §8）。評估產物為 v0.2.2 |

---

## 0. 一句話結論

**建議「比照其骨幹、保留本案特色」**：導覽列的**排列邏輯**改為 TW Core 的「文件類型導向」（說明 → 目錄 → 規範 → 範例 → 下載 → 安全），頂層縮為 8 項並全數改為純中文；但**不刪除**〈快速入門〉與〈未決事項〉這兩頁——TW Core 沒有它們，是因為 TW Core 是母規範而非受託專案型 IG，兩者的讀者組成不同。同時順手修掉一個真正的缺陷：現行導覽列的 `artifacts.html#1`~`#4` 錨點會隨 artifact 類別增減而**靜默指錯區段**。

---

## 1. 現況差異分析

比較基準：
- **TW Core IG v1.0.0**（<https://twcore.mohw.gov.tw/ig/twcore/>，2026-08-16 實地檢視導覽列 DOM 與 `toc.html`）
- **TWHA IG v0.2.1**（`sushi-config.yaml` 之 `menu` 區塊）

### 1.1 導覽列並排對照

| # | TW Core IG v1.0.0 | TWHA IG v0.2.1（現況） |
|:--|:--|:--|
| 1 | 應用說明 `index.html` | 首頁 (Home) `index.html` |
| 2 | **目錄** `toc.html` | 快速入門 (Quick Start) `quickstart.html` |
| 3 | 規範文件 `artifacts.html` ▾<br>　├ 能力聲明 `capabilitystatements.html`<br>　├ 查詢參數及操作定義 `searchparameters-and-operation.html`<br>　├ 邏輯模型 `models.html`<br>　├ FHIR Profiles及Extensions `profiles-and-extensions.html`<br>　└ 專門術語 `terminologies.html` | 背景與案例 ▾<br>　├ 背景 `background.html`<br>　└ 應用案例 `usecases.html` |
| 4 | **範例** `examples.html` | 資料模型 `datamodel.html` |
| 5 | 結構定義與範例檔下載 `downloads.html` | 檢查與紀錄定義 ▾（5 項：一般／特殊／成人預防保健／服務紀錄／健康管理分級） |
| 6 | **安全性** `security.html` | FHIR 資源 ▾<br>　├ 資源總覽 `artifacts.html`<br>　├ Profiles `artifacts.html#1`<br>　├ Extensions `artifacts.html#2`<br>　├ Value Sets `artifacts.html#3`<br>　├ Code Systems `artifacts.html#4`<br>　└ 遵從性與依賴 `conformance.html` |
| 7 | TWCDI `TWCDI.html` | 術語與安全 ▾（術語定義／安全性／智慧財產權聲明） |
| 8 | 驗證教學 `validates.html` | 未決事項 `open-issues.html` |
| 9 | — | 下載區 `downloads.html` |

**量化**：TW Core 頂層 8 項、下拉 1 組、總入口 13；TWHA 頂層 9 項、下拉 4 組、總入口 21。

### 1.2 五項結構性差異

| 代號 | 差異 | TW Core | TWHA 現況 | 影響 |
|:--|:--|:--|:--|:--|
| **D-1** | **排列邏輯** | **文件類型導向**：說明→目錄→規範→範例→下載→安全→延伸應用→教學 | **業務主題導向**：背景→資料模型→各類檢查→FHIR 資源→術語與安全 | 熟悉 FHIR IG 的審查者（含衛福部資訊處、國際驗證平臺）以文件類型尋址，在本 IG 找不到習慣的位置；這正是主管所指之「順序」問題 |
| **D-2** | **缺〈目錄〉頁籤** | 置於第 2 項 | `toc.html` 由 IG Publisher 自動產生但**未列入 menu** | 全站唯一的完整索引無入口；兩站並排時第一眼即見落差 |
| **D-3** | **缺〈範例〉頂層入口** | 頂層第 4 項 | 12 個 example 僅能自 `artifacts.html` 頁尾找到 | 實作端與委員最想先看範例，卻要捲到最下面 |
| **D-4** | **安全性位階** | 頂層頁籤 | 埋於「術語與安全」下拉第 2 項 | 本案資安為重點審查項目，位階與其重要性不符 |
| **D-5** | **標籤語言** | 純中文 | 中英雙語「首頁 (Home)」 | 導覽列橫向過長，且 `i18n-default-lang: zh-TW` 之後括號英文成為冗餘 |

### 1.3 錨點位移——**這不是樣式問題，是實質缺陷**

現行 menu：

```yaml
Profiles:     artifacts.html#1
Extensions:   artifacts.html#2
Value Sets:   artifacts.html#3
Code Systems: artifacts.html#4
```

`artifacts.html` 的 `#1`、`#2`… 是 **IG Publisher 依「該次建置中實際存在的 artifact 類別」出現順序自動編號**的錨點，並非固定語意。TW Core 的 `artifacts.html` 目前有 12 個區段（Capability Statements／Operation Definitions／Search Parameters／Logical Models／Resource Profiles／Data Type Profiles／Extension Definitions／Value Sets／Code Systems／Concept Maps／Example Instances），TWHA 目前只有其中數類。

**風險**：一旦本 IG 新增或移除任一 artifact 類別（例如 JOB-04 補上 `OperationDefinition`／`CapabilityStatement`、JOB-22 之 `ConceptMap` 已存在），編號整體位移，四個導覽連結會**指到錯誤區段而不會有任何錯誤訊息**——IG Publisher 不檢查頁內錨點語意，`err = 0` 依然成立。

TW Core 對同一問題的解法是**建策展頁**（`profiles-and-extensions.html` 依 resource 分節列出，`terminologies.html` 同理），而非指向自動編號錨點。

### 1.4 底層模板：同源，故調整成本低

| 項目 | TW Core IG | TWHA IG |
|:--|:--|:--|
| 模板 | `fhir2.base.template` 系列（`assets/css/bootstrap-fhir.css`、`project.css`） | `ig.ini`：`template = fhir2.base.template#current` |
| 客製 | `assets/images/logo-header.png`（TW 標誌）、`tw.svg` | 無客製 header 圖示 |

**兩站模板同源**，所謂「樣式不同」的實際來源是 `menu` 設定與 header 圖示，**非模板差異**。因此本 JOB 的主要工作量在 YAML 與兩張新頁面，不涉及模板改寫。

⚠️ 附帶發現：`ig.ini` 使用 `#current` **未釘版**（JOB-09 已登記）。上游模板改版時，本站導覽列外觀會在無人變更程式碼的情況下自行改變——與本次「樣式為何不一致」的問題直接相關，建議一併釘版。

### 1.5 TWHA 有、TW Core 沒有的頁面（**不建議刪除**）

| 頁面 | 為何 TW Core 沒有 | 為何本案應保留 |
|:--|:--|:--|
| 〈快速入門〉 | TW Core 讀者預設為 FHIR 實作者 | 本案審查對象含主管機關、事業單位、非資訊背景委員；此頁為 v0.2.1 專為此需求新增 |
| 〈未決事項〉 | 母規範已定版，無待決清單 | 本案 M-1～M-10／T-1～T-12 之外部依賴揭露，是「研製中草案」誠實交付的核心證據 |
| 〈背景〉〈應用案例〉 | 母規範不需說明委託緣起 | 委託案交付要件 |
| 各類檢查頁（附表八／九／十對照） | 母規範不涉單一領域 | 本 IG 的實質內容主體 |

> **向主管說明的要點**：TW Core 是「母規範／技術參考書」，TWHA 是「受託專案型 IG」，讀者組成不同。比照的應是**排列邏輯與命名風格**，不是逐項複製頁面清單。

---

## 2. 建議方案

### 2.1 建議採納（A 類：低風險、直接回應主管指示）

| 編號 | 措施 | 對應差異 |
|:--|:--|:--|
| **A-1** | 頂層縮為 **8 項**，順序改為 TW Core 之文件類型骨幹；業務主題頁收入下拉 | D-1 |
| **A-2** | 新增〈目錄〉頁籤指向 `toc.html`，置於第 2 位 | D-2 |
| **A-3** | 新增〈範例〉頂層頁籤（需新增 `input/pagecontent/examples.md` 策展頁） | D-3 |
| **A-4** | 〈安全性〉提升為頂層 | D-4 |
| **A-5** | 頂層標籤改**純中文**；英文名稱保留於各頁 H1 與下拉子項 | D-5 |
| **A-6** | **`artifacts.html#1`~`#4` 全數移除**，改指向新增之 `profiles-and-extensions.html` 策展頁與既有 `terminology.html` | §1.3 |
| **A-7** | `ig.ini` 之 template 由 `#current` **釘定版本** | §1.4 |

### 2.2 建議不採納（B 類：須向主管說明理由）

| 編號 | 不採納事項 | 理由 |
|:--|:--|:--|
| **B-1** | 不刪〈快速入門〉〈未決事項〉 | 見 §1.5；此二頁為本案對審查最有利之資產 |
| **B-2** | **不更動任何頁面檔名** | 委員意見書、簡報、既發函文已引用 `general-exam.html` 等位址；改名將造成大量 404，且 `path-history` 尚指向 GitHub Pages。**只改標籤與順序** |
| **B-3** | 不模仿 `TWCDI.html` | 該頁為 TW Core 專屬之臨床文件實作規範，本案無對應物，勉強比照將產生空殼頁 |
| **B-4** | 不比照 header logo／配色 | 使用 MOHW 視覺識別須經授權；且本 IG canonical 尚為 provisional（M-1），視覺上先行「像官方站」反而可能造成本 IG 已獲核定之誤解。屬治理議題，非技術議題 |

### 2.3 建議列入後續評估（C 類）

| 編號 | 事項 | 說明 |
|:--|:--|:--|
| **C-1** | 新增〈驗證教學〉頁（對應 TW Core `validates.html`） | 說明如何以 `validator.fhir.org` 驗證本 IG 之封包，並呼應 [open-issues G-2／G-3](../../input/pagecontent/open-issues.md)「0 Error 代表什麼、不代表什麼」。對送審具高說服力，惟需 1 人日撰寫 |
| **C-2** | 補 `capabilitystatements.html` 策展頁 | 待 JOB-04 之 `$submit`／CapabilityStatement 定案後再做 |

### 2.4 建議之新 `menu`（草案，供核准後直接套用）

```yaml
menu:
  應用說明:
    導言與架構: index.html
    快速入門: quickstart.html
    計畫背景: background.html
    應用案例: usecases.html
  目錄: toc.html
  規範文件:
    資源總覽: artifacts.html
    資料模型: datamodel.html
    Profiles 與 Extensions: profiles-and-extensions.html
    術語與代碼系統: terminology.html
    遵從性與依賴: conformance.html
  檢查與紀錄:
    一般健康檢查: general-exam.html
    特殊危害健康作業: special-exam.html
    成人預防保健: adult-preventive-care.html
    勞工健康服務執行紀錄: service-record.html
    健康管理分級與配工: health-management.html
  範例: examples.html
  結構定義與範例檔下載: downloads.html
  安全性:
    安全與個資保護: security.html
    智慧財產權聲明: ip-statements.html
  未決事項: open-issues.html
```

**核對**：頂層 8 項（與 TW Core 相同）；**所有既有頁面皆保留、檔名皆未變更**；新增頁面 2 個（`examples.md`、`profiles-and-extensions.md`）；移除 4 個位移型錨點連結。

---

## 3. 驗收標準

1. `sushi-config.yaml` 之 `menu` 頂層為 8 項，順序如 §2.4；標籤為純中文。
2. menu 中**不再出現** `artifacts.html#<數字>` 形式之連結（由 `scripts/check-menu.js` 於 CI 強制）。
3. `toc.html`、`examples.html`、`profiles-and-extensions.html` 三個 target 於建置產出中存在且可達。
4. 既有 15 個 pagecontent 頁面之**檔名與網址全數不變**（以 `git diff --name-status` 佐證）。
5. `ig.ini` 之 template 已釘定明確版本號。
6. tx 建置：`err = 0`，`qa-gate.js` 不退步（新增 2 頁會帶進其自身之連結訊息，依 CI 實測值上調基準線並具名說明，程序見 [`docs/RELEASE.md`](../RELEASE.md) §2.2）。
7. `README.md`、`package-list.json`、`sushi-config.yaml` 三處版本一致。

---

## 4. 工作項目

| 序 | 項目 | 產出 |
|:--|:--|:--|
| 1 | 新增 `input/pagecontent/examples.md`：依使用情境（UC-001～**UC-009**）與檢查類別分節列出 **67 個範例實例**並各附說明 | ✅ 新頁（另說明 10 個 `#inline` 實例不產生獨立頁面） |
| 2 | 新增 `input/pagecontent/profiles-and-extensions.md`：依 FHIR resource 分節列出 **41 個** profile 與 11 個 extension | ✅ 新頁（17 個 resource 分節；Observation 16 個再細分五組） |
| 3 | 套用 §2.4 之 `menu` | ✅ `sushi-config.yaml`（頂層 8 項、入口 20 個） |
| 4 | `ig.ini` template 釘版 | ⏸ **未執行，移列 JOB-09**（見 §8） |
| 5 | 新增 `scripts/check-menu.js`（規格見 §5）並掛入 `npm run check:menu` 與 CI | ✅ 腳本＋`check:menu{,:strict,:selftest}`＋CI 步驟（先自我測試再實檢） |
| 6 | tx 建置、更新 `qa-baseline.json`（具名說明新增 2 頁之訊息增量） | ⏳ **待本機／CI 執行**（本容器 proxy 封鎖套件來源，見 §8） |
| 7 | 版次 0.2.3、README 更新記錄、`package-list.json` 條目 | ✅ 三處一致 |

---

## 5. `scripts/check-menu.js` 規格

> 目的：把「導覽列指向不存在的頁面」與「使用位移型錨點」從人工目視改為 CI 阻斷。現行 `check:refs` 只檢查 pagecontent 內文，**不涵蓋 menu**。

輸入：`sushi-config.yaml` 之 `menu`。逐一檢查每個 target：

| 規則 | 判定 | 失敗行為 |
|:--|:--|:--|
| R-1 | target 若為 `<name>.html`，則 `input/pagecontent/<name>.md` 須存在，**或** `<name>` 屬 IG Publisher 自動產生頁白名單（`toc`／`artifacts`／`searchparameters-and-operation`／`capabilitystatements`） | `exit 1` |
| R-2 | target **不得**符合 `artifacts\.html#\d+`（位移型錨點） | `exit 1` |
| R-3 | 含 `#` 之 target，其錨點須為具名錨點（非純數字） | 警告 |
| R-4 | 頂層項目數 > 9 | 警告（可尋性劣化） |
| R-5 | `input/pagecontent/*.md` 中**未被任何 menu target 引用**者，須列於腳本內之孤兒頁白名單並附理由 | 警告（`--strict` 時失敗） |

> R-5 承接 [JOB-12](JOB-12-navigation-and-repo-hygiene.md) §1(1) 之 `conformance.html` 孤兒頁問題，改以機制防止復發。

負向測試（比照 JOB-21／JOB-22 之作法）：於腳本 `--self-test` 模式內建 3 組必失敗案例（不存在之 target／`artifacts.html#2`／孤兒頁未白名單），確保閘門本身不會空過。

---

## 6. 風險

| 風險 | 等級 | 因應 |
|:--|:--|:--|
| 使用者書籤／既發文件連結失效 | **低** | B-2：不改檔名。僅 menu 標籤與順序變動 |
| 新增 2 頁使 QA 訊息數上升，誤判為退步 | 中 | 依 `qa-baseline.json` 之既定例外程序，以 CI 實測值上調並具名說明（比照 v0.2.1 之 `_quickstartNote`） |
| 兩張新策展頁與 `artifacts.html` 內容重複、日後不同步 | 中 | 策展頁只放**分類與一句說明＋連結**，不複製 profile 內容；並於頁首註明「權威清單見資源總覽」 |
| 主管期待的是「外觀（logo／配色）」而非「順序」 | 中 | 送審前以並排截圖確認理解一致；B-4 之授權問題先行說明 |
| 頂層 8 項在窄螢幕折行 | 低 | 純中文標籤後總字數較現況雙語**減少約 45%**，折行風險反而降低 |

---

## 7. 交給 Claude 規劃用提示

```
請依 docs/optimization/JOB-23-navigation-alignment-twcore.md 執行導覽列調整。
先確認：§2.4 之 menu 草案是否已獲核准（未核准則停止並回報）。
執行順序：先做工作項目 1、2（兩張新策展頁），確認建置可產出後再套用 menu（項目 3），
最後補 check-menu.js（項目 5）與版次（項目 7）。
鐵則：不得更動任何既有 pagecontent 檔名；menu 不得出現 artifacts.html#<數字>；
對外發佈前一律以 _genonce_tx.bat（tx 建置）重建並檢視 output/qa.html。
```

---

## 8. 執行結果與偏離事項（2026-08-16，v0.2.3）

### 8.1 已完成之驗證

| 驗證 | 結果 |
|:--|:--|
| FSH 剖析（SUSHI import 階段） | 98 definitions／84 instances，無錯誤 |
| `npm run check:refs` | OK（19 個 pagecontent 檔；2 筆既有 backlog 標註容忍） |
| `npm run check:menu --self-test` | 三組負向測試全數通過 |
| `npm run check:menu`（新 menu） | OK：頂層 8 項、入口 20 個、無位移型錨點、無未白名單孤兒頁 |
| `npm run check:menu`（**舊 0.2.2 menu**，回歸佐證） | 攔下全部 4 條 `artifacts.html#1`～`#4` |
| 兩張新頁之連結目標靜態解析 | 140 條全數可解析（Profile／Extension／範例實例／站內頁面） |
| 既有頁面檔名 | `git diff --name-status` 無任何 rename／delete |

### 8.2 偏離 §2 建議之事項

| 項目 | 原建議 | 實際 | 理由 |
|:--|:--|:--|:--|
| **A-7 模板釘版** | `ig.ini` 由 `#current` 釘定版本 | **未執行，移列 [JOB-09](JOB-09-build-config-hardening.md) 續辦** | JOB-09 §197 已裁示「本環境無法連線模板來源，**不宜憑猜測寫入版本號**——寫錯會讓建置直接失敗」，並已於 CI 加入 `Report resolved template version`。應待該步驟取得實際解析版本後再釘定。本 JOB 撰寫時未察 JOB-09 已有此裁示，A-7 之原始寫法與之衝突 |

### 8.3 §1、§4 之數量更正

評估階段引用之 artifact 數量取自舊 README，與實際 FSH 不符，已於實作時以 FSH 為準更正：

| 項目 | 評估時記載 | 實際（自 FSH 抽取） |
|:--|:--|:--|
| Profile | 38 | **41** |
| Extension | 11 | 11（相符） |
| 範例 | 12（實為 **fsh 檔案數**，非實例數） | **67 個獨立實例**＋10 個 `#inline` 實例（共 12 個 fsh 檔） |
| 使用情境 | UC-001～UC-007 | UC-001～**UC-009**（UC-008／UC-009 為 JOB-04 之上傳封包） |

### 8.4 尚待執行（不在本容器能力範圍）

1. ✅ **tx 建置**：已於 CI 完成（commit `c55dfac5`，tx 建置，**err = 0**）。本容器 proxy 封鎖 `packages.fhir.org`／`packages2.fhir.org`／`tx.fhir.org`，SUSHI 無法下載核心套件，故當時無法產出 `output/`。
2. ✅ **`qa-baseline.json` 上調**：已依既定例外程序、以 CI 實測值上調並具名說明——`cannot be resolved` 2313 → **2317（+4）**，即兩張新頁各 +2（根層轉址殼頁與 zh-TW 語言層），與 `_quickstartNote` 之 +2／頁規則完全一致。詳見 `qa-baseline.json` 之 `_job23Note`。
   `TOTAL info` 實測 439（基準 459）、`TOTAL warn` 實測 96（基準 152）為未歸因改善，依 `_warnNote` 之既定政策**不下調**，故未執行 `npm run qa -- --update`。
3. ⏳ **外觀複核**：新 menu 於實際建置後之折行、下拉層級與 TW Core 之並排比對。

### 8.5 附帶處理之建置環境問題（2026-08-17）

實作套用至本機（Windows）時另修掉兩項與本 JOB 無關、但阻擋驗收的問題：

| 問題 | 處置 |
|:--|:--|
| `_genonce_tx.bat` 無法執行 | 檔內中文註解之位元組在作用中的 codepage 下被批次直譯器誤判為 `^`／`|` 等運算子，指令未執行即被切斷。註解全數改為英文。 |
| CI `check:assets` 失敗 | `sushi-config.yaml` 收錄於 `input/assets/fsh-source.zip`，本 JOB 變更版次與 menu 後該封包即過期。已重建。**注意**：Windows 無 `zip` 執行檔，且 `core.autocrlf=true` 會使 `git archive` 亦輸出 CRLF；須以 WSL 之 Info-ZIP 3.0、`TZ=UTC`、`git -c core.autocrlf=false archive` 取得 LF 內容後打包，否則與 CI 之逐位元組比對必不一致。 |
