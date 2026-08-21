# JOB-32｜委員意見：`Observation.code` 之語意角色——`698188003` 為 finding 不宜作問題碼

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（涉 Level 1 之 breaking change，且已有自相矛盾之已發佈實例） |
| **類別** | 術語／建模／對外一致性 |
| **預估** | S–M（1–1.5 人日，不含送簽時序調整） |
| **主要影響檔案** | `input/fsh/profiles/TWHA-SocialHistory.fsh`、`input/fsh/codesystems/CS-BetelNut.fsh`、`input/fsh/examples/03-social-history.fsh`、`VS-CoreUploadSet.fsh`、`general-exam.md`、`datamodel.md`、`terminology.md`、`conformance.md`、`docs/drafts/HPA-CONFIRMATION-JOB-30.md` |
| **緣起** | 2026-08-21 委員來函：主張 `SCT#698188003` 係 finding（答案），置於 `Observation.code`（問題）為 FHIR anti-pattern，建議回復綁定上游 `TWCRSFObsBehCS#BetelNutChewing` 並將 `698188003` 移入 `value` |
| **狀態** | ✅ **步驟 1、2 皆已完成**：步驟 1 之三階查證見 §4.1.1／§4.2.3（v0.8.3）；步驟 2 已於 **v0.9.0** 實作——`Observation.code` 改為 `CS-BetelNutObservable#betel-quid-chewing-status`，`698188003` 改列為肯定式狀態之 SNOMED 對應（terminology.md §6.2b-3），遷移說明見 conformance.md §8.1。⚠️ 確認單 §0 已同步更正，惟依 PI 裁示**於 v0.9.0 合併前仍不得送出** |

---

## 0. 一句話結論

**委員的技術判斷成立，且本案有比其所述更強的實證；但其處置方案不宜採用——會回復對上游之硬綁定，推翻 v0.4.0 C-0 的解耦成果。建議採第三方案：`.code` 改為本指引自訂之「狀態」問題碼。**

另須指出：委員來函所據之 repo 狀態為 **v0.4.0 之前**——其建議之第二、三項（開放 `value[x]`、建立 `VS-BetelNutStatus`）**已於 v0.4.0 完成**。

---

## 1. 逐項處置（依本案五級框架）

| # | 委員意見 | 決議 | 說明 |
|:--|:--|:--|:--|
| 1 | `698188003` 為 finding，置於 `Observation.code` 係 anti-pattern | **階段性同意** | 判斷成立。§2 提出比委員所述更直接之實證 |
| 2 | 撤銷 C-0，`.code` 回復綁定 `TWCRSFObsBehCS#BetelNutChewing` | **不同意** | 會回復對 TWCR_SF 之硬綁定，推翻 v0.4.0 之解耦成果（§3.1） |
| 3 | 修正敘述頁，消滅文件與程式碼落差 | **階段性同意（方向）** | 但更正方向相反——應改 `.code`，不是改敘述頁遷就現況（§3.2） |
| 4 | 在 Profile 新增 `valueCodeableConcept` 約束 | **已完成，無須再辦** | v0.4.0 已有 `value[x] only CodeableConcept` ＋ `from VS_BetelNutStatus (required)` |
| 5 | 建立 `VS-BetelNutStatus` 裝載 `698188003` 及其他狀態答案碼 | **部分不同意** | 值集已建立（四碼本地）；惟 SNOMED **無** never／ex-chewer 對應碼，無法承載四碼對稱（§3.3） |

---

## 2. 實證：一個已發佈的自相矛盾實例

委員以「anti-pattern」立論。本案有更直接的證據——**已發佈站台上存在一個自相矛盾的資源**：

`Observation-obs-betelnut-never.json`（v0.6.1 線上實測）：

```json
"code":  { "coding": [{ "system": "http://snomed.info/sct",
                        "code": "698188003", "display": "Chews betel quid" }] },
"valueCodeableConcept": { "coding": [{ "system": ".../CS-BetelNutStatus",
                        "code": "0-never", "display": "從未嚼食檳榔" }] }
```

**同一筆資源同時斷言「此人嚼食檳榔」與「此人從未嚼食檳榔」。**

