# JOB-07｜情境資料集值集（附表九／附表十 RequiredSet）落地

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（委員最可能追問的內容缺口） |
| **類別** | 內容／法規對應 |
| **預估** | L（1–2 人週） |
| **相依** | 建議在 JOB-01 完成後進行（避免把錯碼寫進法定必驗值集） |
| **主要影響檔案** | 新增 `input/fsh/valuesets/VS-Appendix9-RequiredSet.fsh`、`VS-Appendix10-RequiredSet.fsh`（或按危害類別分檔）、`input/pagecontent/general-exam.md`、`special-exam.md`、`index.md`、`scripts/check-pagecontent-refs.js` |

---

## 1. 問題（證據）

這是 IG **自己承認**的缺口。`index.md` 之「三個不同層次的資料集概念」表格：

| 層次 | 對應產物 |
|:---|:---|
| ① IG scope | `VS-CoreDataset` ∪ `VS-ExtendedDataset` |
| ② Core upload set | `VS-CoreUploadSet` |
| **③ 情境資料集（法定情境需求）** | **本期尚未以值集形式完整定義**（列為 backlog：`VS-Appendix9/10-RequiredSet`） |

`general-exam.md:81` 同樣標註 backlog，`scripts/check-pagecontent-refs.js` 也因此回報
`VS-Appendix9-RequiredSet`、`VS-Appendix9` 為未解析引用。

### 為什麼這是 P1 而不是可延後

IG 花了整段篇幅強調「① ≠ ② ≠ ③」，並警告：

> 亦**不得**以「某項目不在 Core（②）」推論該項目不重要或非 Must Support

但**③ 完全沒有機器可讀的形式**。結果是：

1. IG 建立了一個概念框架，卻只實作了其中 2/3，論述完整度與交付物不一致；
2. 實作端無法用程式檢查「這位噪音作業勞工的檢查項目是否齊備」——
   而這正是勞工健檢資料交換最直接的應用價值（法定完整性稽核）；
3. 附表十已由 32 項增為 **35 項**（115.06.26 修正），沒有值集就只能靠人工比對表格。

現行 `VS-OccHealthCheck-Required` 只是「第一期法定必驗項目**草案子集**（一般必驗 + 噪音/鉛/粉塵三模組）」，
並非依情境切分的完整集合。

---

## 2. 目標與驗收標準

1. 新增 `VS-Appendix9-RequiredSet`：附表九一般體格／健康檢查之法定應執行項目，
   逐項對應到本 IG 代碼；無法以 LOINC 表達者（如「既往病史」「作業經歷」）明確標示承載方式。
2. 新增附表十情境值集。建議結構（plan 時確認）：
   - `VS-Appendix10-RequiredSet`：grouping 值集；
   - 依 12 危害家族各一個子值集（如 `VS-Appendix10-Noise-RequiredSet`），
     並以 `ConceptMap-Appendix10ToHazardType` 既有對映串接 35 項具名作業 → 家族 → 值集。
3. `special-exam.md` 之 35 項涵蓋表新增一欄，連結至對應值集。
4. `index.md` 的三層表格中，③ 欄位由「本期尚未定義」改為實際連結。
5. `scripts/check-pagecontent-refs.js` 不再回報這些引用為未解析
   （同時修正該腳本，使其能辨識文件中明示的 `backlog:` 標記，避免假警報——見 JOB-12）。
6. 提供**至少一個**「完整性稽核」示範：如何用這些值集判定某次健檢是否符合法定項目
   （可用 `Group` 或文件說明 + FHIRPath 範例）。

---

## 3. 工作項目

### 3.1 來源資料

repo 根目錄已有四份法規附表 PDF，是本 JOB 的權威來源：

```
附表九  一般體格檢查、健康檢查項目表.PDF
附表十  特殊體格檢查、健康檢查項目表.PDF
附表十一 勞工一般體格及健康檢查紀錄.PDF
附表八  勞工健康服務執行紀錄表.PDF
```

`input/assets/Appendix10-to-HazardType.xlsx`（或已產出於發佈站者）與
`CS-Appendix10Operation`（35 項具名作業）、`ConceptMap-Appendix10ToHazardType` 已存在，
本 JOB 是**把對映補完為值集**，不是從零開始。

