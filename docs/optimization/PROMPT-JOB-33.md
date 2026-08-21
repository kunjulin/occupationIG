# 給 Claude Code 的施作提示詞｜JOB-33 對外試用版乾淨化

> 前置：`origin/main` 現為 **v0.7.1**（`f09302dc`）。先套用
> `TWHA_IG_JOB-32-33_v0.7.2-0.7.3.patch`（兩個評估 commit：JOB-32 → v0.7.2、JOB-33 → v0.7.3），
> 再依本文件分三步實作。**每一步一個 commit、一個版次，不得合併。**
>
> 套用前先確認 `git log --oneline -1 origin/main` 仍為 `f09302dc`；若已前進改用 `git am -3`，
> 仍衝突則停下回報，不要自行猜解法。
>
> ⚠️ **步驟 1 開始前先重新清點 `JOB-n` 出現處**——JOB-33 §1 之 122 處量測於 v0.6.1，
> v0.7.0／v0.7.1 之變更會增加該計數，不得沿用。

---

## 步驟 0｜先問，不要自行決定

本 JOB 有一項**必須由 PI 裁示**才能動：**canonical 是否改為
`https://kunjulin.github.io/occupationIG`**（JOB-33 §2）。

- 若裁示 **(A) 改**：三步全做。
- 若裁示 **(B) 不改**：**只做步驟 1 與步驟 2**，步驟 3 不執行，
  並在回報中說明「移除 continuous build 標記於 (B) 之下不可行」及其原因。

**在取得裁示前，不得變更 `sushi-config.yaml` 之 `canonical`、`ig.ini` 或 `package-list.json` 之 `current` 條目。**

---

## 步驟 1｜內部工作痕跡清除（v0.7.4）

1. 掃描 `input/pagecontent/*.md` 與**所有 FSH 之 `Description:`／`Title:`**，
   移除下列樣態：
   - 內部工作編號 `JOB-\d+`、內部節號（`§A.1`、`§D.3a` 等）
   - 開發過程敘述：「初稿」「本評估」「已於 v0.x 更正」「該推論不成立」等
   - CI 一次性診斷之殘留說明
2. **FSH 之 `//` 註解一律保留**（不進入產出，且是維護資訊）。
3. ⚠️ **重點在 `Description`**：它會渲染進 `.html`／`.json`／`.xml`／`.ttl` **四種變體**，
   一處未清即擴散四處。`CS-BetelNutComponent` 現為 28 次即由此而來。
4. 需要溯源者，改寫為「本指引 v0.x 之修訂」或連結至 GitHub commit，**不得保留 JOB 編號**。
5. **新增閘門** `scripts/check-no-internal-refs.js`：
   - 掃 `input/pagecontent/*.md` 與 FSH 之 `Description`／`Title`
   - 命中 `JOB-\d+`、「初稿」、「本評估」、「已於 v」等即 exit 1
   - **內建 `--self-test`，至少三組必失敗案例**，CI 中先跑負向再跑實檢
   - 掛入 `npm run verify`

**驗收**：重建後掃 `output/`（或 gh-pages 產出），`JOB-\d+` 出現次數 **為 0**。
`docs/` 與 `README.md` 不在此限。

---

## 步驟 2｜警語收斂 ＋ 未決事項頁外移（v0.8.0，破壞性）

### 2.1 警語分兩類，**不可一律刪除**

- **內部備註型**（「初稿誤寫」「已於 vX 更正」）→ **刪除**。
- **規範性揭露** → **不得刪除**，改為**收斂**：自各頁移除散落區塊，
  集中為首頁一個〈**使用前須知**〉區塊，**最多 6 條、每條一句**，須涵蓋：
  1. canonical 為試用期暫用命名空間，正式版會變更，**請勿寫死 URL**
  2. Core 21 列係國健署工作原案，正式公告後欄位可能增減
  3. 嚼檳、健康管理分級等本地代碼為 **provisional**
  4. SNOMED 對照未逐碼驗證者僅供參考，**不得作正式建議 mapping**
  5. 法規解釋事項（保存期限起算點等）本指引**不代為認定**
  6. 建置通過**不等於**臨床適切性或法規符合性

