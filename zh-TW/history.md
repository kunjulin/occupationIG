# History - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.2.1

## History

# 版本歷程 (Version History)

本頁列出本指引之發佈版本。頁面上方發佈資訊列（publish box）之 「Directory of published versions」即連結至本頁。

> ⚠️ **本指引為工業技術研究院委託研擬中之草案，尚未定稿。** 下表所列版本皆為**審閱用草案**，不得作為實作或稽核依據。

## 1. 版本清單

| | | | |
| :--- | :--- | :--- | :--- |
| `current` | — | 持續建置 (ci-build) | 研製中之最新建置。內容得隨時變動。 |
| `0.2.0` | 2026-07-29 | 草案 (draft, STU 1) | 完成 JOB-01～14 之術語稽核、可實作性與治理優化；主要異動見 §1.1。 |
| `0.1.0` | 2026-07-26 | 草案 (draft, STU 1) | 依《勞工健康保護規則》115.06.26 修正同步，並合併四方委員意見。 |

機器可讀之版本清單見 repo 根目錄之 [`package-list.json`](https://github.com/kunjulin/occupationIG/blob/main/package-list.json)。 逐次變更明細見 [`README.md` 版本與更新記錄](https://github.com/kunjulin/occupationIG#版本與更新記錄-update-history)。

### 1.1 0.2.0 主要異動摘要

相對於 `0.1.0`，`0.2.0` 彙集 JOB-01 至 JOB-14 之優化（原始碼 commit 範圍 `7169521a..bb554ce1`，96 個 commit）。六項主要異動：

| | | | |
| :--- | :--- | :--- | :--- |
| 顯示名不符 (Wrong Display Name) | 133 | **0** | JOB-01 |
| `VS-ExtendedDataset`成員 | 277 碼 | **288 碼**（換碼 19、移除 8、回收 9；另 113 碼更正 display） | JOB-01、JOB-14 |
| ConceptMap 歸一 | 31 組 | **37 組** | JOB-01、JOB-14 |
| 法定情境值集 | 無（僅 markdown 對照） | **新增**`VS-Appendix9-RequiredSet`及附表十四家族之 RequiredSet（噪音／鉛／粉塵／有機溶劑） | JOB-07 |
| 發布組態 | 本機建置、`lang=en`、無 history | CI 建置、`zh-TW`、history 與 IP 聲明齊備 | JOB-02／03／08／12／13 |
| CI 品質閘門 | 無 | 有（`Wrong Display Name > 0`即失敗） | JOB-08 |

> 版本性質不變：仍為 STU1 草案（`releaseLabel: STU1`、`status: draft`），工業技術研究院 委託研擬中、尚未定稿；canonical 為 provisional。`0.1.0` 之既有紀錄保留於上表，未更動。

## 2. 關於發佈位址（provisional）

| | |
| :--- | :--- |
| **canonical** | `https://twcore.mohw.gov.tw/ig/twha`——**provisional**。正式命名空間之核定機關與命名尚待確認（見[未決事項 P-1](open-issues.md#p-1)）。 |
| **目前審閱位址** | `https://kunjulin.github.io/occupationIG`（GitHub Pages） |

即 **canonical 與實際發佈位址目前不一致**：canonical 為預留之正式命名空間， 現階段內容則置於 GitHub Pages 供審閱。待正式命名空間核定並於官方站發佈後， `package-list.json` 之 `path`、`sushi-config.yaml` 之 `parameters.path-history` 須一併更新，且本頁應改由 HL7 發佈流程依 `package-list.json` 自動產生。

## 3. 建置來源之可追溯性

本頁所列版本目前係由**本機建置後手動推送**至 GitHub Pages， 故發佈內容與原始碼 commit 之對應關係尚未固化（已列為優化項目 [JOB-08](https://github.com/kunjulin/occupationIG/blob/main/docs/optimization/JOB-08-ci-cd-reproducible-build.md)）。 在此之前，引用本指引時請一併註明查閱日期。

