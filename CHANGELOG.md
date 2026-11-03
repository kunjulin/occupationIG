# CHANGELOG

臺灣勞工健康檢查交換實作指引（TWHA IG）之變更紀錄，**新的寫在最上面**。

> ⚠️ 本指引為工業技術研究院委託研擬中之草案，尚未定稿。下列各版皆為審閱用草案。

本檔是**索引**，每版一到三行，供快速查找「哪一版改了什麼」。有出入時以下列來源為準：

| 來源 | 內容 | 權威性 |
|:--|:--|:--|
| [`package-list.json`](package-list.json) | 逐版之 `desc`（完整說明） | **權威**，發佈流程讀取 |
| [`README.md` 版本與更新記錄](README.md#版本與更新記錄-update-history) | v0.8.1 以前逐版明細（含閘門結果、實測數字） | 明細 |
| [`input/pagecontent/history.md`](input/pagecontent/history.md) | 對外網站之版本歷程頁，以次版本歸納 | 對外摘要 |

標記：🔴 **破壞性變更**｜🟠 **規範性變更**（非破壞）｜📄 僅新增評估文件，未變更任何定義｜
括號內為將該版加入 `package-list.json` 之 commit，可用 `git show <代碼>` 查看。

## 怎麼補這份檔

每次在 `package-list.json` 新增版次時，同一個 commit 在最上面加一條：

```
### x.y.z（YYYY-MM-DD）
- 一句話說做了什麼；破壞性／規範性變更要標記。`commit 代碼`
```

⚠️ 數字（碼數、組數、件數）只寫該版**實測當下**之值，並註明是哪一個數
（例：preferred 主碼數 ≠ `$expand` 成員代碼數）。溯源（「依某某決議」）須逐項對回來源文件，不可整批套用同一出處。

---

## 發佈狀態

- 版控最新為 **0.10.4**；線上站台仍為 **0.10.3**，須另以 Actions 手動觸發 `publish`（見 [`docs/RELEASE.md`](docs/RELEASE.md)）。

---

## 0.10.x — 溯源更正與術語判準換基準

### 0.10.4（2026-11-03）
- UCUM 對照檔（`extended-ucum-reference.csv`）更正兩筆：`5810-7` `{Spec grav}`→`{Spec_grav}`（annotation 不得含空白）；`59261-8` `%`→`mmol/mol`（PROPERTY 為 SFr，`%` 屬 `4548-4` MFr）。`terminology.md` 單位表同步；值集、ConceptMap、範例未動。（[#56](https://github.com/kunjulin/occupationIG/pull/56)）`fe957c1`
- 建置模板釘版：`ig.ini` 改為 `fhir2.base.template#0.1.0-twha.20260730`（repo 內快照 `ig-template/`，CI 預置至套件快取）；起因為上游 `#current` 新增 19 個字串鍵致翻譯閘門紅燈。QA 各類別與 0.10.3 相同。（[#56](https://github.com/kunjulin/occupationIG/pull/56)、[#57](https://github.com/kunjulin/occupationIG/pull/57)）`a225691`
- 另含 0.10.3 之後、升版前合併之文件修正：`downloads.md`／`quickstart.md` 移除或更新寫死之版號與過期 QA 數字，`history.md` 補齊沿革（[#53](https://github.com/kunjulin/occupationIG/pull/53)）`3284c80`；記錄 v0.10.3 線上複驗（僅 `CLAUDE.md`，[#52](https://github.com/kunjulin/occupationIG/pull/52)）`8a6bb60`。

### 0.10.3（2026-08-22）
- `ConceptMap.equivalence` 判準由 comment 散文改為**六軸實測**（COMPONENT／PROPERTY／TIME／SYSTEM／SCALE／METHOD），散文判準退役。（[#51](https://github.com/kunjulin/occupationIG/pull/51)）`8223e3c`
- 據此更正 MCV 一組（comment 誤稱 calculation，該碼 METHOD 實為未指定）：分佈改為 `wider` 14／`narrower` 7／`relatedto` 28。

### 0.10.2（2026-08-22）
- 第二批委員決議納入四個 acceptable 碼（TG 12 小時空腹 1 碼、尿蛋白定性 3 碼）；`VS-CoreDataset` 22→26 碼，ConceptMap 45→49 組。（[#49](https://github.com/kunjulin/occupationIG/pull/49)）`29053f1`
- 明確區分值集層（容許跨尺度並存）與歸一層（`wider`／`narrower` 須有語意包含關係）。各列 preferred 主碼未變。

### 0.10.1（2026-08-22）
- 依 2026-08-22 委員決議擴充 acceptable 碼（腰圍超音波法、TG 空腹條件），ConceptMap 41→45 組。（[#47](https://github.com/kunjulin/occupationIG/pull/47)）`557e36b`
- 對外下載之跨術語對照檔清出 7 筆錯碼與 2 列 preferred／acceptable 顛倒；閘門擴大範圍並新增方向檢查。
- 溯源再精確化：三項實質差異之依據逐項切分（僅第②項出自專家會議臨時動議）；更正「展開碼數」為「preferred 主碼數」。

### 0.10.0（2026-08-22）
- **溯源更正**：五處「經主管機關答覆確認」不實（國健署未曾函復），改記為本案專家會議之技術決議。（[#45](https://github.com/kunjulin/occupationIG/pull/45)、[#46](https://github.com/kunjulin/occupationIG/pull/46)）`3c58732`
- BMI 由 `VS-CoreUploadSet` 明文 `exclude`（回到原案）；第 11 列「嚼檳月數」明訂為嚼食持續期間；嚼檳量單位維持 `{quid}/d`。新增未決事項 M-12。

## 0.9.x — 嚼檳狀態代碼之 Level 1 破壞性變更

### 0.9.3（2026-08-21）
- 修復資源總覽頁 9 個分類標題全空白（補 `stringsArtifacts.json` 之 `zh-TW`）；翻譯閘門改為掃描模板所有字串檔。（[#42](https://github.com/kunjulin/occupationIG/pull/42)）`8d9fe57`

### 0.9.2（2026-08-21）
- 嚼檳 CodeSystem 6 處 `definition` 改為純文字（markdown 記號不算繪）；新增 `check:plaintext`；`check:gov`／`check:intref` 補接 CI。（[#40](https://github.com/kunjulin/occupationIG/pull/40)）`991877c`

### 0.9.1（2026-08-21）
- 更正 `conformance.md` §7.4 成熟度件數；新增 G-5，件數改由登記表動態比對。（[#39](https://github.com/kunjulin/occupationIG/pull/39)）`bb328cd`

### 0.9.0（2026-08-21）🔴
- 嚼檳 `Observation.code` 由 `SCT#698188003`（肯定式 finding）改為 `CS-BetelNutObservable#betel-quid-chewing-status`，結構對齊 `LNC#72166-2`；遷移說明見 `conformance.md` §8。上傳欄位（`30907X-1`）本身未變。（[#38](https://github.com/kunjulin/occupationIG/pull/38)）`bf13f78`
- 🟠 急診友善摘要之章節型別補收健康管理分級。

## 0.8.x — 對外試用版乾淨化

### 0.8.6（2026-08-21）
- 移除下載專區於 `zh-TW` 層失效之附表十試算表連結；新增資產連結閘門 `check-download-links.js`。（[#38](https://github.com/kunjulin/occupationIG/pull/38)）`b8bff0c`

### 0.8.5（2026-08-21）🟠
- 醫師總評章節（`LNC#51848-0`）允許健康管理分級 Profile，兩個 Composition Profile 認定一致（放寬，非破壞）。（[#37](https://github.com/kunjulin/occupationIG/pull/37)）`b83f452`

### 0.8.4（2026-08-21）
- 特殊危害檢查報告範例 Bundle 之章節歸檔補正，走訪不到項目 11→1。（[#37](https://github.com/kunjulin/occupationIG/pull/37)）`e1b305d`

### 0.8.3（2026-08-21）
- 23 筆未具名 WARNING 逐類納入 `qa-baseline.json` 監控，未具名歸零。（[#36](https://github.com/kunjulin/occupationIG/pull/36)）`2617cc0`

### 0.8.2（2026-08-21）
- 補 `ConceptMap.title`；QA 閘門改為雙向並加未具名 WARNING 歸因報表。（[#36](https://github.com/kunjulin/occupationIG/pull/36)）`7eb8bcb`

### 0.8.1（2026-08-21）
- 加回 `open-issues.html` 相容層殼頁（27 個原錨點對照列），不列入導覽。（[#35](https://github.com/kunjulin/occupationIG/pull/35)）`f2a6fe5`

### 0.8.0（2026-08-21）🔴
- `open-issues.html` 自網站移除，內容移至 `docs/known-limitations.md`；散落警語收斂為首頁〈使用前須知〉六條。（[#35](https://github.com/kunjulin/occupationIG/pull/35)）`d212074`

## 0.7.x — 權責登記範圍擴大

### 0.7.4（2026-08-21）
- 對外產出清除內部工作痕跡（`JOB-n` 等）109→0；新增 `check-no-internal-refs.js`。（[#35](https://github.com/kunjulin/occupationIG/pull/35)）`87866d4`

### 0.7.3（2026-08-21）📄
- 對外試用版乾淨化之評估與計畫（JOB-33）。（[#35](https://github.com/kunjulin/occupationIG/pull/35)）`cbf3263`

### 0.7.2（2026-08-21）📄
- 委員意見：`Observation.code` 之語意角色評估（JOB-32）。（[#35](https://github.com/kunjulin/occupationIG/pull/35)）`62b21ab`

### 0.7.1（2026-08-21）
- 修正 `TWHealthCheckLaboratoryMap` 之權責標籤未進產出。（[#34](https://github.com/kunjulin/occupationIG/pull/34)）`9b37a94`

### 0.7.0（2026-08-21）🟠
- `ConceptMap` 與 `NamingSystem` 納入權責登記（JOB-31 §5，採 (A)）。（[#33](https://github.com/kunjulin/occupationIG/pull/33)）`bfdf4ba`

## 0.6.x — 嚼檳三項落地與成熟度標示

### 0.6.2（2026-08-20）📄
- v0.6.1 線上站台獨立複驗（JOB-31）。（[#32](https://github.com/kunjulin/occupationIG/pull/32)）`673ef85`

### 0.6.1（2026-08-20）
- 修正 6 個跨行 `Description` 之標記失效（v0.6.0 宣稱 50 件、實際上線 44 件）。（[#31](https://github.com/kunjulin/occupationIG/pull/31)）`285a47f`

### 0.6.0（2026-08-20）🟠
- 嚼檳三項落地；勞工區塊機器可讀成熟度標示。（[#30](https://github.com/kunjulin/occupationIG/pull/30)）`0c96858`
- ⚠️ 本版原記「依主管機關答覆」，**該敘述不實，已於 0.10.0 更正**；實際依據為本案專家會議之技術決議。

## 0.5.x — 合規層級與權責界線

### 0.5.0（2026-08-20）🟠
- 新增 Level 1（Core 上傳合規）／Level 2（勞工健檢涵蓋）、權責標籤與呈現分層（JOB-30 A＋B 部）。（[#29](https://github.com/kunjulin/occupationIG/pull/29)）`6034a76`

## 0.4.x — 嚼檳 Profile 解耦

### 0.4.1（2026-08-20）📄
- 先行公布供臨床試用之整備評估（JOB-30）。`b6dd1f7`

### 0.4.0（2026-08-20）🟠
- 嚼檳 Profile 移除對上游之最後一處硬綁定，補上承載狀態之 `value[x]`（JOB-29 C-0＋路徑甲）。（[#28](https://github.com/kunjulin/occupationIG/pull/28)）`433f22e`

## 0.3.x — 未決事項收斂與相依治理

### 0.3.3（2026-08-20）📄
- JOB-29 評估之內部一致性修訂。`bfb3bc4`

### 0.3.2（2026-08-20）📄
- 委員意見之逐項處置（JOB-29 附錄 B）。`acb5501`

### 0.3.1（2026-08-20）📄
- 嚼檳術語之權責界線與上游耦合度評估（JOB-29）。`4236596`

### 0.3.0（2026-08-20）
- 屬本團隊職權之六項技術事項逕行定案；存取控制範疇界定；TWCR_SF 本地 stub 改為正式相依。`31fb115`

## 0.2.x — 術語稽核與發布組態

### 0.2.5（2026-08-17）
- 頁面標題中文化（`sushi-config.yaml` 之 `pages:`）＋ pages／pagecontent 雙向對應閘門。`20011f0`

### 0.2.4（2026-08-17）
- 補齊模板 `stringsBase.json` 之 `zh-TW`，修復全站空白標籤。`6eddc4d`

### 0.2.3（2026-08-16）
- 導覽列比照 TW Core IG v1.0.0 調整（頂層 9→8 項、新增〈目錄〉〈範例〉）＋ `check-menu` 閘門。`450889d`

### 0.2.2（2026-08-16）📄
- 導覽列比照 TW Core IG 之差異分析。`16110fd`

### 0.2.1（2026-08-05）
- 新增〈快速入門〉導覽頁。`cb5069a`

### 0.2.0（2026-07-29）
- STU1 第二次審查稿：術語稽核（Wrong Display Name 133→0）、Transaction Bundle＋`$submit`、附表九／十 RequiredSet、安全與隱私章節、CI／tx 建置與 QA 閘門。`ae6e9b9`

## 0.1.0（2026-07-26）
- STU1 草案：依《勞工健康保護規則》115.06.26 修正同步，並合併四方委員意見。`ae6e9b9`

更早之更新（2026-07-09～07-23）見 [`README.md`](README.md#版本與更新記錄-update-history) 末段。
