# 發佈流程 (Release Runbook)

本檔為**可照著跑的清單**：從「改好一份變更」到「線上網站更新完成」的完整步驟、
各道閘門失敗時的判讀方式，以及幾類變更所需的附加動作。

> 本檔記錄的是**流程**。各項技術前提（離線建置不得送審、顯示名不符可能代表用錯碼等）
> 見 [`README.md`](../README.md) 與 [`CLAUDE.md`](../CLAUDE.md)，此處不重複。

---

## 0. 兩個前提

**（一）合併 ≠ 發佈。** 本 repo 刻意把兩者拆成兩個獨立決定：

| 動作 | 觸發方式 | 影響 |
|:--|:--|:--|
| 合併 PR 至 `main` | GitHub PR merge | **不會**動到線上網站 |
| 發佈至 gh-pages | Actions → Run workflow，勾選 `publish` | 線上網站**全量覆蓋** |

`publish` job 的 `if` 條件另要求 `github.ref == 'refs/heads/main'`——
在功能分支上按 Run workflow 只會建置，不會發佈。這是刻意的。

（repo variable `AUTO_PUBLISH_PAGES = true` 可改為「每次 main 更新即自動發佈」，
目前**未設定**，發佈仍為手動。README §QA 閘門段落中「目前 CI 不自動發佈」一句仍然成立。）

**（二）CI 只在 `pull_request` 或 push 至 `main` 時觸發。**
往功能分支 push 而**沒有開著的 PR**，不會產生任何 CI run——不是失敗，是根本沒跑。
本 repo 已因此誤判過一次（PR 合併後繼續往同一分支 push，等了很久卻沒有 run）。
**若要取得 CI 驗收，先確認該分支有一個 open PR。**

---

## 1. 例行變更的發佈流程

### 步驟 1 — 本機自檢（約 1 秒，不需建置）

```bash
npm ci
npm run check:refs     # pagecontent 參照 ＋ markdown 連結目標
npm run check:assets   # 下載檔可重現性 ＋ 值集/CSV/ConceptMap 一致性
```

這兩道不需要 IG Publisher，會在數秒內擋下最常見的兩類錯誤（見 §3.1、§3.5、§3.6）。
**在 push 之前跑**，否則同樣的錯誤要等約 15 分鐘才在 CI 現形。

> `npm run verify` 會再串上 `npm run qa`，但 `qa` 需要 `output/qa.txt`，
> 即需先完成一次完整建置。本機無 IG Publisher 時只跑上面兩道即可。

### 步驟 2 — 開 PR，取得 CI 驗收

```bash
git push -u origin <branch>
```

然後在 GitHub 開 PR（目標 `main`）。CI 會跑 [`build-ig.yml`](../.github/workflows/build-ig.yml)
的 `build` job，約 10–20 分鐘，依序執行：

| # | 步驟 | 說明 |
|:--|:--|:--|
| 1 | Check pagecontent references | 快速檢查，先失敗先省時間 |
| 2 | Check downloadable assets are current | 同上 |
| 3 | Run SUSHI | FSH → FHIR 資源 |
| 4 | Run IG Publisher | 帶 `-tx https://tx.fhir.org/r4` |
| 5 | Upload QA output | `if: always()`，閘門失敗時仍可下載 `qa.txt` 診斷 |
| 6 | Report resolved template version | 資訊性 |
| 7 | Verify publication layout | 內容首頁存在、`lang=zh-TW`、無 `en/` |
| 8 | Broken link breakdown | 資訊性；列出斷鏈目標分布 |
| 9 | Must Support 覆蓋檢核 | 目前非硬性（無 `--strict`） |
| 10 | **QA gate** | 比對 `qa-baseline.json` |
| 11 | **UCUM 稽核閘門** | 需 tx；離線建置略過 |
| 12 | Verify publish box | 不得為 Local Development build |
| 13 | Upload built site | `if: success()`，產出 `site-<sha>` artifact |

**發佈的是這份 `site-<sha>` artifact，不是重新建置的結果**——
`publish` job 直接下載它，避免上游套件在兩次建置之間變動。

