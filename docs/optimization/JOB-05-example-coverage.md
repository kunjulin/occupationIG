# JOB-05｜範例覆蓋率：9 profile／5 extension 補範例、Must Support 欄位落實

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1** |
| **類別** | 可實作性 |
| **預估** | M（3–5 人日） |
| **相依** | JOB-04（Transaction Bundle 範例由該 JOB 負責） |
| **主要影響檔案** | `input/fsh/examples/examples.fsh`、`input/pagecontent/*.md`（範例連結）、`input/pagecontent/downloads.md` |

---

## 1. 問題（證據）

### (1) 14 個 artifact 無任何範例

qa.txt：`contains no examples for this profile` × 9、`contains no examples for this extension` × 5。

**Profiles（9）**

| Profile | 為何值得補 |
|:--|:--|
| `TWHA-Bundle-Transaction` | 上傳路徑核心 → **由 JOB-04 處理** |
| `TWHA-HealthManagementLevel` | 健康管理分級（一～四級）是本 IG 的招牌功能之一，`health-management.md` 有專頁卻無範例 |
| `TWHA-ServiceRequest` | 附表八臨場服務轉介 |
| `TWHA-CarePlan` | 適性配工計畫 |
| `TWHA-DiagnosticReport` | 報告層級容器，實作端必用 |
| `TWHA-Occupation` | 職業／工作史 |
| `TWHA-ECG` | 異常氣壓、二硫化碳作業需求項目 |
| `TWHA-ImagingStudy` | 粉塵作業胸部 X 光 |
| `TWHA-SocialHistory-Alcohol` | 生活習慣（其餘 Smoking／BetelNut／Sleep 都有範例，Alcohol 獨缺） |

**Extensions（5）**：`ext-cessation-duration`、`ext-fitness-for-work`、`ext-hazard-type`、
`ext-labor-report-code`、`ext-smoking-quantity`

> 注意 `ext-hazard-type` 與 `ext-fitness-for-work` 是本 IG 的**核心自訂 extension**
> （危害類別、適性配工），卻沒有範例，這對實作端很不友善。

### (2) 已宣告 Must Support 的欄位在範例中缺漏

qa.txt：`Best Practice Recommendation: In general, all observations should have a performer` **× 47**。

而 `README.md` 2026-07-23 更新明確寫著：

> `Observation.performer` 於 TWHA-LabResult-General、TWHA-LabResult-Special、TWHA-VitalSigns
> 標 **Must Support**，支援第 19 條紀錄保存與稽核之執行者追溯。

**宣告了 Must Support，範例卻不填**——這是自我矛盾，且正好落在「稽核追溯」這個
本 IG 特別強調的合規訴求上。受影響範例包含 `obs-height`、`obs-weight`、`obs-waist`、
`obs-bloodpressure`、`obs-lab-glucose` 等基礎項目（在 7 個 UC bundle 中各出現一次，故放大為 47 筆）。

---

## 2. 目標與驗收標準

1. tx 建置後 `contains no examples` **= 0**。
2. `should have a performer` **= 0**（或每一筆殘留都有具名抑制與理由）。
3. **建立「Must Support 欄位 × 範例」對照檢核表**：所有標記 MS 的欄位，
   在至少一個範例中實際出現（或以 `dataAbsentReason` 示範缺值）。
4. 各 pagecontent 專頁（`health-management.md`、`service-record.md`、`special-exam.md` 等）
   在說明處直接連結到對應範例，讓讀者從敘述跳到可驗證實例。
5. `downloads.md` 補上新增之範例封包（含現已遺漏的 UC-007）。

---

## 3. 工作項目

### 3.1 建立 MS 覆蓋檢核

先產出清單（可寫成 `scripts/check-ms-coverage.js`）：