- 這不是風格問題：以 `Observation?code=698188003` 檢索（代碼式索引的標準用法）會把**從未嚼檳者一併撈出**，
  屬**偽陽性資料風險**，直接影響 21 列上傳之下游統計與癌症登記勾稽。
- 建置 `err = 0` 仍成立——驗證器**不檢查 `code` 與 `value` 之語意相容性**。
  此與 G-3（建置驗證不檢查 display 語意）為同一類盲區。

### 2.1 與吸菸並非真的對稱

| | `.code`（問題） | 從未者之 `.value` | 是否矛盾 |
|:--|:--|:--|:--|
| 吸菸 | `LNC#72166-2` **Tobacco smoking status**（狀態問句） | `#0-never` | 否 |
| 嚼檳（現況） | `SCT#698188003` **Chews betel quid**（肯定式 finding） | `#0-never` | **是** |

委員之對稱性主張正確：**現行設計並未達成對稱**，因為吸菸的 `.code` 是「狀態」，嚼檳的 `.code` 是「答案」。

### 2.2 更正 JOB-29 §D.3a 之推論

JOB-29 §D.3a 依 `$lookup`（run 32369946585）實測結果裁定「C-0 據此成立」，理由為
`Interprets → 228272008 Health-related behavior`，「即以一個 Observation 記錄某項行為之語意形狀」。

**該推論不成立**：

- 同一份 `$lookup` 已明載 FSN 為 **`Chews betel quid (finding)`**、
  parent 為 **`409069009 Finding related to substance use`**——即位於
  **Clinical finding（`404684003`）階層**，**不在 Observable entity（`363787002`）階層**。
- `Interprets` 本身即為 **Clinical finding 之屬性**；它證明該概念「關於某行為」，
  **不使其成為問題碼**。以該屬性反推可作 `Observation.code`，是把佐證讀過頭了。

> 本項屬**本團隊自身之判斷錯誤**，非委員指謫不當。JOB-29 §D.3a 之結論句應予更正。

---

## 3. 為何不採委員之處置方案

### 3.1 回復綁定上游＝推翻 v0.4.0 之解耦成果

JOB-29 §2.1.1 對 `Observation.code` 之定性為
「該欄位為 `1..1`、固定為上游代碼，是本 Profile 對上游**最後一處硬綁定**——
不改則其餘解耦做完仍達不到『可切換級』」。

回復綁定 `TWCRSFObsBehCS#BetelNutChewing` 將：

1. 使建置重新依賴 TWCR_SF canonical 之可解析性（G-5／JOB-28 曾因上游 registry 全 404 而生之風險）；
2. 使本 Profile 之核心欄位再度由外部 IG 決定，與 JOB-29「量／年／戒除改 `Quantity`、
   上游級距碼降為可選 component」之整體方向自相矛盾；
3. `sf-ObserBeh#BetelNutChewing` 之語意是否確為 observable entity，**係委員之推定，未經查證**——
   上游為本地代碼系統，不具 SNOMED 之階層佐證。以未驗證之上游碼取代已驗證之 SNOMED 碼，
   並未改善語意，只是換一個位置放同樣的問題。

### 3.2 更正方向相反

委員建議「修改敘述頁以符合 FSH」。但敘述頁（`general-exam.md` §表、`datamodel.md`）
所寫的**才是正確的建模意圖**（嚼檳狀態，對稱於吸菸狀態）；
v0.4.0 之 C-0 是**把程式碼改成迎合一個本身就不精確的敘述**。
應更正者為 `.code` 之值，不是敘述頁的文字。

### 3.3 SNOMED 無法承載四碼對稱

JOB-29 附錄 B #1（採認委員先前以 Ontoserver 之查詢）記載：
**SNOMED 全部 betel 相關概念僅 6 個，且無 ex-chewer／never-chewer，亦無 duration／amount observable。**

> 🔴 **更正（v0.8.3）：原文寫「已確立」，下得太重。**
> 該數字係**採認委員以 Ontoserver 所作之查詢**，本 repo 從未自行複驗，
> 卻已被本節當成「SNOMED 無法承載四碼對稱」之決策理由。
> **一個當作理由用的數字，必須可被自己的紀錄支撐。**
>
> ✅ **已於 v0.8.3 複驗（§4.2.3）**：本 repo 自行以 tx.fhir.org 檢索，
> betel 命中 7 筆扣除 1 筆假陽性（細菌）為 **6 個**，與委員之數字相符；
> 6 碼之 FSN 語意標籤為 finding 1、disorder 2、substance 2、organism 1，
> **無任何 observable entity**（另以階層限定檢索 `isa/363787002` 得 0 筆，附對照組佐證）。
> 故本節結論成立，且自本版起係**自行複驗之結果**，非採認外部查詢。
> ⚠️ 惟委員原查詢是否含 inactive 概念不明，數字相符可能係巧合——**相符的是結論方向**。

