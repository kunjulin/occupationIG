# 臺灣勞工職業健康體格及健康檢查實作指引 (Taiwan Occupational Health Examination Implementation Guide - TWOHEIG)

臺灣勞工健康檢查與臨場健康服務執行紀錄之 FHIR 實作指引。本指引依據中華民國《勞工健康保護規則》設計，並繼承「臺灣核心實作指引」(Taiwan Core IG / TW Core IG)。

## 專案簡介
* **ID**: `mohw.tw.ohe`
* **Canonical**: `https://twcore.mohw.gov.tw/ig/ohe`
* **FHIR 版本**: `4.0.1` (R4)
* **發布者**: 衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院

---

## 專案結構與目錄說明

* `input/`：包含 IG 的原始輸入內容，如頁面內容（`pagecontent/`）、FHIR 資源定義等。
* `sushi-config.yaml`：SUSHI 編譯器的設定檔，包含專案中繼資料、依賴項以及導覽選單配置。
* `ig.ini`：HL7 IG Publisher 的設定檔。
* `_genonce.bat`：用於一鍵下載 IG Publisher 並執行編譯與發布的 Windows 批次檔。
* `_updatePublisher.bat`：用於更新本地 `publisher.jar` 的批次檔。

---

## 建置與編譯步驟

本專案採用 [FSH (FHIR Shorthand)](https://hl7.org/fhir/uv/shorthand-codegen/) 與 [SUSHI](https://github.com/FHIR/sushi) 進行開發，並使用官方的 HL7 IG Publisher 來產出最終的靜態網頁與資源。

### 準備環境
1. **Node.js**：請安裝 Node.js (建議 LTS 版本)。
2. **Java JDK**：HL7 IG Publisher 執行需要 Java 環境 (建議 Java 11 或以上)。
3. **SUSHI 編譯器**：可透過 npm 安裝：
   ```bash
   npm install -g fsh-sushi
   ```

### 執行編譯
在 Windows 環境下，直接執行根目錄底下的 `_genonce.bat` 即可：
1. **SUSHI 編譯**：將 FSH 程式碼編譯為 JSON 資源（置於 `fsh-generated/` 目錄）。
2. **下載發布器**：若無 `input-cache/publisher.jar`，會自動下載最新版發布器。
3. **產出網頁**：執行 HL7 IG Publisher 產出完整的 HTML 網頁與相關 Profile 定義（產出於 `output/` 目錄）。

---

## 依賴指引 (Dependencies)
* **tw.gov.mohw.twcore**: `1.0.0`
* **fhir.twcrsf**: `0.1.1`

---

## 版本與更新記錄 (Update History)

### 2026-07-09 更新 (同步勞工體檢項目)
- **擴充值集 (ValueSet Expansion)**: 
  - [VS-CoreDataset](input/fsh/valuesets/VS-CoreDataset.fsh): 新增 83 個一般健檢檢驗項目代碼（白血球分類計數與異常細胞、葡萄糖 AC、無 P-5'-P 的 AST/ALT、直接 LDL-C、CA19-9、PSA、AFP、IgE、肝炎病毒抗體、尿液常規/沉渣鏡檢、以及新增之**糞便檢查**區段與相關代碼）。
  - [VS-ExtendedDataset](input/fsh/valuesets/VS-ExtendedDataset.fsh): 新增 11 個特殊健檢與進階檢驗項目代碼（血中/尿中重金屬錳/鎘/鉻與肌酸酐比值、沙門氏菌與志賀氏菌糞便培養、以及尿液毒品篩檢）。
- **修復錯誤與調整對應 (ConceptMap Alignment)**: 
  - **修復 LOINC 83085-1 標記錯誤**: 修正原誤將 `83085-1` (癌胚抗原 CEA by IA) 標記為 CA-125 的 Bug，將 CA-125 可接受代碼修正為 `83082-8`，並建立正確的 CEA (`83085-1` -> `2039-6`) 與 CA-125 (`83082-8` -> `10334-1`) 對應關係。
  - 新增無 P-5'-P 的 AST/ALT (`88112-8` / `1744-2`) 以及葡萄糖 AC (`2345-7`) 對應至 preferred 代碼之規則。
- **術語對照表同步**:
  - 更新 [snomed-loinc-mappings.csv](input/assets/snomed-loinc-mappings.csv) 與 [terminology.md](input/pagecontent/terminology.md)，納入 CEA (SNOMED CT `60267001`) 並修正 CA-125 的 acceptable 代碼。

