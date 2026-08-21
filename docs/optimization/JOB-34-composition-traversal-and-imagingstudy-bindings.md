# JOB-34｜17 筆結構性 WARNING 之處置：Composition 走訪不到 ＋ ImagingStudy 值集解析不到

| 欄位 | 內容 |
|:--|:--|
| **優先序** | P1（不影響 `err = 0`，惟屬**實質結構問題**，非呈現層瑕疵） |
| **類別** | 範例正確性／文件語意／上游術語可解析性 |
| **預估** | S（診斷已完成）＋ M（實作，視裁定方向） |
| **主要影響檔案** | `input/fsh/examples/07-compositions.fsh`、`09-bundles.fsh`、`11-special-exam-followup.fsh` |
| **緣起** | JOB-31 §4 具名化時發現：89 筆 WARNING 中有 17 筆屬結構問題，先前僅由 `totals.warn` 一個數字間接看管 |
| **狀態** | ✅ **步驟 2 完成（v0.8.4 ＋ v0.8.5）**——UC-003 之不可達 entry 由 11 降為 **1**，僅動範例層（`07-compositions.fsh`、`09-bundles.fsh`），**未動任何 profile**。餘 1 筆（`obs-health-mgmt-level`）已依 PI 裁示採 (A) 於 v0.8.5 解決，**七個 Bundle 之不可達 entry 全數歸零**。同型問題另有一處（`TWHA-Composition-EmergencySummary`）未處置，見 §2.6。ImagingStudy 7 筆依 §3.4 採 (A) 維持現狀＋載明 |

---

## 0. 一句話結論

**兩組問題性質完全不同，不可合併處置。**

- **10 筆 Composition 走訪不到＝文件語意問題，且只出在一個範例（UC-003）。**
  不是 Bundle type 用錯，也不是系統性建模缺陷——七個 document Bundle 中六個完全乾淨。
- **7 筆 ImagingStudy 值集解析不到＝上游條件所致，且永遠不會消失。**
  實測原值顯示，R4 核心在此把綁定指向 `…RadLex_Playbook.aspx` 與
  `…sect_B.5.html#table_B.5-1`——**兩個都是 HTML 說明頁的網址，不是 ValueSet 資源的識別碼**，
  故沒有任何術語伺服器解得開。本 IG 無從修正，也無從等待上游修正。

---

## 1. 診斷方法

**未用推估。** 以 `input/fsh/examples/*.fsh` 建立參照圖，自各 document Bundle 之 Composition
做前向可達性走訪（BFS），即 R4 §3.3.1 之判準；Provenance 為該節明文豁免，一併排除。

> ⚠️ **診斷腳本第一版靜默失敗過一次，記錄在此以免重蹈。**
> 剝除 FSH 註解時用了 `/\/\/.*$/`，把 `fullUrl` 的 `https://` 當成註解砍掉，
> `entry` 清單全空，結果是**「0 筆不可達」而且沒有任何錯誤訊息**。
> 這與 JOB-32 §4.2 的 FSN 靜默落空是同一個失效模式：**把「沒抓到」讀成「沒有」**。
> 正解是「找不在引號內的 `//`」——`scripts/check-no-internal-refs.js` 之 `commentStart()`
> 早已為同一個坑寫過，當時沒有複用。

---

## 2. 10 筆 Composition 走訪不到

### 2.1 逐 Bundle 之可達性（實測）

| Bundle | entry 數 | 可達 | 不可達 |
|:--|--:|--:|--:|
| UC-001 | 13 | 13 | **0** |
| UC-002 | 15 | 15 | **0** |
| **UC-003** | **19** | **8** | **11** |
| UC-004 | 13 | 13 | 0 |
| UC-005 | 16 | 16 | 0 |
| UC-006 | 9 | 9 | 0 |
| UC-007 | 12 | 12 | 0 |

**七個 document Bundle 中六個完全乾淨。** 這一列事實就排除了兩個常見誤判方向：

- **不是 Bundle type 用錯。** 若 `type = #document` 是誤用，六個乾淨的 Bundle 不會存在。
- **不是 Profile 或建模缺陷。** 七個 Bundle 同用 `TWHABundleDocumentProfile`，
  同一個 Composition profile，只有一個出問題。