故 `698188003` 至多只能表達「目前嚼食」一種狀態，**無法**構成與 `CS-SmokingStatus`
逐碼對稱之四碼答案集。將其混入 `VS-BetelNutStatus` 只會破壞既有對稱。

---

## 4. 建議方案：`.code` 改為本指引自訂之「狀態」問題碼

| 位置 | 現況 | 建議 |
|:--|:--|:--|
| `Observation.code` | `SCT#698188003`（finding） | **本指引自訂之狀態問題碼**，例如 `CS-BetelNutObservable#betel-quid-chewing-status`「嚼檳榔狀態」（命名與粒度待定案） |
| `Observation.value` | `VS-BetelNutStatus` 四碼（本地） | **不變**——對稱維持 |
| `698188003` | 佔用 `.code` | 移至其語意所屬之處：作為**肯定式狀態（`1-occasional`／`2-daily`）之 SNOMED 對應**，
於 `terminology.md` 之對照表載明；如需機器可讀，另以 `ConceptMap` 表達，**不放進 `.code`** |

**此方案同時滿足四項**：(a) 不回復上游硬綁定；(b) 消除 §2 之自相矛盾；
(c) 維持與吸菸之逐碼對稱；(d) `698188003` 仍可表達，只是放在正確位置。

### 4.1 ⚠️ 實作前必須先查證：LOINC 是否已有對應之 observable 碼

吸菸之所以能用 `LNC#72166-2`，是因為 LOINC 已備「Tobacco smoking status」此一**狀態問句碼**。
**若 LOINC 亦有檳榔／檳榔子使用狀態之對應碼，應優先採用，而非自訂本地碼**——
本地碼是 LOINC 無碼時的後備，不是首選。

- 本 IG 目前**未使用任何 LOINC 檳榔相關碼**（全庫實測）。
- 本容器封鎖 `loinc.org` 與 `tx.fhir.org`，**無法於本機查證**。
- **處置**：比照 JOB-29 之作法，以一次性 CI 步驟對 tx 執行檢索
  （`$lookup`／關鍵字檢索 betel、areca、quid），取得結果後再定案；**不得憑推定逕自訂碼**。

#### 4.1.1 查證結果（已執行）

**執行環境**：CI run 32447792978／job 96670500124，commit `8596e460`，2026-08-21T04:47Z，
tx = `https://tx.fhir.org/r4`。一次性步驟已於本次一併移除（驗收標準 §6.1 之留存要求由本節承擔）。

> ⚠️ **本節之涵蓋範圍（v0.8.3 更正）**：本輪只做了 **LOINC 的關鍵字檢索** 與
> **SNOMED `698188003` 的單碼 `$lookup`**。**未曾對 SNOMED 執行任何 `$expand` 關鍵字檢索。**
> 先前把本節記為「步驟 1（LOINC／SNOMED 查證）已完成」，是把「查了一個 SNOMED 碼」
> 誤述為「查了 SNOMED」——**一個被記成已完成、實際沒做的事，比一個明擺著的待辦更危險**，
> 因為下一個讀的人不會再去查。缺口與其處置見 §4.2。

**Q1｜LOINC 有無「嚼檳狀態」之 observable 碼？——無。**

查詢式：`$TX/ValueSet/$expand?url=http%3A%2F%2Floinc.org%2Fvs&filter=<kw>&count=40`（全 LOINC 值集）

| 關鍵字 | `expansion.total` | 回傳筆數 | 判讀 |
|:--|:--|--:|:--|
| `betel` | 未回報 | **0** | LOINC 無任何 betel 概念 |
| `areca` | 未回報 | **0** | LOINC 無任何 areca 概念 |
| `quid` | 未回報 | 40（達 `count` 上限） | **全數為 `liquid` 之子字串命中，無一與檳榔有關** |

