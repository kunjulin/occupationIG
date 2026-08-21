# JOB-33｜對外試用版之「乾淨化」：內部痕跡清除、警語收斂、未決事項外移、發布模式

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（阻擋對外試用之呈現整備） |
| **類別** | 發布治理／呈現／建置設定 |
| **預估** | M–L（3–4 人日，W1 另計） |
| **主要影響檔案** | `sushi-config.yaml`（canonical／`pages:`／`menu:`）、`package-list.json`、`ig.ini`、全部 `input/pagecontent/*.md`、`input/fsh/**` 之 `Description`、`qa-baseline.json`、`scripts/`（新閘門） |
| **緣起** | 2026-08-21 使用者指示：本 IG 尚未正式發布，現站僅為試驗場；現有頁面備註過多，需一個乾淨版供臨床試用 |
| **裁示範圍** | 四項全選：內部工作痕跡／各頁 ⚠ 警語／未決事項頁／continuous build 標記；**發布目標為同一個 github.io，供臨床試用** |
| **狀態** | 📋 **評估與計畫（v0.6.4）**，待裁示後實作 |

---

## 0. 一句話結論

**四項之中，三項是本團隊可逕行的呈現工作；第四項（移除 continuous build 標記）不是呈現問題——它的真正前提是「決定 canonical」，而那一個決定同時會讓站上最難看的數字（2320 筆斷鏈）歸零。**

---

## 1. 現況實測（v0.6.1，`gh-pages` 實地清點）

> 📌 **量測基準**：下表之 `JOB-n` 計數量測於 **v0.6.1**。`main` 其後已推進至 **v0.7.1**
> （JOB-31 §3／§5 實作），該批變更會**增加** `JOB-n` 之出現處（新增之 `governance-map` 說明、
> `check-governance-tags` 相關敘述等），故**實作前須重新清點**，不得沿用本表數字。
> **斷鏈數已複驗於 v0.7.1：仍為 2321 筆，其中 2320 筆為同一目標**——§2 之結論不受版次推進影響。

| 項目 | 實測 |
|:--|--:|
| 含內部工作編號 `JOB-n` 之已發佈頁面 | **21 頁** |
| `JOB-n` 出現總次數 | **122 次** |
| ── `open-issues.html` | 44 |
| ── `terminology.html` | 18 |
| ── `history.html` | 12 |
| ── `CS-BetelNutComponent` 之 4 種渲染變體 | 28（**Description 內含 JOB-n，故隨 json／xml／ttl 一併擴散**） |
| 被引用之 JOB 編號 | JOB-01、02、04～11、14、18～22、26～30 |
| `qa.txt` 之 `broken links` | **2321**，其中 **2320 筆為同一個目標**（v0.7.1 複驗：**數字不變**） |

**引用之 JOB 編號外部讀者無從解讀**——`JOB-19 §5`、`JOB-29 §A.1` 這類字樣對試用單位是純噪音。

---

## 2. W1｜canonical：第四項的真正前提（**須 PI 裁示**）

### 2.1 為什麼 banner 移不掉

publish box 之全文為：

> 「This guide is **not an authorized publication**; it is the **continuous build** for version 0.6.1
> built by the FHIR CI Build. This version is based on the current content of
> `https://github.com/kunjulin/occupationIG` and changes regularly. See the **Directory of published versions**」

此段由 IG Publisher 於 **CI-build 模式**產生，觸發條件為 `package-list.json` 之 `current` 條目
`status = "ci-build"`。要換成正式發布之 banner，須以**釋出模式**建置
（`-publish <站台網址>`＋ `current` 條目指向實際版本），而釋出模式會把
「Directory of published versions」指向 **`<canonical>/history.html`**。

### 2.2 決定性的實測：2320 筆斷鏈只有一個成因

```
2320  https://twcore.mohw.gov.tw/ig/twha/history.html
   1  （其他）
```

- `history.html` **本站已生成且存在**（根層與 `zh-TW/` 各一份）。
- 斷的不是檔案，是**canonical 前綴**——canonical 為 `https://twcore.mohw.gov.tw/ig/twha`，
  而站台實際位於 `https://kunjulin.github.io/occupationIG`。
- 亦即：**canonical 與實際發布位置不一致，是「未授權發布」banner 與 2320 筆斷鏈的同一個根因。**

