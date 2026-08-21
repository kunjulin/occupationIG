# JOB-31｜v0.6.1 線上複驗：基準線鬆動 61 筆、25 筆未具名 WARNING、ConceptMap 未納登記

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（閘門有效性；不影響已發佈內容之正確性） |
| **類別** | QA 治理／閘門 |
| **預估** | S（0.5–1 人日） |
| **主要影響檔案** | `qa-baseline.json`、`scripts/check-governance-tags.js`、`scripts/governance-map.js`、`README.md` |
| **緣起** | 2026-08-20 就 v0.6.1 已發佈站台（`37613689`）之獨立複驗 |
| **狀態** | 📋 **評估（v0.6.2）**，待裁示後實作 |

---

## 0. 一句話結論

**已發佈內容通過複驗，沒有錯誤；問題全在「閘門看不看得到」這一層。**
三項發現：基準線 `warn` 上限比實況鬆 **61 筆**、**25 筆 WARNING 不屬任何具名類別**、
**2 個 ConceptMap 與 1 個 NamingSystem 不在權責登記表內**。

---

## 1. 複驗方法與範圍

以 `git clone --branch gh-pages` 取得**已發佈產出本身**（非 CI 日誌、非本機重建），
逐項比對 `qa.txt`（閘門實際解析之來源，非 `qa.html`）與 `governance-map.js` 登記表。

> ⚠️ **`qa.html` 不可用於計數**：其訊息在摘要區與明細區重複出現，
> 不同類別重複倍數不一（實測有 ×2 亦有 ×3），逐字串計數會系統性高估。
> 本複驗全部以 `qa.txt` 為準。

| 項目 | 實測值 |
|:--|:--|
| `sourceCommit` | `3761368983d21858d659f16c83991defa3d6c52c` |
| `builtAt` | 2026-08-20T18:20:43Z |
| IG Publisher | 2.2.11 |
| `ImplementationGuide.version` / `.status` | **0.6.1** / `active` |
| `qa.txt` 摘要 | **err = 0, warn = 91, info = 467**（broken links 2321、pinned 30） |

---

## 2. ✅ 通過複驗者（與施作方回報一致）

### 2.1 具名類別零回歸

`qa-baseline.json` 之 **22 個具名類別全部與實測完全相符（差 ±0）**，無任何一項超出。
包含 `Wrong Display Name = 0`、`cannot be resolved = 2321`、`does not match any known slice = 23`、
`There are no valid display names = 246`、`should have an OID assigned = 49` 等。

### 2.2 101 件權責登記之全量比對——獨立複驗結果相同

自 gh-pages 取出 `governance-map.js` 所登記之 101 件對應之已發佈 JSON，
逐件讀取 `status` 與 `structuredefinition-standards-status`：

| 登記層級 | `status` | `standards-status` | 件數 |
|:--|:--|:--|--:|
| Level 1 | `active` | `#trial-use` | **24** |
| Level 2 | `draft` | `#draft` | **50** |
| 共用技術結構（level 0） | `active` | 無 | **27** |

**不符登記者 0 件；找不到對應產出者 0 件。** 施作方之「全量、零例外」回報**成立**。

### 2.3 敘述頁內容已上線

`zh-TW/conformance.html` §7.0 範疇聲明（含「**亦未受勞動部職業安全衛生署委任或授權**」全句）、
§7.1 兩個層級、§7.2「Level 1 逐列清單（21 列）」與 `13 + 3 + 3 + 2 = 21` 算式、
`30907X-3`，均實測存在。
`zh-TW/open-issues.html` 之 `<title>` 已為「**已知限制與試用須知**」；
主一覽表欄位為「編號／標題／決定者／**對試用的影響**／**權責歸屬**／狀態」共 **20 資料列**，
頁尾「已結案（存查）」表 **6 資料列**，合計 **26 項**，與規劃相符。

---

## 3. ⚠️ 發現一：基準線 `warn` 上限鬆動 61 筆

