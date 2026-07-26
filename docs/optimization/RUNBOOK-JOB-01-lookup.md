# 執行手冊：JOB-01 之 A／B 類代碼查證（需可連外環境）

> 適用對象：能連上 `https://tx.fhir.org/r4` 的機器（例如平常跑 `_genonce_tx.bat` 的那台）。
> 目的：把 74 筆（A 類 54 ＋ B 類 20）待查代碼的**事實**取回來，供後續換碼決策使用。

---

## 0. 先講結論：建議怎麼分工

這件事分成三段，**只有第一段非在你的機器上做不可**：

| 段 | 內容 | 在哪做 | 需要判斷嗎 |
|:--|:--|:--|:--|
| **① 取事實** | 對 74 碼跑 `$lookup`，取回官方 display 與六軸 | **你的機器**（需連 tx） | 否，純機械 |
| **② 下判斷** | 逐碼判定「確認錯碼／確認正確／需臨床決策」，並決定替代碼 | 兩者皆可 | **是** |
| **③ 套用變更** | 改值集 ＋ ConceptMap ＋ `terminology.md` ＋ 受影響範例，跑 CI 驗收 | 建議回主工作流 | 是，且需 repo 全域脈絡 |

**推薦做法：你只做 ①，把結果 commit 推上分支，然後回到對話說「查證結果已推上去」，
由我接 ② 和 ③。** 理由：

- ① 是確定性的，一分鐘跑完，不需要 AI；
- ③ 牽涉值集、ConceptMap、對照表、範例四處同步與 CI 閘門，我有這條分支的完整脈絡，
  在本機另起一個 Claude 做容易產生分歧；
- ② 之中有一部分**不是 AI 該決定的**（見 §4），無論在哪跑都要人。

如果你想在本機一次做到 ②，§3 有可直接複製的提示詞。

---

## 1. 需要什麼環境

**只要兩樣**：

| 需要 | 檢查指令 | 備註 |
|:--|:--|:--|
| **Git** | `git --version` | 你已在推 GitHub，應該有 |
| **Node.js 20+** | `node -v` | README 已列為 SUSHI 之前置需求，應該有 |

**不需要**：Java、Ruby、Jekyll、IG Publisher，也**不需要 `npm ci`**。
`scripts/lookup-loinc.js` 只用 Node 內建模組（`https`／`fs`／`path`），沒有任何套件相依。
本階段不建置 IG，只是對術語伺服器發 74 次查詢。

網路方面只要能連 `https://tx.fhir.org/r4` 即可——你平常跑 `_genonce_tx.bat` 就是連這台。

### ⚠️ 先確認你的資料夾是不是 git clone

qa.txt 顯示你的建置路徑是 `C:\repo\occupationIG-main`。
**`occupationIG-main` 正是 GitHub「Download ZIP」解壓後的預設資料夾名稱**，
若那是下載的 zip 而非 clone，裡面不會有 `.git`，`git fetch` 會失敗。

```
cd C:\repo\occupationIG-main
git status
```

- 正常顯示分支 → 是 clone，直接跳到 §2。
- 出現 `not a git repository` → 是 zip，請依 §2 另外 clone 一份（不影響你原本的資料夾）。

---

## 2. ① 取事實

### 指令（一行一道，cmd 與 PowerShell 皆可）

> 下列每道都是**單行**，不含 `^` 或 `` ` `` 換行符，也不用 `&&`——
> 這兩者在 cmd 與 PowerShell 的行為不同，分開執行最不會出錯。

```
git clone https://github.com/kunjulin/occupationIG.git twha-lookup
cd twha-lookup
git checkout claude/occupational-health-ig-review-6vx9gn
```

（若你原本的資料夾已是 clone，改為在該資料夾執行下列三道即可：
`git fetch origin`、`git checkout claude/occupational-health-ig-review-6vx9gn`、
`git pull origin claude/occupational-health-ig-review-6vx9gn`）

### 先用 1 個代碼試水溫

```
node scripts/lookup-loinc.js --codes 14390-9 --out check.json
```

預期輸出：

```
[  1/1] ? 14390-9 … Amylase [Enzymatic activity/volume] in Dialysis fluid
成功 1／失敗 0
```

看到 `Amylase ... in Dialysis fluid` 就對了——這正是本 IG 標為「血清 ALT」的那個碼，
連線與解析都正常。若出現 `HTTP 403`／`timeout`／憑證錯誤，先設定後重試：

```
set NODE_OPTIONS=--use-system-ca
```

（PowerShell 用 `$env:NODE_OPTIONS="--use-system-ca"`）

試完可刪掉 `check.json`。

### 正式跑 74 筆

```
node scripts/lookup-loinc.js --classes A,B --csv-out docs/optimization/evidence/display-triage-with-lookup.csv
```

約 30 秒（74 次查詢，每次間隔 300ms）。產出兩個檔：

- `docs/optimization/evidence/lookup-<日期>.json` —— 完整結果（含六軸與 STATUS）
- `docs/optimization/evidence/display-triage-with-lookup.csv` —— 在分流表上補入
  `lookup_component` / `lookup_property` / `lookup_system` / `lookup_scale` /
  `lookup_method` / `lookup_status` 欄位

查證失敗者會標 `lookup_error`。**失敗本身可能就是結論**（例如代碼根本不存在），
但也可能只是網路問題，請先看 error 內容再判定。

### 推上分支

```
git add docs/optimization/evidence/
git commit -m "chore(terminology): JOB-01 A/B 類 74 碼之 lookup 查證結果"
git push origin claude/occupational-health-ig-review-6vx9gn
```

**做到這裡就可以回到對話了。**

---

## 3. 若你想在本機用 Claude Code 一併做 ②

在 repo 根目錄開 Claude Code，貼下面這段：

```
請閱讀 CLAUDE.md、.claude/skills/fhir-tx-audit/SKILL.md、
docs/optimization/JOB-01-terminology-code-audit.md 與
docs/optimization/RUNBOOK-JOB-01-lookup.md，然後執行 JOB-01 的「②下判斷」階段。

