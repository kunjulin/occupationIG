# JOB-14｜尿沉渣面積碼回收為 Acceptable（preferred／acceptable 雙軌之範圍修正）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（送審阻斷級：影響他院可實作性） |
| **類別** | 術語正確性／可實作性 |
| **預估** | S（1 人日） |
| **相依** | JOB-01（本 JOB 為其批 3 之範圍修正，非推翻）；JOB-08（CI tx 建置，用於驗收） |
| **主要影響檔案** | `input/fsh/valuesets/VS-ExtendedDataset.fsh`、`input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh`、`input/pagecontent/terminology.md`、`input/pagecontent/open-issues.md`、`qa-baseline.json` |
| **既有程序** | `.claude/skills/fhir-tx-audit/SKILL.md`（display 逐字採官方字串之驗收沿用此程序） |

---

## 1. 問題（證據）

### 1.1 JOB-01 批 3 的範圍錯誤

JOB-01 批 3（commit `8ab7164`）依 2026-07-27 臨床回覆「本院 Sysmex UF-5000／UD-10
報每 µL」，將尿沉渣 9 個 `[#/area] in Urine sediment by Automated count` 碼
**整組刪除**，換為 `[#/volume] in Urine by Automated count` 碼。

該處置把「本院怎麼報」誤當成「全國只能這樣報」。實際上：

- `[#/area]`（每高倍視野，/HPF）與 `[#/volume]`（每 µL）**兩者皆為合法且臨床常見**
  之尿液分析儀報告方式；
- 9 個被刪除的代碼經 `input/assets/display-verification-report.csv`（2026-07-26
  tx `$lookup` 驗證）確認**全數 STATUS = ACTIVE**，並非停用或錯誤代碼；
- 當時之所以被列入 `Wrong Display Name`，是因為 **IG 的 display 標成了 `[#/volume]`**，
  而代碼本身是 `[#/area]`。**錯的是標籤，不是代碼。**

刪除後之結果：**以 /HPF 報告之機構在本 IG 中無代碼可用。** 這與本 IG
「preferred code ＋ ConceptMap 歸一以容納院際差異」之設計直接衝突
（見 `index.md` §4.2、`terminology.md`）。

### 1.2 同一輪處置內標準不一致

第 2 題（4 碼）採「保留原碼 ＋ 加變異碼」：

```
42221-2 尿錳（莫耳）  ＋ 5684-6（質量）      ← 正確
34304-6 尿氟（莫耳）  ＋ 5650-7（質量）      ← 正確
19177-5 AFP（質量）   ＋ 53962-7（腫瘤標記型）← 正確
2428-1  同半胱胺酸    ＋ 13965-9（莫耳）     ← 正確
```

第 3 題（2 碼）`22322-2`／`5193-8` 定性與定量**兩碼都保留**，僅修 display，亦正確。

**唯獨第 1 題採整組替換。** 同一輪處置內兩種標準並存。

### 1.3 ConceptMap 未同步（更嚴重）

換碼後，**ConceptMap 對這 9 碼一組都沒有補**：

```
33218-9 → ConceptMap 出現 0 次
33219-7 → 0 次   33223-9 → 0 次   33342-7 → 0 次
43755-8 → 0 次   46419-8 → 0 次   46702-7 → 0 次
50235-1 → 0 次   53324-0 → 0 次
```

即使某機構送出舊碼，**亦無歸一路徑**。JOB-01 §2 驗收條件第 4 點原已明訂
「凡換碼者，ConceptMap 之對映與 `terminology.md` §4 對照表同步更新，
**不得只改值集**」——此條在批 3 未被落實。

### 1.4 背景：Extended 之 preferred／acceptable 涵蓋率

| 值集 | 成員數 | ConceptMap 涵蓋 | 比率 |
|:--|--:|--:|--:|
| `VS-CoreDataset` | 21 | 18 | **86%** |
| `VS-ExtendedDataset` | 279 | 30 | **11%** |

且 Extended 之 acceptable 目前僅以 `// Acceptable:` **註解**標示（全檔 13 行），
非機器可讀結構。此為結構性議題，**不在本 JOB 範圍**（見 §4），但構成本問題之背景。

---

## 2. 目標與驗收標準