`quid` 之 40 筆前段原文（節錄，其餘同型）：

```
    LA12294-7  Able to feed self independently but requires: (a) meal set-up; OR ... a liquid, pureed or ground meat diet.
    LP102849-9 Are you able to pour liquid from a bottle into a glass
    61658-1    Are you able to pour liquid from a bottle into a glass [PROMIS]
    LA26129-9  Clear liquid
    LA26809-6  Denaturing high-pressure liquid chromatography (DHPLC)
    76012-4    Desflurane liquid delivered during case [Volume] from Gas delivery system
    76014-0    Enflurane liquid delivered during case [Volume] from Gas delivery system
    ...
```

> ⚠️ **這 40 筆是本次查證唯一的陷阱**：只看「`quid` 命中 40 筆」會得出「LOINC 有相關碼」之相反結論。
> `quid` 為 `li-quid` 之子字串，tx 之 `filter` 係對 display 作子字串比對，非語意檢索。
> 逐筆看過 40 筆之 display 後確認**無一為檳榔概念**。

**限制**：`filter` 係對概念 display／designation 之文字比對，非語意檢索；理論上
可能存在一個不含 betel／areca／quid 任一字樣的檳榔概念。惟 LOINC 之命名慣例
必然於 display 使用該物質之英文名（比照 `Tobacco smoking status`），且三個關鍵字
已涵蓋該物質之全部通用英文名，故判定**LOINC 無對應碼**之信心足以據以定案。

**結論**：§4 之「LOINC 優先，無則自訂本地碼」條件成立於後者——**採本指引自訂之本地狀態問題碼**。

**Q2｜SNOMED `698188003` 是 finding 還是 observable entity？——finding，委員主張成立。**

查詢式：`$TX/CodeSystem/$lookup?system=http%3A%2F%2Fsnomed.info%2Fsct&code=698188003&property=parent&property=inactive`

```
  display: Chews betel quid
    inactive = undefined      ← 未回傳 inactive 屬性，即該概念未停用
    parent = 409069009        ← Finding related to substance use
```

`409069009` 位於 `404684003 Clinical finding` 階層，**不在 `363787002 Observable entity` 階層**。
此與 §2.2 依 JOB-29 之 `$lookup` 所作之更正一致，係**獨立一次查詢之複驗**，非同一份輸出之重述。

**Q3｜對照組：吸菸狀態碼 `LNC#72166-2` 之語意軸長什麼樣？**

查詢式：`$TX/CodeSystem/$lookup?system=http%3A%2F%2Floinc.org&code=72166-2&property=CLASSTYPE&property=SCALE_TYP&property=PROPERTY`

```
  display: Tobacco smoking status
    PROPERTY  = LP6813-2      （Find）
    SCALE_TYP = LP7750-5      （Ord）
    CLASSTYPE = 2             （Clinical）
```

即：**Clinical 類、Find 屬性、Ord 尺度之「狀態問句」碼**——問句在 `.code`、答案在 `.value`。
自訂之嚼檳狀態問句碼應對齊此形狀（序位尺度、臨床類、以狀態為屬性），
而非對齊 `698188003`（肯定式 finding）。

**三問合計之處置**：**LOINC 優先之可能已排除**；惟「是否需自訂本地碼」尚不能定案——
還差 SNOMED 這一邊（§4.2）。步驟 2 於 §4.2 完成前不得進入。

---

### 4.2 ⚠️ 尚未查證：SNOMED 是否有可用之 observable entity

§4.1.1 只 `$lookup` 了 `698188003` 一個碼。**「SNOMED 有沒有可用的檳榔 observable entity」
這一問從未被提出過，更沒有被回答。** 這個缺口同時卡住兩件事：

**(1) 若 SNOMED 有 observable entity，就不該自訂本地碼。**
§4 的處置階梯是「LOINC 優先 → 無則自訂」，但這個階梯本身漏了一階。
本 IG 之 `Observation.code` 現行值即為 SNOMED 碼，`VS-BetelNutStatus` 之答案碼亦與 SNOMED 對照；
若 SNOMED 備有「betel quid chewing status」之 observable entity，
它比自訂本地碼更接近吸菸之 `LNC#72166-2` 所扮演的角色。**正確的階梯是
LOINC → SNOMED observable → 自訂本地碼**，而中間那一階至今空白。