> **這六條不得省略。** 它們是「哪些欄位日後會變」的唯一告知管道；
> 刪掉之後試用單位在不知情下投入開發，變更成本會回到本團隊。

### 2.2 未決事項頁外移

- `input/pagecontent/open-issues.md` 移出建置：自 `sushi-config.yaml` 之 `pages:` 與 `menu:` 移除。
- 內容移至 `docs/`（**版本控管檔案，不要用 GitHub Issues**——Issue 可被編輯、關閉、刪除，無版次）。
- **站內連結 31 處（其中具名錨點 24 處）必須一次改寫完畢**：
  規範性者指向〈使用前須知〉；其餘指向 GitHub 之 `docs/` 檔案。
  未改寫會使 `check-menu.js` R-1／R-5／R-6a 與 `check-pagecontent-refs.js` exit 1。
- `check-menu.js` 之孤兒頁白名單同步處理。

**驗收**：`npm run verify` 全綠；全站無指向已移除頁面之連結；
`qa-baseline.json` 依重建**實測**校準（**不得憑推算**）。

---

## 步驟 3｜canonical 與發布模式（v0.9.0，破壞性；**僅在裁示 (A) 時執行**）

1. `sushi-config.yaml` 之 `canonical` 改為 `https://kunjulin.github.io/occupationIG`。
2. **先實跑 `scripts/check-dependencies.js`**，確認 **D-2 閘門**（canonical 命名空間限制）
   不會擋下本變更；**不得推定**——實跑並貼出輸出。
3. `package-list.json`：`current` 條目由 `status: ci-build` 改為指向實際版本之釋出條目，
   保留完整版次歷程（`history.html` 由此生成）。
4. 以**釋出模式**建置：`-publish https://kunjulin.github.io/occupationIG`。
5. 於首頁與 `conformance.md` 載明：
   > 本版 canonical 為**試用期暫用命名空間**，正式版將改為主管機關核定之位址，
   > **屆時所有資源 URL 會變更**。實作端請勿將本站 URL 寫死於程式碼。

**驗收**：
- `qa.txt` 之 `broken links` **由 2321 降至 < 10**
  （現況 2320 筆全為單一目標 `https://twcore.mohw.gov.tw/ig/twha/history.html`；
  `history.html` 本站已存在，斷的只是 canonical 前綴）
- publish box 不再出現 `not an authorized publication` 或 `continuous build`
- 「Directory of published versions」可點且指向本站 `history.html`
- `err` 仍為 0

> ⚠️ **不得**為消除 banner 而在 `package-list.json` 謊報狀態卻不改 canonical——
> 那會做出一個宣稱已發布、Directory 連結卻仍壞的站台，比現況更難解釋。

---

## 全域硬約束

1. **不得刪除步驟 2.1 之六條規範性揭露**，只能收斂位置。
2. **不得**把未決事項內容放進 GitHub Issues（要放 `docs/` 版本控管檔案）。
3. **不得憑推算調整 `qa-baseline.json`**；增量須用分種類三值：
   **範例實例 10／CodeSystem・ValueSet 12／Profile 18**。
4. **不得**變更 M-5 狀態、嚼檳系列 `experimental` 或 Level 1 成熟度（待書面依據）。
5. **不得**把勞動部職安署表述為本指引之治理／主管機關。
6. commit message **不得含任何模型識別字串**。
7. 三個步驟**各自一個 commit 與版次**，不得合併。

---

## 回報格式

- 三個（或兩個）commit 之 hash 與變更檔案清單
- 重建後 `JOB-\d+` 於產出中之出現次數（應為 0）
- 〈使用前須知〉六條之逐條對照
- 31 處連結之改寫結果逐一列出
- 若執行步驟 3：D-2 閘門實跑輸出、`broken links` 前後數字、publish box 前後全文
- 任何**你判斷需要 PI 裁示**而未自行決定的項目
