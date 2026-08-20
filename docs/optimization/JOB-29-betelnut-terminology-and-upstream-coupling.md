# JOB-29｜嚼檳榔術語之權責界線，與 TWCR_SF 相依之耦合度調整

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（涉及對外文件與指引之實質落差，且為 JOB-28 之後續風險） |
| **類別** | 術語／相依治理／對外一致性 |
| **預估** | M（2–3 人日，不含上游協調） |
| **相依** | 須在 **v0.3.0（JOB-28）之後**套用；本 JOB 不推翻 JOB-28 |
| **主要影響檔案** | `input/fsh/profiles/TWHA-SocialHistory.fsh`、`input/fsh/codesystems/`（新增）、`input/fsh/extensions/ext-cessation-duration.fsh`、`input/fsh/examples/03-social-history.fsh`、`scripts/check-dependencies.js`、`input/pagecontent/terminology.md`、`input/pagecontent/open-issues.md`、對外之《勞工健檢上傳欄位建議修訂案》 |
| **緣起** | 2026-08-20：(1) 國民健康署上傳欄位文件之嚼檳榔欄位無編碼，詢問是否比照吸菸自訂值集；(2) 取得 TWCR_SF 上游 `package.tgz` 後，發現封裝內含 `file://C:\Users\Lily\TWCR_SF\output` 之開發者本機路徑 |
| **狀態** | 📋 **評估（v0.3.1；v0.3.2 補入附錄 B 委員意見處置）——待核准後實作** |

---

## 0. 一句話結論

**兩個問題要分開答。** 嚼檳榔「**狀態**」欄位國健署無編碼，本指引**應自訂**——此屬本團隊職權、
授權與規範上皆無障礙，且**目前指引根本沒有承載該欄位的位置**（見 §2.1），是既存缺件而非新增需求。
嚼檳榔「**量／年／戒除**」則**不應自行複製上游 90 餘碼的列舉清單**，而應把 Profile 的**綁定主軸**
由列舉碼改為 **Quantity（UCUM）**，使建置的可重現性不再單點取決於上游的封裝品質。

**不退回本地 stub、不撤銷 JOB-28、不等上游修復。**

---

## 1. 為什麼要拆成兩題

外界（含國健署來問）的提法是「檳榔沒有碼，是不是我們自己定？」。這句話混合了兩個不同層次的決策：

| | 問題 | 決策層次 | 答案 |
|:--|:--|:--|:--|
| **Q1** | 國健署上傳欄位無檳榔編碼，本指引可否自訂值集？ | **術語治理**（誰有權在哪個命名空間下定義代碼） | **可以，而且必須**——但只限「狀態」欄位，且須標 provisional |
| **Q2** | 上游 TWCR_SF 封裝有瑕疵，是否改為自行定義以求不延宕？ | **相依治理**（建置的可重現性與單點風險） | **不以「自行定義」解決**——改以降低耦合度解決 |

把 Q2 用「自己定一份」來解，等於把 JOB-10 §7.3 已明確否決的做法反向再做一次：
同一組代碼在兩個 canonical 下並存，與癌症登記的資料無法勾稽。

---

## 2. Q1：嚼檳榔狀態——現況缺件與自訂建議

### 2.1 先講一個尚未被記錄的實質落差

《勞工健檢上傳欄位建議修訂案 v2.1》第 9 列載明：

> 30907X-1　嚼檳狀態　Coded　（無 LOINC）　SNOMED 698188003　**Observation.code 採 SNOMED 698188003，建 CS-BetelNutStatus**

但本指引之 `TWHASocialHistoryBetelNutProfile` 現況為：

```fsh
* code = TWCRSFObsBehCS#BetelNutChewing "嚼檳榔行為"
* component[amount] / component[year] / component[quit]   // 三者皆 CodeableConcept
```

- **`CS-BetelNutStatus` 於 repo 內並不存在**；
- Profile **未約束 `value[x]`**，亦無 status 之 component
  → **「嚼檳狀態」這一格在指引中沒有承載位置**。

亦即：對外文件說明的建模方式，與指引實際定義**不一致**。此性質與 JOB-18 之
吸菸量 UCUM 落差同型，但更嚴重——那是單位標錯，這是**欄位缺件**。
若國健署依修訂案第 9 列實作，送出的資源將無法通過本指引之 Profile。

#### 2.1.1 同一支 Profile 之第二處落差：`Observation.code` 與敘述頁不符

`code` 之固定值取自**上游**之 CodeSystem（`aliases.fsh:83`：
`TWCRSFObsBehCS = https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem`），
但本指引之兩張敘述頁，在**與吸菸相同之欄位**（吸菸列填的正是其實際
`Observation.code` `LNC#72166-2`）都宣稱嚼檳之 code 為 SNOMED `698188003`：

| 頁面 | 欄位標題 | 嚼檳列內容 |
|:--|:--|:--|
| [`general-exam.md`](../../input/pagecontent/general-exam.md) | 代碼 / 術語系統 | SNOMED CT `698188003` (Chews betel quid) |
| [`datamodel.md`](../../input/pagecontent/datamodel.md) | 備註 / LOINC 代碼 | SNOMED CT `698188003` (Chews betel quid) |

（`VS-CoreUploadSet` 內之 `SCT#698188003` **不算**不一致——該值集描述已自陳
「不作 `Observation.code` 綁定」，係涵蓋矩陣之項目識別。）

**兩處落差同型、同一支 Profile，應一併處置**：只講「狀態缺件」而不講 `code` 對不上，
實作者照著改仍會對不起來。

此外，`code` 為 **1..1** 且固定為上游代碼——**它是本 Profile 對上游最後一處硬綁定**：
即使三個 `component` 全數改為 Quantity（§3.2），單這一行仍會使上游不可用時建置失敗。
故 §5 將其列為 **C-0**，排序在 C-1 之前。

### 2.2 建議：比照吸菸的**結構**，不挪用吸菸的**代碼**

本指引之吸菸建模已具備完整三層，可直接對稱複製：

| 語意 | 吸菸（現況） | 嚼檳榔（建議） |
|:--|:--|:--|
| Observation.code | `LNC#72166-2`（TW Core 繼承） | `SCT#698188003`（**須先驗證，見 §2.4**） |
| 狀態值 | `valueCodeableConcept` ← `VS-SmokingStatus`（本地 `CS-SmokingStatus`，4 碼） | `valueCodeableConcept` ← **新增** `VS-BetelNutStatus`（本地 `CS-BetelNutStatus`，4 碼對稱） |
| 量 | `ExtSmokingQuantity`（dailyAmount／durationYears） | 見 §3（改 Quantity 主軸） |
| 戒除期間 | `ExtCessationDuration`（月數） | **既有 Extension 之標題已寫「戒菸/戒檳榔月數」，但嚼檳 Profile 從未使用它** |