閘門失敗時的判讀見 §3。

### 步驟 3 — 合併

CI 全綠後合併 PR。此時線上網站**尚未改變**。

### 步驟 4 — 發佈

GitHub → **Actions** → **Build IG** → **Run workflow**：

| 欄位 | 值 |
|:--|:--|
| Use workflow from | `main`（**必須**，否則 publish job 會被 `if` 略過） |
| `tx` | `https://tx.fhir.org/r4`（保持預設；`n/a` 之產出不得對外發佈） |
| `publisher-version` | `2.2.11`（須與 `qa-baseline.json` 之 `igPublisherVersion` 一致，否則 QA 數字不可比） |
| `publish` | ☑ **勾選** |

`publish` job 會：清空 gh-pages（保留 `.git`）→ 複製新站台 → `touch .nojekyll` →
寫入 `build-info.json` → 發佈前再驗一次內容 → commit & push。

> ⚠️ **全量覆蓋，不是增量。** 舊網址 `/en/…` 已於 JOB-02 失效且經確認不保留轉址。

### 步驟 5 — 發佈後驗證

```bash
# 確認線上內容確實來自剛才那個 commit
curl -s https://raw.githubusercontent.com/kunjulin/occupationIG/gh-pages/build-info.json
```

比對 `sourceCommit` 是否等於合併後的 `main` HEAD、`workflowRun` 是否為剛才那次執行。

> 本容器之 proxy 封鎖 `*.github.io`（403），**無法**直接 curl
> `https://kunjulin.github.io/occupationIG/`。改以上述 `raw.githubusercontent.com`
> 路徑讀 gh-pages 分支的實際檔案內容驗收；要驗某一頁是否上線，路徑為
> `https://raw.githubusercontent.com/kunjulin/occupationIG/gh-pages/zh-TW/<page>.html`。

---

## 2. 依變更類型的附加步驟

### 2.1 新增 `input/pagecontent` 頁面

三件事**必須**同時做，缺一即出問題：

1. **加進 `sushi-config.yaml` 的 `menu`。** 否則成為孤兒頁（`conformance.html` 曾如此）。
2. **連結目標只能用站內 `.html` 或絕對 URL。**
   `](../…)` 會讓 IG Publisher 以
   `java.lang.RuntimeException: Computed path does not start with first element`
   **硬性中止**（不是警告）；`](*.md)` 指向不會被發佈的檔案。
   兩者皆已由 `npm run check:refs` 在本機 1 秒內攔下。要連 repo 內文件，
   用絕對 blob URL：`https://github.com/kunjulin/occupationIG/blob/main/docs/...`。
3. **預期 `cannot be resolved` 會上升，須調整基準線。** 見 §2.2。

### 2.2 調整 `qa-baseline.json`

**下調**（品質改善後）：

```bash
npm run qa -- --update   # 只會下調；有退步項目時會拒絕執行
```

**上調**（新增 artifact／新增頁面帶進其自身的訊息）：**手動編輯，並加一則具名說明**。
慣例是新增一個 `_jobNNNote` 欄位（見檔內既有的 `_job18Note`、`_job14Note` 等），
寫明「多出來的是什麼」與「量測來源（CI run／commit）」。

> ⚠️ **增量必須以 CI 實測為準，不得預先猜測後寫入。**
> 正確順序是：先 push 取得一次 CI run（QA gate 會印出實測值與基準線之差）→
> 讀該次實測數字 → 回填基準線並加註 → 再跑一次 CI 確認轉綠。
> 猜一個數字寫進去，等於把基準線變成事後追認的裝飾。

### 2.3 改動值集、ConceptMap 或對照表

換一個代碼要同步四處：**值集 ＋ ConceptMap ＋ `terminology.md` 對照表 ＋ 受影響範例**。
下載檔（`fsh-source.zip`、`loinc-valuesets.xlsx`、`snomed-mappings.xlsx`）
**由值集自動產生**，不手工維護：

```bash
npm run build:assets   # 重新產生並提交
npm run check:assets   # 確認提交進版控的那份與原始碼一致
```