**故問題在 `composition-uc003` 這一個實例本身：它的 section 沒有把 Bundle 帶進來的內容歸檔。**

### 2.2 UC-003 之落差

`composition-uc003` 之 section 僅列 5 個 entry：

```
section[demographics]  → example-worker、example-encounter-general
section[physicalExams] → obs-hearing
section[labExams]      → obs-pulmonary
section[assessment]    → example-clinical-impression
```

加上 `subject`（worker）、`author`（doctor），再經 `example-encounter-general.serviceProvider`
遞移到 `example-hospital`，可達者共 8 個（含 Composition 自身）。

而 Bundle 帶了 19 個 entry。**未被任何 section 收納者如下**（本 IG 之特殊危害作業內容幾乎全在這裡）：

| 不可達 entry | 資源型別 | 這是什麼 |
|:--|:--|:--|
| `example-encounter-special` | Encounter | 特殊危害作業之就醫事件 |
| `obs-occupation` | Observation | 作業別 |
| `obs-ecg` | Observation | 心電圖 |
| `example-imaging-chest-xray` | ImagingStudy | 胸部 X 光 |
| `example-diagnostic-report` | DiagnosticReport | 檢查報告 |
| `obs-health-mgmt-level` | Observation | 健康管理分級 |
| `example-careplan-fitness` | CarePlan | 配工建議 |
| `example-servicerequest-followup` | ServiceRequest | 追蹤檢查 |
| `example-nurse` | Practitioner | 護理人員 |
| `obs-alcohol` | Observation | 飲酒 |
| `obs-smoking-former` | Observation | 吸菸（已戒） |

### 2.3 差額（11 vs 10）已查明：差在 `example-nurse`

**逐筆原文取得於** CI run 32474502859／job 96747954715（commit `10ed28b0`，PR #37）。
qa.txt 之 10 筆，其標的依序為：

```
example-encounter-special、obs-occupation、obs-ecg、example-imaging-chest-xray、
example-diagnostic-report、obs-health-mgmt-level、example-careplan-fitness、
example-servicerequest-followup、obs-alcohol、obs-smoking-former
```

即 §2.2 表列 11 筆**減去 `example-nurse`**。差額歸因完成，無餘數。

**兩個數字都是對的，計的不是同一件事：**

| | 計什麼 |
|:--|:--|
| 本文件之 **11** | 自 Composition 前向走訪**實際到不了**的 entry（R4 §3.3.1 之字面） |
| qa.txt 之 **10** | IG Publisher **實際發出警告**的 entry |

`example-nurse`（Practitioner）確實走訪不到——這點本文件與 qa.txt 並不衝突，
**IG Publisher 只是沒有為它發警告**。

> ⚠️ **不發警告的機制尚未確立，故不寫成結論。**
> 觀察到的事實只有一條：11 筆中唯一未被警告者是唯一的 Practitioner。
> 可能之解釋（**皆未驗證，不得引用**）：驗證器對 Practitioner 這類「參與者」型資源另有豁免；
> 或其可達性判定另含本文件未模擬之路徑。
> **差額已歸因到具體那一筆，成因未明**——兩者要分開講，前者足以支撐 §2.4 之處置，後者不影響處置。

> 📌 **本文件之 11 不改成 10。** `example-nurse` 是 UC-003 中無任何資源參照的孤兒，
> 它「沒被警告」不代表「沒問題」——反而正是 §2.4 判定應自 Bundle 移除的那一筆。
> 若為了對齊 qa.txt 而把它從清單刪掉，就會把唯一一筆**真正該刪的資源**藏起來。
> 這與 CLAUDE.md §2.4「21 列 vs 20 碼」同型：**數不符時查明兩者各計什麼，不是把數字湊齊。**

### 2.4 處置（已實作，v0.8.4）

PI 已裁示兩項情境問題（2026-08-21）：
**UC-003 是特殊危害檢查，就醫事件應為 `example-encounter-special`**；
**`example-nurse` 是「飲酒病史」Observation 的執行者**。據此實作：