**(2) §3.3 之決策理由至今未經本 repo 驗證。**
§3.3 寫「JOB-29 附錄 B #1 已確立：SNOMED 全部 betel 相關概念僅 6 個」，
並據以推出「SNOMED 無法承載四碼對稱」。⚠️ 該數字**係採認委員以 Ontoserver 所作之查詢**，
本 repo 從未自行複驗。「已確立」三字對一個未經己方查證的外部數字而言下得太重——
與 §2.2 更正 JOB-29 §D.3a 時所犯的是同一類毛病：**把佐證讀成結論**。

**查詢式**（一次 CI 即可同時回答上列兩問）：

```
$TX/ValueSet/$expand?url=http%3A%2F%2Fsnomed.info%2Fsct%3Ffhir_vs&filter=betel&count=100
$TX/ValueSet/$expand?url=http%3A%2F%2Fsnomed.info%2Fsct%3Ffhir_vs&filter=areca&count=100
```

再對每個命中碼 `$lookup`，取其 **FSN 之語意標籤**（`(observable entity)`／`(finding)`／
`(procedure)`…）與 `parent`——語意標籤直接回答「是不是 observable entity」，
不必靠階層推導。

**判讀規則（先寫下來，避免拿到結果後才決定怎麼算）**：

| 檢索結果 | 對 §4 之影響 |
|:--|:--|
| 有 `(observable entity)` 且語意為「嚼檳狀態／頻率」 | **改採該 SNOMED 碼**，不自訂本地碼；§4 之建議方案須改寫 |
| 只有 `(finding)`／`(procedure)`，無 observable | §4 之自訂本地碼成立；§3.3 之結論成立 |
| 命中數 ≠ 6 | §3.3 之「僅 6 個」須改為本次實測值，並註明原數字之來源與差異 |

⚠️ **不得因為「反正結論大概一樣」而略過**。§3.3 已把該數字當成決策理由寫進評估，
一個當作理由用的數字就必須可被自己的紀錄支撐。

**限制（結果出來後仍需載明）**：`$expand` 預設不含 inactive 概念；
`filter` 係對 display／designation 之文字比對，非語意檢索。

#### 4.2.1 第一輪結果（commit `e814e7d9`，run 32466291783／job 96723502961，2026-08-21T09:12Z）

**⚠️ 本輪只答出一半，且是靜靜地少了一半——先講缺陷再講結果。**

逐碼 `$lookup` 只帶了 `property=parent&property=inactive`，tx 遂**未回傳 designation**，
於是 FSN 與語意標籤**一行都沒印出來**，而該步驟不會失敗、CI 全綠。
本文件所設計的判讀依據（語意標籤）等於整個落空，卻沒有任何訊號提示。

> 這與本 JOB 反覆記載的失效模式是同一個：**把「沒印出來」讀成「沒有」**。
> 若當時逕以 `parent` 反推「都不是 observable entity」，就正是 §2.2 所更正的
> 「把佐證讀成結論」——換一個位置再犯一次。故本輪**不下語意結論**，改以第二輪重問。

**已成立之部分：關鍵字檢索本身有效。** 兩式皆 `count=100`，回傳筆數 < 100，故**無截斷**。

| `filter` | 回傳 | 命中碼 |
|:--|--:|:--|
| `betel` | **7** | `25933002` Betel deposit on teeth／`75980007` Areca catechu／`227380001` Betel leaf／`227491007` Betel nut／`699276000` Betel chewer's mucosa／`698188003` Chews betel quid／**`113697002` Stenotrophomonas maltophilia** |
| `areca` | **7** | `3927007` Areca／`75980007` Areca catechu／`227491007` Betel nut／`387942003` Queen palm specific immunoglobulin E／`392348004` Queen palm specific IgE antibody measurement／`411902005` Queen palm diagnostic allergen extract／`107631008` Family Arecaceae |

union 去重 **12 碼**。

> ⚠️ `113697002 Stenotrophomonas maltophilia`（一種細菌）出現在 `betel` 命中中，
> 與 LOINC 那輪 `quid` 命中 `liquid` 是**同一類假陽性**：`filter` 是文字比對，不是語意檢索。
> 兩輪各出現一次，可見這不是偶發——**關鍵字檢索的結果一律要逐筆看過，不能只看筆數**。

