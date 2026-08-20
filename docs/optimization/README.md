# TWHA IG 優化工作範圍（Job Scope）總覽

> 建立日期：2026-07-26
> 審閱對象：<https://kunjulin.github.io/occupationIG/en/index.html>（gh-pages `9fd146f`）
> 對應原始碼：`main` / `claude/occupational-health-ig-review-6vx9gn` @ `7169521`
> 建置版本：IG Publisher 2.2.11、`mohw.tw.twha#0.1.0`、FHIR 4.0.1
> 建置結果：**err = 0, warn = 208, info = 257**

---

## 0. 這份文件怎麼用

本目錄把「發佈網站審閱後發現的優化點」拆成 **13 個彼此可獨立執行的 JOB**。
每個 JOB 檔案結尾都有一段「交給 Claude 規劃用提示」，可**直接複製貼給 Claude**，
Claude 會針對該 JOB 產出 plan 後再實作，避免一次塞太多範圍導致計畫失焦。

建議節奏：

```
一個 JOB → 一次 Claude 對話 → 一個 plan → 一個 commit（或一個 PR）
```

- 先做 **P0**（送審／對外發佈的阻斷級問題），再做 P1、P2。
- `JOB-08`（CI）建議提早做，因為之後每個 JOB 都需要可重現的 tx 建置來驗收。
- 證據明細在 [`evidence/qa-summary-2026-07-26.md`](evidence/qa-summary-2026-07-26.md)。

---

## 1. 審閱總結

這份 IG 的**內容深度已相當高**——法規對照（附表八／九／十）、三層資料集概念界定（① IG scope ≠ ② Core upload set ≠ ③ 情境資料集）、
治理原則、驗證結果之意義界定、已知盲區自我揭露，這些都超過一般國內 IG 草案的水準，
也已經自行抓出並移除 16 個語意錯誤代碼。

因此以下優化點**不是「品質不好」，而是「從研製中草案推進到可送審／可實作」還缺的最後一段**。
問題集中在四個面向：

| 面向 | 現況 | 影響 |
|:--|:--|:--|
| **A. 術語正確性尚未收斂** | tx 建置回報 **133 筆 Wrong Display Name**、6 筆 LOINC 狀態為 DISCOURAGED。其中至少 8 個代碼的官方語意與 IG 標示**根本不同**（例如 `14390-9` 標為 ALT，官方為「透析液澱粉酶」） | 這正是 README 自己警告的盲區：`err = 0` 但代碼是錯的。送審後被抽查會直接動搖信任 |
| **B. 發佈組態未正式化** | 網站內容為繁體中文，但 `<html lang="en">`、URL 落在 `/en/`、根目錄只是 JS 轉址殘骸；publish box 顯示 **"Local Development build"**，且指向不存在的 `history.html`。缺 `package-list.json` | 委員／實作者第一眼看到的就是「這像是還沒發佈的本機測試版」 |
| **C. 可實作性缺口** | **上傳路徑（Transaction Bundle）零範例**——UC-001~007 全是 document bundle；`$submit` OperationDefinition 無 description、無回傳定義；CapabilityStatement 無 searchParam。9 個 profile／5 個 extension 無範例 | 主管機關平台端拿到這份 IG，無法照著做上傳介接 |
| **D. 工程可重現性** | qa.txt 顯示建置來源為 `C:\repo\occupationIG-main`（Windows 本機），無 CI；`ig.ini` 用 `template#current` 未釘版；6 個值集掛在 `no-validate` | 網站與原始碼可能不同步，且無人能重現同一份輸出 |

另有智財合規一項需特別注意：本 IG 大量引用 LOINC 與 SNOMED CT，但 QA 明確回報
`ip-statements.xhtml` **未被納入任何頁面**，即網站目前**沒有顯示 LOINC/SNOMED 授權聲明**（見 JOB-03）。

---

## 2. JOB 清單與優先序