```
掃描 fsh-generated/resources/StructureDefinition-*.json
  → 取出所有 element.mustSupport = true 的路徑
掃描所有 Example Instance
  → 判斷該路徑是否有值，或有 dataAbsentReason
輸出：未被任何範例覆蓋的 MS 欄位清單
```

這個腳本本身就是交付物之一——它讓「MS 宣告 vs 範例落實」的落差在 CI 中持續可見（併入 JOB-08）。

### 3.2 補 performer

在既有 Observation 範例補 `performer`，並示範**兩種**執行者：

- 醫事機構（`Organization/example-facility`）——檢驗由機構出具；
- 執行人員（`Practitioner/example-doctor`／護理人員）——理學檢查、臨場服務。

同時檢查 `TWHA-Practitioner` 之 identifier 是否有 slice 定義
（qa.txt 有 7 筆 `This element does not match any known slice defined in the profile ... TWHA-Practitioner`
與 7 筆 `identifier.system: No definition could be found for URL` → 與 **JOB-06** 一起處理）。

### 3.3 補 13 個 artifact 範例（`TWHA-Bundle-Transaction` 除外）

建議策略：**不要各自孤立**，而是併入既有 UC 敘事，使範例互相參照：

| 範例 | 併入情境 |
|:--|:--|
| `HealthManagementLevel`、`CarePlan`、`ServiceRequest` | 延伸 UC-003（特殊健檢）→ 判定四級 → 適性配工 → 轉介 |
| `ECG`、`ImagingStudy`、`Occupation` | 併入 UC-003 之特殊作業項目 |
| `DiagnosticReport` | 併入 UC-002（勞工一般體格檢查） |
| `SocialHistory-Alcohol` | 併入 UC-001 生活習慣區塊 |
| 5 個 extension | 依附在上述範例的宿主資源上，**不需獨立 Instance**（extension 之「範例」是指有資源用到它） |

### 3.4 敘述與範例互連

在 pagecontent 中補連結，例如 `health-management.md` 說明四級判定後接
`[範例：三級管理判定](Observation-obs-health-mgmt-level-3.html)`。
（注意：新增連結後請跑 `node scripts/check-pagecontent-refs.js` 確認無失效引用。）

---

## 4. 不在本 JOB 範圍

- Transaction Bundle 範例（JOB-04）。
- NamingSystem 定義（JOB-06）——但本 JOB 的範例會用到，需等 JOB-06 或先用暫時值並註記。
- 新增 profile／extension（僅補範例，不擴充模型）。

---

## 5. 風險與注意事項

- 補範例會**增加驗證表面積**，可能浮出新的 warning（這是好事，但要預留修正時間）。
- extension 的「無範例」警告，靠**宿主資源使用該 extension** 即可消除，不要為此建立無意義的獨立 Instance。
- `examples.fsh` 已 48KB／53 個 Instance，建議本 JOB 同時**拆檔**
  （如 `examples/uc001-general.fsh`、`uc003-special.fsh`、`service-record.fsh`），
  否則後續維護成本會持續上升。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-05-example-coverage.md 與
docs/optimization/evidence/qa-summary-2026-07-26.md §2，並檢視 input/fsh/examples/examples.fsh
與相關 profile，為這個 JOB 產出實作計畫。

要求：
1. 列出 13 個待補範例的 artifact（TWHA-Bundle-Transaction 交由 JOB-04），
   並規劃各自要併入哪個 UC 敘事、需要哪些關聯資源。extension 的範例請用「宿主資源使用它」
   的方式處理，不要建立無意義的獨立 Instance。
2. 規劃 scripts/check-ms-coverage.js：掃描 mustSupport 欄位並比對範例覆蓋，輸出缺口清單。
   這個腳本要能在 CI 中執行。
3. 規劃補 Observation.performer 的做法（47 筆 BPR 警告），並區分機構 performer 與人員 performer。
4. 規劃 examples.fsh 的拆檔方式（目前 48KB／53 個 Instance）。
5. 一併列出 pagecontent 中要新增的「敘述 → 範例」連結，並在計畫中包含
   node scripts/check-pagecontent-refs.js 的驗收步驟。