建議之 `CS-BetelNutStatus`（與 `CS-SmokingStatus` 逐碼對稱，便於同一份問卷邏輯共用）：

| code | display |
|:--|:--|
| `0-never` | 從未嚼食檳榔 |
| `1-occasional` | 偶爾嚼食（非每日） |
| `2-daily` | 每日嚼食 |
| `3-quit` | 已戒除 |

### 2.3 自訂為何沒有治理障礙

| 疑慮 | 事實 |
|:--|:--|
| 「在別人的地盤定代碼」 | 本建議之 canonical 位於**本指引自己的命名空間**（`.../ig/twha/CodeSystem/CS-BetelNutStatus`），與 JOB-10 §7.3、`check-dependencies.js` **D-2** 所禁止的情形正好相反 |
| 「上游有碼就不該自訂」 | 上游 TWCR_SF **沒有**「嚼檳狀態」之四級分類碼；其 `sf-ObserBeh` 僅提供行為別（Observation.code 用），非狀態值 |
| 「主管機關未核定就不能定」 | 本指引已有先例：`CS-HealthMgmtLevel` 標 `experimental = true` 並於描述明載「**provisional，尚待主管機關確認官方代碼與定義（M-2）**」。嚼檳狀態依同一格式辦理即可 |
| 授權 | 上游 TWCR_SF 為 **CC0-1.0**（JOB-28 §1），即便日後需對齊其代碼內容亦無授權障礙 |

**規範上唯一的禁忌是「在他方 canonical 命名空間下發佈定義」，不是「自訂代碼」。**
自訂 + 標 provisional + 提供對照，是 IG 的常規做法。

### 2.4 一個必須先補的查證

修訂案 v2.1 第 9 列之「查證」欄標為「**— 無國際碼**」——該欄僅陳述 LOINC 無對應碼。

> ⚠️ **本節初稿據此推論該碼「屬未驗證對照」，該推論不成立，已更正。**
> [`terminology.md`](../../input/pagecontent/terminology.md) §4.1〈已驗證之綁定 SNOMED CT 代碼〉
> 明列 `698188003` 為「**✅ 已驗證 2026-07-26**」，係透過 `tx.fhir.org`（SNOMED International
> Edition）完成 **`$validate-code` 代碼有效性驗證**；§4.2 之免責語（「SNOMED CT 欄位
> **除 §4.1 所列者外**均未經術語伺服器驗證」）亦明確將本碼排除在未驗證之外。

**尚待補的是另一件事**：已完成者為「**代碼存在且有效**」，未完成者為以 **`$lookup` 取官方 FSN
並逐軸確認其作為 `Observation.code` 之語意適切性**——確認 `Chews betel quid` 是一個
**finding**，用作觀察項目之 `code`（而非用作 `value`）是否適當。

依 [CLAUDE.md](../../CLAUDE.md) §2.2，這兩者本就不可互相取代：**代碼有效 ≠ 語意正確**，
而建置驗證只檢查前者。本 IG 於 2026-07-26 查出並移除的 16 個錯碼，全部都通過了代碼有效性檢查。

實作前須以既有管線取得官方 FSN 並完成語意覆核，**並將結果回填 `terminology.md` §4.1 之
「驗證狀態」欄**（由 `$validate-code` 升為含 `$lookup` 語意覆核）。
本容器無法連線術語伺服器，**不預先宣稱結果**。

> 📌 **不要寫進 `display-verification-report.csv`**：該檔為 **LOINC 專用**產物
> （標頭 `code,ig_display,loinc_display,loinc_status,overlap,verdict,files`，324 列，
> 無任何 SNOMED 碼）。SNOMED 之驗證紀錄現行載體即為 `terminology.md` §4.1。

---

## 3. 量／年／戒除：問題不在「誰的碼」，在「不該是碼」

### 3.1 現況

```fsh
* component[amount].valueCodeableConcept from TWCRSFBetNutChewAmountVS (required)   // 94 碼：每日1顆…每日90顆
* component[year].valueCodeableConcept   from TWCRSFBetNutChewYearVS   (required)   // 100 碼
* component[quit].valueCodeableConcept   from TWCRSFBetNutChewQuitVS   (required)   // 91 碼
```

以 94 個代碼列舉「每日 N 顆」，本質上是**把數值編碼化**。這在癌症登記的固定表單情境有其歷史理由，
但對健檢交換有三個後遺症：

1. **與同一份指引的吸菸建模不對稱**——吸菸量走 `64218-1` + UCUM `/d`（數值），嚼檳量走列舉碼；
2. **與對外文件不一致**——修訂案 v2.1 第 10／11 列明寫「本地 Extension 承載」、UCUM `{個}/d`、`mo`；
3. **`required` 綁定使建置成為單點相依**——上游套件一旦取不到，建置直接失敗（§4）。

### 3.2 建議：主軸改 Quantity，上游碼降為可選對照

| component | 建議 | UCUM |
|:--|:--|:--|
| 嚼檳量 | `valueQuantity` | `{quid}/d`（`unit` 可寫「顆/日」） |
| 嚼檳年數 | `valueQuantity` | `a` |
| 戒除期間 | `valueQuantity` 或既有 `ExtCessationDuration` | `a` 或 `mo`（以原始採集粒度為準——**§3.2 原寫一律 `mo`，經附錄 A.6 逐碼檢視後修正**） |
| （可選）上游級距碼 | 追加 `component[*Coded] 0..1`，綁定強度 **extensible** | — |

上游碼與 Quantity 之關係為**一對一之數值編碼**（`#05` = 每日 5 顆），
故對照應以**可執行之轉換規則**（StructureMap 或文件化演算法）表達，
**不宜硬套 ConceptMap**——ConceptMap 對映的是概念與概念，不是概念與數值。

### 3.3 ⚠️ `{個}/d` 是無效的 UCUM 字串

修訂案 v2.1 第 10 列將嚼檳量之 UCUM 標為 `{個}/d`。UCUM 之註記（annotation，大括號內容）
**僅允許可列印之 ASCII 字元**，中文字元不在其列，故 `{個}/d` **並非合法 UCUM code**。

- `Quantity.code`（機器可讀）：`{quid}/d`
- `Quantity.unit`（人可讀）：「顆/日」——此欄可用中文

此為 JOB-18／19 之 `{pack}/d` 同型錯誤（單位字串本身有問題，而非填錯值），
須以本案既有之 UCUM 稽核腳本實跑確認後，於修訂案 v2.2 一併更正。
**repo 內未出現 `{個}/d`（已全庫檢索），故此項只影響對外文件。**