### 3.2 處理「無法以 LOINC 表達」的法定項目

附表九／十包含非檢驗項目（既往病史、家族病史、作業經歷、自覺症狀、身體各系統理學檢查）。
這些不應硬塞 LOINC，而應：

- 對應到既有 profile（`TWHA-PhysicalExam`、`TWHA-WorkExposure`、`TWHA-Questionnaire*`）；
- 在值集說明或對照表中標明「以 X profile 承載，非以值集成員表達」。

**這是本 JOB 最容易做錯的地方**：把值集當成「法定項目清單」會造成非檢驗項目被迫用不合適的代碼。
建議產出兩種東西：機器可讀的**檢驗項目值集** ＋ 文件化的**完整項目對照表**（含承載方式欄）。

### 3.3 與 `VS-OccHealthCheck-Required` 的關係

現有 `VS-OccHealthCheck-Required` 定位為「第一期草案子集」。本 JOB 需明確處理：

- 是取代它，還是保留為「第一期實作範圍」而新增的 RequiredSet 為「法定完整需求」？
- 若兩者並存，`terminology.md` 必須說清楚差異，否則會出現第四層混淆
  （IG 已花力氣區分三層，不要再多加一層歧義）。

### 3.4 過渡期聲明

附表十第 33–35 項（苯乙烯／甲苯／二甲苯）為新增類別，repo 已有過渡期聲明（commit `ebaa196`）。
新值集需沿用同一過渡期語彙，不要另創說法。

---

## 4. 不在本 JOB 範圍

- 法規解釋之爭議（例如某項目是否適用於特定作業）——遇到就登記 JOB-13 未決事項。
- 成人預防保健之情境值集（國健署服務項目，可另立 JOB）。
- 代碼正確性（JOB-01）。

---

## 5. 風險與注意事項

- **務必在 JOB-01 之後做**。若把 `14390-9`（實為透析液澱粉酶）這類錯碼寫進「法定必驗值集」，
  錯誤的權威性會更高，也更難撤回。
- 附表十 35 項 × 12 家族的對映已存在，但值集顆粒度是新決策：太細（35 個值集）維護困難，
  太粗（1 個值集）失去稽核價值。建議以 12 家族為主體、35 項透過 ConceptMap 導引。
- 讀 PDF 時逐項核對，不要憑既有 markdown 表格轉抄——既有表格本身就是待驗證的產物。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-07-scenario-required-valuesets.md，並檢視
input/pagecontent/general-exam.md、special-exam.md、index.md（三層資料集表格）、
input/fsh/valuesets/VS-OccHealthCheck-Required.fsh、
input/fsh/codesystems/CS-Appendix10Operation.fsh 與 ConceptMap-Appendix10ToHazardType.fsh，
為這個 JOB 產出實作計畫。

要求：
1. 以 repo 根目錄的「附表九」「附表十」PDF 為權威來源（請實際讀取 PDF，不要只轉抄現有 markdown 表格）。
2. 提出值集顆粒度方案並比較取捨：附表十要做成 1 個、12 個（危害家族）、還是 35 個（具名作業）？
   建議方案要說明如何用既有 ConceptMap 串接 35 項 → 家族 → 值集。
3. 明確區分「可用 LOINC 表達的檢驗項目」與「須以 profile 承載的非檢驗項目
   （病史、作業經歷、理學檢查、自覺症狀）」，後者不要硬塞代碼，改以對照表的「承載方式」欄處理。
4. 說明新值集與現有 VS-OccHealthCheck-Required 的關係（取代還是並存），
   並確保不會在 index.md 已建立的「三層資料集」框架上再增加歧義。
5. 規劃一個「法定完整性稽核」示範（如何判定某次健檢項目是否齊備）。
6. 提醒：本 JOB 必須在 JOB-01（術語稽核）之後執行，並在計畫中說明如何確認引用的代碼已通過稽核。
7. 一併規劃 scripts/check-pagecontent-refs.js 的假警報修正。
```
</content>
