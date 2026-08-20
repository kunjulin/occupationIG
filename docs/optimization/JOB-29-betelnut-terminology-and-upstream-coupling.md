# JOB-29｜嚼檳榔術語之權責界線，與 TWCR_SF 相依之耦合度調整

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（涉及對外文件與指引之實質落差，且為 JOB-28 之後續風險） |
| **類別** | 術語／相依治理／對外一致性 |
| **預估** | M（2–3 人日，不含上游協調） |
| **相依** | 須在 **v0.3.0（JOB-28）之後**套用；本 JOB 不推翻 JOB-28 |
| **主要影響檔案** | `input/fsh/profiles/TWHA-SocialHistory.fsh`、`input/fsh/codesystems/`（新增）、`input/fsh/extensions/ext-cessation-duration.fsh`、`input/fsh/examples/03-social-history.fsh`、`scripts/check-dependencies.js`、`input/pagecontent/terminology.md`、`input/pagecontent/open-issues.md`、對外之《勞工健檢上傳欄位建議修訂案》 |
| **緣起** | 2026-08-20：(1) 國民健康署上傳欄位文件之嚼檳榔欄位無編碼，詢問是否比照吸菸自訂值集；(2) 取得 TWCR_SF 上游 `package.tgz` 後，發現封裝內含 `file://C:\Users\Lily\TWCR_SF\output` 之開發者本機路徑 |
| **狀態** | 📋 **評估（v0.3.1）——待核准後於下一版實作** |

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

修訂案 v2.1 第 9 列之「查證」欄標為「**— 無國際碼**」——該欄僅陳述 LOINC 無對應碼，
**並未表示 SNOMED `698188003` 已通過本案之逐碼驗證程序**。以 JOB-01／JOB-26（T-3 處置規則）
之標準衡量，該碼目前屬「未驗證對照」，**不得逕標為正式建議 mapping**。

實作前須以既有管線（CI 之 `$lookup`／`$validate-code`）確認其 FSN、狀態與語意軸，
並將結果納入 `display-verification-report.csv`。本容器無法連線術語伺服器，**不預先宣稱結果**。

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
| **C-1** | 量／年／戒除之綁定主軸改 `Quantity`（§3.2） | 核心資料不再需要解析上游 canonical |
| **C-2** | 上游級距碼降為可選 component，綁定強度 `required` → `extensible` | 上游若長期不可用，可於一版內移除該 component 而**不影響任何核心資料** |
| **C-3** | 保留 `fhir.TWCRSF` 正式相依（不推翻 JOB-28） | 對照關係與癌症登記勾稽能力維持 |
| **C-4** | 新增閘門 **D-5**：檢查已取得之套件內不含 `file:` scheme 之 URL，且所有 canonical 為 `https://` | 上游封裝瑕疵不會靜默進入本案產出 |
| **C-5** | 行政面：由工研院轉知上游維護方封裝瑕疵（附證據），並請其上架 registry | 屬協調事項，**本案不等待** |

C-2 是整個路徑的重點：**把單點相依從「建置阻斷級」降為「可切換級」**。
做完之後，上游是否修復、何時上架，都不再影響本案時程。

C-4 依本案既定工程慣例（JOB-20／21／22／23），須自帶負向測試，CI 中先跑負向再跑實檢。

---

## 6. 驗收標準

1. `CS-BetelNutStatus`／`VS-BetelNutStatus` 建立，canonical 位於本指引命名空間，
   `experimental = true` 且描述載明 provisional 與待確認事項編號；
2. `TWHASocialHistoryBetelNutProfile` 具備狀態承載位置（`value[x]` 綁定 `VS-BetelNutStatus`），
   修訂案第 9 列之建模說明與指引一致；
3. 量／年／戒除三者以 `Quantity` 為主軸，UCUM 分別為 `{quid}/d`、`a`、`mo`，
   且通過本案 UCUM 稽核腳本；
4. 上游級距碼之綁定強度為 `extensible`，且移除該 component 不使建置失敗（以實驗開關實測）；
5. `check-dependencies.js` 新增 D-5 並含負向測試，CI 綠燈；
6. SNOMED `698188003` 完成 `$lookup` 驗證並納入 `display-verification-report.csv`；
   若驗證未過，依 T-3 處置規則改列 informative 對照區；
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
* code = SCT#698188003 "Betel nut chewer"          // ⚠ 待 $lookup 驗證（§2.4）
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
    "code": "698188003", "display": "Betel nut chewer" }] },
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