---

## 4. Q2：上游封裝瑕疵——嚴重度先定位，處置不延宕

### 4.1 事實

使用者於上游 `package.tgz`（`https://mitw.dicom.org.tw/IG/TWCR_SF/package.tgz`）內
發現 `file://C:\Users\Lily\TWCR_SF\output` 之開發者本機路徑。

**本容器之 egress proxy 封鎖該站台（CONNECT tunnel failed 403），無法自行複驗；
以下嚴重度分級為判準，實際落點須由本機或 CI 確認，不預先斷言。**

### 4.2 三行定位指令

```bash
tar tzf package.tgz | head -50
tar xzf package.tgz -O package/package.json | python -m json.tool
tar xzf package.tgz --wildcards -O 'package/*.json' 2>/dev/null | grep -n 'file://'
# 或逐檔：解開後 grep -rn 'file:' package/
```

### 4.3 嚴重度分級

| 落點 | 影響 | 處置 |
|:--|:--|:--|
| `package.json` 之 `canonical` / `url` | **致命**。相依解析與 canonical 比對會指向本機路徑 | 不得作為正式相依，退回 §5 路徑 |
| 任一 `CodeSystem`／`ValueSet`／`ImplementationGuide` 之 `.url` | **致命且會污染本指引**——本 IG 之引用將指向 `file://` | 同上 |
| `ImplementationGuide.definition.parameter`（`path-output`、`path-tx-cache` 等建置參數） | **非致命**。不參與 canonical 解析 | 可續用，但列為上游品質觀察項 |
| `other/`、`.index.json` 等產製附屬檔 | **非致命** | 同上 |

### 4.4 無論落點為何，已經成立的三件事

1. 該套件**未上架任何公開 registry**（JOB-28 §1，兩度實測）；
2. CI 須自 IG 站台抓取單一 static file 才能建置（JOB-28 新增之 `Fetch TWCR_SF package`）；
3. 封裝內含開發者本機路徑 → **發佈流程未受控**。

三者合起來，對本案最終要面對的**國家 IG 報備審查**構成一個實質風險：
**審查方無法以標準 FHIR 工具鏈重建本指引**——`sushi` 或 IG Publisher 在乾淨環境下
解析不到 `fhir.TWCRSF`，必須複製本案 CI 的客製下載步驟。這是可重現性問題，
不是美觀問題。

### 4.5 明確**不建議**的處置

- ❌ **退回本地 stub**——`check-dependencies.js` 之 D-4 即為此設；那是治理倒退，且 JOB-28 §1 已證明其前提不成立。
- ❌ **把上游 90 餘碼複製進本指引命名空間**——製造第二套權威來源，與癌症登記資料無法勾稽（JOB-10 §7.3 已否決）。
- ❌ **等上游修復後再繼續**——上游未上架 registry 已逾一年（v0.1.1 為 2024-08-01 建置），無時程可依。

---

## 5. 建議路徑 C：解耦，而非切斷

| # | 措施 | 效果 |
|--:|:--|:--|
| **C-0** | `Observation.code` 由 `TWCRSFObsBehCS#BetelNutChewing` 改為 `SCT#698188003`（§2.1.1、§A.1；**須先完成 §2.4 之語意覆核**） | `code` 為 1..1 且固定為上游代碼，是本 Profile 對上游**最後一處硬綁定**；不改則 C-1／C-2 做完仍達不到「可切換級」。同時消除 §2.1.1 之敘述頁落差 |
| **C-1** | 量／年／戒除之綁定主軸改 `Quantity`（§3.2） | 核心資料不再需要解析上游 canonical |
| **C-2** | 上游級距碼降為可選 component，綁定強度 `required` → `extensible` | 上游若長期不可用，可於一版內移除該 component 而**不影響任何核心資料** |
| **C-3** | 保留 `fhir.TWCRSF` 正式相依（不推翻 JOB-28） | 對照關係與癌症登記勾稽能力維持 |
| **C-4** | 新增閘門 **D-5**：檢查已取得之套件內不含 `file:` scheme 之 URL，且所有 canonical 為 `https://` | 上游封裝瑕疵不會靜默進入本案產出 |
| **C-5** | 行政面：由工研院轉知上游維護方封裝瑕疵（附證據），並請其上架 registry | 屬協調事項，**本案不等待** |

C-2 是整個路徑的重點：**把單點相依從「建置阻斷級」降為「可切換級」**。
做完之後，上游是否修復、何時上架，都不再影響本案時程。

**但 C-2 單獨不足**：`component[*].code` 若仍取自上游 `sf-BetNutChewBeh`，或 `Observation.code`
仍為 C-0 所指之上游固定值，建置照樣需要解析上游 canonical。故三者須合起來看——
**C-0（`code`）＋ C-1（值改 Quantity）＋ 本地 `CS_BetelNutComponent`（`component.code`，見 §A.1）
才共同構成「不依賴上游即可建置」**，C-2 則負責讓保留下來的對照關係可隨時卸除。

C-4 依本案既定工程慣例（JOB-20／21／22／23），須自帶負向測試，CI 中先跑負向再跑實檢。

---

## 6. 驗收標準

1. `CS-BetelNutStatus`／`VS-BetelNutStatus` 建立，canonical 位於本指引命名空間，
   `experimental = true` 且描述載明 provisional 與待確認事項編號；
2. `TWHASocialHistoryBetelNutProfile` 具備狀態承載位置（`value[x]` 綁定 `VS-BetelNutStatus`），
   修訂案第 9 列之建模說明與指引一致；
3. 量／年／戒除三者以 `Quantity` 為主軸，UCUM 分別為 `{quid}/d`、`a`、
   **`a` 或 `mo`（戒除期間以原始採集粒度為準，見 §A.6——原寫「一律 `mo`」已隨 §3.2 更正）**，
   且通過本案 UCUM 稽核腳本；
4. 上游級距碼之綁定強度為 `extensible`，且移除該 component 不使建置失敗（以實驗開關實測）；
5. `check-dependencies.js` 新增 D-5 並含負向測試，CI 綠燈；
6. SNOMED `698188003` 完成 **`$lookup` 語意覆核**（官方 FSN、狀態、作為 `Observation.code`
   之適切性），結果回填 **`terminology.md` §4.1 之「驗證狀態」欄**——**不是**
   `display-verification-report.csv`（該檔為 LOINC 專用，無任何 SNOMED 碼，見 §2.4）；
   若覆核未過，依 T-3 處置規則改列 informative 對照區，且 C-0 不成立；
7. `qa-baseline.json` 依 CI 實測更新並具名說明，**不預先填數字**。

---

## 7. 不在本 JOB 範圍

