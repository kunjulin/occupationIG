# JOB-34｜17 筆結構性 WARNING 之處置：Composition 走訪不到 ＋ ImagingStudy 值集解析不到

| 欄位 | 內容 |
|:--|:--|
| **優先序** | P1（不影響 `err = 0`，惟屬**實質結構問題**，非呈現層瑕疵） |
| **類別** | 範例正確性／文件語意／上游術語可解析性 |
| **預估** | S（診斷已完成）＋ M（實作，視裁定方向） |
| **主要影響檔案** | `input/fsh/examples/07-compositions.fsh`、`09-bundles.fsh`、`11-special-exam-followup.fsh` |
| **緣起** | JOB-31 §4 具名化時發現：89 筆 WARNING 中有 17 筆屬結構問題，先前僅由 `totals.warn` 一個數字間接看管 |
| **狀態** | 🔍 **診斷（v0.8.3）**——本文件只做判定，**未變更任何定義**；處置方向待裁示 |

---

## 0. 一句話結論

**兩組問題性質完全不同，不可合併處置。**

- **10 筆 Composition 走訪不到＝文件語意問題，且只出在一個範例（UC-003）。**
  不是 Bundle type 用錯，也不是系統性建模缺陷——七個 document Bundle 中六個完全乾淨。
- **7 筆 ImagingStudy 值集解析不到＝上游條件所致**，R4 核心把 ImagingStudy 之數個元素綁定至
  DICOM／RadLex 值集，而該等值集不隨核心套件散布。本 IG 無從修正，只能決定「留著並載明」或「不用該資源」。

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

### 2.3 ⚠️ 未解之差額：本文件算出 11，qa.txt 為 10

**兩個數字都寫在這裡，不取其一，也不調整任一方。**

- 本節之可達性分析：**11 筆**（全在 UC-003）。
- `qa.txt` 之實測：**10 筆**——`qa-baseline.json` 之具名類別
  `isn't reachable by traversing forwards from the Composition` 為 10，
  且該值在容差 0 之雙向閘門下跑綠（run 32468203194／32468946686），
  代表 qa.txt 中該字串恰好出現 10 次，不是約略值。

差額為 **1 筆**，成因尚未查明。已排除者：

- 不是漏抓參照——UC-003 之可達節點（worker／doctor／hospital／encounter-general／
  obs-hearing／obs-pulmonary／clinical-impression）全文逐一檢視過，
  其 `Reference(...)` 皆已納入圖中，無指向上表任一資源者。
- 不是 Provenance 豁免——UC-003 無 Provenance entry。

尚待查證之可能：IG Publisher 之走訪種子或豁免規則與 R4 §3.3.1 之字面不完全相同。

> **處置：先取得 qa.txt 中那 10 筆之逐筆原文再定案。**
> 在此之前，**不得**把本文件的 11 改成 10，也**不得**把基準線的 10 改成 11——
> 兩者計的可能不是同一件事（比照 CLAUDE.md §2.4「21 列 vs 20 碼」之前例：
> 數不符時先找權威來源，不要急著改文件數字，也不要急著補足差額）。

### 2.4 處置方向（待裁示）

**不是把 11 個 entry 一律塞進 section 就好。** 每一筆要先判「該不該在這份文件裡」：

| 類型 | 判斷 | 建議 |
|:--|:--|:--|
| 特殊危害作業之檢查結果（`obs-occupation`／`obs-ecg`／`example-imaging-chest-xray`／`example-diagnostic-report`） | 屬本文件標題「特殊危害健康作業檢查報告」之內容 | **補進 `section[labExams]`／新增影像 section** |
| 醫師判定（`obs-health-mgmt-level`／`example-careplan-fitness`／`example-servicerequest-followup`） | 屬總評與處置 | **補進 `section[assessment]` 或新增建議 section** |
| 生活習慣（`obs-alcohol`／`obs-smoking-former`） | 是否屬特殊危害報告之範疇，需臨床確認 | 補進生活習慣 section，**或**自 Bundle 移除 |
| `example-encounter-special` | 文件已有 `example-encounter-general`，**一份文件出現兩個 Encounter 需要理由** | 釐清 UC-003 究竟描述哪一次就醫；可能是**範例本身的內部矛盾** |
| `example-nurse` | UC-003 中**無任何資源參照它** | 若無參照即應自 Bundle 移除，而非硬塞進 section |

⚠️ 最後兩列不是清理工作，是**範例語意問題**：UC-003 同時帶了一般與特殊兩個 Encounter，
卻只在 section 引用一般那個；`example-nurse` 則是沒有任何人參照的孤兒。
處置前應先確認 UC-003 想描述的情境。

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

⚠️ **待補**：上開 3 個 canonical URL 之實際值尚未取得——閘門之形態正規化把引號內容
換成 `'X'`，日誌看不到原值。**不以記憶填入**，與 §2.3 一併於下一輪 CI 取得原文。

### 3.3 處置方向（待裁示）

| 選項 | 說明 |
|:--|:--|
| **(A) 維持現狀＋載明（建議）** | 已具名納管（`qa-baseline.json`），於〈已知限制〉載明係上游值集不可解析，非本 IG 缺陷。零風險。 |
| (B) 以 `ignoreWarnings.txt` 抑制 | ⚠️ **不建議**。CLAUDE.md 明列「以泛用字串抑制警告」為常犯錯誤；且抑制後連上游哪天修好都看不到。 |
| (C) 不使用 ImagingStudy，改以 Observation 承載影像結論 | 代價高且降低表達力——UC-004 已用 Observation 承載影像結論，UC-003 之 ImagingStudy 是**唯一**示範完整影像中繼資料者。 |

---

## 4. 驗收標準

1. §2.3 之 10 vs 11 差額**已查明**（取得 qa.txt 逐筆原文），兩數字之關係寫入本文件；
   **未查明前不得實作 §2.4**。
2. §3.2 之 3 個 canonical URL 已取得原值並寫入本文件。
3. UC-003 之情境先確認（兩個 Encounter、孤兒 `example-nurse`），再動 section。
4. 實作後 `err` 仍為 0；`isn't reachable...` 類別降至實測值並於 `qa-baseline.json` 具名說明；
   **雙向閘門會要求同批校準**，不得只改範例不改基準線。

---

## 5. 不在本 JOB 範圍

- JOB-32 步驟 2（`Observation.code` 之問題碼）。⚠️ 惟其會調整嚼檳範例，
  若同時進行需注意兩者對 `03-social-history.fsh` 之改動不要互相覆蓋。
- ImagingStudy 上游值集之取得（屬 DICOM 授權議題，非本團隊可決）。

---

## 交給 Claude 規劃用提示

> 依 `docs/optimization/JOB-34-composition-traversal-and-imagingstudy-bindings.md` 執行，**分兩步**：
> **步驟 1（先做，不改任何定義）**：加一次性 CI 步驟，自 `output/qa.txt` 印出
> ① 全部 `isn't reachable by traversing forwards from the Composition` 之逐筆原文；
> ② 全部 `binding.valueSet: A definition could not be found for Canonical URL` 之逐筆原文；
> ③ 全部 `ValueSet '...' not found` 之逐筆原文。回填 §2.3 與 §3.2，**取得結果後移除該步驟**。
> **未查明 10 vs 11 之差額前不得進入步驟 2。**
> **步驟 2**：依 §2.4 之逐列判斷處置 UC-003，先確認情境（兩個 Encounter、孤兒 nurse）再動 section；
> ImagingStudy 依 §3.3 採 (A)。
> **不得**以 `ignoreWarnings.txt` 抑制；**不得**只改範例而不同批校準 `qa-baseline.json`。