| JOB | 標題 | 優先序 | 類別 | 預估 | 相依 | 狀態 |
|:--|:--|:--|:--|:--|:--|:--|
| [JOB-01](JOB-01-terminology-code-audit.md) | 術語稽核：133 筆 display 不符之錯碼分流與修正 | **P0** | 術語 | L（1–2 週） | JOB-08 較佳 | ✅ **已完成：133 → 0**（達 README §3 驗收條件）。臨床回覆（2026-07-27）後分批消化：批1 -3、批2 -8、Q4-1 裁示 -1、批3 -11；2 項 LOINC 缺口（精子→`51479-4`；EBV VCA IgA 保留 `9633-9`）已裁示。見 [T-1](../../input/pagecontent/open-issues.md)、`_job01Batch{1,2,3}Note` |
| [JOB-02](JOB-02-publication-language-and-versioning.md) | 發佈語言（zh-TW）、網址結構與版本歷程正式化 | **P0** | 發佈 | S（1–2 天） | — | ✅ **已執行**（待建置驗證） |
| [JOB-03](JOB-03-ip-and-required-fragments.md) | LOINC/SNOMED 授權聲明與四個必要 HTML fragment 補納 | **P0** | 合規 | S（1 天） | — | ✅ **已執行**（待建置驗證） |
| [JOB-04](JOB-04-upload-path-conformance.md) | 上傳路徑（Transaction Bundle ＋ `$submit`）契約與端到端範例 | **P1** | 可實作性 | M（3–5 天） | — | ✅ **已執行**（transaction／batch 語意屬 M-9，待平台端定案） |
| [JOB-05](JOB-05-example-coverage.md) | 範例覆蓋率：9 profile／5 extension 補範例、performer 補齊 | **P1** | 可實作性 | M（3–5 天） | JOB-04 | ✅ **已執行**（餘 Bundle-Transaction 範例屬 JOB-04；T-10 為新發現之建模議題） |
| [JOB-06](JOB-06-identifier-namingsystem.md) | 識別碼命名系統（NamingSystem）定義與範例對齊 | **P1** | 術語／治理 | S（1–2 天） | — | 🔶 **第一階段**（本 IG 自有者已定義；其餘待 TW Core 盤點） |
| [JOB-07](JOB-07-scenario-required-valuesets.md) | 情境資料集值集（附表九／附表十 RequiredSet）落地 | **P1** | 內容 | L（1–2 週） | JOB-01 | 🔶 **附表九完整＋附表十四家族**；未審八家族待 T-1（M-8） |
| [JOB-08](JOB-08-ci-cd-reproducible-build.md) | CI/CD：可重現 tx 建置、QA 閘門與自動發佈 | **P1** | 工程 | M（2–4 天） | — | ✅ **已執行**（建置＋閘門＋發佈；發佈預設為手動觸發） |
| [JOB-09](JOB-09-build-config-hardening.md) | 建置組態固化：釘版、`pin-canonicals`、`no-validate` 正當性 | **P2** | 工程 | S（1–2 天） | JOB-08 | 🔶 **部分完成**（釘版與 OID 待外部條件） |
| [JOB-10](JOB-10-twcrsf-dependency-governance.md) | TWCR_SF mock 依賴治理（勿在他方命名空間下發佈代碼） | **P2** | 治理 | S（1–2 天） | — | ✅ **已執行**（路徑 B：明確降級為本地 stub；正式套件待 G-5） |
| [JOB-11](JOB-11-security-privacy-depth.md) | 安全與隱私章節深化（可驗證化，非僅原則宣示） | **P2** | 內容 | M（3–5 天） | — | ✅ **已執行**（雇主版 Composition 落實欄位級隔離；Consent／AuditEvent／salt 政策屬 M-10） |
| [JOB-12](JOB-12-navigation-and-repo-hygiene.md) | 資訊架構與 repo 整理（孤兒頁、下載區、文件歸檔、CLAUDE.md） | **P2** | 文件 | S（1 天） | — | ✅ **已執行** |
| [JOB-13](JOB-13-open-issues-register.md) | 未決事項登記簿（M-5／M-6／G-2／provisional canonical 集中揭露） | **P2** | 治理 | S（1 天） | — | ✅ **已執行** |
| [JOB-14](JOB-14-preferred-acceptable-recovery.md) | 尿沉渣面積碼回收為 Acceptable（preferred／acceptable 雙軌之範圍修正） | **P0** | 術語／可實作性 | S（1 人日） | JOB-01 | ✅ **已執行**（9 個面積碼回收為 acceptable＋ConceptMap `element[28–36]` #relatedto 歸一；CI 實測 err 0、Wrong Display Name 0 維持、VS-ExtendedDataset 288 碼、ConceptMap 37 element） |
| [JOB-15](JOB-15-version-bump-0.2.0.md) | 指引進版 0.1.0 → 0.2.0（STU1 草案，補齊版本歷程） | **P0** | 發布／治理 | S（0.5 人日） | JOB-01～14 | ✅ **已執行**（sushi-config `version: 0.2.0`、package-list 新增 0.2.0 條目（0.1.0 保留）、history.md 補 0.2.0 摘要；純版本標記未動任何 FSH，CI 實測 err 0／WDN 0／VS-ExtendedDataset 288 維持） |
| [JOB-16](JOB-16-egfr-formula-provenance.md) | eGFR 估算公式沿革之法規依據補註（T-5 結案） | **P1** | 術語治理／文件 | S（0.5 人日） | — | ✅ **已執行**（補國健署 115.01.15 國健慢病字第1150660003號函依據與公式沿革於 VS 註解／terminology §6.2a／adult-preventive-care／open-issues T-11／ConceptMap comment；純註記，未動代碼，VS 維持 288、ConceptMap 37、element[8] equivalence 維持 #relatedto） |
| [JOB-17](JOB-17-download-assets-drift.md) | 下載區試算表資產漂移之修正（`loinc-valuesets.xlsx`／`snomed-mappings.xlsx` 改為建置時自值集產生＋CI 攔阻） | **P0** | 工程／發布正確性 | S（0.5–1 人日） | — | ✅ **已執行**（新增 `scripts/build-download-xlsx.js`，二 xlsx 由值集／`snomed-loinc-mappings.csv` 位元組可重現產生並納入 `check:assets`；Core 21／Extended 288、eGFR 98979-8、11 個已移除語意錯碼全數不再出現；含負向測試：改值集未重建則 CI 失敗；未動任何值集內容） |
| [JOB-18](JOB-18-vitalsigns-codes-and-bp-panel.md) | 生理量測方法特化碼補列、血壓 panel 汰換與吸菸量單位更正 | **P1** | 術語正確性 | S（0.5–1 人日） | — | ✅ **已執行**（身高/體重補 `3137-7`/`3141-9` acceptable＋ConceptMap `element[37/38]` #narrower；血壓 `55284-4`→`85354-9` 四處同步；`64218-1` 單位更正為 `/d`；DISCOURAGED 6→5；CI 實測 err 0／WDN 0／ConceptMap 39／VS-ExtendedDataset 288） |
| [JOB-19](JOB-19-ucum-snomed-asset-audit.md) | 術語資產稽核與閘門化（UCUM 單位、SNOMED 對映） | **P0** | 術語正確性／工程 | M（3–5 人日） | JOB-17／18 | ✅ **已執行**（**線 A**：`snomed-loinc-mappings.csv` 逐筆覆核，視力 `79880-1`→`98497-1`、WHR `73708-3`→無碼哨符，33 列 `snomed_status` 全改 `待覆核`；新增 `scripts/check-asset-consistency.js`（PR #19）。**線 B**：新增 `scripts/audit-ucum.js`，以 CI 為 `$lookup` oracle 對 271 列取官方 `EXAMPLE_UCUM_UNITS` 四態比對——相符 197／不符 0／LOINC 未提供 74／待人工判定 0，`verification` 欄去「需覆核」；CI 閘門 `--gate --max 0`；`terminology.md` 更新為代碼驗證五要件。均不動值集，`VS-ExtendedDataset` 維持 288） |
| [JOB-20](JOB-20-t12-scale-parts-resolution.md) | T-12 結案：Scale 未對映之三個 part 代碼查證與稽核範圍調整（`LP32888-7`=Doc／`LP436123-6`=SemiQn／`LP7747-1`=-） | **P1** | 術語正確性／工程 | S（0.5 人日） | JOB-19 及其補充 | ✅ **已執行**（三碼依 loinc.org 查證補入 `SCALE_BY_LP`；納入判準擴為 `{Qn, OrdQn, SemiQn}`，10 筆 SemiQn 官方單位經 tx 取回並全數相符；`--max-unknown` 29→**0**，T-12 結案；新增分類失效自我檢查 `--min-inscope-ratio 0.5`（實測 241/320＝75.3%），使「全判不適用卻閘門全綠」之空過自動現形。CI 實測 err 0／WDN 0／VS-ExtendedDataset 288／Scale 未知 0／未列於對照檔 0／不符 0） |
| [JOB-21](JOB-21-download-xlsx-tier-and-normalization.md) | 下載用值集試算表補列層級與歸一資訊，並修正 12 筆層級標示不一致（含 `2888-6` 語意矛盾待裁示） | **P1** | 可實作性／術語正確性 | S–M（1–2 人日） | JOB-17／19／20／**22** | ✅ **已執行**（xlsx 擴為 7 欄（層級／歸一至／equivalence／備註）＋新增 `ConceptMap 歸一` 分頁 41 組，`relatedto` 加「需換算，數值不可直接比較」警示；層級以 ConceptMap 為準，新增**層級標示一致性閘門**（對稱差 0，含 3 項負向測試）；A 類 3 組補歸一（`57735-3`→`5804-0` #wider、`63557-3`→`5196-1` #relatedto、`19876-2`→`19868-9` #wider）、B 類 7 組補 `// Acceptable:` 標籤；依裁示移除 `2888-6`→`5804-0`（定量/定性為獨立醫令）。CI 實測 err 0／WDN 0／VS 288／element **41**／層級不一致 0） |
| [JOB-22](JOB-22-conceptmap-equivalence-direction.md) | ConceptMap equivalence 方向修正（16 組與 R4 target-relative 定義相反）、5 組 comment 覆核與 R4／R5 對照表 | **P0** | 術語正確性／規範符合性 | S（1 人日） | 無（JOB-21 §3.2 相依於本 JOB） | ✅ **已執行**（新增 `scripts/fix-conceptmap-equivalence.js`：12 組以腳本翻轉、6 組個別修 comment＋重判（`[3]` 依裁示與 `[6]` 一致改 `relatedto`）；`terminology.md` §3.2.1 新增 R4／R5 對照表並揭露舊版方向錯誤；ConceptMap Description 之 source-relative 判準（根因）一併更正；一致性檢查納入 `check:assets`（含負向測試）。CI 實測 err 0／WDN 0／VS 288／element 39／違反 0；分佈 `wider` 10／`narrower` 6／`relatedto` 23／`equivalent` 0） |
| [JOB-23](JOB-23-navigation-alignment-twcore.md) | 導覽列（頁籤內容與順序）比照 TW Core IG v1.0.0：五項結構性差異＋`artifacts.html#1~#4` 位移型錨點缺陷 | **P1**（錨點項屬 P0 性質） | 資訊架構／發佈呈現 | S–M（1.5–2 人日） | 無（JOB-12 §1(1) 由本 JOB 之 R-5 承接） | ✅ **已執行（v0.2.3）**：menu 頂層 9→**8** 項、改文件類型導向、標籤純中文；新增〈目錄〉〈範例〉入口、〈安全性〉升頂層；**移除 4 條 `artifacts.html#1~#4` 位移型錨點**改指策展頁；新增策展頁 2 張（41 profile／11 extension；67 範例實例）；新增 `scripts/check-menu.js`（R-1~R-5＋負向自我測試）並掛入 CI，對舊 menu 實跑可攔下全部 4 條錨點。**既有頁面檔名全數未變更**。A-7 模板釘版移列 JOB-09；tx 建置與 `qa-baseline.json` 上調已於 CI 完成（err 0；cannot be resolved 2313→2317，即兩張新頁各 +2） |
| [JOB-24](JOB-24-zh-tw-template-strings.md) | 全站 chrome 標籤空白：模板 `stringsBase.json` 只含 `en`，本 IG 宣告 `zh-TW` 致取字回傳空字串 | **P1** | 發佈呈現／國際化 | S（0.5–1 人日） | 無（早於 JOB-23，非其引入） | ✅ **已執行（v0.2.4）**：新增 `input/data/stringsBase.json`（en 逐字複製 ＋ zh-TW 126 鍵），本機建置實測頁尾恢復為「連結: 目錄 | QA 報告」，profile 頁〈正式網址〉〈機器可讀名稱〉等亦回復；新增 `scripts/check-translations.js`（T-1~T-5＋四組負向自我測試）掛入 CI，**須排在 IG Publisher 之後**方能與解壓後之模板比對。已排除 JOB-23 為肇因（gh-pages 前一版站台頁尾逐字相同） |
| [JOB-25](JOB-25-page-titles-zh-tw.md) | 頁面標題中文化：全站 `<title>`／H1／麵包屑仍為英文（SUSHI 依檔名推導） | **P1** | 發佈呈現／i18n | S（0.5 人日） | JOB-23／24 | ✅ **已執行（v0.2.5）**：新增 `pages:` 逐頁指定中文標題（19 頁），排序與導覽列一致故同時修正 toc.html 章節順序；`check-menu.js` 新增 R-6a~R-6e 雙向對應閘門（漏列會使該頁靜默消失）＋4 組負向測試，合計 7 組。緣起：2026-08-14 工研院李建儒經理「格式對標 TW Core IG、提案要求一致性」。N-1 已於線上 v0.2.5 確認生效（應用說明／範例／安全與個資保護／未決事項…）；**N-2 結案**——toc.html 標題經逐層回溯確定寫死於 SUSHI `dist/ig/IGExporter.js`，`pages:` 僅填子節點、根節點 title 不被覆寫，無法自 `sushi-config.yaml` 設定，屬上游限制不予 workaround |
| [JOB-26](JOB-26-open-issues-convergence.md) | 未決事項收斂：A 類 6 項逕行定案＋保存期限移出範疇（M-6／M-7） | **P1** | 治理／文件 | M（2–3 人日） | T-1（已結案） | ✅ **已執行（v0.3.0）**：待決 18→**8 項**，其中僅 2 項涉主管機關擬公告之欄位內容。M-8 分期落地規則／M-9 預設 `transaction`／T-3 SNOMED 處置規則／T-9 未結構化交換規則／T-10 維持 TW Core 繼承；T-6 逐項補列理由並分【A】1 項長期保留（`VS-UnfitDiseases` 引用整個 ICD-10-CM）、【B】5 項待 CI `drop-no-validate` 實測後移除。P-1 筆數依實測由 12 更正為 10 |
| [JOB-27](JOB-27-access-control-scope.md) | 存取控制範疇界定：IG 不規定「誰可以看病歷」；M-10 改名為稽核與同意機制之選型 | **P1** | 治理／安全 | S（0.5 人日） | 無 | ✅ **已執行（v0.3.0）**：`security.md` 新增 §0 範疇聲明並引 TW Core〈安全性〉頁原文為據；以 (a) 存取控制（不在範圍）／(b) 交換內容組成（本指引職責、已定案且由 closed slicing 可驗證）兩層區分。與 JOB-26 之 M-6 同一原則 |
| [JOB-28](JOB-28-twcrsf-upstream-dependency.md) | TWCR_SF 改為正式相依：刪 9 個本地 stub、清 9 條 `special-url`，G-5 結案 | **P1** | 相依治理／術語 | S–M（1 人日） | 無（推翻 JOB-10 路徑 B 之前提） | ✅ **已執行（v0.3.0）**：上游站台 mitw.dicom.org.tw v0.1.1 可用、`package.tgz` HTTP 200、代碼集 94=94 完全一致、CC0-1.0。CI 新增 `Fetch TWCR_SF package`（含 name／version 驗證）；新增 `check-dependencies.js`（D-1~D-4＋4 組負向＋1 組正向對照），對舊狀態實跑攔下 11 筆。**待 CI 首次執行確認 §6 五項** |
| [JOB-29](JOB-29-betelnut-terminology-and-upstream-coupling.md) | 嚼檳榔術語之權責界線（狀態欄位自訂）與 TWCR_SF 相依之耦合度調整 | **P1** | 術語／相依治理／對外一致性 | M（2–3 人日） | 須在 JOB-28（v0.3.0）之後 | 📋 **評估（v0.3.1／v0.3.2）**：查出「嚼檳狀態」在指引中無承載位置（`CS-BetelNutStatus` 不存在、Profile 未約束 `value[x]`）；建議狀態欄位自訂、量／年／戒除改 Quantity 主軸、上游碼降為 `extensible` 可選、新增 D-5 閘門檢查 `file:` scheme。v0.3.2 補附錄 B：委員意見逐項處置（採認 7／附條件 3／不同意 2／列管 1，另更正委員方案 4 處技術細節），panel 化列為須 PI 裁示之選項題。**待核准後實作** |