**對 Q5（委員「僅 6 個」）之初步對照**：`betel` 之 7 筆扣除上開細菌 = **6**，與委員之數字相符。
惟「相符」尚不等於「已複驗」——本輪未取得 FSN，無法逐筆確認其語意類別，
亦未確認委員當時之計數口徑（是否含 `areca` 側、是否含 inactive）。**待第二輪定案。**

**對 Q4（有無 observable entity）**：⚠️ **本輪無結論。** 12 碼之 `parent` 雖已取得
（如 `698188003` → `409069009`、`227491007` → `13577000`），但以 parent 反推語意類別
即為上開之「佐證讀成結論」，故不採。

#### 4.2.2 第二輪之設計變更：改用階層限定檢索，不再解析 FSN 字串

第二輪不修補「要記得帶 designation」了事，而是**換一個不會靜默失敗的問法**：

```
$TX/ValueSet/$expand?url=…sct%3Ffhir_vs%3Disa%2F363787002&filter=betel   ← Observable entity 階層
$TX/ValueSet/$expand?url=…sct%3Ffhir_vs%3Disa%2F404684003&filter=betel   ← Clinical finding 階層（對照組）
```

- 回 0 筆 = **tx 依 SNOMED 階層算出來的「沒有」**，不是我方以 parent 反推的推論。
- **Clinical finding 作對照組是必要的**：否則「Observable entity 回 0 筆」與
  「查詢式根本壞掉」外觀完全相同。對照組回得出東西，才證明查詢式會回東西。
- 腳本另分三種輸出：`OperationOutcome`（查詢未成立，**明文標示不得解讀為 0 筆**）／
  空展開（查詢成立但無命中）／有命中。**第一輪的失敗正是這三者外觀相同。**
- 逐碼 `$lookup` 同時補帶 `property=designation`；若回應仍不含 FSN，
  腳本會印「⚠ 本次回應不含 FSN designation（非「無 FSN」，是沒要到）」——
  **少了就要吵，不能靜靜地少。**

#### 4.2.3 第二輪結果（commit `aa3135aa`，run 32467134590／job 96726011710，2026-08-21T09:25Z）

**Q4｜SNOMED 有無可用之檳榔 observable entity？——無。**

查詢式：`$TX/ValueSet/$expand?url=…sct%3Ffhir_vs%3Disa%2F<階層碼>&filter=<kw>&count=100`

| 階層 | `filter` | `expansion.total` | 判讀 |
|:--|:--|--:|:--|
| `363787002` Observable entity | `betel` | **0** | 空展開（查詢成立、無命中） |
| `363787002` Observable entity | `areca` | **0** | 同上 |
| `404684003` Clinical finding **（對照組）** | `betel` | **3** | `25933002`／`699276000`／`698188003` |
| `404684003` Clinical finding（對照組） | `areca` | 0 | — |

> **對照組是這張表的關鍵。** 若只跑 Observable entity 那兩式，「0 筆」與「查詢式壞掉」
> 外觀完全相同——正是第一輪那種靜默失敗。Clinical finding 同式回得出 3 筆，
> 證明查詢式成立、`filter` 有作用、階層限定有作用；故上面那兩個 **0 是真的 0**。

**結論**：SNOMED **無**檳榔相關之 observable entity。
§4 之處置階梯 **LOINC → SNOMED observable → 自訂本地碼** 三階全部走完，
前兩階皆為無，**自訂本地碼之方向成立**。

**Q5｜委員「SNOMED 全部 betel 概念僅 6 個」——複驗成立，且各碼語意類別已逐筆取得。**

`betel` 之 7 筆命中，扣除假陽性 `113697002 Stenotrophomonas maltophilia`（細菌，FSN 為
`(organism)`；命中係文字比對所致）後為 **6 個**，與委員之數字**完全相符**：

| 碼 | display | FSN 語意標籤 |
|:--|:--|:--|
| `698188003` | Chews betel quid | **finding** |
| `25933002` | Betel deposit on teeth | disorder |
| `699276000` | Betel chewer's mucosa | disorder |
| `227380001` | Betel leaf | substance |
| `227491007` | Betel nut | substance |
| `75980007` | Areca catechu | organism |