- 與 TWCR_SF 維護方之協調（行政作業，C-5）。
- 上游代碼內容本身之臨床適當性審查。
- 國健署上傳欄位清單之法定效力（M-5／P-1，主管機關權責）。

---

## 8. 對外文件之連帶更新（修訂案 v2.2）

| 列 | 更正 |
|:--|:--|
| 第 9 列（嚼檳狀態） | SNOMED `698188003` 標示為「待逐碼驗證」；`CS-BetelNutStatus` 由「建議建立」改為指引實際 canonical |
| 第 10 列（嚼檳量） | UCUM `{個}/d` → **`{quid}/d`**（`unit` 顯示「顆/日」） |
| 第 10／11 列 | 「本地 Extension 承載」之敘述改為與指引一致之 component + Quantity 建模 |

三處均屬**敘述與單位字串**之更正，Preferred 代碼不變。

---

## 9. 風險

- **C-2 之綁定強度變更屬規範性變更**，會影響既有範例 `obs-betelnut`（現以 `#05`／`#10`／`#01` 表達），
  須同步改寫並重新驗證。
- 若 §4.2 定位結果落在「致命」欄，C-3 不成立，須改為完全移除相依並僅保留文件對照表；
  屆時 §5 之其餘措施仍全部適用——**這正是先做 C-1／C-2 的理由**。
- 本 JOB 全部結論之量測部分（QA 訊息筆數、UCUM 稽核、`$lookup`）**均待 CI 實測**，
  本容器受 proxy 限制無法複驗。

---

## 附錄 A：改版後「怎麼描述吃檳榔」——完整範例

> 本附錄於 v0.3.1 評估內補入，係逐碼檢視上游三個代碼清單後所得。
> **檢視結果推翻了 §3.2 的一項寫法**（戒除期間單位），並查出兩項先前未記錄的語意風險（§A.5）。

### A.1 建議之 Profile 骨架

```fsh
Profile: TWHASocialHistoryBetelNutProfile
Parent: Observation
Id: TWHA-SocialHistory-BetelNut
Title: "嚼檳榔歷史與狀態 Profile"
* ^experimental = true
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = SCT#698188003 "Chews betel quid"          // display 依 B.2 更正；仍待 $lookup 驗證（§2.4）
* subject only Reference(TWHAPatientProfile)
* performer only Reference(TWHAPractitionerProfile)

// ── 狀態：主值（新增，補 §2.1 之缺件）──────────────────
* value[x] only CodeableConcept
* valueCodeableConcept from VS_BetelNutStatus (required)

// ── 量化：component 一律 Quantity ─────────────────────
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #open
* component contains
    amount 0..1 MS and
    durationYears 0..1 MS and
    cessationDuration 0..1 MS and
    amountCoded 0..1                 // 可選：上游級距碼對照（extensible）

* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].value[x] only Quantity
* component[amount].valueQuantity.system = "http://unitsofmeasure.org"
* component[amount].valueQuantity.code = #"{quid}/d"

* component[durationYears].code = CS_BetelNutComponent#duration-years "嚼食年數"
* component[durationYears].value[x] only Quantity
* component[durationYears].valueQuantity.code = #a

* component[cessationDuration].code = CS_BetelNutComponent#cessation-duration "戒除期間"
* component[cessationDuration].value[x] only Quantity
* component[cessationDuration].valueQuantity.code from VS_TimeUnitYearMonth (required)  // a 或 mo，見 A.6

* component[amountCoded].code = CS_BetelNutComponent#amount-coded "每日嚼食量（上游級距碼）"
* component[amountCoded].value[x] only CodeableConcept
* component[amountCoded].valueCodeableConcept from SFBetNutChewAmountValueSet (extensible)
```

`CS_BetelNutComponent` 為本指引自訂之三碼小型代碼系統（`amount`／`duration-years`／`cessation-duration`），
與上游 `sf-BetNutChewBeh` 之 `amount`／`year`／`quit` 為 1:1，列於對照表。
**component.code 改用本地碼，是「解耦」的實際著力點**——否則即使值改成 Quantity，
仍須解析上游 canonical 才能建置。

### A.2 四個範例（涵蓋四種臨床情形）

**① 已戒（＝現有範例 `obs-betelnut` 之同一位受檢者）**

```fsh
Instance: obs-betelnut
InstanceOf: TWHASocialHistoryBetelNutProfile
Title: "嚼檳榔狀態與量化資料範例（已戒）"
Description: "受檢勞工王大同：過去每日嚼食 5 顆，嚼檳 10 年，目前已戒除 1 年。"
* status = #final
* subject = Reference(example-worker)
* effectiveDateTime = "2026-06-12T08:05:00+08:00"
* performer = Reference(example-nurse)
* valueCodeableConcept = CS_BetelNutStatus#3-quit "已戒除"
* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].valueQuantity = 5 '{quid}/d' "顆/日"
* component[durationYears].code = CS_BetelNutComponent#duration-years "嚼食年數"
* component[durationYears].valueQuantity = 10 'a' "年"
* component[cessationDuration].code = CS_BetelNutComponent#cessation-duration "戒除期間"
* component[cessationDuration].valueQuantity = 1 'a' "年"
```

**② 目前每日嚼食，未戒**

```fsh
* valueCodeableConcept = CS_BetelNutStatus#2-daily "每日嚼食"
* component[amount].valueQuantity = 10 '{quid}/d' "顆/日"
* component[durationYears].valueQuantity = 20 'a' "年"
// 不送 cessationDuration——未戒者本就沒有這個值
```

**③ 從未嚼食**

```fsh
* valueCodeableConcept = CS_BetelNutStatus#0-never "從未嚼食檳榔"
// 三個 component 全部不送
```

> **這一個範例就足以說明為何要改。** 現行設計三個 component 皆為 `1..1`，
> 「從未嚼食」者仍**必須**填三個代碼（`amount#00`＋`year#00`＋`quit#88`），
> 其中 `quit#88` 之語意是「無嚼檳榔」——用一個外觀像「88 年」的代碼表達「從來沒有」。

**④ 有嚼但量不詳**

```fsh
* valueCodeableConcept = CS_BetelNutStatus#2-daily "每日嚼食"
* component[amount].code = CS_BetelNutComponent#amount "每日嚼食量"
* component[amount].dataAbsentReason = $data-absent-reason#unknown "不詳"
// 不送 valueQuantity
```

**範例 ① 之 JSON（節錄）**