### 2.3 兩個選項

| | **(A) 試用期 canonical 改為 `https://kunjulin.github.io/occupationIG`** | **(B) canonical 不動** |
|:--|:--|:--|
| banner | ✅ 可改為正式發布措辭 | ❌ 移不掉，或移掉後 Directory 連結仍壞 |
| 斷鏈 2320 | ✅ **歸零** | ❌ 維持 |
| `history.html` | ✅ 生效可點 | ❌ 仍指向不存在之位址 |
| 代價 | 全部 `StructureDefinition.url`／`meta.profile`／範例 URL 變更；**正式版移回主管機關命名空間時須再改一次** | 無 |
| 與既有立場 | P-1 現況為「canonical 待主管機關核定」；本案等於**自行決定試用期之 provisional canonical** | 維持 |
| 時機 | **使用者已明示本 IG 尚未發布過**——此刻改動成本為歷來最低 | — |

**建議採 (A)**，並於首頁與 `conformance.md` 明載：

> 本版之 canonical 為**試用期暫用命名空間**，正式版將改為主管機關核定之位址，**屆時所有資源 URL 會變更**。
> 實作端請勿將本站 URL 寫死於程式碼。

> ⚠️ 採 (A) 前須先確認 `scripts/check-dependencies.js` 之 **D-2 閘門**
> （canonical 命名空間限制）是否涵蓋本變更；`github.io` 不屬該閘門所禁之 `hpa.gov.tw`，
> 但仍須實跑確認，不得推定。

**若裁示採 (B)，則第四項（移除 continuous build 標記）本 JOB 不予執行**，並於回覆中說明其不可行之原因。

---

## 3. W2｜內部工作痕跡清除

**原則**：對外頁面與 artifact 之 `Description` **不得出現內部工作編號與開發過程敘述**。

| 樣態 | 處置 |
|:--|:--|
| `JOB-n`、`§A.1` 之類內部節號 | 刪除；確需溯源者改寫為「本指引 v0.x 之修訂」或連結至 GitHub commit |
| 「初稿誤寫」「已於 v0.3.3 更正」「本評估認為」 | 刪除——**規範文件不記錄自己的修訂過程**，那是 `README`／`package-list` 的職責 |
| CI 一次性診斷之殘留說明 | 刪除 |
| FSH 之 `//` 註解 | **保留**（不進入產出，且是重要的維護資訊） |

⚠️ **重點是 `Description`**：artifact 之 `Description` 會渲染進 `.html`／`.json`／`.xml`／`.ttl`
**四種變體**，一處未清即擴散為四處（`CS-BetelNutComponent` 現為 28 次即由此而來）。

**新增閘門** `scripts/check-no-internal-refs.js`：掃 `input/pagecontent/*.md` 與 FSH 之
`Description`／`Title`，命中 `JOB-\d+`、「初稿」、「本評估」、「已於 v」等樣態即 exit 1；
依本 repo 慣例內建 `--self-test`（至少三組必失敗），CI 中先跑負向再跑實檢，並掛入 `npm run verify`。

---

## 4. W3｜警語收斂與未決事項頁外移

### 4.1 ⚠ 警語分兩類，處置不同

| 類別 | 例 | 處置 |
|:--|:--|:--|
| **內部備註型** | 「初稿據修訂案 v2.1 推論……該推論不成立」 | **刪除** |
| **規範性揭露** | canonical 為 provisional；Core 係工作原案待公告；SNOMED 未逐碼驗證**不得作正式建議 mapping**；保存期限起算點待釋示 | **不得刪除**，但**收斂**——自各頁移除散落區塊，集中為首頁一個〈**使用前須知**〉區塊 |

〈使用前須知〉建議內容（**最多 6 條**，每條一句）：
canonical 試用期暫用且會變更／Core 21 列待國健署公告／嚼檳與健康管理分級等本地代碼為 provisional／
SNOMED 對照未逐碼驗證者僅供參考／法規解釋事項本指引不代為認定／建置通過不等於臨床適切或法規符合。

> **為何不能全刪**：這些是「哪些欄位日後會變」的唯一告知管道。刪掉之後，
> 試用單位在不知情下投入開發，其變更成本會回到本團隊。收斂可以，歸零不行。

