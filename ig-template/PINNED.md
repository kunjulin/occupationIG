# 釘版之 IG 模板

本目錄是 `fhir2.base.template` 之**快照**（FHIR 模板套件結構，模板檔位於 `package/` 下）。

⚠️ **模板根層檔案（`config.json`、`ig.ini`、`cache.ini`、`package-list.json`、`README.md`）必須放在
`package/$root/`**。IG Publisher 2.2.11 之 `TemplateManager` 自 `package/$root/config.json` 讀取設定，
解壓時將 `$root/` 之內容放到 `template/` 根層；放在 `package/` 根層者不會被解壓（實測：`template/config.json not found`）。
`onLoad-*`／`onGenerate-*`／`onCheck-*` 等為模板腳本之執行產物，不屬模板內容，已自快照移除。

## 釘版機制

`ig.ini` 寫 `template = fhir2.base.template#0.1.0-twha.20260730`（版號＝`package/package.json` 之 `version`）。
CI 之「Seed pinned template into package cache」步驟在執行 publisher 前，先核對兩處版號一致，再把 `package/`
複製到 `~/.fhir/packages/fhir2.base.template#<版號>/package`；明確版號於快取命中時不需連網。
「Report resolved template version」步驟斷言日誌中**沒有** `Installing fhir2.base.template`（即未自網路重抓）、
無載入錯誤，且有 `Load Template from fhir2.base.template#<版號>`。

⚠️ **不使用 `#current` 加預置快取**：2.2.11 實測，即使快取已預置，`#current` 仍會向網路比對並重新下載。
publisher 解壓模板之工作目錄為 `./template/`（已列入 `.gitignore`）。

⚠️ **不使用 `ig.ini` 之 `template = #ig-template`（本機資料夾）語法**：IG Publisher 2.2.11 實測會判定
`IG template '#ig-template' is not trusted. No scripts will be executed`——模板內之產生腳本不執行，
輸出與以套件載入者不同。

⚠️ **本機建置（`_genonce*.bat`）不經過預置步驟**：該版號不存在於任何公開套件庫，未預置時 publisher 會找不到模板而中止
（明確失敗，不會悄悄改用 `#current`）。請先將 `package/` 複製到本機套件快取之
`fhir2.base.template#0.1.0-twha.20260730/package`（Windows 通常為 `%USERPROFILE%\.fhir\packages\`）。

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
2. 以其內容取代 `package/`（保留本檔與 `package/package.json`；根層檔案放入 `package/$root/`，勿帶入 `onLoad-*`／`onGenerate-*`／`onCheck-*` 等執行產物），並**同時**更新 `package.json` 之 `version`、`ig.ini` 之版號與上表——CI 會核對兩處版號一致。
3. 跑 `node scripts/check-translations.js`：模板新增之字串鍵須補 en（逐字照抄）與 zh-TW 譯文至 `input/data/`。
4. 目視比對升級前後之頁面輸出；`qa-baseline.json` 依 CI 實測調整並具名說明。

⚠️ **不要直接修改本目錄內之模板檔來「修」頁面**——那會使本快照與任何上游版本都對不上。