**目標**：將尿沉渣 9 個面積碼回收為 Acceptable，並補齊 ConceptMap 歸一路徑，
使以 /HPF 報告之機構可實作，同時維持 `Wrong Display Name = 0`。

驗收標準（**一律以 CI tx 建置實測，不得推估**）：

1. `err = 0`。
2. **`Wrong Display Name = 0`**（維持）。若出現 9 筆，即代表 display 未逐字採用
   LOINC 官方字串——此為本 JOB 最容易失敗之處。
3. `VS-ExtendedDataset` 成員數 = **288**（279 ＋ 9）。
4. `ConceptMap-TWHealthCheckLaboratoryMap` 之 `group[0].element` 總數 = **37**（0–36）。
5. 9 組 equivalence **全數為 `#relatedto`**，且每組附 `comment`。
6. `qa-baseline.json` 之任何總數變動須以 `_wave14Note`（或 `_job14Note`）**具名歸因**，
   說明多出來的是什麼——沿用本專案既定規則：**總數上調必須具名**。
7. `terminology.md` §4 對照表含此 9 組，並有一段說明本 IG 對尿沉渣採雙軌收錄之理由。

---

## 3. 工作項目

### 3.1 值集回收（`VS-ExtendedDataset.fsh`）

於「尿沉渣自動計數」區塊，在每個現有 `[#/volume]` preferred 碼之後，
緊接加入對應之 `[#/area]` acceptable 碼。

**display 必須逐字使用 LOINC 官方字串**，來源為
`input/assets/display-verification-report.csv` 之 `loinc_display` 欄
（2026-07-26 經 tx `$lookup` 驗證）：

| Preferred（現有，勿動） | Acceptable（本次新增） | 官方 display（逐字） |
|:--|:--|:--|
| `51480-2` | `33218-9` | `Bacteria [#/area] in Urine sediment by Automated count` |
| `51486-9` | `33219-7` | `Epithelial cells.squamous [#/area] in Urine sediment by Automated count` |
| `51484-4` | `33223-9` | `Hyaline casts [#/area] in Urine sediment by Automated count` |
| `87926-2` | `33342-7` | `Epithelial cells [#/area] in Urine sediment by Automated count` |
| `51483-6` | `43755-8` | `Casts [#/area] in Urine sediment by Automated count` |
| `798-9`   | `46419-8` | `Erythrocytes [#/area] in Urine sediment by Automated count` |
| `51487-7` | `46702-7` | `Leukocytes [#/area] in Urine sediment by Automated count` |
| `51478-6` | `50235-1` | `Mucus [#/area] in Urine sediment by Automated count` |
| `51479-4` | `53324-0` | `Spermatozoa [#/area] in Urine sediment by Automated count` |

> `51479-4`（精子）不在該區塊內，位於檔案稍後處（批 3 註記「缺口已解」那一行），
> 請於其後加入 `53324-0`。

註解慣例比照本檔既有 Acceptable 寫法，例如：

```
* LNC#33218-9 "Bacteria [#/area] in Urine sediment by Automated count"   // Acceptable：每高倍視野（/HPF）鏡檢沉渣計數；以 /HPF 報告之機構適用，經 ConceptMap 歸一至 51480-2
```

**並改寫該區塊上方之區塊註解。** 現行註解寫「原列 `[#/area]` 碼全數用錯」——
此敘述不正確（代碼有效，錯的是當時 display 標了 `[#/volume]`）。
應改為說明本 IG 同時收錄兩種量綱：preferred 為體積碼、acceptable 為面積碼。

### 3.2 ConceptMap 補 9 組歸一

該檔使用單一 `group[0]`，現有 `element[0]` 至 `element[27]`。
新增 `element[28]` 至 `element[36]`，`source` ＝面積碼、`target` ＝體積碼。

**equivalence 一律 `#relatedto`**，不得用 `equivalent` 或 `narrower`。
判準見該檔第 9 行之 equivalence 使用原則：兩者量綱不同（每面積 vs 每體積），
需經儀器換算，無包含關係。

每組 `comment` 請說明：source 為每高倍視野鏡檢沉渣計數、target 為每體積全尿
自動計數；兩者需依儀器換算係數轉換，**不可直接比較數值**。

### 3.3 `terminology.md` 同步

