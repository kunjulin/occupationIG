# JOB-10｜TWCR_SF mock 依賴治理（勿在他方命名空間下發佈代碼）

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P2**（但屬治理正確性問題，不宜長期擱置） |
| **類別** | 治理／術語 |
| **預估** | S（1–2 人日） |
| **相依** | 無 |
| **主要影響檔案** | `input/fsh/codesystems/TWCRSF-mocks.fsh`、`sushi-config.yaml`、`input/fsh/profiles/TWHA-SocialHistory.fsh`、`input/pagecontent/terminology.md`、`README.md` |

---

## 1. 問題（證據）

`input/fsh/codesystems/TWCRSF-mocks.fsh` 開頭自述：

```fsh
// ==========================================
// Mocked TWCRSF CodeSystems and ValueSets
// (Generated to bypass dependency errors from fhir.twcrsf)
// ==========================================

CodeSystem: sf-BetNutChewAmount-codesystem
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem"
* ^status = #active
* ^content = #complete
```

問題在於：這個檔案在本 IG 中**定義並發佈**了 5 個 CodeSystem 與 4 個 ValueSet，
而它們的 canonical URL 屬於 **`hapi.fhir.tw`（臺灣癌症登記短表 IG，TWCR_SF）** 的命名空間。

具體風險：

| 風險 | 說明 |
|:--|:--|
| **命名空間佔用** | 本 IG 對外宣稱 `https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem` 的定義，但本 IG 無權定義該 URL。任何同時載入 TWHA IG 與 TWCR_SF IG 的系統會遇到 canonical 衝突 |
| **內容漂移** | `^content = #complete` 宣告「這是完整定義」。若 TWCR_SF 官方版本與此 mock 不同（例如嚼檳量代碼的級距或標籤），實作端會依 mock 產生錯誤資料，且**無從察覺** |
| **`status = #active`** | mock 卻標為 active，等於對外保證其正確性 |
| **未標 experimental** | 這是全 repo **唯一**未標 `^experimental` 的術語檔（已逐檔確認），因此觸發 qa.txt 的 4 筆 `SHOULD conform to the ShareableValueSet profile ... ValueSet.experimental is mandatory, but it is not present` |
| **命名不符規範** | 4 筆 `Constraint failed: vsd-0`（ValueSet.name 需為 UpperCamelCase，現為 `sf-BetNutChew...-valueset`） |
| **OID 缺漏** | 4 筆 `should have an OID assigned` 也來自這些 mock |

`sushi-config.yaml` 用 `parameters.special-url` 把這 9 個 URL 列為例外，
這個機制**只是讓建置通過**，並未解決治理問題。

---

## 2. 目標與驗收標準

擇一路徑（plan 時決定）：

**路徑 A（最正確）**：改為對 TWCR_SF 套件的正式依賴

1. 確認 TWCR_SF 是否有可用的 FHIR 套件（package id、版本、發佈位置）；
2. 若有 → 加入 `sushi-config.yaml` 之 `dependencies`，**刪除 `TWCRSF-mocks.fsh`**，
   移除對應 `special-url` 項目；
3. 驗收：建置後這 9 個 artifact 不再由本 IG 產出，而是以外部引用呈現。

**路徑 B（若套件不可用）**：明確降級為本地 stub

1. 檔名／標題／描述明確標示為 stub，例如
   `Title: "【本地 stub】每日嚼檳榔量代碼系統（非權威定義）"`；
2. `^status = #draft`、`^experimental = true`、`^content = #fragment`（**不可再宣稱 complete**）；
3. `^copyright` 或 description 中註明「權威定義來源為 TWCR_SF IG，本 IG 僅為建置用局部複本，
   實作端應以 TWCR_SF 官方定義為準」；
4. `terminology.md` 與 `README.md` 增列此限制，並列入 JOB-13 未決事項（待套件可用後改為路徑 A）；
5. 驗收：`ShareableValueSet` 4 筆、`vsd-0` 4 筆警告消除，OID 依 JOB-09 一併處理。

