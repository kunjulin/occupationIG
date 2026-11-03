# 釘版之 IG 模板

本目錄是 `fhir2.base.template` 之**快照**，供 `ig.ini` 之 `template = #ig-template` 使用。
模板檔位於 `package/` 下——IG Publisher 以 npm 套件結構讀取本機模板，要求 `package/package.json` 存在（2.2.11 實測）。
IG Publisher 每次建置會自本目錄讀取模板，解壓至 `./template/`（工作目錄，已列入 `.gitignore`）。

| 項目 | 內容 |
|:--|:--|
| 上游套件 | `fhir2.base.template`（canonical `http://fhir.org/templates/fhir2.base.template`） |
| 快照來源 | 2026-07-30 commit 進 repo 之 `template/`（commit `ae6e9b9`），即當時 `#current` 解壓結果 |
| `package.json` 之 `version` | `0.1.0-twha.20260730`——**本 repo 自訂之識別字，非上游版號** |
| 釘版日期 | 2026-11-03 |

## 為何不用上游版號

* npm 上之 `fhir2.base.template` 只有 `0.1.0`（2025-10-01），以 `scripts/check-translations.js` 實測
  比本快照**舊**（4 句 en 不同、36 個鍵本快照有而 0.1.0 無）。
* packages.fhir.org 自本專案之遠端環境不可達，無法查證其他版號。
* 本快照以同一閘門實測與 `input/data/strings*.json` **完全對齊**。

## 升級程序

1. 在可連外之環境以 `#current`（或指定版號）建置一次，取得 publisher 解壓之 `template/`。
2. 以其內容取代 `package/`（保留本檔與 `package/package.json`，並更新其 `version` 與上表）。
3. 跑 `node scripts/check-translations.js`：模板新增之字串鍵須補 en（逐字照抄）與 zh-TW 譯文至 `input/data/`。
4. 目視比對升級前後之頁面輸出；`qa-baseline.json` 依 CI 實測調整並具名說明。

⚠️ **不要直接修改本目錄內之模板檔來「修」頁面**——那會使本快照與任何上游版本都對不上。