| 指標 | 基準線上限 | v0.6.1 實測 | 落差 |
|:--|--:|--:|--:|
| `err` | 0 | 0 | 0 |
| `warn` | **152** | **91** | **−61（鬆）** |
| `info` | 467 | 467 | 0 |

`scripts/qa-gate.js` 之判準為「**任一數值高於基準線即失敗**（只能降不能升）」，
故 91 ≤ 152 為綠燈——**但這代表未來可再新增最多 61 筆 WARNING 而閘門完全不會亮**。

`docs/optimization/README.md` 自己寫的規則是「**現行基準線（每個 JOB 完成後應下調）**」，
`qa-gate.js` 亦提供 `--update` 專供此用。JOB-30 之三個版次（v0.5.0／v0.6.0／v0.6.1）
使 `warn` 由 152 降至 91，**下調動作未執行**。

**處置**：以 `node scripts/qa-gate.js --update` 依 v0.6.1 實測回填，
並於 `README.md` 記錄「由 152 下調至 91，來源為 workflow run 32401836568」。

---

## 4. ⚠️ 發現二：25 筆 WARNING 不屬任何具名類別

> **更正（v0.8.2）：現為 24 筆，不是 25。**
> 25 係以當時之 `warn 91` 減 66 所得；`warn` 已實測校準為 **90**（v0.7.1 已改善 1 筆而未同步下調，
> 見 `qa-baseline.json` 之 `_v080Note` 末段），故未具名筆數應為 **90 − 66 = 24**。
> 消失的那 1 筆最可能是下表末列之 `ShareableConceptMap`（v0.7.1 補了 `description`）。
> **具名化之範圍以 24 為準。**
>
> **v0.8.2 之處置（兩件事，不要混為一談）**：
> - **偵測**：`qa-gate.js` 改為雙向閘門、容差 0（波動已實測為 0）。任何一筆增減都會紅。
> - **歸因**：閘門每輪列印「未具名 WARNING 之形態分布」，不必再臨時加一次性步驟才知道組成。
>
> 緊天花板保證的是**偵測**得到，具名化提供的是**歸因**——兩者不能互相取代，
> 但有了每輪列印的形態分布後，具名化的邊際價值變成「逐類獨立設上限」而非「知道是什麼」。
> 逐類具名仍要做（見下），其確切筆數改依該報表之實測值填寫，不沿用本表之 v0.7.0 期量測。
>
> **✅ 具名化已於 v0.8.3 完成。實測為 23 筆／12 種形態，不是 24，也不是 25。**
> 三個數字各自都對，只是量在不同版次：25（v0.7.0 期，warn 91）→ 24（warn 校準為 90）
> → 23（v0.8.2 補 `ConceptMap.title` 又消掉 1 筆）。歸為 6 個新具名類別
> ＋ 1 個鎖定為 0 之已達成類別；逐形態筆數與理由見 `qa-baseline.json` 之 `_job31S4Note`。
> **未具名 WARNING 現為 0**——89 筆全數具名，任一類增減都會被逐類攔下。
> ⚠️ 「全數具名」是此刻的狀態，不是永久性質：新範例會帶進新樣態，故報表仍每輪列印。
>
> 下表之筆數屬 v0.7.0 期量測，保留供追溯，**不得引用為現值**。

91 筆 WARNING 中，**僅 66 筆**落在具名類別內（OID 49、URL definition 11、DISCOURAGED 5、
experimental-not-labeled 1）；**其餘 25 筆完全未被具名**，閘門只能經由 `totals.warn`
這個總量上限間接看到——而該上限正好鬆了 61 筆（§3），**等於目前對這 25 筆的組成完全盲目**。