`areca` 側之其餘 5 碼（`3927007` Areca／`107631008` Family Arecaceae／`387942003`
Arecastrum romanzoffianum specific IgE／`392348004` 同名 IgE antibody measurement／
`411902005` 同名 diagnostic allergen extract）語意標籤分別為 organism／organism／
substance／procedure／product——**全屬檳榔科植物之過敏原檢驗家族，與嚼檳行為無關**。

**故 §3.3「SNOMED 無法承載四碼對稱」之結論成立，且自本輪起係本 repo 自行複驗之結果，
不再是採認外部查詢。** 6 個概念中無 ex-chewer／never-chewer，
亦無 duration／amount 之 observable——與 Q4 之 0 筆互相印證。

**限制（依 §4.2 之要求載明）**：

1. `$expand` 預設**不含 inactive 概念**，故上開計數為現行有效概念；
   委員原查詢之口徑（是否含 inactive）不明，兩者相符可能係巧合，惟結論方向一致。
2. `filter` 係對 display／designation 之**文字比對**，非語意檢索。兩輪各出現一次假陽性
   （LOINC 之 `liquid`／SNOMED 之 Stenotrophomonas），**命中結果一律須逐筆看過**。
3. `$lookup` 之 FSN designation 含**歷史描述**：`227491007` 回傳兩個 FSN
   （`Betal nut` 為舊拼字誤植、`Betel nut` 為現行），`107631008`／`392348004`／`411902005`
   亦各回兩個。腳本未濾除失效描述，**不影響語意標籤之判讀**（同碼之標籤一致），
   但引用 FSN 字串時須取現行者。

---

## 5. ⚠️ 兩項連動風險（委員未提及，且時效上更急）

### 5.1 這是 Level 1 之 breaking change

`TWHA-SocialHistory-BetelNut` 之登記層級為 **Level 1**（`active` ＋ `#trial-use`，JOB-30）。
變更 `Observation.code` 屬**對已宣告 trial-use 之 Level 1 profile 的破壞性變更**：

- 任何依現行 IG 開始試用、已送出 `code = 698188003` 之系統，其資料將不再符合新版；
- 現正處於「先行公布供臨床試用」之起點，**此刻是變更成本最低的時點**——
  但仍須以 minor 版（建議 **v0.7.0**）發布，並於 `conformance.md` §7 與
  〈已知限制與試用須知〉載明**遷移說明**（舊碼之處置、是否接受一段期間之並存）。
- 觸點實測：`TWHA-SocialHistory.fsh` 2、`03-social-history.fsh` **3 個範例**、
  `VS-CoreUploadSet.fsh` 1、`general-exam.md` 1、`datamodel.md` 1、`terminology.md` 3、
  `conformance.md` 1，另 `docs/drafts/HPA-CONFIRMATION-JOB-30.md` 1。

### 5.2 與 JOB-30 §3.4 送簽確認單之時序衝突（**須先處置**）

`docs/drafts/HPA-CONFIRMATION-JOB-30.md` §0 現載明：

> 嚼檳之 FHIR 技術結構（……`Observation.code` **解耦為 SNOMED CT `698188003`**）｜✅ 已落地（v0.4.0）｜**否**——不需 貴署認定

**該確認單尚未送出前必須修正**。否則將發生：送簽 → 國健署據以同意 21 項 →
本團隊隨即變更同一欄位之 `code`。這正是本案一再避免的「先取得同意、再改規範」。

**處置二擇一**：

- **(A) 先定案再送簽（建議）**：完成 §4 之查證與裁示，改妥 `.code` 後再送出確認單，
  §0 之敘述同步更新。代價是送簽延後約一週。
- **(B) 先送簽，但加註**：於 §0 明列「`Observation.code` 之問題碼另案檢討中，
  不影響本單第 1～4 項所詢之填報規格」，並將其列為第 6 項告知事項。

> 兩案均可；**不可接受的是照現狀送出**——現狀敘述已因本 JOB 而不再正確。

---

## 6. 驗收標準

