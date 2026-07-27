# 臺灣健康檢查資料交換實作指引 (TWHA IG) 調整評估與實作計畫書 (最終決定版)

本計畫書旨在對比當前開發之「臺灣勞工職業健康體格及健康檢查實作指引 (OHE IG)」與工業技術研究院 (ITRI) 委託之「臺灣健康檢查資料交換實作指引 (TWHA IG) 建置計畫規劃書」新案規劃，並依據您的最新決策調整實作內容。

---

## 專案決策與實作共識

依據您的指示，本專案將以下列決策進行調整：

1. **直接在現有的 `occupation_IG` 倉庫中進行改名與重構**。我們不會建立新倉庫，而是直接就地升級，將 ID 改為 `mohw.tw.twha`，Canonical URL 改為 `https://twcore.mohw.gov.tw/ig/twha`。
2. **SDOH 問卷範圍**：精簡定義 **5-6 個核心欄位**（例如：教育程度、就業狀態、居住環境安全、主要照顧壓力、經濟困難等）。
3. **成人預防保健與一般自費健檢之問卷**：額外建置獨立的 **Questionnaire (問卷定義)** 與對應的 **QuestionnaireResponse (問卷回覆)** 資源，用以涵蓋成人預防保健與自費健檢的自覺症狀與生活習慣問卷。

---

## 專案範疇與架構差異對比

| 評估維度 | 當前專案 (OHE IG) | 新案規劃 (TWHA IG) | 調整方案 |
| :--- | :--- | :--- | :--- |
| **專案名稱與 ID** | `mohw.tw.ohe` / OHE IG | `mohw.tw.twha` / TWHA IG | **需要重構**。更換專案識別碼、Canonical URL、目錄名稱及所有 FSH 資源名稱（前綴從 `OHE` 改為 `TWHA`）。 |
| **涵蓋範疇** | 僅限於「勞工職業健康檢查 (附表八~十一)」 | (1) 一般健康檢查<br>(2) 勞工健康檢查<br>(3) 成人預防保健 (Health Taiwan) | **範疇擴大**。整合勞工健檢、國健署成健、與一般自費健檢。 |
| **系統架構** | 單層扁平化結構 | **雙層架構**：<br>1. Foundation Layer (共通核心)<br>2. Domain Supplement (領域擴充) | **拆分 Profiles**。區分基礎共通核心 Profiles 與特定領域擴充 Profiles。 |
| **新概念引入** | 無特定 SDOH 模組 | 引入 **SDOH (精簡)** | **新增問卷**。設計精簡版 PRAPARE 社會風險問卷（含 5-6 個核心欄位）的 Questionnaire 與 QuestionnaireResponse Profile。 |
| **資料治理原則** | 常規 Must Support、值集獨立維護 | 1. 強化 DataAbsentReason (Invariant 限制)<br>2. **極簡化 ValueSet** (Core 與 Extended 兩組) | **收緊規則**。在 Observation 中加入 Invariant 限制式，並將零散的值集整合收斂為 Core 與 Extended 兩大主體值集。 |
| **傳輸封包設計** | 僅提供 Document Bundle 範例 | 建立 **TWHA-EP 交換封包**：<br>1. Document Bundle (報告用)<br>2. Transaction Bundle (上傳用)<br>3. CapabilityStatement | **建置交換封包規格**。正式定義報告用與上傳用之兩個 Bundle Profile，並撰寫 CapabilityStatement 描述交互作用。 |
| **實用範例 (UC)** | 多個隨機範例 | 規範 **6 個特定案例 (UC-001 ~ UC-006)** 的完整 Example Bundle | **全面重構範例**。建置 6 個對應情境的 Example Bundle，並通過驗證。 |

---

## 新案 KPI 評估與達成路徑

依據規劃書「九、驗收指標」，評估達成方案如下：

*   **指標 1：完成 100 項以上之 Core Dataset**
    *   *解決方案*：將目前 `VS-GeneralLabTests` 的 126 項 LOINC 正式包裝為 `Core Dataset` (Core ValueSet)。
*   **指標 2：完成附表八~十一之 FHIR Mapping (100% 對應)**
    *   *解決方案*：保留現有對應，並將對應關係整理至專屬的 `OHC Mapping Guide` 說明網頁中。
*   **指標 3：完成 FHIR Profiles 並通過 IG Publisher 驗證 (0 Error)**
    *   *解決方案*：重構後重新進行本地端 IG Publisher 編譯，並排查解決所有潛在錯誤。
*   **指標 4：完成 6 個 Example Bundle 並通過 FHIR Validator**
    *   *解決方案*：全新建立這 6 個特定場景的 Transaction/Document Bundle (UC-001 ~ UC-006)，並通過驗證。
*   **指標 5：完成 Exchange Package 並完成交換示範 (Round-trip 成功)**
    *   *解決方案*：使用公開的 HAPI FHIR 測試伺服器或本地 Validator 示範資料上傳 (POST) 與回讀成功。
*   **指標 6：完成公開 IG 網站 (GitHub Pages)**
    *   *解決方案*：配合專案名稱修改，更換託管路徑。

---

## 調整實作 Plan (分階段執行建議)

我們將按以下敏捷步驟執行重構：

### 階段一：專案基礎重命名與治理規則配置
1. 修改 `sushi-config.yaml` 變更專案 ID 為 `mohw.tw.twha`，Canonical 為 `https://twcore.mohw.gov.tw/ig/twha`，專案名稱為 `TWHA IG`。
2. 在所有 Observation Profiles 中加入 Invariant 限制式：
   `"value.exists() or dataAbsentReason.exists()"`

### 階段二：雙層 Profile 建置與問卷建置
1. **Foundation Layer Profiles**：
   * `TWHA-Patient`、`TWHA-Organization`、`TWHA-Practitioner`、`TWHA-Encounter`
   * `TWHA-Observation-Social` (社會史)
   * `TWHA-Observation-Vital` (生命徵象)
   * `TWHA-Observation-Lab` (實驗室檢驗)
   * `TWHA-Observation-Screening` (篩檢項目)
2. **Domain Supplement Profiles**：
   * **OHC 擴充**：`TWHA-Composition-OHC` (健檢報告組成)、`TWHA-ClinicalImpression-OHC` (分級總評)
   * **Health Taiwan (成人預防保健) 擴充**：`TWHA-QuestionnaireResponse-HT` (成人預防保健問卷回覆)
   * **自費健檢問卷**：對應 Questionnaire 定義與 Response。
   * **SDOH 擴充**：精簡版 PRAPARE 問卷（5-6 個欄位）。
3. **值集收斂**：將現有實驗室項目與特殊檢驗 LOINC 合併，分別定義為 `ValueSet-CoreDataset` (Core) 與 `ValueSet-ExtendedDataset` (Extended)。

### 階段三：Exchange Package 與 6 大實用範例 (UC-001 ~ UC-006)
1. 建立交換封包定義：`TWHA-Bundle-Document` 與 `TWHA-Bundle-Transaction`。
2. 撰寫 `CapabilityStatement-TWHA` 描述上傳互動模式。
3. 建置 6 個實體範例 Bundle (UC-001 ~ UC-006)，並使用 FHIR Validator 進行格式驗證。

### 階段四：網站編譯、Round-trip 測試與公開發布
1. 執行 SUSHI 與 IG Publisher 進行 0 Error 編譯。
2. 利用公開 HAPI FHIR 伺服器進行 Round-trip 示範（產生 -> 封裝 -> 上傳 -> 解析回讀）。
3. 發布靜態網站至 GitHub Pages。
