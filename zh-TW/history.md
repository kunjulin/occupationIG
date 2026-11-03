# 版本歷程 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.4

## 版本歷程

# 版本歷程 (Version History)

本頁列出本指引之發佈版本。頁面上方發佈資訊列（publish box）之 「Directory of published versions」即連結至本頁。

> 📌 **本頁為里程碑摘要，非逐版清單。** 目前已發佈之版次逾三十個，多為同日之 連續修補；逐版列出反而不易看出走向，故以次版本（minor）為單位歸納。 **完整且逐版之清單以 [`package-list.json`](https://github.com/kunjulin/occupationIG/blob/main/package-list.json) 為準**——該檔由發佈流程維護，是機器可讀的權威來源，本頁若與之不符，以該檔為準。

> ⚠️ **本指引為工業技術研究院委託研擬中之草案，尚未定稿。** 下表所列版本皆為**審閱用草案**，不得作為實作或稽核依據。

## 1. 版本清單

| | | | |
| :--- | :--- | :--- | :--- |
| `current` | — | 持續建置 (ci-build) | 研製中之最新建置。內容得隨時變動。 |
| `0.10.x` | 2026-08-22 – 2026-11-03 | 草案 (draft, STU 1) | **溯源更正與術語判準換基準**。更正五處不實之「經主管機關答覆確認」（國民健康署從未就嚼檳三項作成函復），依據改記為本案專家會議之技術決議並逐項切分；依委員決議兩批納入八個 acceptable 變異碼；`ConceptMap`之`equivalence`判準由 comment 散文改為術語伺服器實測之六軸，並據以更正兩組方向有誤之對應；另於`0.10.4`更正兩筆單位對照（尿比重之 UCUM 註記、國際臨床化學聯合會方法糖化血色素之單位），並將建置所用之頁面模板釘版 |
| `0.9.x` | 2026-08-21 | 草案 (draft, STU 1) | **嚼檳狀態代碼之 Level 1 破壞性變更**。`Observation.code`原用之國際標準術語概念經查證為肯定式臨床發現，置於提問位會使「從未嚼食」之紀錄自相矛盾，已改為自訂狀態問句碼並附遷移說明；另修復全站分類標題空白（第二個模板字串檔未補譯）與六處不會算繪之 markdown 記號 |
| `0.8.x` | 2026-08-21 | 草案 (draft, STU 1) | **對外試用版乾淨化**，屬破壞性變更：未決事項頁自網站移除，指向該頁之外部連結將失效；散落各頁之規範性揭露收斂為首頁「使用前須知」六條 |
| `0.7.x` | 2026-08-21 | 草案 (draft, STU 1) | **權責登記範圍擴大**：`ConceptMap`與`NamingSystem`納入登記（含規範性中繼資料變更）；補正文件 Bundle 之走訪可達性 |
| `0.6.x` | 2026-08-20 | 草案 (draft, STU 1) | 依專家會議決議調整嚼檳三項；勞工區塊之機器可讀成熟度標示。⚠️ 本系列原記「依主管機關答覆」，該敘述已於`0.10.0`更正 |
| `0.5.x` | 2026-08-20 | 草案 (draft, STU 1) | **合規層級與權責界線**：新增 Level 1（Core 上傳合規，依據為國民健康署健檢上傳欄位規範）與 Level 2（勞工健檢涵蓋，依據為《勞工健康保護規則》附表），並明載本指引之主管機關只有國民健康署一個 |
| `0.4.x` | 2026-08-20 | 草案 (draft, STU 1) | **嚼檳 Profile 解耦與欄位擴充**，含規範性變更：移除對上游之最後一處硬綁定，補上承載狀態之`value[x]` |
| `0.3.x` | 2026-08-20 | 草案 (draft, STU 1) | **未決事項收斂與相依治理**：屬本團隊職權之六項技術事項逕行定案；本地 stub 改為正式相依 |
| `0.2.x` | 2026-07-29 – 2026-08-17 | 草案 (draft, STU 1) | 完成術語稽核、可實作性與治理優化（主要異動見 §1.1）；其後補齊發布組態——`zh-TW`模板字串、頁面標題中文化、快速入門頁 |
| `0.1.0` | 2026-07-26 | 草案 (draft, STU 1) | 依《勞工健康保護規則》115.06.26 修正同步，並合併四方委員意見。 |

機器可讀之版本清單見 repo 根目錄之 [`package-list.json`](https://github.com/kunjulin/occupationIG/blob/main/package-list.json)。 逐次變更明細見 [`README.md` 版本與更新記錄](https://github.com/kunjulin/occupationIG#版本與更新記錄-update-history)。

### 1.1 0.2.0 主要異動摘要（保留為該次之逐項紀錄）

相對於 `0.1.0`，`0.2.0` 彙集該階段之優化（原始碼 commit 範圍 `7169521a..bb554ce1`，96 個 commit）。六項主要異動：

| | | |
| :--- | :--- | :--- |
| 顯示名不符 (Wrong Display Name) | 133 | **0** |
| `VS-ExtendedDataset`成員 | 277 碼 | **288 碼**（換碼 19、移除 8、回收 9；另 113 碼更正 display） |
| ConceptMap 歸一 | 31 組 | **37 組** |
| 法定情境值集 | 無（僅 markdown 對照） | **新增**`VS-Appendix9-RequiredSet`及附表十四家族之 RequiredSet（噪音／鉛／粉塵／有機溶劑） |
| 發布組態 | 本機建置、`lang=en`、無 history | CI 建置、`zh-TW`、history 與 IP 聲明齊備 |
| CI 品質閘門 | 無 | 有（`Wrong Display Name > 0`即失敗） |

> 版本性質不變：仍為 STU1 草案（`releaseLabel: STU1`、`status: draft`），工業技術研究院 委託研擬中、尚未定稿；canonical 為 provisional。`0.1.0` 之既有紀錄保留於上表，未更動。

## 2. 關於發佈位址（provisional）

| | |
| :--- | :--- |
| **canonical** | `https://twcore.mohw.gov.tw/ig/twha`——**provisional**。正式命名空間之核定機關與命名尚待確認（見[未決事項 P-1](index.md#before-you-start)）。 |
| **目前審閱位址** | `https://kunjulin.github.io/occupationIG`（GitHub Pages） |

即 **canonical 與實際發佈位址目前不一致**：canonical 為預留之正式命名空間， 現階段內容則置於 GitHub Pages 供審閱。待正式命名空間核定並於官方站發佈後， `package-list.json` 之 `path`、`sushi-config.yaml` 之 `parameters.path-history` 須一併更新，且本頁應改由 HL7 發佈流程依 `package-list.json` 自動產生。

## 3. 建置來源之可追溯性

本站由 CI 自動建置與發佈。每次發佈之產出根目錄均含 `build-info.json`， 記載該次發佈對應之原始碼 commit（`sourceCommit`）、建置時間與 IG Publisher 版本， **發佈內容與原始碼之對應關係可逐次追溯**。引用本指引時，建議一併註明版本與查閱日期。