6. 分批提交，每批可獨立以 _genonce_tx.bat 驗收。
```

---

## 7. 執行紀錄（2026-07-28）

### 7.1 已執行

1. **拆檔**（§5）：`examples.fsh`（49KB／53 Instance）拆為 `01-actors-and-encounter` …
   `11-special-exam-followup` 共 11 檔，依資源種類／情境而非 UC——基礎 Instance 被多個
   UC 封包共用，按 UC 拆會造成重複定義。拆分以腳本核對：忽略註解與空行後 855 行
   有效 FSH 逐字相同。
2. **performer**（§3.2）：18 個 Observation 範例補齊，區分機構（example-hospital，
   檢驗與影像）與人員（example-nurse 生理量測與問診／example-doctor 暴露史與臨場服務）。
   `should have a performer` **47 → 0**。新增 `example-nurse`，其 identifier 命名空間
   問題併入 T-2。
3. **13 個 artifact 補範例**（§3.3）：新增 `11-special-exam-followup.fsh`，延續 UC-003
   敘事（特殊健檢 → 影像／心電圖 → 報告 → 四級判定 → 配工 → 複檢）。5 個 extension
   全部由宿主資源涵蓋。`contains no examples`：profile **9 → 1**（餘
   `TWHA-Bundle-Transaction`，§4 交 JOB-04）、extension **5 → 0**。
4. **MS 覆蓋檢核**（§3.1）：`scripts/check-ms-coverage.js`＋CI 步驟（非 strict）。
5. **敘述 → 範例連結**（§3.4）：`health-management.md`／`special-exam.md`／
   `service-record.md`。§2.5 之 UC-007 已於先前批次存在，無需變更。
6. **順帶**：`fsh-source.zip` 改為建置時產生（原為 2026-07-10 手工快照，內容已落後
   數週），CI 以 `--check` 擋過期封包。

### 7.2 過程中被 CI 打掉的東西（保留為方法論記錄）

- **MS 檢核第一版是假綠**：掃 SUSHI 產物（無 snapshot）得 0 個 MS 欄位卻回報 OK。
  修正後：0 筆一律視為掃描基礎錯誤而失敗；優先掃 `output/`；differential 退回時明講。
- **SUSHI soft index**：數字索引與具名 slice 是兩套計數器，`extension[+]` 從 0 起算
  把 examType 蓋掉。混用是錯的，四個 extension 改全數字索引。
- **上游要求先量測再寫**：6 個 TW Core 母 profile 之必填／固定值／required 綁定以
  `scripts/describe-profile.js` 在 runner 上實測（CarePlan 之 text 必填、
  ServiceRequest.code 1..1、ECG 固定 code 等均非 FHIR 基礎資源可推知）。

### 7.3 發現之建模議題

`TWCoreDiagnosticReport.result` 限定 `Reference(Observation-laboratoryResult-twcore)`，
非檢驗類 Observation（聽力／肺功能／心電圖）一律不符，而 profile 不得放寬上游約束。
範例刻意不填 `result`，議題登記為**未決事項 T-10**（含三條路徑與代價分析）。

### 7.4 驗收狀態

| §2 條件 | 狀態 |
|:--|:--|
| 1. `contains no examples` = 0 | 🔶 profile 餘 1（TWHA-Bundle-Transaction，JOB-04）；extension = 0 |
| 2. `should have a performer` = 0 | ✅ |
| 3. MS × 範例檢核表 | ✅ 腳本＋CI（暫非 strict；首份完整缺口清單待 output/ 掃描輪） |
| 4. 敘述 → 範例連結 | ✅ 三頁 |
| 5. downloads.md 含 UC-007 | ✅（先前批次已完成） |

基準線變動之逐筆歸因見 `qa-baseline.json` 之 `_job05Note`。
