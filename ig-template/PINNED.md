# 釘版之 IG 模板

本目錄是 `fhir2.base.template` 之**快照**（npm 套件結構，模板檔位於 `package/` 下）。

## 釘版機制

`ig.ini` 維持 `template = fhir2.base.template#current`。CI 之「Seed pinned template into package cache」
步驟在執行 publisher 前，把 `package/` 複製到 `~/.fhir/packages/fhir2.base.template#current/package`；
publisher 見快取已有 `#current` 即直接使用、不重新下載。「Report resolved template version」步驟斷言
日誌中**沒有** `Installing fhir2.base.template`（即未自網路重抓）且無載入錯誤。
publisher 解壓模板之工作目錄為 `./template/`（已列入 `.gitignore`）。

⚠️ **不使用 `ig.ini` 之 `template = #ig-template`（本機資料夾）語法**：IG Publisher 2.2.11 實測會判定
`IG template '#ig-template' is not trusted. No scripts will be executed`——模板內之產生腳本不執行，
輸出與以套件載入者不同。

⚠️ **本機建置（`_genonce*.bat`）不經過預置步驟**，仍會使用本機快取或網路上之 `#current`。
送審建置以 CI 為準；本機若要對齊，請先將 `package/` 複製到本機套件快取之同一路徑。

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