| 筆數 | 樣態 | 性質 |
|--:|:--|:--|
| **10** | `Entry '<url>' isn't reachable by traversing forwards from the Composition. Only Provenance is approved to be used this way (R4 §3.3.1)` | **實質結構問題**。UC-003 等 document Bundle 內有 entry 自 Composition 走訪不到（如 `Encounter/example-encounter-special`、`Observation/obs-occupation`） |
| **7** | ImagingStudy 之 `binding.valueSet: A definition could not be found`（3）＋`ValueSet '<url>' not found`（4） | 待查：`TWHA-ImagingStudy` 綁定之值集解析不到 |
| **4** | `Best Practice Recommendation: In general, all observations should have a **subject**`／`should have an **effective[x]**`（`Observation/example-service-finding`） | ⚠️ **同類盲區換措辭復現**。基準線具名的是 `should have a performer`（JOB-05 已打到 0），**subject／effective[x] 兩種措辭未被具名** |
| **2** | `UCUM Codes that contain human readable annotations like {quid} can be misleading … Best Practice is not to depend on annotations` | 命中 `obs-betelnut`／`obs-betelnut-current`。**屬 JOB-29 之刻意決定**（`{個}/d` 非合法 UCUM，故採 `{quid}/d`），須具名並註明「已知且刻意保留」，否則日後會被誤修 |
| **2** | `Published concept maps SHOULD conform to the ShareableConceptMap profile` | 基準線僅具名了 `ShareableValueSet`，**ConceptMap 之對應項未具名**。⚠️ v0.8.2 起應為 **1** 筆：v0.7.1 補了 `description`（`* description =` 元素賦值）消掉 1 筆，v0.8.2 再以 `* title =` 補齊 `TWHealthCheckLaboratoryMap.title`，預期歸零——實際筆數以 CI 為準 |

**處置**：將上述五類**逐一加入 `qa-baseline.json` 之 `categories`**（含刻意保留者，以 `_note` 說明理由），
使其成為受監控之具名類別；`totals.warn` 同步下調（§3）。
其中 10 筆 Composition 走訪問題與 7 筆 ImagingStudy 值集問題**應另立工項處置**，不只是具名。

> **為何這件事重要**：本 repo 已兩次踩過同一形態——`cannot be resolved` 不計入 `err` 致閘門盲目、
> `pages:` 漏列致頁面靜默消失。**「總量上限綠燈」不等於「內容沒問題」**，
> 未具名類別 ＋ 過鬆上限的組合，正是這種盲區的標準配方。

---

## 5. ⚠️ 發現三：2 個 ConceptMap ＋ 1 個 NamingSystem 不在權責登記表

已發佈之定義類 artifact 共 **104** 件，其中屬本 IG 命名空間者 **103** 件，登記表為 **101** 件。
差額為：

| Artifact | 型別 | `status` | `standards-status` | 判斷 |
|:--|:--|:--|:--|:--|
| `TWHealthCheckLaboratoryMap` | ConceptMap | `active` | 無 | ⚠️ **功能上屬 Level 1**——即 acceptable→preferred 之歸一對照，院所送變異碼須靠它 |
| `Appendix10-to-HazardType` | ConceptMap | `active` | 無 | 屬 Level 2（附表十） |
| `NS-ReportIdentifier` | NamingSystem | `draft` | 無 | 同類，須裁定 |

**成因不是閘門失效，而是登記範圍之界定**：`check-governance-tags.js` 之 `scanFsh` 僅掃
`Profile`／`Extension`／`ValueSet`／`CodeSystem` 四種宣告，`Instance:` 宣告者一律排除
（原始碼註解已明載此設計）。上述三件在 FSH 中均以 `Instance:` 宣告，故 G-1
「未登記即失敗」對它們不會觸發。

**問題點**：Level 1 對外宣稱 `trial-use`，但其**必要配套** `TWHealthCheckLaboratoryMap`
既無成熟度標記、也不在登記表內。實作端若依 Level 1 介接並使用該對照，
無從得知其成熟度，且日後對它的任何變更不受本閘門保護。

**處置（二擇一，須 PI 裁示）**：
- **(A) 擴大登記範圍**——將 ConceptMap 與 NamingSystem 納入 `governance-map.js` 與
  `scanFsh`（需支援 `Instance:` + `InstanceOf:` 之解析），並比照標註
  `TWHealthCheckLaboratoryMap` → Level 1、`Appendix10-to-HazardType` → Level 2。**建議採此案。**
