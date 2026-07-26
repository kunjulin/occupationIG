# docs/drafts — 草稿資源（未納入建置）

本目錄存放**尚未接入建置流程**的 FHIR 資源草稿。
放在這裡的檔案**不會**被 SUSHI 或 IG Publisher處理，因此不會出現在發佈網站上。

## `Requirements-fromNarrative.json`

一個 `Requirements` 資源的空殼，用途為「把散落在敘述文字中的遵從性陳述
(conformance statements) 收攏成可計算的資源，以支援可追溯性」——
即其 `description` 所述之意圖。

**現況**：

| 項目 | 狀態 |
|:--|:--|
| 內容 | 僅有 metadata（`url`／`name`／`title`／`status`／`description`），**無任何 `statement`** |
| 是否納入建置 | **否**。原置於 repo 根目錄，不在 `input/` 之下，故從未被 SUSHI 或 IG Publisher 讀取 |

**待決定**：

1. **接入並填實** —— 移至 `input/resources/`，並將各頁敘述中的 SHALL／SHOULD／MAY
   陳述逐條填入 `statement`。此舉可讓遵從性要求成為可計算、可測試的資產，
   與 qa.txt 中多筆 `No conformance term found in the text` 的提示相呼應。
2. **移除** —— 若本期不採用 `Requirements` 資源，則刪除以免誤導。

**不建議**在未填實的情況下接入建置：那會在發佈網站上產生一個沒有任何要求內容的
「遵從性要求」artifact，比不存在更容易誤導讀者。

此決策已於 2026-07-26 登記（JOB-12），待與 [JOB-04](../optimization/JOB-04-upload-path-conformance.md)
之遵從性契約工作一併評估。
