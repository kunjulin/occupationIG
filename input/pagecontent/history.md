# 版本歷程 (Version History)

本頁列出本指引之發佈版本。頁面上方發佈資訊列（publish box）之
「Directory of published versions」即連結至本頁。

> ⚠️ **本指引為工業技術研究院委託研擬中之草案，尚未定稿。**
> 下表所列版本皆為**審閱用草案**，不得作為實作或稽核依據。

## 1. 版本清單

| 版本 | 日期 | 狀態 | 說明 |
|:--|:--|:--|:--|
| `current` | — | 持續建置 (ci-build) | 研製中之最新建置。內容得隨時變動。 |
| `0.1.0` | 2026-07-26 | 草案 (draft, STU 1) | 依《勞工健康保護規則》115.06.26 修正同步，並合併四方委員意見。 |

機器可讀之版本清單見 repo 根目錄之 [`package-list.json`](https://github.com/kunjulin/occupationIG/blob/main/package-list.json)。
逐次變更明細見 [`README.md` 版本與更新記錄](https://github.com/kunjulin/occupationIG#版本與更新記錄-update-history)。

## 2. 關於發佈位址（provisional）

| 項目 | 現況 |
|:--|:--|
| **canonical** | `https://twcore.mohw.gov.tw/ig/twha` —— **provisional**。正式命名空間之核定機關與命名尚待確認。 |
| **目前審閱位址** | `https://kunjulin.github.io/occupationIG`（GitHub Pages） |

即 **canonical 與實際發佈位址目前不一致**：canonical 為預留之正式命名空間，
現階段內容則置於 GitHub Pages 供審閱。待正式命名空間核定並於官方站發佈後，
`package-list.json` 之 `path`、`sushi-config.yaml` 之 `parameters.path-history`
須一併更新，且本頁應改由 HL7 發佈流程依 `package-list.json` 自動產生。

## 3. 建置來源之可追溯性

本頁所列版本目前係由**本機建置後手動推送**至 GitHub Pages，
故發佈內容與原始碼 commit 之對應關係尚未固化（已列為優化項目
[JOB-08](https://github.com/kunjulin/occupationIG/blob/main/docs/optimization/JOB-08-ci-cd-reproducible-build.md)）。
在此之前，引用本指引時請一併註明查閱日期。