**兩路徑共同驗收**：
- ValueSet.name 改為 UpperCamelCase（如 `SFBetNutChewAmountValueSet`），`vsd-0` 警告 = 0；
- `README.md §依賴指引` 之敘述與實際組態一致。

---

## 3. 工作項目

1. **查證 TWCR_SF 套件可用性**——這是決定路徑 A/B 的唯一依據。
   查 `hapi.fhir.tw` 之 IG 發佈站、FHIR package registry（`packages.fhir.org` / `simplifier.net`）、
   以及是否有 `fhir.twcrsf` 之類的 package id（檔案註解提到 `fhir.twcrsf`，暗示曾嘗試過）。
2. 依結果執行路徑 A 或 B。
3. 檢查 `TWHA-SocialHistory.fsh`（嚼檳榔 profile）之綁定是否需隨之調整。
4. 更新 `terminology.md`：說明嚼檳榔代碼之權威來源與本 IG 的引用方式。
5. 同步 `README.md`「依賴指引」段落。

---

## 4. 不在本 JOB 範圍

- 與 TWCR_SF 團隊協調套件發佈（行政作業）。
- 嚼檳榔代碼內容本身的正確性審查（若採路徑 A，內容由 TWCR_SF 負責）。

---

## 5. 風險與注意事項

- **不要為了消除警告而把 mock 的 `experimental` 設為 false**——那會讓問題更嚴重
  （等於更強力地宣稱這是權威定義）。
- 若改為路徑 A，套件依賴可能引入新的驗證訊息（TWCR_SF 自身的 profile 約束），需預留修正時間。
- 現有範例（`obs-social-betelnut` 等）使用這些代碼，路徑切換後需重新驗證。
- `special-url` 參數在路徑 A 下應移除；路徑 B 下應保留並加註理由。

---

## 6. 交給 Claude 規劃用提示（可直接複製）

```
請閱讀 docs/optimization/JOB-10-twcrsf-dependency-governance.md、
input/fsh/codesystems/TWCRSF-mocks.fsh、sushi-config.yaml（dependencies 與 parameters.special-url）
與 input/fsh/profiles/TWHA-SocialHistory.fsh，為這個 JOB 產出實作計畫。

要求：
1. 第一步先查證臺灣癌症登記短表 IG（TWCR_SF, hapi.fhir.tw）是否有可用的 FHIR 套件
   （package id 與版本）。檔案註解提到 fhir.twcrsf，請查證實際情況。
   如果無法確認，明確說「無法確認」，不要假設。
2. 依查證結果選擇路徑 A（正式套件依賴，刪除 mock）或路徑 B（明確降級為本地 stub），
   並說明選擇理由與各自的完整改動清單。
3. 路徑 B 需把 status 改 draft、experimental 改 true、content 改 fragment，
   並在標題與描述中明示「非權威定義」。特別注意：不要為了消除 ShareableValueSet 警告
   而把 experimental 設成 false。
4. 一併修正 ValueSet.name 的 UpperCamelCase 問題（4 筆 vsd-0 警告）。
5. 列出受影響的既有範例與需同步更新的文件（terminology.md、README.md 依賴指引段落）。
6. 若採路徑 B，規劃如何登記為 JOB-13 的未決事項（待套件可用後轉為路徑 A）。
```

---

## 7. 執行紀錄（2026-07-28）

### 7.1 查證結果：路徑 A 不可行

§3.1 要求「查證 TWCR_SF 套件可用性——這是決定路徑 A/B 的唯一依據」。
開發環境連不到 `packages.fhir.org` 與 `hapi.fhir.tw`（本機測到的 403 是代理的回應，
不是伺服器的，**不得作為證據**），故新增工具由 CI 執行：

| 探測 | 工具 | 結果 |
|:--|:--|:--|
| `fhir.twcrsf` 套件（3 個 registry 之**根路徑**） | `inspect-package.yml` 新增之 Probe registry 步驟 | **全部 404**（run 30368332715） |
| 10 個 canonical 於 `hapi.fhir.tw` | 新增 `scripts/probe-canonicals.js` | **全部 404**（run 30368750214） |