| 項目 | 處置 | 落點 |
|:--|:--|:--|
| `example-encounter-special` | 改列入 demographics，取代 general | `section[demographics].entry[1]` |
| `example-encounter-general` | **自 UC-003 封包移除**（非本情境之就醫事件，留著也走訪不到） | entry 19 → 18 |
| `obs-occupation` | 作業經歷 | `section[workHistory]`（新增） |
| `obs-alcohol`／`obs-smoking-former` | 生活習慣 | `section[habits]`（新增） |
| `obs-ecg`／`example-imaging-chest-xray`／`example-diagnostic-report` | 檢驗與影像檢查 | `section[labExams].entry[1..3]` |
| `example-careplan-fitness`／`example-servicerequest-followup` | 醫師總評與建議 | `section[assessment].entry[1..2]` |
| `example-nurse` | **不需個別處置**——`obs-alcohol.performer` 本就指向它，`obs-alcohol` 進 section 後即遞移可達 | — |

⚠️ `workHistory`（作業經歷）與 `habits`（生活習慣）**不是新增的切片**，
`TWHA-Composition` 早已定義，只是 `composition-uc003` 沒用到。

**實測結果**：UC-003 不可達 **11 → 1**（`node scripts/check-document-reachability.js`），
其餘六個 Bundle 維持 0。

### 2.5 ⚠️ 剩下 1 筆卡在兩個 profile 對同一個 section 的認定不一致

`obs-health-mgmt-level`（健康管理分級，`InstanceOf: TWHAHealthManagementLevelProfile`，
基底為 Observation）**放不進任何 section**：

```fsh
// TWHA-Composition.fsh
* section[assessment].code  = http://loinc.org#51848-0
* section[assessment].title = "醫師總評、分級與建議"
* section[assessment].entry only Reference(ClinicalImpression or CarePlan or ServiceRequest or Procedure)
```

section 標題寫著**「分級」**，型別卻不收承載分級的那個資源。

**這不是本文件的推論，本 IG 內部已有直接前例——而且是同一個 LOINC section：**

```fsh
// TWHA-Composition-EmployerSummary.fsh
* section[healthManagement].code  = http://loinc.org#51848-0      ← 同一個碼
* section[healthManagement].title = "健康管理分級與適性配工建議"
* section[healthManagement].entry only Reference(TWHAHealthManagementLevelProfile
                                                 or TWHAClinicalImpressionProfile
                                                 or TWHACarePlanProfile)
```

兩個 profile 的 section 切片判別子都是 `code` 之 pattern，故 `51848-0` 在 FHIR 眼中
**就是同一個 section**。雇主端明文允許 `TWHAHealthManagementLevelProfile`，主文件卻不允許——
**同一個 section 在本 IG 內有兩套認定。**

| 選項 | 說明 | 風險 |
|:--|:--|:--|
| **(A) 把 `TWHAHealthManagementLevelProfile` 加入 `TWHA-Composition.section[assessment].entry`** | 使兩個 profile 對 `51848-0` 的認定一致。屬**放寬**，既有實例全數仍合法，非破壞性變更 | 低，惟屬已發佈 profile 之定義變更 |
| (B) 自 UC-003 移除 `obs-health-mgmt-level` | 分級已由 `example-clinical-impression.extension[healthMgmtLevel]` 表達 | 低，但等於承認主文件不放分級 Observation |
| (C) 維持現狀，保留 1 筆 WARNING | 不動任何定義 | 把已查明的建模不一致留在原地 |

✅ **PI 已裁示採 (A)（2026-08-21），已於 v0.8.5 實作。**
加入者為 **profile 而非裸 `Observation`**，故本節仍不允許任意 Observation 進入。
`composition-uc003` 之 assessment 依標題次序排列：總評 → 分級 → 建議。
實測全部七個 document Bundle 之不可達 entry **歸零**。

### 2.6 ⚠️ 同型問題另有一處，本版未處置（新發現）

`51848-0` 在本 IG 實際上有**三個** profile 使用，型別認定三種：