前置：docs/optimization/evidence/display-triage-with-lookup.csv 已含 74 筆
（A 類 54、B 類 20）的官方六軸查證結果。若該檔不存在，先依 RUNBOOK §2 產生。

要做的事：逐筆填寫該 CSV 的 action / replacement_code / rationale /
verified_by / verified_date 五個欄位。判定只有三種結果：

  confirmed-wrong  IG 標示與官方六軸在 COMPONENT 或 SYSTEM 上不同 → 確認用錯碼。
                   請以 $lookup 或 LOINC 搜尋找出正確代碼填入 replacement_code，
                   並在 rationale 寫明「原碼六軸 → 應為六軸」的具體差異。
                   替代碼本身也必須跑一次 $lookup 確認，不得憑印象填寫。

  confirmed-ok     代碼正確，僅 display 用語漂移 → action 填 rewrite-display，
                   replacement_code 留空，rationale 寫明為何判定代碼無誤。

  needs-clinical   需臨床或檢驗科決定，AI 不得代為決定 → replacement_code 留空，
                   rationale 寫明「要決定什麼、由誰決定」。
                   詳見 RUNBOOK §4 的清單，該節列出的案例一律歸此類。

規則（違反其一即為錯誤）：
1. 比對六軸（COMPONENT／PROPERTY／TIME／SYSTEM／SCALE／METHOD），不可只比對
   display 字串相似度。14390-9 的字串長度與 ALT 相近，但六軸完全不同。
2. 不要為了消掉訊息而改 display。「顯示名不符可能代表用錯碼」是本專案第一鐵則。
3. 任何 replacement_code 都必須經 $lookup 實際查證過才可填入。
4. 不確定就填 needs-clinical，不要猜。寧可多留幾筆給人看。
5. verified_by 填「Claude Code + <你的名字>」，verified_date 填今天日期。

**本階段不要修改任何 FSH、ValueSet、ConceptMap 或 pagecontent 檔案。**
只填 CSV。套用變更是下一階段的事，需要與值集、ConceptMap、terminology.md
及受影響範例四處同步，並經 CI 閘門驗收。

完成後提交並推送到 claude/occupational-health-ig-review-6vx9gn，
並在最後告訴我三類各有幾筆、以及 needs-clinical 那些分別需要誰決定。
```

---

## 4. 這些不是 AI 該決定的

以下幾類即使查完 `$lookup` 也**必須有人決定**，因為答案取決於「院內實際怎麼報」，
而不是 LOINC 說什麼：

| 案例 | 要決定什麼 | 該問誰 |
|:--|:--|:--|
| `42221-2` 尿錳、`34304-6` 尿氟 | IG 標質量濃度、官方為莫耳濃度。院內 LIS 實際以 µg/L 還是 µmol/L 報告？前者要換碼，後者要改單位宣告 | 檢驗科 |
| `19177-5` AFP、`2428-1` 同半胱胺酸 | 同上之量綱問題 | 檢驗科 |
| `5671-3` 血中鉛（DISCOURAGED） | 已改 Preferred 為 `77307-7`，但 `5671-3` 仍在**法定必驗子集**內。要移除還是保留為 Acceptable？移除可能造成院內 LIS 無法對應 | 職業醫學科 ＋ 檢驗科 |
| `33914-3` MDRD eGFR（DISCOURAGED） | 臨床已改採 CKD-EPI，Core 已收 `88293-6`。要不要移除 MDRD？ | 職業醫學科 |
| `26505-8`／`26508-2` 嗜中性球分類 | 官方為「Segmented」「Band form」，IG 標「Hypersegmented」「總嗜中性球」。要的是哪一個概念？ | 檢驗科 |
| `9633-9` EBV VCA IgA | 官方為 [Titer] by IF，IG 標 [Presence]。院內報定性還是效價？ | 檢驗科 |

把這些歸為 `needs-clinical` 並寫清楚問題，比自行決定有價值得多——
這份 IG 是要送主管機關與臨床專家審查的，留下「這一題我們知道，正在確認」
遠好過留下一個看起來已解決、實則猜的答案。

---

## 5. 回到主工作流之後會做什麼（③）

1. 依 CSV 之 `action` 修改 `VS-ExtendedDataset` / `VS-CoreDataset` / `VS-OccHealthCheck-Required`；
2. 同步 `ConceptMap-TWHealthCheckLaboratoryMap` 之對映；
3. 同步 `terminology.md` §4 對照表；
4. 更新 `examples.fsh` 中引用到被換掉之代碼的 Instance；
5. 將稽核結果合併回 `input/assets/display-verification-report.csv`（發佈資產）；
6. 分批提交，每批由 CI 之 QA 閘門驗收——`Wrong Display Name` 應逐批下降，
   完成後於 `qa-baseline.json` 下調並鎖定。

C 類 57 筆會在 A／B 決策完成後一併處理（其中若干可能因換碼而連帶變動）。
