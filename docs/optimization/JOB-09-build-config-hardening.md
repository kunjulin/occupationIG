# JOB-09｜建置組態固化：釘版、`pin-canonicals`、`no-validate` 正當性

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P2** |
| **類別** | 工程／治理 |
| **預估** | S（1–2 人日） |
| **相依** | JOB-08（CI 建立後才好驗收） |
| **主要影響檔案** | `ig.ini`、`sushi-config.yaml`、`input/ignoreWarnings.txt`、`input/fsh/codesystems/CS-*.fsh`、`input/fsh/valuesets/*.fsh` |

---

## 1. 問題（證據）

### (1) 模板未釘版

`ig.ini`：

```ini
template = fhir2.base.template#current
```

`#current` 表示每次建置都抓最新模板。模板更新就可能改變輸出樣式、頁面結構甚至
fragment 名稱（JOB-03 的四個 fragment 就是模板提供的）。對一份要送審的文件，
**建置輸入必須可釘版**。

另注意 repo 內已 commit 了整份 `template/` 目錄（含 20 個 `.po` 翻譯檔、liquid 模板、
以及 template 自帶的樣本 `template/package/package-list.json`）。IG Publisher 通常自行抓取模板，
此目錄的角色需釐清：是刻意的離線快取，還是誤入版控？若無必要應移除，
否則容易與 `#current` 抓來的版本混淆。

### (2) `pin-canonicals` 未設定 → 29 筆警告

qa.txt 有 **29 筆** `There are multiple different potential matches for the url ...`，
訊息本身就給了解法：