於 §4 對照表新增此 9 組，並補一段說明：本 IG 對尿沉渣採
「體積碼為 preferred、面積碼為 acceptable」，理由為國內各機構尿液分析儀
報告單位不一致（/HPF 與 /µL 並行）。

### 3.4 `open-issues.md`

若 T-1 或相關條目提及尿沉渣 9 碼已「換碼完成」，更新為「preferred／acceptable
雙軌收錄」，避免與實際狀態不符。

---

## 4. 不在本 JOB 範圍

- **不得回收 JOB-01 移除之其他 7 個語意錯碼**：`14390-9`（透析液澱粉酶）、
  `14409-7`（胸膜液 AST）、`19199-9`（精液 PSA）、`1783-0`（全血 ALP）、
  `46986-6`（VLDL 3 次分群）、`20627-6`（尿液濁度）、`70028-6`（巨核細胞核）。
  這些是「拿 A 的碼裝 B 的資料」，保留為 acceptable 會把錯誤永久化，
  且會令 ConceptMap 宣告一個假的等價關係。
- **`13705-9`（24 小時尿 ACR）維持移除**。健檢採隨機尿，屬 out-of-scope
  而非可接受變異。
- **不處理 Extended 之 preferred／acceptable「由註解升級為機器可讀結構」**
  （涵蓋率 11%，見 §1.4）。屬治理層議題，另立 JOB-15 或列為未決事項。
- 不修改 `VS-CoreDataset` 任何內容（該值集在整輪優化中零變動，應維持）。

---

## 5. 風險與注意事項

- **display 逐字**是本 JOB 唯一的高風險點。9 個代碼之官方 display 與體積碼
  僅差 `[#/area]` vs `[#/volume]`、`in Urine sediment` vs `in Urine`，
  極易複製錯行。建議先寫好對照後以腳本產生，勿手打。
- **勿順手把 equivalence 標成 `equivalent`。** /HPF 與 /µL 之換算係數取決於
  離心速度、沉渣濃縮倍率與顯微鏡視野面積，各實驗室不同。若標 `equivalent`，
  實作端可能直接把 /HPF 數值當每 µL 使用，屬臨床可致誤判之錯誤。
- 新增 9 碼會使 `VS-ExtendedDataset` 相關之 info 訊息數上升。**這是預期的**，
  但仍須具名歸因，不得只調天花板。
- 本 JOB 完成後，`文件二`（Extended 碼數）與`附件 v7.0`（Extended 分頁、
  變更明細分頁）需同步改版為 279 → 288。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-14-preferred-acceptable-recovery.md 與
docs/optimization/JOB-01-terminology-code-audit.md §9（第四階段：套用變更），
並依 .claude/skills/fhir-tx-audit/SKILL.md 的程序，為 JOB-14 產出實作計畫。

要求：
1. 本 JOB 是 JOB-01 批 3 的「範圍修正」，不是推翻 JOB-01。請在計畫開頭
   明確區分：哪 9 碼要回收（尿沉渣，代碼有效、錯的是原 display 標籤），
   哪 7 碼絕對不能回收（真正的語意錯碼）。若計畫中出現回收那 7 碼的任何
   建議，即為理解錯誤。
2. display 必須逐字取自 input/assets/display-verification-report.csv 之
   loinc_display 欄，不得憑印象或重新檢索。請在計畫中列出你將寫入的
   9 行 FSH 全文供覆核，再動手改檔。
3. ConceptMap 新增 element[28]–[36]，equivalence 一律 #relatedto，
   每組附 comment。請說明你如何確認現有最大 element index 為 27。
4. 計畫須包含：terminology.md §4 同步、open-issues.md 更新、
   qa-baseline.json 具名歸因段落之草稿。
5. 分兩個 commit：(1) 值集＋ConceptMap＋文件；(2) qa 基準線具名歸因。
   每個 commit 說明如何以 CI tx 建置驗收。
6. 完成後回報實測值：err／Wrong Display Name／VS-ExtendedDataset 成員數／
   ConceptMap element 總數／CI run id，以及 qa-baseline 的具體變動與歸因。

注意：Wrong Display Name 目前為 0，這是 JOB-01 的驗收成果。若本 JOB 使其
變為非 0，代表 display 沒有逐字採用官方字串，必須修正後才算完成。
```