```json
{
  "resourceType": "Observation",
  "status": "final",
  "category": [{ "coding": [{
    "system": "http://terminology.hl7.org/CodeSystem/observation-category",
    "code": "social-history" }] }],
  "code": { "coding": [{
    "system": "http://snomed.info/sct",
    "code": "698188003", "display": "Chews betel quid" }] },
  "subject": { "reference": "Patient/example-worker" },
  "effectiveDateTime": "2026-06-12T08:05:00+08:00",
  "valueCodeableConcept": { "coding": [{
    "system": "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutStatus",
    "code": "3-quit", "display": "已戒除" }] },
  "component": [
    { "code": { "coding": [{ "system": ".../CS-BetelNutComponent", "code": "amount" }] },
      "valueQuantity": { "value": 5, "unit": "顆/日",
        "system": "http://unitsofmeasure.org", "code": "{quid}/d" } },
    { "code": { "coding": [{ "system": ".../CS-BetelNutComponent", "code": "duration-years" }] },
      "valueQuantity": { "value": 10, "unit": "年",
        "system": "http://unitsofmeasure.org", "code": "a" } },
    { "code": { "coding": [{ "system": ".../CS-BetelNutComponent", "code": "cessation-duration" }] },
      "valueQuantity": { "value": 1, "unit": "年",
        "system": "http://unitsofmeasure.org", "code": "a" } }
  ]
}
```

### A.3 同一位受檢者：舊 vs 新

| | 現行（v0.3.0） | 建議 |
|:--|:--|:--|
| 狀態 | **無處可放** | `valueCodeableConcept = #3-quit` |
| 每日 5 顆 | `component[amount] = sf-BetNutChewAmount#05` | `valueQuantity = 5 {quid}/d` |
| 嚼 10 年 | `component[year] = sf-BetNutChewYear#10` | `valueQuantity = 10 a` |
| 已戒 1 年 | `component[quit] = sf-BetNutChewQuit#01` | `valueQuantity = 1 a` |
| 可否算平均量、做區間查詢 | ❌ 需先查代碼表還原數值 | ✅ 直接數值運算，tx 可做 UCUM 換算 |
| 上游套件取不到時 | ❌ 建置失敗 | ✅ 核心三項不受影響 |

### A.4 上游代碼 → 新模型之落點對照

**這張表本身就是「不宜硬套 ConceptMap」的證據**：同一個代碼清單裡的代碼，
會落到 FHIR 的**三個不同位置**（`value`／`component.valueQuantity`／`dataAbsentReason`）。

| 上游 `sf-BetNutChewAmount` | 語意 | 新模型落點 |
|:--|:--|:--|
| `00` | 無嚼檳榔 | `value = 0-never`；不送 amount |
| `01`–`89` | 每日 N 顆 | `amount.valueQuantity = N {quid}/d` |
| `90` | 每日 **≧90** 顆 | `valueQuantity.comparator = >=`，`value = 90` |
| `91` | **偶爾嚼（無規律或無定量）** | `value = 1-occasional`；amount 不送 |
| `98` | 有嚼，但量不詳 | `amount.dataAbsentReason = unknown` |
| `99` | 病歷未記載／完全不詳 | 整筆 `value.dataAbsentReason = unknown` |

| 上游 `sf-BetNutChewYear`（100 碼） | 落點 |
|:--|:--|
| `00` 無嚼檳榔 → 不送；`01`–`97` → `N a`；`98` 年不詳 → `dataAbsentReason`；`99` 未記載 → 整筆不詳 |

| 上游 `sf-BetNutChewQuit`（91 碼） | 落點 |
|:--|:--|
| `00` 無戒 → `value = 2-daily`，不送 cessation；`01`–`87` → `N a`；**`88` 無嚼檳榔** → `value = 0-never`；`98` 已戒但年不詳 → `3-quit` ＋ `dataAbsentReason`；`99` 未記載 → 整筆不詳 |

### A.5 逐碼檢視查出的兩項語意風險（新發現）

**（一）數值與哨兵值混編於同一個代碼軸**

`sf-BetNutChewAmount` 之 `01`–`89` 是數量，`90` 是**設限值**（≧90），
`91` 是**狀態**（偶爾嚼，無規律無定量），`98`／`99` 是**缺值原因**。
四種語意壓在同一個 CodeableConcept 裡，接收端若把代碼當數字用，
`91` 會被讀成「每日 91 顆」——而它其實是「偶爾嚼、沒有定量」。

FHIR 對這三件事各有正規位置（`Quantity.comparator`、狀態 `value`、`dataAbsentReason`），
改版後即自然分開。這也反過來說明 §2.2 建議之 `1-occasional` 一碼**並非本案自創語意**：
上游同樣需要它，只是沒有狀態欄位可放，才塞進量的代碼軸。

**（二）跨清單同碼異義——`#88`**

| 代碼 | 於 `sf-BetNutChewAmount` | 於 `sf-BetNutChewQuit` |
|:--|:--|:--|
| `88` | **每日 88 顆** | **無嚼檳榔** |

兩者皆為合法代碼，僅所屬 CodeSystem 不同。實作端若在 component 之間錯置代碼系統，
會產生「每日 88 顆」↔「從未嚼檳榔」的反向誤讀，**而 `required` 綁定攔不住**
（兩個綁定各自都通過，只是綁錯 component）。其性質與修訂案 v2.1 第 1 項
（`22326-3` 實為 C 肝抗體卻用於 B 肝抗原）同型，屬**送審阻斷級**之語意風險。

改為 Quantity 後，該類錯置會直接呈現為單位或量綱不符，可被機器攔下。

### A.6 對 §3.2 之修正：戒除期間單位

§3.2 原寫「戒除期間 UCUM 一律 `mo`」。逐碼檢視後**修正為 `a` 或 `mo` 並行**，以原始採集粒度為準：

- 上游以**年**收集（`sf-BetNutChewQuit#01` = 已戒 1 年）。強制轉為 `12 mo` 會**偽造精度**——
  原始資料並未主張「恰好 12 個月」。
- 吸菸之 `63632-4` 官方例示單位本即為 `d`／`wk`／`mo`／`a` **四者並列**，故並行不破壞與吸菸的對稱性。
- 兩者皆為 UCUM 時間量綱，術語伺服器可自動換算，跨機構統計不受影響。

實作時以值集 `VS_TimeUnitYearMonth`（`a`／`mo`）約束，並於 implementation note 載明
「**原始以年收集者送 `a`，不得逕行乘 12**」。

---

## 附錄 B：委員意見（2026-08-20）之逐項處置

> 委員就菸品在 FHIR 之標準表達、檳榔標準碼現況（Ontoserver SNOMED CT 2026-07-31 版展開）
> 與建議之 IG 設計提出完整方案。**內容價值高，其中 SNOMED 查證直接補上本評估 §2.4 之缺口。**
> 以下依本案既定五級框架逐項處置；另列四項須更正之技術細節。