- **(B) 明文排除**——於 `governance-map.js` 開頭寫明排除理由與清單，
  並於 `conformance.md` §7 註明該等 artifact 不構成合規標的。

無論何者，**不得維持現狀之「未寫明的沉默排除」**——那與本案「範疇界定要寫出來，不是省略」之
既有立場（M-6、JOB-27、JOB-30 §3.1）相違。

---

## 6. 對「共用技術結構 27 件是否也標 `draft`」之意見

**建議：不標。** 三項理由：

1. **會破壞 Level 1 之論述**。該 27 件（`TWHA-Patient`、`TWHA-Practitioner` 等）為兩層共用；
   標 `draft` 後，Level 1 之 Profile 與範例將產生大量 `Reference to draft`——
   該類別**目前為受監控之具名類別、基準線 12**，實測 12 筆全為 INFORMATION 且來自範例引用
   draft CodeSystem。一旦基礎結構轉 draft，此數必然大幅上升並觸發閘門。
2. **與裁示範圍不符**。PI 裁示之文字為「勞工區塊」，共用技術結構不屬勞工區塊；
   施作方未擴大解釋是正確的。
3. **語意上不成立**。`draft` 表示該結構本身尚未穩定；但這 27 件是 Level 1 已宣告 `trial-use`
   之相依基礎，若其為 draft，則 Level 1 之 `trial-use` 反而失去意義（相依鏈之成熟度不得高於其基礎）。

**替代作法**：若目的是表達「共用技術結構亦非定案」，應改於 `conformance.md` §7 以文字說明
其成熟度隨兩層之較低者，而非變更 `status`。

---

## 7. 驗收標準

1. `qa-baseline.json` 之 `totals.warn` 依 v0.6.1 實測下調至 **91**（或屆時之實測值），
   並於 `_note` 記錄來源 workflow run id。
2. §4 之五類 WARNING **全部成為具名類別**；刻意保留者（UCUM `{quid}` 註記）附 `_note` 說明理由。
3. 具名類別加總 ＋ 未具名筆數 **等於** `totals.warn`（以腳本核算，不得目視）。
4. §5 之三件依裁定結果處置：採 (A) 者須通過 `check-governance-tags.js --self-test`
   之新增負向案例（未登記之 ConceptMap 必須被抓到）；採 (B) 者須有書面排除清單。
5. 共用技術結構 27 件之 `status` **維持 `active`**，除非另有裁示。
6. `_genonce_tx.bat` 或 CI 重跑後 `err` 仍為 0；具名類別無任一項超出新基準線。

---

## 8. 不在本 JOB 範圍

- §4 之 10 筆 Composition 走訪問題與 7 筆 ImagingStudy 值集問題之**實際修復**——
  本 JOB 僅要求「具名並列管」，修復另立工項（避免把閘門治理與內容修正混為一批）。
- M-5、嚼檳系列 `experimental`、Level 1 成熟度——**待書面依據**，見 JOB-30 §3.4。

---

## 交給 Claude 規劃用提示

> 依 `docs/optimization/JOB-31-qa-baseline-and-registry-gaps.md` 執行：
> (1) 以 CI 或 `_genonce_tx.bat` 之**實測值**下調 `qa-baseline.json` 之 `totals.warn`，
>     **不得憑本文件所載之 91 逕填**——須自該次建置之 `qa.txt` 讀取；
> (2) 將 §4 五類 WARNING 加為具名類別，刻意保留者附 `_note`；
> (3) 加一項核算：具名類別加總 ＋ 未具名筆數 = `totals.warn`，不符即失敗；
> (4) 依 PI 裁示處置 §5 之三件（建議採 (A) 擴大登記範圍，並為 `check-governance-tags.js`
>     新增 `Instance:` + `InstanceOf:` 之解析與對應之 `--self-test` 負向案例）；
> (5) **不得**變更共用技術結構 27 件之 `status`；
> (6) **不得**變更 M-5 狀態、嚼檳系列 `experimental` 或 Level 1 成熟度。