兩項區分很重要：

- 查**根路徑**而非特定版本，才能區分「套件不存在」與「版本號給錯」——兩者都是 404。
- canonical 形如 `hapi.fhir.tw/fhir/CodeSystem/<id>`，那是 FHIR **伺服器資源端點**
  而非套件 canonical，故套件不存在**不等於**資源不存在，必須分別查證。
  結果顯示伺服器有回應（404 而非連線失敗），只是不服務這些資源。

**結論：上游既無套件、亦不服務該命名空間下的這些資源 → 採路徑 B。**

### 7.2 已執行（路徑 B）

| # | 變更 | 依據 |
|--:|:--|:--|
| 1 | `^content` `#complete` → **`#fragment`**（5 個 CodeSystem） | §2 路徑 B.2 |
| 2 | `^status` `#active` → `#draft`（9 個） | §2 路徑 B.2 |
| 3 | `^experimental = true`（9 個，原本全無） | §2 路徑 B.2 |
| 4 | Title 冠【本地 stub】並註明（非權威定義）（9 個） | §2 路徑 B.1 |
| 5 | `^copyright` 載明權威來源與引用限制（9 個） | §2 路徑 B.3 |
| 6 | ValueSet 宣告名改 UpperCamelCase（4 個，消 `vsd-0`） | §2 共同驗收 |
| 7 | 檔頭改寫：載明 stub 性質、實測證據、降級內容、待辦 | §2 路徑 B.1 |
| 8 | `sushi-config.yaml` 之 `special-url` 加註保留理由 | §5 |
| 9 | `README.md` 依賴指引更正 | §3.5 |
| 10 | `terminology.md` §6.2b 新增權威來源說明 | §3.4 |
| 11 | `open-issues.md` G-5 以實測結果更新 | §2 路徑 B.4 |

**`#fragment` 是重點，不是妥協。** 它正是 FHIR 為「外部代碼系統之局部複本」
設計的機制；原本標 `#complete` 等於宣稱本 IG 是該代碼系統的權威完整定義。

### 7.3 刻意未做

- **canonical 未改為本 IG 命名空間。** 路徑 B 的用意是「誠實標示為局部複本」，
  而非把他方的代碼搬進自己的命名空間——後者會讓同一組代碼在兩個 canonical 下並存，
  與 TWCR_SF 的資料無法勾稽。`#fragment` 已正名其性質。
- **綁定強度未動。** `TWHA-SocialHistory-BetelNut` 之三個 component 為 `required`
  綁定。對 `#fragment` 內容做 `required` 綁定在模型上值得商榷（fragment 未必涵蓋
  上游全部代碼），但改綁定強度屬規範性變更，超出本 JOB 範圍。**列為觀察項**。
- **CodeSystem 宣告名未改 UpperCamelCase。** 只有 ValueSet 的 `vsd-0` 有實測筆數（4 筆）；
  CodeSystem 未見對應告警，不做未經量測的改動。

### 7.4 殘留風險

本 IG 產出中仍存在 9 個掛在他方命名空間下的資源。`#fragment` 已將其正名為
「局部複本」，但**命名空間本身仍非本專案所有**。若 TWCR_SF 日後於同一 canonical
發佈與本 stub 不同的內容，同時載入兩者的系統會遇到衝突——而本 stub 之代碼清單
（嚼檳榔量 91 碼、年 100 碼、戒檳榔年 91 碼）**未經上游核對，無從核對**。

唯一的根本解法是上游正式發佈套件（G-5），屬行政協調，§4 已列為本 JOB 範圍外。

### 7.5 預期量測

`SHOULD conform to the ShareableValueSet profile` 4 筆與 `Constraint failed: vsd-0`
4 筆應歸零（§2 共同驗收）。**由 CI 認定，不預先宣稱。**