| profile | section | entry 允許型別 |
|:--|:--|:--|
| `TWHA-Composition` | `assessment` | ClinicalImpression／CarePlan／ServiceRequest／Procedure ＋ **分級 profile（v0.8.5 加入）** |
| `TWHA-Composition-EmployerSummary` | `healthManagement` | **分級 profile**／總評 profile／配工 profile |
| `TWHA-Composition-EmergencySummary` | `assessment` | ClinicalImpression／CarePlan **（無分級 profile）** |

⚠️ 第三列之問題比第一列更明確：**該 profile 自身的 `Description` 就寫著**
「供急診醫師快速掌握其……以及**健康管理分級**」、「將……總評分級以 `section.entry` 引用」，
但其 `section[assessment].entry` 並不收承載分級的資源——**文件承諾與型別約束互相矛盾**。

**本版未處置**，理由有二：(1) PI 之裁示範圍為 `TWHA-Composition`；
(2) 目前無任何實例把分級放進該摘要，故不產生 WARNING、無 QA 訊號。
**惟這正是它值得單獨登記的原因**——沒有訊號的矛盾不會自己浮出來。
處置方式與 (A) 相同（一行），待裁示。


---

## 3. 7 筆 ImagingStudy 值集解析不到

### 3.1 組成（實測）

| 筆數 | 樣態 | 位置 |
|--:|:--|:--|
| 3 | `StructureDefinition.snapshot.element[N].binding.valueSet: A definition could not be found for Canonical URL 'X'` | `StructureDefinition/TWHA-ImagingStudy` |
| 2 | `ImagingStudy.procedureCode[N]: ValueSet 'X' not found` | `ImagingStudy/example-imaging-chest-xray`（獨立 1 ＋ 封裝於 Bundle 1） |
| 2 | `series[N].instance[N].sopClass: ValueSet 'X' not found` | 同上 |

### 3.2 定性：上游條件，非本 IG 之缺陷

`TWHAImagingStudyProfile` 對 ImagingStudy **只加了一條約束**：

```fsh
Profile: TWHAImagingStudyProfile
Parent: TWCoreImagingStudy
* subject only Reference(TWHAPatientProfile)
```

它沒有新增任何綁定。那 3 筆 `binding.valueSet` 出自 **R4 核心 ImagingStudy 自身之綁定**，
經 snapshot 展開後落在本 Profile 上；相應之值集屬 DICOM／RadLex 體系，
**不隨 FHIR R4 核心套件散布**，故解析不到。範例那 4 筆是同一批值集在驗證
`procedureCode` 與 `sopClass` 時再度解析失敗（獨立資源與 Bundle 內各一份）。

範例所用之值本身是合法的 DICOM 標識：

```fsh
* procedureCode.text = "胸部X光攝影（後前位）"
* series[0].instance[0].sopClass = urn:ietf:rfc:3986#urn:oid:1.2.840.10008.5.1.4.1.1.1.1
```

（`1.2.840.10008.5.1.4.1.1.1.1` 為 DICOM Digital X-Ray Image Storage – For Presentation。）

### 3.3 解析不到的 canonical URL（實測原值）

同一輪 CI（run 32474502859／job 96747954715）取得之原文：

| 位置 | canonical URL |
|:--|:--|
| `TWHA-ImagingStudy` snapshot `element[22]`、`element[26]` | `http://www.rsna.org/RadLex_Playbook.aspx` |
| `TWHA-ImagingStudy` snapshot `element[60]` | `http://dicom.nema.org/medical/dicom/current/output/chtml/part04/sect_B.5.html#table_B.5-1` |
| 範例 `procedureCode[0]`（獨立 ＋ Bundle 內各 1） | `http://www.rsna.org/RadLex_Playbook.aspx` |
| 範例 `series[0].instance[0].sopClass`（獨立 ＋ Bundle 內各 1） | `http://dicom.nema.org/…#table_B.5-1` |

> **原值比預期更有決定性：這兩個 canonical 根本不是 ValueSet 資源的識別碼，
> 而是網頁文件的網址**——一個 `.aspx`、一個 `.html#table_B.5-1`。
>
> 這把 §3.2 的定性從「值集未隨套件散布」收緊為更確定的一句：
> **R4 核心在此處把綁定指向了 HTML 說明頁，因此沒有任何術語伺服器解得開，
> 現在解不開、將來也解不開。** 不是暫時性的套件缺漏，也不是 tx 的問題。
>
> 這使 §3.4 之選項 (A) 從「目前最務實」變成「唯一正確」：等不到上游修好，
> 因為沒有東西可修。