決議狀態五級：階段性同意／附條件同意／技術方向同意但政策意義保留／暫予保留（列管）／不同意。

### B.1 處置總表

| # | 委員建議 | 決議 | 本期處置 |
|--:|:--|:--|:--|
| 1 | SNOMED 全部 betel 相關概念僅 6 個，**無 ex-chewer／never-chewer，亦無 duration／amount observable** | **階段性同意** | 直接採認，補入 §2.4；並據以更正 display（見 B.2） |
| 2 | **不可挪用菸品 LOINC（88029-4 等）記檳榔年數**，否則造成菸品暴露之假陽性 | **階段性同意** | 與本案立場一致，明文寫入 `terminology.md` |
| 3 | 檳榔必須自建 CodeSystem + ValueSet，結構鏡射菸品 | **階段性同意** | 即本評估 §2.2／§3.2 之結論，兩案獨立得出同一判斷 |
| 4 | 戒除以 **`bq-quit-date`（dateTime）** 表達 | **階段性同意** | **改進本評估 A.6**：日期是原始事實，期間是導出值（會隨檢查日改變）。惟上游與現行問卷收的是「已戒 N 年」，故兩者並存、優先 quit-date（見 B.3） |
| 5 | `bq-with-tobacco`（檳榔是否含菸草）—— IARC 對含／不含菸草分開評估 | **階段性同意** | 納入 `0..1`。理由充分且流病分析確有需要 |
| 6 | 資料來源標註 LOINC **48766-0**（自述／病歷／篩檢表） | **階段性同意** | 納入 `0..1` |
| 7 | 原始勾選保留為 coded Observation（`bq-hpa-category`），**不換算成中位數**（假精確會污染 dose-response） | **階段性同意** | 與 JOB-26 之 T-9「保留原始 coding」同一原則 |
| 8 | 狀態值集 **5 碼**（含 `unknown`） | **附條件同意** | **維持 4 碼**：`unknown` 應走 `dataAbsentReason`，見 B.4 |
| 9 | 派生 duration 用 **`valueRange`** 以支援分析查詢 | **附條件同意** | 改用 **`valueQuantity` + `comparator`**，見 B.5（`valueRange` 反而不可搜尋） |
| 10 | `bq-type`：荖花／荖葉／紅灰／白灰 | **附條件同意** | 這是**兩個軸**（添加物／石灰種類），應拆分或改 `0..*`，見 B.6 |
| 11 | CodeSystem canonical 用 `https://hpa.gov.tw/fhir/...` | **不同意（技術理由）** | 本 IG 不得在他方命名空間下定義資源——`check-dependencies.js` **D-2** 即為此設。應置於本 IG 命名空間，俟主管機關核定（M-1）後再議 |
| 12 | 改為 **panel + `hasMember`** 之多 Observation 結構 | **暫予保留（列管）** | 與 JOB-26 之 T-10 裁示衝突，且會破壞委員自己主張的「與菸品對稱」，見 B.7。**列為須 PI 裁示之選項題** |
| 13 | 「TWCore 目前公開版為 v0.3.2」 | **不同意（事實更正）** | 本案相依為 **v1.0.0**（JOB-23 實測導覽列即 v1.0.0）。所引 `tw-core-7`／`tw-core-8` invariant 是否存續於 v1.0.0，**須複核後再引用** |

### B.2 SNOMED display 之更正

委員查得 `698188003` 之詞條為 **「Chews betel quid」**（finding）。
本評估 §A.1 與《建議修訂案 v2.1》第 9 列均寫 `"Betel nut chewer"`——**屬 display 不符**，
即 JOB-01 所稽核之 `Wrong Display Name` 類別。實作時應以官方 display 為準，
並仍須通過本案既有之 `$lookup` 管線納入 `display-verification-report.csv`
（委員以 Ontoserver 查證，本案基準為 tx.fhir.org，兩者須一致才算結案）。

### B.3 戒除：日期優先，期間為輔

| 來源 | 可得資料 | 建議表達 |
|:--|:--|:--|
| 直接詢問受檢者 | 戒除日期／年月 | `bq-quit-date`，`valueDateTime`（可只到年或年月） |
| 上游 TWCR_SF `sf-BetNutChewQuit` | 「已戒 N 年」 | `cessation-duration`，`valueQuantity = N a` |
| 現行問卷 6 選 1 | 僅「已戒」 | 僅 `value = 3-quit`，兩者皆不送 |

**不得由「已戒 N 年」回推 quit-date**——與 A.6「不得逕行乘 12」同一原則（偽造精度）。

### B.4 `unknown` 不應進狀態值集

委員於其方案第四節自陳「未知者用 `dataAbsentReason`（`asked-unknown`／`not-asked`），不要用 0 年」，
此原則正確，但**同一原則亦適用於狀態**：把 `unknown` 放進狀態值集，
就是委員自己在檢視上游時所批評的「哨兵值混編於同一代碼軸」（本評估 A.5(一)）。

處置：狀態值集維持 4 碼（`0-never`／`1-occasional`／`2-daily`／`3-quit`），
不詳者送 `value.dataAbsentReason`。此舉同時使「狀態不詳」與「狀態為某值但量不詳」得以區分——
若 `unknown` 是值集成員，兩者會被壓成同一種表達。

### B.5 `valueRange` 反而不可搜尋——與委員第一節之主張衝突

委員第一節主張「duration 一律用 `valueQuantity(a)` **保證可 search**」，
第三節 C-3 又建議派生值用 `valueRange`。**兩者不能兼得。**

R4 之 `Observation` 搜尋參數 `value-quantity`，其 expression 為
`(Observation.value as Quantity) | (Observation.value as SampledData)`——**不含 `Range`**。
以 `valueRange` 表達之期間無法被 `value-quantity=gt10|http://unitsofmeasure.org|a` 命中。

> **本容器連不到 hl7.org（WebFetch 內容截斷），未能取得逐字原文。**
> 請於本機以一行複核，不採信本文陳述：
> ```bash
> grep -A2 '"expression"' ~/.fhir/packages/hl7.fhir.r4.core#4.0.1/package/SearchParameter-Observation-value-quantity.json
> ```

處置：派生值一律用 `valueQuantity` + `comparator`（`>=` / `<`），不用 `valueRange`。
此法既可搜尋，也能表達「10 年以上」「每日 20 顆以上」等開放區間，
與 A.4 對上游 `#90（≧90顆）` 之處置一致。

### B.6 `bq-type` 混了兩個軸

「荖花／荖葉／紅灰／白灰」並非互斥之四選一：

| 軸 | 取值 |
|:--|:--|
| 添加物 | 荖花／荖葉／無 |
| 石灰種類 | 紅灰／白灰 |