各已執行之 JOB 於其檔案 **§7 執行紀錄**載明實際變更、刻意未做的部分，
以及**尚待在可建置環境驗證的項目**。

預估規模：S ≈ 1–2 人日、M ≈ 3–5 人日、L ≈ 1–2 人週。

### 剩餘未來工作（2026-07-29 更新）

P0 原已全數完成（JOB-01／02／03）。**JOB-14**（2026-07-29 發現並修正、已完成）：
JOB-01 批 3 對尿沉渣 9 碼整組換碼、刪除 9 個 ACTIVE 每面積碼、ConceptMap 未補對應之範圍錯誤，
已將 9 碼回收為 acceptable 並補 ConceptMap `#relatedto` 歸一（preferred 體積／acceptable 面積雙軌），
CI 實測 err 0、Wrong Display Name 維持 0。

尚未收尾者為下列 🔶 部分完成、且**受外部輸入所限**之 JOB：

- **JOB-06（識別碼命名系統 NamingSystem，第二階段）**：本 IG 自有識別碼已定義；其餘識別碼之
  NamingSystem 待 **TW Core 上游盤點**後對齊。
- **JOB-09（建置組態固化）**：`template` 釘版、`auto-oid-root`、`no-validate` 正當性等，
  待 **主管機關核配之 OID 根節點**（[T-5](../../input/pagecontent/open-issues.md#t-5)）與可釘定之模板版本。

（另 JOB-07 附表十其餘八家族之未審代碼待 T-1／M-8；其餘 JOB 04／05／08／10／11／12／13 均已執行。）
未決事項集中於 [open-issues](../../input/pagecontent/open-issues.md)。

### 建議執行順序

```
第 1 波（讓網站「看起來已發佈」＋合規）：JOB-02 → JOB-03 → JOB-12   ✅ 已完成
第 2 波（建立驗收基礎設施）：           JOB-08 ✅ → JOB-09 🔶
第 3 波（正確性，最重）：                JOB-01 ✅ → JOB-06 🔶 → JOB-10 ✅
第 4 波（可實作性）：                    JOB-04 → JOB-05 → JOB-07
第 5 波（治理深化，可與委員意見並行）：   JOB-11 → JOB-13
```

> ✅ **第 1、2 波已完成並經 CI 實證**（run 30211050020，閘門全綠：
> `err 0` / `warn 204` / `info 475`，13 個具名類別全部持平）。
>
> CI 於建立過程中連續攔下四個真實問題：佈局斷言的 `pipefail`＋`head` 誤報、
> `language:` 參數用錯（實際應為 `i18n-default-lang`）、`Appendix10 xlsx` 之誤判、
> 以及切換語言後 +218 筆 info。這些在原本「本機建置後手動推 gh-pages」的流程下
> 皆不會被發現。

### 現行基準線（每個 JOB 完成後應下調）

`qa-baseline.json`：`err 0` / `warn 152` / `info 459` ＋ 22 個具名類別。
已鎖定歸零者：`is not included anywhere`、`multiple different potential matches`、
`should have a performer`（47 → 0，JOB-05）、`contains no examples for this extension`、
`ShareableValueSet`／`vsd-0`（JOB-10）。**`Wrong Display Name` 由 133 降至 0**
（JOB-01 完成：稽核 133→23，臨床批1–3＋Q4-1 裁示 23→0；達 §3 驗收條件）；
`contains no examples` 已全數歸零
（最後一個 TWHA-Bundle-Transaction 由 JOB-04 之 UC-008／UC-009 補上）。
`There are no valid display names found for the code`（237）為宣告中文預設語言之
必然結果，非待修項目。

`info` 之所以高於初始的 394：JOB-10 之 stub 降級帶進 19 筆（`_job10Note`）、
JOB-05 新增 11 個範例 artifact 帶進約 31 筆（`_job05Note`）——
**總數上調必須具名說明多出來的是什麼**，這是基準線的既定規則。

---

## 3. 全域驗收標準（所有 JOB 完成後）

1. `_genonce_tx.bat`（或 CI 之 tx 建置）產出 **0 Error**，且：
   - Wrong Display Name **= 0**；
   - `No definition could be found for URL value` **= 0**；
   - `contains no examples` **= 0**；
   - 其餘 warning 皆已於 `input/ignoreWarnings.txt` 具名並附**逐條理由**（不使用泛用字串抑制）。
2. 網站根 URL（`.../occupationIG/`）直接呈現內容，`<html lang="zh-TW">`，publish box 不再顯示 `Local Development build`。
3. `history.html` 可達，`package-list.json` 存在且版本序列正確。
4. 網站可見 LOINC 與 SNOMED CT 授權聲明、依賴表（dependency table）、全域 profile 表。
5. 上傳情境（transaction bundle ＋ `$submit`）有可驗證通過的端到端範例。
6. 每個 Profile 與 Extension 至少 1 個範例；所有標為 Must Support 的欄位在範例中至少出現一次。
7. 未決事項集中於 `open-issues.html`，且各處內文以連結指向該頁，不再散落重複聲明。

---

## 4. 不在本次優化範圍

以下屬「需外部輸入才能定案」，本目錄僅記錄為未決事項（JOB-13），不排入實作：

- 正式 canonical namespace 之核定機關與命名（現為 provisional）。
- 國健署最小上傳集 21 列之**正式公告版本**（現依工作原案，M-5）。
- 第 19 條保存期限起算點之法定解釋（M-6）。
- 英文版敘述性內容（narrative translation）——JOB-02 只修正語言標記與網址結構，**不**產出英譯（若後續需要，另立 JOB）。
