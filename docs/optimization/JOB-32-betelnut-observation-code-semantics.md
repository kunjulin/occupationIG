# JOB-32｜委員意見：`Observation.code` 之語意角色——`698188003` 為 finding 不宜作問題碼

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P0**（涉 Level 1 之 breaking change，且已有自相矛盾之已發佈實例） |
| **類別** | 術語／建模／對外一致性 |
| **預估** | S–M（1–1.5 人日，不含送簽時序調整） |
| **主要影響檔案** | `input/fsh/profiles/TWHA-SocialHistory.fsh`、`input/fsh/codesystems/CS-BetelNut.fsh`、`input/fsh/examples/03-social-history.fsh`、`VS-CoreUploadSet.fsh`、`general-exam.md`、`datamodel.md`、`terminology.md`、`conformance.md`、`docs/drafts/HPA-CONFIRMATION-JOB-30.md` |
| **緣起** | 2026-08-21 委員來函：主張 `SCT#698188003` 係 finding（答案），置於 `Observation.code`（問題）為 FHIR anti-pattern，建議回復綁定上游 `TWCRSFObsBehCS#BetelNutChewing` 並將 `698188003` 移入 `value` |
| **狀態** | 📋 **評估（v0.6.3）**，待裁示後實作 |

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

JOB-29 附錄 B #1（採認委員先前以 Ontoserver 之查詢）已確立：
**SNOMED 全部 betel 相關概念僅 6 個，且無 ex-chewer／never-chewer，亦無 duration／amount observable。**

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
- 本容器封鎖 `loinc.org` 與 `tx.fhir.org`，**無法查證**。
- **處置**：比照 JOB-29 之作法，以一次性 CI 步驟對 tx 執行檢索
  （`$lookup`／關鍵字檢索 betel、areca、quid），取得結果後再定案；**不得憑推定逕自訂碼**。

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

> 依 `docs/optimization/JOB-32-betelnut-observation-code-semantics.md` 執行，**分兩步**：
> **步驟 1（先做，不改任何定義）**：加一次性 CI 步驟，對 tx 檢索 LOINC 是否有檳榔／檳榔子
> 使用狀態之 observable 碼（關鍵字 betel、areca、quid；並 `$lookup` 任何命中碼之 SCALE_TYP 與 STATUS），
> 將完整輸出貼回本 JOB §4.1，**取得結果後移除該步驟**。**未完成前不得進入步驟 2。**
> **步驟 2（依 §4 實作）**：`.code` 改為查證結果所定之問題碼（LOINC 優先，無則自訂本地碼）；
> `.value` 之 `VS-BetelNutStatus` 四碼**不動**；`698188003` 改列為肯定式狀態之 SNOMED 對應，
> 寫入 `terminology.md` 對照表，**不得放回 `.code`**；三個範例、`VS-CoreUploadSet`、
> 四個敘述頁與 `conformance.md` §7.2 之該列同步更新。
> **不得**回復綁定 `TWCRSFObsBehCS#BetelNutChewing`；
> **不得**在未處置 `docs/drafts/HPA-CONFIRMATION-JOB-30.md` 之前送出確認單；
> **不得**變更 M-5 狀態、嚼檳系列 `experimental` 或 Level 1 成熟度。
> 完成後回報：LOINC 查證全文、13 處觸點之逐處置結果、三個範例之 code/value 語意相容性檢查輸出。