### 4.2 未決事項頁之移除（依裁示執行）

- `input/pagecontent/open-issues.md` 移出建置：`pages:` 與 `menu:` 移除該頁；
  內容移至 `docs/`（版本控管檔案，**非 GitHub Issues**——Issue 可被編輯關閉刪除、無版次）。
- **站內連結 31 處（其中具名錨點 24 處）須一次改寫**，否則 `check-menu.js` R-1／R-5／R-6a
  與 `check-pagecontent-refs.js` 會 exit 1。改寫目標：規範性者指向〈使用前須知〉，
  其餘指向 GitHub 之 `docs/` 檔案。
- `qa-baseline.json` 須依重建後之實測調整（少一頁、少一批連結訊息）；**不得憑推算**。

> 📌 **一句話提醒（仍依裁示執行）**：〈未決事項〉頁之兩欄（對試用的影響／權責歸屬）、
> 已結案 6 項移頁尾與改標題，**正是 v0.5.0～v0.6.1 剛完成並上線的 JOB-30 A 部**；
> 整頁移除等於捨棄該批成果。若目的僅是「看起來乾淨」，
> 保留該頁而只做 §4.1 之警語收斂即可達成八成效果。

---

## 5. W4｜發布模式（依賴 W1）

採 W1 之 (A) 時：

1. `package-list.json`：`current` 條目由 `status: ci-build` 改為指向實際版本之釋出條目；
   保留完整版次歷程（`history.html` 由此生成）。
2. 以**釋出模式**建置：`-publish https://kunjulin.github.io/occupationIG`。
3. 驗收：publish box 不再出現 `not an authorized publication`／`continuous build`；
   「Directory of published versions」可點且指向本站 `history.html`；
   `qa.txt` 之 `broken links` **由 2321 降至個位數**。

> ⚠️ **不得**為了消除 banner 而在 `package-list.json` 謊報狀態卻不改 canonical——
> 那會產生一個宣稱已發布、但 Directory 連結仍壞的站台，比現況更難解釋。

---

## 6. 版次與順序

| 步驟 | 內容 | 版次 |
|:--|:--|:--|
| 0 | **PI 裁示 W1 之 (A)／(B)** | — |
| 1 | W2 內部痕跡清除 ＋ 新閘門 | v0.7.4 |
| 2 | W3 警語收斂 ＋ 未決事項外移 ＋ 31 處連結改寫 | v0.8.0（**破壞性**：頁面消失、錨點失效） |
| 3 | W1(A)＋W4 canonical 與發布模式 | v0.9.0（**破壞性**：全部資源 URL 變更） |

**步驟 3 之破壞性最大，但若確定要做，愈早愈便宜**——使用者已明示本 IG 尚未發布過。

---

## 7. 驗收標準

1. 全站已發佈 `.html`／`.json`／`.xml`／`.ttl` 中，**`JOB-\d+` 出現次數為 0**
   （`docs/` 與 `README` 不在此限）；以腳本掃描 `gh-pages` 產出，不得只掃原始碼。
2. `check-no-internal-refs.js` 通過，且其 `--self-test` 負向案例先行通過。
3. 〈使用前須知〉存在且**涵蓋 §4.1 所列六項揭露**；逐項核對，不得目視。
4. 若執行 W3：`npm run verify` 全綠；31 處連結全部改寫完畢，無指向已移除頁面者。
5. 若執行 W1(A)＋W4：`qa.txt` 之 `broken links` 由 **2321 降至 < 10**；
   publish box 無 `not an authorized publication`；`err` 仍為 0。
6. `qa-baseline.json` 依每一步之**實測**重新校準（**不得憑推算**；增量須用分種類三值：
   範例 10／CodeSystem・ValueSet 12／Profile 18）。

---

## 8. 不在本 JOB 範圍

- M-5、嚼檳系列 `experimental`、Level 1 成熟度——待書面依據（JOB-30 §3.4）。
- JOB-32 之 `Observation.code` 語意修正——**建議先於本 JOB 步驟 3 完成**，
  以免 canonical 與 `code` 兩次破壞性變更分開發布。

---

## 交給 Claude 規劃用提示

見 `docs/optimization/PROMPT-JOB-33.md`（與本文件同批交付）。