三個一致性條件由 CI 強制（見 §3.5、§3.6）。

### 2.4 版本號調整（正式釋出）

須**同步**三處，否則 publish box 與版本歷程會不一致：

1. `sushi-config.yaml` 的 `version:`
2. `package-list.json` 的 `list[]` 新增一筆（`version` / `date` / `desc` / `path` /
   `status` / `sequence` / `fhirversion`）；`version: "current"` 那筆保持 `current: true`
3. 釋出後於 `main` 打 tag（現有：`v0.2.0`）

另建議在釋出前跑一次嚴格檢查：

```bash
npm run check:refs:strict   # 連 backlog 標註也視為失敗
```

---

## 3. 六道閘門與失敗判讀

### 3.1 pagecontent 參照（`npm run check:refs`）

* `Unresolved pagecontent references` — 引用了不存在的 FSH 物件。
  若為刻意的待辦，在**同一行**標註 `backlog`。
* `Invalid markdown link targets in pagecontent` — 見 §2.1 第 2 點。

### 3.2 QA gate（`npm run qa`）

比對 `output/qa.txt` 的 `err = N, warn = N, info = N` 與各具名類別。
**任一數值高於基準線即失敗。**

* 若是**真的退步** → 修程式碼/內容，不要改基準線。
* 若是**新增 artifact 帶進的自身訊息** → 依 §2.2 具名上調。
* `err = 0` **不代表沒有 ERROR**：斷鏈（`cannot be resolved`）在 `qa.txt` 以
  `ERROR:` 列出但**不計入** `err` 摘要。故該類別已另列為具名追蹤類別。

此步另含**術語伺服器連線檢查**（`--expect-tx`）：掃 `input-cache/publisher-run.log`，
不看 `qa.txt`——因為 `input/ignoreWarnings.txt` 管不到日誌，
否則「連不上 tx」與「通過驗證」外觀會完全相同。
**絕不可為了讓建置變綠而抑制術語伺服器連線失敗。**

### 3.3 UCUM 稽核閘門（`scripts/audit-ucum.js`）

四道基準：`--max 0`（單位不符）、`--max-missing 0`（值集有量值碼而 CSV 無）、
`--max-unknown 0`（Scale 答案清單碼未對映）、`--min-inscope-ratio 0.5`。

最後一道是**分類失效自我檢查**：首輪曾因 Scale 判準錯誤而「320 碼全判不適用」，
三道零基準全部為 0 而閘門**空過**——綠燈，但一碼都沒驗。
故對「納入比對之量值碼／全集」設 50% 下限（實測 241/320 = 75.3%）。
**比率大幅下滑要當成判準塌陷處理，不是資料變好。**

### 3.4 Must Support 覆蓋（`npm run check:ms`）

目前**非硬性**（未帶 `--strict`），只讓缺口在每次建置中可見。
宣告 MS 的欄位至少要有一個範例實際填值，或以 `dataAbsentReason` 示範缺值。

### 3.5 下載檔可重現性（`build-*.js --check`）

失敗代表「改了值集卻忘了重建下載檔」。修法：`npm run build:assets` 後提交。
產生器以固定 mtime（`2020-01-01T00:00:00Z`）＋ `zip -qX` 確保位元組可重現，
故 diff 只會反映真實內容變動。

### 3.6 值集／對照表／ConceptMap 一致性

* `check-asset-consistency.js`
  * `loinc_preferred 不存在於任何 IG 值集` — **以值集為真更正 CSV**，不是反過來。
    該項目於 LOINC 確無適用代碼時，用 `(-確定無合適碼)` 等哨符。
  * `層級標示不一致` — FSH 註解標 `Acceptable:` 與 ConceptMap 之 source 集合
    須對稱相等（對稱差為 0）。
* `fix-conceptmap-equivalence.js --check`
  * `comment 與 equivalence 不一致` — 註解之方向敘述與 `equivalence` 值相衝。
    **R4 的 `equivalence` 以 target 為主詞**（`narrower` ＝ target 比 source 窄），
    R5 才改名為 `source-is-narrower-than-target`。判讀見
    [術語頁 §3.2.1](../input/pagecontent/terminology.md)。
  * `規則涵蓋為 0` 或 `涵蓋率 < 門檻` — 判準失效，不是「全部無簽章」。
    與 §3.3 同型的自我檢查：防止規則失配時靜靜地全數放行。