### 3.4 處置方向（待裁示）

| 選項 | 說明 |
|:--|:--|
| **(A) 維持現狀＋載明（建議，且依 §3.3 為唯一正確選項）** | 已具名納管（`qa-baseline.json`），於〈已知限制〉載明：R4 核心把此處綁定指向 HTML 說明頁而非 ValueSet 資源，故永遠無法解析，非本 IG 缺陷。零風險。 |
| (B) 以 `ignoreWarnings.txt` 抑制 | ⚠️ **不建議**。CLAUDE.md 明列「以泛用字串抑制警告」為常犯錯誤。⚠️ 原本的理由（「抑制後連上游哪天修好都看不到」）依 §3.3 已不成立——它不會被修好；但反對理由改為更強的一條：**抑制會讓範例日後真的用錯值集時也一併靜音**。 |
| (C) 不使用 ImagingStudy，改以 Observation 承載影像結論 | 代價高且降低表達力——UC-004 已用 Observation 承載影像結論，UC-003 之 ImagingStudy 是**唯一**示範完整影像中繼資料者。 |

---

## 4. 驗收標準

1. ✅ **已完成**：§2.3 之 10 vs 11 差額已查明——差在 `example-nurse`，兩數字各計什麼已寫明。
   （⚠️ 不發警告之**機制**仍未確立，已標為未驗證；不影響 §2.4 之處置。）
2. ✅ **已完成**：§3.3 之 canonical URL 原值已取得——`RadLex_Playbook.aspx` 與
   DICOM `sect_B.5.html#table_B.5-1`，**兩者皆為網頁網址而非 ValueSet 資源**。
3. ✅ **已完成**：UC-003 之情境已由 PI 裁示（特殊危害檢查／護理師為飲酒 Observation 之執行者），
   據此改 section 與封包。
4. ✅ **已完成**：`err` 維持 0；基準線已依實測校準並具名歸因（`qa-baseline.json` 之 `_v084Note`）：
   `warn 89 → 80`、`info 464 → 462`、`isn't reachable 10 → 1`、
   `There are no valid display names 246 → 244`。**兩個降幅逐筆歸因、無餘數**——
   -9 全來自走訪不到之減少，-2 全來自 UC-003 移除 `example-encounter-general` 後
   該 Encounter 在此情境下之兩筆 zh-TW 顯示名提示消失（該 Encounter 本身未刪，
   UC-001／002／004／005 仍使用，故其同型訊息保留）。
   ⚠️ 本版刻意不預填基準線，首輪 CI 判「未校準」而紅屬預期——降幅一律以實測為準。

---

## 5. 不在本 JOB 範圍

- JOB-32 步驟 2（`Observation.code` 之問題碼）。⚠️ 惟其會調整嚼檳範例，
  若同時進行需注意兩者對 `03-social-history.fsh` 之改動不要互相覆蓋。
- ImagingStudy 上游值集之取得（屬 DICOM 授權議題，非本團隊可決）。

---

## 交給 Claude 規劃用提示

> 依 `docs/optimization/JOB-34-composition-traversal-and-imagingstudy-bindings.md` 執行，**分兩步**：
> ~~**步驟 1（先做，不改任何定義）**：加一次性 CI 步驟印出三類逐筆原文。~~
> ✅ 步驟 1 已於 v0.8.3 完成（§2.3、§3.3），一次性步驟已移除。
> **步驟 2**：依 §2.4 之逐列判斷處置 UC-003，先確認情境（兩個 Encounter、孤兒 nurse）再動 section；
> ImagingStudy 依 §3.4 採 (A)——§3.3 之原值顯示該綁定指向 HTML 說明頁，永遠解不開，故 (A) 非權宜而是唯一正確。
> **不得**以 `ignoreWarnings.txt` 抑制；**不得**只改範例而不同批校準 `qa-baseline.json`。