1. §4.1 之 LOINC 查證**已實際執行並留存輸出**（比照 JOB-29 §D.3a 之 `$lookup` 全文格式），
   結論寫入本 JOB；**未完成查證前不得實作**。
   - ✅ **LOINC 檢索已完成（v0.8.2）**——見 §4.1.1 Q1。結論：LOINC 無對應碼。
   - ✅ **SNOMED `698188003` 單碼語意軸已驗（v0.8.2）**——見 §4.1.1 Q2。
   - ✅ **SNOMED 關鍵字與階層限定檢索已完成（v0.8.3）**——見 §4.2.3。
     結論：無 observable entity（附對照組佐證）；§3.3 所引之「僅 6 個」已自行複驗。
   - 一次性 CI 步驟已於 v0.8.3 移除；三輪之輸出全文留存於 §4.1.1、§4.2.1、§4.2.3。
2. 全庫 `698188003` 之 13 處觸點逐一處置完畢，且**不再出現於任何 `Observation.code` 位置**
   （以腳本檢查 FSH 與已發佈 JSON，不得目視）。
3. `Observation-obs-betelnut-never` 之 `code` 與 `value` **語意相容**；
   三個嚼檳範例全部重新檢視。
4. 與吸菸之對稱性以表格形式寫入 `general-exam.md` 或 `terminology.md`，
   明列 `.code`／`.value`／`.component` 三層之對應。
5. `VS-CoreUploadSet` 之嚼檳列同步更新；Level 1 逐列清單（`conformance.md` §7.2，21 列）
   之該列同步，**並重新逐列核對**。
6. `docs/drafts/HPA-CONFIRMATION-JOB-30.md` 依 §5.2 之裁定處置；**確認單未處置前不得送出**。
7. JOB-29 §D.3a 之結論句依 §2.2 更正（保留原 `$lookup` 全文，僅更正推論）。
8. 版次為 **minor**（建議 v0.7.0）並附遷移說明；`err` 仍為 0，具名類別無超出。

---

## 7. 不在本 JOB 範圍

- M-5 狀態、嚼檳系列 `experimental`、Level 1 成熟度——**待書面依據**（JOB-30 §3.4）。
- `component[informationSource]` 是否改綁 LOINC 答案清單 `LL3678-1`（JOB-29 §D.3a 註記，仍待展開）。

---

## 交給 Claude 規劃用提示

> 依 `docs/optimization/JOB-32-betelnut-observation-code-semantics.md` 執行。
> ~~**步驟 1（先做，不改任何定義）**：加一次性 CI 步驟，對 tx 檢索 LOINC 是否有檳榔／檳榔子
> 使用狀態之 observable 碼（關鍵字 betel、areca、quid；並 `$lookup` 任何命中碼之 SCALE_TYP 與 STATUS），
> 將完整輸出貼回本 JOB §4.1，**取得結果後移除該步驟**。**未完成前不得進入步驟 2。**~~
> ✅ **步驟 1 已於 v0.8.3 全部完成**（LOINC §4.1.1 Q1、`698188003` Q2、
> SNOMED 檢索 §4.2.3 Q4／Q5）。處置階梯 LOINC → SNOMED observable → 自訂本地碼
> 三階皆已查證，前兩階為無，**自訂本地碼之方向成立**；一次性 CI 步驟已移除。
> ⚠️ 自訂碼應對齊 `LNC#72166-2` 之形狀（Clinical 類／Find 屬性／Ord 尺度之狀態問句），
> **不得**對齊 `698188003`（FSN 為 `Chews betel quid (finding)`，肯定式 finding）。
> **步驟 2（依 §4 實作）**：`.code` 改為查證結果所定之問題碼（LOINC 優先，無則自訂本地碼）；
> `.value` 之 `VS-BetelNutStatus` 四碼**不動**；`698188003` 改列為肯定式狀態之 SNOMED 對應，
> 寫入 `terminology.md` 對照表，**不得放回 `.code`**；三個範例、`VS-CoreUploadSet`、
> 四個敘述頁與 `conformance.md` §7.2 之該列同步更新。
> **不得**回復綁定 `TWCRSFObsBehCS#BetelNutChewing`；
> **不得**在未處置 `docs/drafts/HPA-CONFIRMATION-JOB-30.md` 之前送出確認單；
> **不得**變更 M-5 狀態、嚼檳系列 `experimental` 或 Level 1 成熟度。
> 完成後回報：LOINC 查證全文、13 處觸點之逐處置結果、三個範例之 code/value 語意相容性檢查輸出。
