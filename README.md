# 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG - TWHA IG)

臺灣勞工健康檢查與臨場健康服務執行紀錄之 FHIR 實作指引。本指引依據中華民國《勞工健康保護規則》設計，並繼承「臺灣核心實作指引」(Taiwan Core IG / TW Core IG)，以勞工健康檢查為核心，並可向特殊職類與一般健康檢查／成人預防保健需求擴充。

## 專案簡介
* **ID**: `mohw.tw.twha`
* **Canonical**: `https://twcore.mohw.gov.tw/ig/twha`（`twha` 為技術命名空間 token，詳見 [terminology.md](input/pagecontent/terminology.md)）
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
* **tw.gov.mohw.twcore**: `1.0.0`（`sushi-config.yaml` 之 IG 套件依賴）
* 嚼檳榔相關 CodeSystem/ValueSet 引用臺灣癌症登記短表實作指引 (TWCR_SF, `hapi.fhir.tw`) 之外部 canonical URL（見 `sushi-config.yaml` 之 `parameters.special-url`），非套件層級依賴。

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

### 2026-07-10 更新 (依 develop.md 對接文件一/二/三 v1.1)
- **正式名稱與架構定位**：`sushi-config.yaml`、`README.md`、`index.md`、`background.md` 之標題與敘述改回徵求書名稱「臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG)」；架構敘述由「兩層 Foundation/Domain Supplement」統一為「Core（勞工健檢）＋特殊職類／一般健檢兩類開放式擴充」。技術 ID/Canonical/`TWHA-` 前綴維持不變。
- **修正 pagecontent 失效引用**：`general-exam.md` 中不存在的 `VS_GeneralLabTests`、`VS_BetelNutStatus`、`ext-betelnut-quantity` 改為對應實際 FSH 物件（`VS-CoreDataset` extensible、TWCR_SF 元件模型）。
- **LDL-C Preferred 代碼修正**：由計算法 `13457-7` 改為直接測定法 `2089-1`（對齊文件二 §2.3），同步修正 ConceptMap、`terminology.md`、`datamodel.md`、`general-exam.md`。
- **新增 [VS-OccHealthCheck-Required](input/fsh/valuesets/VS-OccHealthCheck-Required.fsh)**：第一期法定必驗項目草案子集（一般必驗 + 噪音/鉛/粉塵三模組），待正式法規盤點後修訂。
- **Core/Extended 重分層**：將腫瘤標記（AFP/CEA/PSA/CA125/CA19-9/CA15-3/SCC/EBV/IgE）與進階心血管/自體免疫項目（Lp(a)/ApoA-I/ApoB/NT-proBNP/ANA/RF/CYFRA21-1）自 `VS-CoreDataset` 移至 `VS-ExtendedDataset`（代碼不刪除，僅重分層），使 Core 回歸最小共通集。
- **危害類別對照**：`CS-HazardType` 之 `specific-chemical` 補充子類說明，對應 `VS-SpecificChemicalType`，呼應文件一 18 類展開。
- **第一期範疇說明**：`special-exam.md` 新增段落區分「噪音/鉛/粉塵已結構化必驗」與「其餘 9 類以 LabResult-Special 通用承載」。
- **新增 [scripts/check-pagecontent-refs.js](scripts/check-pagecontent-refs.js)**：掃描 pagecontent 中 `VS_*`/`CS_*`/`ext-*`/`TWHA-*` 引用是否皆能在 `input/fsh/` 中找到對應定義，避免再度出現失效引用。

### 2026-07-10 更新（議題5／C-04：附表十特殊作業模組完整性與臨床適當性）
- **純音聽力圖 LOINC 更正與補齊**：原 `TWHA-HearingTest`／`VS-ExtendedDataset` 之頻率×耳別代碼多處錯置（如以 `89017-8`、`89028-5`、`89020-2` 等誤標左右耳頻率），且僅收錄 4 頻率。已依 LOINC `89015-2` panel 成員逐一更正，並補齊 3/6/8 kHz，成為雙耳 0.5–8 kHz 共 14 個氣導聽閾代碼，符合附表十噪音作業要求；範例 `obs-hearing` 同步更新。
- **肺功能 FEV1 代碼更正**：原以 `19868-9` 標示 FEV1，惟該碼實為 FVC（Forced vital capacity）。FEV1 之正確 LOINC 為 `20150-9`（`TWHA-PulmonaryFunction` Profile 原已正確使用），已同步修正 `VS-CoreDataset`、`VS-ExtendedDataset`、`VS-PulmonaryFunction`、`VS-OccHealthCheck-Required`、`terminology.md`、`special-exam.md` 之標示。
- **附表十 18 類涵蓋度對照表**：`special-exam.md` 新增完整 18 類特別危害作業涵蓋度審查表（對應文件一 §2.1.1），逐類標註共用／專屬項目、Preferred LOINC 與承載方式，並補齊臨床缺口：高溫作業電解質氯（`2075-0`）與 BUN、游離輻射甲狀腺功能（TSH `11580-8`／Free T4 `3024-7`）、異常氣壓心電圖、有機溶劑肝功能（γ-GT `2324-2`）、二硫化碳心血管監測、粉塵單張 PA 胸片（`24648-8`）等。
- **血中鉛雙碼**：血中鉛 Preferred `5671-3`（Lead in Blood），院內 LIS 實際報告之 `23749-5`（Lead in Specimen）列為 Acceptable。