---

## 4. 常見陷阱

| 症狀 | 成因 | 處理 |
|:--|:--|:--|
| push 了但沒有 CI run | 該分支沒有 open PR | 開 PR（§0） |
| 按了 Run workflow 但網站沒更新 | 未勾 `publish`，或 workflow from 不是 `main` | 重跑並確認兩者（§1 步驟 4） |
| CI 綠但線上是舊的 | 只合併未發佈 | 執行 §1 步驟 4 |
| IG Publisher 硬性中止 `Computed path does not start with first element` | pagecontent 用了 `](../…)` | 改絕對 blob URL（§2.1） |
| `err = 0` 但實際有 ERROR | 斷鏈不計入 `err` 摘要 | 看 `cannot be resolved` 類別（§3.2） |
| 閘門全綠但其實什麼都沒驗 | 分類判準塌陷 | 看 §3.3 之 ratio 與 §3.6 之涵蓋率 |
| 本機 SUSHI 跑不起來 | 本容器 proxy 封鎖 `packages.fhir.org` | 交由 CI 驗證；**不要**停用 TLS 驗證或取消 `HTTPS_PROXY` |
| `curl` 線上網站 403 | proxy 封鎖 `*.github.io` | 改用 `raw.githubusercontent.com/…/gh-pages/…`（§1 步驟 5） |

---

## 5. 現行實測值速查

以下為**最近一次量測**之值，供比對用。**改動後請以該次 CI 實測值更新本節，
不要沿抄**——本 repo 曾有數處文件長期沿用已失效的舊基準線（`warn = 208, info = 257`），
照著核對就會誤判。

| 項目 | 值 | 來源 |
|:--|:--|:--|
| QA 總數 | `err = 0, warn = 152, info = 459` | `qa-baseline.json` |
| 量測日期 | 2026-07-29 | `qa-baseline.json.measuredAt` |
| IG Publisher | `2.2.11` | `qa-baseline.json.igPublisherVersion`（須與 workflow input 一致） |
| SUSHI | `3.20.0` | `package.json.devDependencies`（已釘版） |
| `Wrong Display Name` | 0 | JOB-01 完成後歸零 |
| `cannot be resolved`（斷鏈） | 2311 | 不計入 `err` 摘要 |
| `There are no valid display names found for the code` | 237 | |
| `has a status of DISCOURAGED` | 5 | |
| UCUM 納入比對比率 | 241/320 ＝ 75.3% | 下限 50% |
| ConceptMap 組數 | 41（索引 0–40 連續） | |
| `equivalence` 分佈 | wider 12／narrower 6／relatedto 23／equivalent 0 | `equivalent` 為 0 係逐組覆核後之刻意結果，非遺漏 |
| 現行版本 | `0.2.0`（tag `v0.2.0`，2026-07-29） | `sushi-config.yaml` / `package-list.json` |

---

## 6. 指令速查

```bash
npm ci                        # 安裝已釘版之 SUSHI

npm run check:refs            # pagecontent 參照 ＋ 連結目標（秒級）
npm run check:refs:strict     # 連 backlog 標註也視為失敗（釋出前）
npm run check:assets          # 下載檔可重現性 ＋ 三項一致性（秒級）
npm run build:assets          # 重新產生下載檔（改了值集後必跑）

npm run build                 # SUSHI → IG Publisher（帶 tx）★ 送審／發佈前
npm run build:offline         # 同上但 -tx n/a ★ 不得作為送審依據
npm run sushi                 # 只跑 SUSHI

npm run qa                    # 比對 qa-baseline.json
npm run qa:tx                 # 另要求日誌證明確實連上 tx
npm run qa -- --update        # 改善後下調基準線（只降不升）
npm run check:ms              # Must Support 覆蓋（非硬性）

npm run verify                # check:refs + check:assets + qa（qa 需先建置）
```