一個人可以「荖葉＋白灰」。以單一 `0..1` CodeableConcept 承載會強迫填報者二選一而失真——
其性質與 A.5(一) 所指之混編同型。處置：拆為兩個 component，或維持單一 component 但改 `0..*`。

### B.7 panel 化：與 T-10 裁示衝突，且會**破壞**與菸品的對稱

委員方案之立論基礎是「結構鏡射菸品 panel（LOINC 88028-6）」。但本案之實況是：

- 本指引之 `TWHASocialHistorySmokingProfile` 之 `Parent` 為 **`TWCoreSmokingStatus`**，
  即**單一 Observation**（`valueCodeableConcept` ＋ Extension），受 TW Core 母規範約束；
- JOB-26 已裁示 **T-10：維持 TW Core 繼承，不為單一議題脫離母規範**；
- 故**吸菸不能改為 panel**。若僅檳榔 panel 化，結果是**檳榔與吸菸在本指引內結構不對稱**
  ——正好與委員的立論相反。

其餘成本：`hasMember` 之多資源結構會連帶影響 UC-008／UC-009 之 transaction 封包、
Composition section 組成、完整度檢核與全部相關範例。

處置：**列管，作為須 PI 裁示之選項題**。

| 選項 | 內容 | 代價 |
|:--|:--|:--|
| **甲（建議）** | 維持單一 Observation ＋ component，**但完整採納委員之欄位清單**（with-tobacco、type、quit-date、hpa-category、資料來源） | 取得內容價值，不付結構重構成本；與吸菸對稱 |
| 乙 | 檳榔改 panel，吸菸維持 | 與吸菸不對稱，且違反委員自身立論 |
| 丙 | 兩者皆改 panel | 牴觸 T-10（脫離 TW Core 繼承），須重開該裁示 |

### B.8 委員方案中須更正之技術細節（四項）

| # | 位置 | 問題 |
|--:|:--|:--|
| 1 | 一、之表格：`8663-7` 單位標 **`{#}/d`** | `8663-7` 之 LOINC 全名為 **Cigarettes smoked current (pack per day) - Reported**，單位應為 **`{pack}/d`**。標為 `{#}/d`（支／日）即量綱不符——**與本案 JOB-18 所修正之事故完全同型**（該次是反向：以 `{pack}/d` 承載 `64218-1` 之支／日）。本案吸菸量採 `64218-1` + `/d`，與 `8663-7` 是不同碼、不同量綱，不可混用 |
| 2 | 三-D 範例：`hasMember` 掛在 `bq-duration` 上並指向 `bq-status` | `hasMember` 應掛在 **panel**（`bq-panel`）並指向各成員；成員之間不應互指。與委員自己 A 表（`bq-panel` → hasMember）矛盾 |
| 3 | 三-C-3：`valueRange` 可被 `value-quantity` search | 見 B.5 |
| 4 | 一／三：`{pack}.a`、`{quid}.a` 之量綱 | UCUM 註記**不影響可換算性**，故 `{quid}.a` 與 `a` 為同量綱。查詢 `value-quantity=gt10\|\|a` 會**同時命中嚼食年數與累積顆-年**。處置：凡量綱相同而語意不同者，搜尋**必須併帶 `code=`**；此點須寫入 implementation note，不能只靠單位區辨 |

### B.9 一項範疇提醒：現在有三套來源，不可混為一談

| 來源 | 粒度 | 與本案之關係 |
|:--|:--|:--|
| **國健署健檢上傳欄位**（原案，M-5） | 嚼檳狀態／量／月數，**無編碼** | **本案 Core 之對標對象** |
| **口腔黏膜檢查表**（委員所引，107/7 修訂） | 6 選 1 ordinal bucket | 癌症篩檢用表，**非**健檢上傳欄位 |
| **TWCR_SF**（癌症登記短表） | 逐顆／逐年列舉碼 | 現行 Profile 之綁定來源 |

委員之 `bq-hpa-category` 係對應**第二列**。納入無妨（可回溯、可稽核），
但**不得因此把口腔黏膜檢查表之欄位當成健檢上傳欄位**——後者才是 M-5 待國健署確認之標的。
三套來源之對照關係應於 `terminology.md` 以一張表明列。

### B.10 對委員之回覆重點（供對外用）

1. SNOMED 查證結果直接採認，並據以更正本案一處 display（`Betel nut chewer` → `Chews betel quid`），一併致謝。
2. 自建 CodeSystem／ValueSet、不挪用菸品 LOINC、原始勾選保留不換算——三點與本案獨立得出之結論一致，已納入。
3. 五處建議須調整：`unknown` 走 `dataAbsentReason`、派生值用 `comparator` 而非 `Range`、
   `bq-type` 拆為兩軸、canonical 不得置於 `hpa.gov.tw` 命名空間、TWCore 版本應為 v1.0.0。
4. panel 化列為須裁示之選項題，並說明其與 T-10 之衝突。
5. 委員提議產出 FSH／JSON 草稿：建議**俟選項題裁示後再行產出**，避免依甲／乙／丙不同結構重工。

---

## 附錄 C：套用時之 repo 核對結果（2026-08-20）

本附錄為**套用 v0.3.1／v0.3.2 時對 repo 現況之逐項核對**，非原評估或委員意見之內容。
可於無網路環境查證者全部實跑；需術語伺服器或 FHIR 套件快取者一律標明未驗。

### C.1 已核對屬實者

| 出處 | 主張 | 核對結果 |
|:--|:--|:--|
| §2.1 | `CS-BetelNutStatus` 於 repo 內不存在 | ✅ 全庫檢索 `BetelNutStatus` 無命中 |
| §2.1 | Profile 未約束 `value[x]`、無 status component | ✅ 全檔僅 `component[amount／year／quit]`，無任何 `* value[x]` 約束 |
| §2.2 | `CS-SmokingStatus` 四碼可對稱複製 | ✅ 實為 `#0-never`／`#1-occasional`／`#2-daily`／`#3-quit`，逐碼一致 |
| §2.2 | `ExtCessationDuration` 標題含「戒檳榔」但嚼檳 Profile 從未使用 | ✅ 標題為「戒除時間（戒菸/戒檳榔月數）擴充」；BetelNut Profile 全檔未引用 |
| §2.3 | `CS-HealthMgmtLevel` 之 provisional 格式可套用 | ✅ `^experimental = true` ＋ 描述載明 provisional 與 M-2 |
| §3.1 | 三個 component 為 `required` 綁定 | ✅ 三行皆 `(required)` |
| §3.3 | repo 內未出現 `{個}/d` | ✅ 全庫檢索無命中 |
| B.13 | TW Core 相依為 v1.0.0 而非 v0.3.2 | ✅ `sushi-config.yaml` 之 `dependencies` 為 `tw.gov.mohw.twcore: 1.0.0` |
| B.7 | 吸菸 Profile 之 `Parent` 為 TW Core 之單一 Observation | ✅ `TWHASocialHistorySmokingProfile` 之 `Parent` 為 `TWCoreSmokingStatus` |