> or use the [IG Parameter `pin-canonicals`](https://hl7.org/fhir/tools/CodeSystem-ig-parameters.html)

影響對象包含 `TWHA-Patient`、`TWHA-Encounter`、`TWHA-Composition`、
`TWHA-QuestionnaireResponse*`、`TWHA-SDOH-QuestionnaireResponse` 等。
未釘版意味著**實作者可能解析到不同版本的 extension／valueset 定義**。

### (3) `no-validate` 遮蔽了最大的值集

`sushi-config.yaml`：

```yaml
  no-validate:
    - .../ValueSet/VS-CoreDataset
    - .../ValueSet/VS-ExtendedDataset
    - .../ValueSet/VS-OccHealthCheck-Required
    - .../ValueSet/VS-PulmonaryFunction
    - .../ValueSet/VS-TWHAVitalSigns
    - .../ValueSet/VS-UnfitDiseases
```

這六個正是本 IG 的**核心術語資產**。`no-validate` 的理由未在任何文件說明。
JOB-01 完成後應重新評估是否還需要，若仍需要，**必須逐項寫明理由**——
否則「0 Error」的說服力會被這段組態抵銷（審查者一定會看 `sushi-config.yaml`）。

### (4) `ignoreWarnings.txt` 抑制過寬

```
# Building without FHIR terminology server (-tx n/a), expected for offline build
No server available

# SSL certificate error: building offline, cannot fix network certificate issue
PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException
```

這兩條在**離線建置**是合理的，但抑制規則不分建置模式，
所以在 `_genonce_tx.bat`（送審用）中會**一併吞掉真實的術語伺服器連線失敗與 TLS 問題**。
結果是：tx 建置可能實際上沒連到 tx，卻仍顯示 0 Error。
這直接違反 README 自訂的核心原則，且會讓 JOB-08 的 CI 閘門失效。

### (5) `experimental` 標記不一致 → 11 筆警告

```
WARNING: StructureDefinition/ext-health-mgmt-level: ... binds to the value set '...' which is
experimental, but this structure is not labeled as experimental
```

`ext-fitness-for-work`、`ext-health-mgmt-level`、`ext-labor-report-code`、
`TWHA-Procedure-ServiceActivity`、`TWHA-HealthManagementLevel`、`TWHA-ImagingStudy` 等
標了 `^experimental = false`，卻綁定到 experimental 的值集。
需決定方向：把 CodeSystem/ValueSet 改為非 experimental，或把 profile 改為 experimental
（考量本 IG 為「研製中草案」，後者也許更誠實）。

另有 **40 筆** `should have an OID assigned`（ValueSet 未指派 OID），
可用 `parameters.auto-oid-root` 一次解決。

---

## 2. 目標與驗收標準

1. `ig.ini` 之 `template` 釘定具體版本。
2. `parameters.pin-canonicals` 設定後，`multiple different potential matches` **= 0**。
3. `parameters.auto-oid-root` 設定後，`should have an OID assigned` **= 0**。
4. `experimental` 標記一致，相關 11 筆警告 **= 0**，且方向決策記錄於 `README.md` 或 `conformance.md`。
5. `ignoreWarnings.txt` **依建置模式分離**（例如 `ignoreWarnings.txt` 用於 tx 建置、
   另一份供離線建置），或改用精確不含糊的抑制字串；tx 建置不得抑制連線失敗訊息。
6. `no-validate` 清單：每一項附理由註解，或（JOB-01 完成後）移除。
7. `template/` 目錄之角色釐清並記錄於 `README.md`。

---

## 3. 工作項目

1. 查明 `fhir2.base.template` 的可用版本並釘定；驗證釘版後 JOB-03 的四個 fragment 仍存在。
2. 依 qa.txt 逐筆整理需 pin 的 canonical 清單（訊息本身有 `Suggested fix`，可直接採用）。
3. 設定 `auto-oid-root`（需一個可用的 OID 根節點——若尚未取得，登記 JOB-13 未決事項並暫緩此項）。
4. 決定 experimental 方向並套用。
5. 重構抑制規則：檢查 IG Publisher 是否支援以不同 `ignoreWarnings` 檔案路徑執行；
   若不支援，改用**精確訊息全文**抑制，並在 CI 中額外檢查 qa.txt 是否出現連線失敗字樣
   （即 CI 層再補一道網，不依賴抑制檔）。
6. 為 `no-validate` 每項加註理由；JOB-01 完成後回頭評估移除。

---

## 4. 不在本 JOB 範圍

- 修正代碼本身（JOB-01）。
- 建立 CI（JOB-08）。

---

## 5. 風險與注意事項

- **釘版模板可能改變輸出樣式**，需目視比對重建前後的頁面。
- 移除 `no-validate` 可能一次噴出大量新訊息；建議在 JOB-01 完成後、以 JOB-08 的 baseline 機制逐步收斂。
- `auto-oid-root` 一旦設定就會產生穩定 OID，**後續變更會破壞已發佈的 OID**，
  務必確認 OID 根節點的正當來源（不要隨意取一個數字）。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-09-build-config-hardening.md、ig.ini、sushi-config.yaml、
input/ignoreWarnings.txt，並參考 docs/optimization/evidence/qa-summary-2026-07-26.md，
為這個 JOB 產出實作計畫。

要求：
1. 查明 fhir2.base.template 的可用版本，提出釘版方案，並說明如何驗證釘版後
   ip-statements / dependency-table / globals-table / cross-version-analysis 這些 fragment 仍可用。
2. 從 qa.txt 的 29 筆 "multiple different potential matches" 訊息中擷取 Suggested fix，
   整理出 parameters.pin-canonicals 的完整設定。
3. 針對 40 筆 OID 警告，說明 auto-oid-root 的設定方式，並提醒 OID 根節點需有正當來源，
   若尚未取得則暫緩並登記為未決事項。
4. 針對 11 筆 experimental 不一致，比較「值集改非 experimental」與「profile 改 experimental」
   兩個方向，考量本 IG 屬研製中草案，給出建議並列出要改的檔案。
5. 重點：input/ignoreWarnings.txt 目前用泛用字串抑制 "No server available" 與 PKIX 錯誤，
   會讓 _genonce_tx.bat 的送審建置吞掉真實連線失敗。請提出依建置模式分離抑制規則的方案，
   並在 CI 層補一道獨立檢查（不要只依賴抑制檔）。
6. 為 sushi-config.yaml 的 6 項 no-validate 逐項研擬理由註解，並規劃 JOB-01 完成後的移除評估。
7. 釐清 repo 內已 commit 的 template/ 目錄角色（離線快取還是誤入版控），提出處理建議。
```
</content>