### C.2 ✅ §2.4 之查證狀態敘述須更正——**已於 v0.3.3 就地更正**

§2.4 謂 SNOMED `698188003`「目前屬**未驗證對照**」。**此與 repo 既有紀錄不符。**
[`terminology.md`](../../input/pagecontent/terminology.md) §4.1〈已驗證之綁定 SNOMED CT 代碼〉
明列該碼為「**✅ 已驗證 2026-07-26**」，係透過 `tx.fhir.org`（SNOMED International Edition）
完成 **`$validate-code` 代碼有效性驗證**；§4.2 之免責語（「SNOMED CT 欄位**除 §4.1 所列者外**
均未經術語伺服器驗證」）亦明確將本碼排除在未驗證之外。

**精確的缺口是另一件事**：已完成者為「代碼存在且有效」，未完成者為以 `$lookup` 取官方 FSN
並逐軸確認其作為 `Observation.code` 之語意適切性——依 [CLAUDE.md](../../CLAUDE.md) §2.2，
兩者本不可互相取代。故 §2.4 之**要求成立、理由須改寫**。

**連帶：驗收標準 #6 之載具用錯。** `display-verification-report.csv` 為 **LOINC 專用**產物
（標頭 `code,ig_display,loinc_display,loinc_status,overlap,verdict,files`，324 列，無任何 SNOMED 碼）。
SNOMED 之驗證紀錄現行載於 `terminology.md` §4.1。#6 應改為「更新 §4.1 之驗證狀態欄
（由 `$validate-code` 升為含 `$lookup` 語意覆核）」，否則字面上無法滿足。

### C.3 B.2 之 display 更正已回頭套用至本文件自身

B.2 判定 `"Betel nut chewer"` 為 display 不符、應為 `"Chews betel quid"`，
但 **§A.1 之 FSH 骨架與 §A.2 之 JSON 範例仍寫著錯誤的 display**——而那兩處正是實作者
複製貼上的來源。已依 B.2 之裁定就地更正（`* code = SCT#698188003 "Chews betel quid"`）。

> 這正是 [CLAUDE.md](../../CLAUDE.md) §2.2 所指之型態：**錯誤 display 會沿著範例擴散，
> 而建置驗證不會攔**。規範文件內的範例與其自身的裁定不一致時，先壞的是範例。

**repo 內之敘述頁本來就是對的**：`terminology.md` §4.1、`datamodel.md`、`general-exam.md`、
`VS-CoreUploadSet.fsh` 均已使用 `Chews betel quid`。錯誤僅存在於本評估文件與對外之修訂案 v2.1。

### C.4 ✅ 落差：`Observation.code` 與敘述頁不符——**已於 v0.3.3 補入 §2.1.1 並列為 C-0**

§A.1 已將 `Observation.code` 改為 `SCT#698188003`，方向正確。但**現況之落差本身仍未被記錄**：

```fsh
* code = TWCRSFObsBehCS#BetelNutChewing "嚼檳榔行為"
// aliases.fsh:83  TWCRSFObsBehCS = https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem
```

而兩張敘述頁在**與吸菸相同之欄位**（吸菸列填的正是其實際 `Observation.code` `LNC#72166-2`）都宣稱：

| 頁面 | 欄位標題 | 嚼檳列內容 |
|:--|:--|:--|
| [`general-exam.md`](../../input/pagecontent/general-exam.md) | 代碼 / 術語系統 | SNOMED CT `698188003` (Chews betel quid) |
| [`datamodel.md`](../../input/pagecontent/datamodel.md) | 備註 / LOINC 代碼 | SNOMED CT `698188003` (Chews betel quid) |

即：**敘述頁說 code 是 SNOMED `698188003`，FSH 固定的卻是上游 `sf-ObserBeh#BetelNutChewing`。**
（`VS-CoreUploadSet` 之 `SCT#698188003` 不算不一致——該值集描述已自陳「不作 `Observation.code` 綁定」。）

此落差與 §2.1 之「狀態無承載位置」同型、同一支 Profile。
**處置（v0.3.3）**：已併入 §2.1.1 敘明，並於 §5 增列 **C-0**（`Observation.code` 改用
`SCT#698188003`）排在 C-1 之前——`code` 為 **1..1** 且固定為上游代碼，是三者中唯一與
「建置能否完成」直接相關者。§A.1 原已這麼寫，但 §5 措施表未列，兩處會不一致，現已一致。

### C.5 未能核對者（本容器限制）

| 項目 | 限制 |
|:--|:--|
| B.5 之 `value-quantity` expression | **未驗**。本容器無 FHIR 套件快取（`~/.fhir/packages` 僅有 `packages.ini`），且 `packages.fhir.org`／`hl7.org` 皆遭 proxy 封鎖（連線碼 000）。B.5 所附之一行指令**可於 CI 執行**——CI 之套件快取已含 `hl7.fhir.r4.core#4.0.1`。在取得該輸出之前，B.5 之結論宜標為待複核 |
| SNOMED `698188003` 之 `$lookup`（§2.4／C.2） | **未驗**。tx.fhir.org 遭封鎖 |
| 上游 `package.tgz` 之 `file://` 落點（§4.2／§4.3） | **未驗**。`mitw.dicom.org.tw` 遭封鎖（403）。惟 v0.3.0 之 CI 實測提供部分答案：run 32347196173 之 3 筆 ERROR 均落在 `StructureDefinition.text.div`，未出現任何 canonical 解析錯誤，且 SUSHI 成功解析全部 9 個 canonical——證據偏向 §4.3 之「非致命」欄，但**不等於已逐檔檢視** |
| 委員所引 `tw-core-7`／`tw-core-8` 是否存續於 v1.0.0 | **未驗**。同上，套件不可得。B.13 之保留意見成立 |

### C.6 機械面：版次調整連帶重建下載檔

`sushi-config.yaml` 版次 `0.3.1 → 0.3.2` 使 `fsh-source.zip` 過期——該 zip 之收錄範圍為
「SUSHI 的實際輸入」，含 `sushi-config.yaml`（見 `scripts/build-fsh-source-zip.js` 檔頭）。
已執行 `npm run build:assets` 重建。**凡調整版次或 `menu` 者皆須比照辦理**，
`npm run check:assets` 會攔。（v0.3.1 套用時亦踩到同一點。）
