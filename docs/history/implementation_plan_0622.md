# 臺灣健康檢查資料交換實作指引 (TWHA IG) 成人預防保健與 3 層術語值集調整實作計畫

本計畫書旨在針對衛生福利部最新合約書中，關於「成人預防保健 (Health Taiwan)」四大面向（基本資料問卷、身體檢查、實驗室檢查、健康諮詢）的要求，檢視現行實作指引 (TWHA IG) 的落差，並擬定具體的調整與更新計畫。

同時，針對健康檢查核心資料集中，部分檢驗項目（如 WBC、血糖、肌酸酐等）存在多個 LOINC 代碼之術語對應議題，本計畫書提出具體的「三層 ValueSet 與 ConceptMap 術語管理機制」，以滿足臨床實務之彈性與資料互操作性。

---

## 現行 IG 與新版衛福部規範差異分析 (Gap Analysis)

依據衛福部新規範，成人預防保健服務之四大核心面向要求與現行 IG 的對比及落差如下：

### 1. 基本資料（自填問卷）
*   **規範要求**：涵蓋疾病史、家族史、服藥史、健康行為、憂鬱檢測等。
*   **現行 IG 狀態**：
    *   已於 `adult-preventive-care-questionnaire` 中定義了吸菸 (`smoking`)、飲酒 (`drinking`)、嚼檳榔 (`betelnut`)、規律運動 (`exercise`)、既往疾病史 (`past-history`)、直系親屬家族史 (`family-history`)。
*   **落差 (Gap)**：
    *   **缺少「服藥史」 (Medication History)**：未有詢問受檢者目前是否長期服用三高或慢性病藥物之欄位。
    *   **缺少「憂鬱檢測」 (Depression Screen)**：未包含標準 PHQ-2（病人健康問卷-2）的兩題篩檢題目。

### 2. 身體檢查
*   **規範要求**：一般理學檢查、身高、體重、血壓、身體質量指數 (BMI)、腰圍。
*   **現行 IG 狀態**：
    *   `TWHAVitalSignsProfile` 與值集 `VS_TWHAVitalSigns` 包含身高、體重、腰圍、收縮壓、舒張壓。
    *   `TWHAPhysicalExamProfile` 包含各系統部位之一般理學檢查。
*   **落差 (Gap)**：
    *   **值集中缺少「身體質量指數 (BMI)」**：雖然現行文件有提及，但在 `VS_TWHAVitalSigns` 值集中漏掉了 BMI 的 LOINC 代碼 `39156-5`，且無 BMI 實例範例。

### 3. 實驗室檢查
*   **規範要求**：
    *   (1) 尿液蛋白質
    *   (2) eGFR 計算
    *   (3) 血液生化（GOT, GPT, 肌酸酐, 血糖, 總膽固醇, 三酸甘油酯, HDL, LDL 計算, 尿酸）
    *   (4) B型肝炎表面抗原 (HBsAg) 及 C型肝炎抗體 (anti-HCV)
*   **現行 IG 狀態**：
    *   上述所有項目的優先 LOINC 代碼均已收錄於 `VS_CoreDataset` 中，且結構定義完整。
*   **落差 (Gap)**：
    *   **代碼單一性與歷史代碼相容性議題**：目前為扁平值集，若院所上傳非優先 LOINC 代碼（如 WBC 手動計數或體液代碼），將面臨驗證錯誤。
    *   **缺少多代碼對應架構 (3層值集機制)**：未正式定義優先代碼與可接受代碼之間的關聯對應。

### 4. 健康諮詢
*   **規範要求**：戒菸、節酒、戒檳榔、規律運動(含150分鐘/每週)、維持正常體重、健康飲食(含我的健康餐盤)、事故傷害預防、口腔保健、慢性疾病風險評估、腎病識能衛教指導。
*   **現行 IG 狀態**：
    *   現行 IG 著重於臨場服務活動 (`Procedure`) 及適性配工計畫 (`CarePlan`)，尚無針對上述 10 項特定健康諮詢/衛教指導的專屬代碼或 Profile。
*   **落差 (Gap)**：
    *   **缺少「健康諮詢與衛教指導」的 Profile 與代碼值集**：臨床端無法以結構化代碼標記完成了哪幾項健康諮詢。

---

## 建議調整方案 (Proposed Solutions)

### 1. 自填問卷擴充 (Medication History & Depression Screening)
*   在問卷定義 `adult-preventive-care-questionnaire` 中新增 3 個 item：
    1.  `medication-history` (長期服藥史，boolean)：「您目前是否因高血壓、糖尿病、高血脂症或心血管疾病等而長期服藥？」
    2.  `depression-interest` (憂鬱檢測 1，PHQ-2-Q1，integer)：「過去兩星期，您是否經常感覺做事提不起勁或沒有樂趣？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)」
    3.  `depression-mood` (憂鬱檢測 2，PHQ-2-Q2，integer)：「過去兩星期，您是否經常感覺心情低落、沮喪或絕望？(0:完全沒有, 1:幾天, 2:一半以上的天數, 3:幾乎每天)」
*   更新範例實例 `adult-preventive-care-response` 以包含這三個新問卷回覆答案。

### 2. 身體檢查擴充 (BMI)
*   在 `VS_TWHAVitalSigns` 值集中新增：
    *   `LNC#39156-5` "Body mass index (BMI) [Ratio]"
*   在範例中新增一個 BMI 測量實例 `obs-bmi` (22.86)，並將其加入至成健報告 Composition (`composition-uc005`) 及交換封包 (`UC-005` Bundle) 中。

### 3. 三層 ValueSet 與 ConceptMap 術語管理機制
我們將建立三層架構，並以 FHIR Extensible Binding 及 ConceptMap 來實現：
*   **Layer 1 (Preferred Code - 強制推薦)**：
    *   每個核心檢驗項目指定 1 個最優先代碼。
*   **Layer 2 (Acceptable Codes - 可接受集合)**：
    *   將同義或情境相近的 LOINC 代碼納入 `VS_CoreDataset` (作為 Extensible 綁定目標)，使其在驗證時可順利通過。
*   **Layer 3 (Exclusion - 排除/非範疇)**：
    *   在術語指引網頁明確說明哪些代碼 (例如體液檢體代碼) 排除在成人健檢範疇之外。
*   **建立 ConceptMap 資源 (`TWHealthCheckLaboratoryMap`)**：
    *   將 Layer 2 的所有「可接受代碼」明確對應到 Layer 1 的「優先推薦代碼」，供接收端系統進行標準化轉換。

#### 代碼映射對照表 (核心範例)
| 檢驗項目 | Layer 1 (Preferred) | Layer 2 (Acceptable) | Layer 3 (Excluded) |
| :--- | :--- | :--- | :--- |
| **WBC 白血球** | `6690-2` (自動計數) | `6690-2`, `804-5` (手動), `26464-8` (未指定) | `12227-5` (體液) |
| **尿液蛋白質** | `5804-0` (試紙定性) | `5804-0`, `2888-6` (定量) | 其它非尿液檢體 |
| **Fasting Glucose 飯前血糖** | `1558-6` (血清/血漿空腹) | `1558-6`, `2339-0` (全血) | 飯後血糖、尿糖 |
| **Creatinine 肌酸酐** | `2160-0` (血清/血漿) | `2160-0`, `38483-4` (全血) | 尿肌酸酐 (除比值外) |
| **eGFR 腎絲球過濾率** | `88293-6` (CKD-EPI 2021) | `88293-6`, `33914-3` (MDRD) | 兒科公式、非標準化 |
| **LDL-C 低密度脂蛋白** | `13457-7` (計算式) | `13457-7`, `18262-6` (直接法) | 其它脂蛋白 |
| **HBsAg B肝抗原** | `5196-1` (血清) | `5196-1`, `22326-3` (血清/血漿) | 其它B肝指標 |
| **anti-HCV C肝抗體** | `13955-0` (血清/血漿) | `13955-0`, `47365-2` (全血) | HCV RNA |

### 4. 新增健康諮詢與衛教指導模組 (Procedure)
*   **代碼系統與值集定義**：
    *   新增 `CS_HealthCounseling` 代碼系統與 `VS_HealthCounseling` 值集，定義上述 10 項衛教指導項目。
*   **Profile 定義**：
    *   建立 `TWHAProcedureCounselingProfile` ("健康諮詢與衛教指導 Profile")，繼承自 `TWCoreProcedure`：
        *   `status` 固定為 `#completed`。
        *   `code` 綁定至 `VS_HealthCounseling` (required)。
        *   `subject` 指向 `TWHAPatientProfile`。
        *   `encounter` 關聯至健檢事件。
*   **範例與組成更新**：
    *   新增健康諮詢 Procedure 範例 `example-procedure-counseling`，記錄為患者進行了「規律運動諮詢」與「腎病識能衛教指導」。
    *   修改 `TWHACompositionProfile`，允許 `section[assessment].entry` 包含 `Procedure` 資源。
    *   更新 `composition-uc005` 報告與 `UC-005` 交換封包，納入該諮詢範例。

---

## 具體修訂檔案與 Proposed Changes

### Component 1: 術語與值集定義 (Terminology & ValueSets)
*   [MODIFY] [VS-TWHAVitalSigns.fsh](file:///e:/repos/occupation_IG/input/fsh/valuesets/VS-TWHAVitalSigns.fsh): 新增 BMI 的 LOINC `39156-5` 代碼。
*   [MODIFY] [VS-CoreDataset.fsh](file:///e:/repos/occupation_IG/input/fsh/valuesets/VS-CoreDataset.fsh): 將 WBC 等項目的可接受代碼 (Layer 2) 併入核心值集，確保 extensible 驗證相容性。
*   [NEW] [CS-HealthCounseling.fsh](file:///e:/repos/occupation_IG/input/fsh/codesystems/CS-HealthCounseling.fsh): 新增包含 10 項健康諮詢項目的 CodeSystem 與 ValueSet。
*   [NEW] [ConceptMap-TWHealthCheckLaboratoryMap.fsh](file:///e:/repos/occupation_IG/input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh): 新增 3層架構的 LOINC 映射 ConceptMap。

### Component 2: 結構設定檔重構 (Profiles)
*   [MODIFY] [TWHA-QuestionnaireResponse-HT.fsh](file:///e:/repos/occupation_IG/input/fsh/profiles/TWHA-QuestionnaireResponse-HT.fsh): 擴充成健問卷的 Medication History 及 PHQ-2 憂鬱篩檢題目。
*   [MODIFY] [TWHA-Composition.fsh](file:///e:/repos/occupation_IG/input/fsh/profiles/TWHA-Composition.fsh): `section[assessment].entry` 限制放寬，允許包含 `Procedure` 資源。
*   [NEW] [TWHA-Procedure-Counseling.fsh](file:///e:/repos/occupation_IG/input/fsh/profiles/TWHA-Procedure-Counseling.fsh): 定義專屬的健康諮詢 Procedure Profile。

### Component 3: 實體範例建置 (Examples & Bundles)
*   [MODIFY] [examples.fsh](file:///e:/repos/occupation_IG/input/fsh/examples/examples.fsh):
    *   更新 `adult-preventive-care-response` 加入服藥史及憂鬱篩檢回覆答案。
    *   新增 BMI 生命徵象實例 `obs-bmi`。
    *   新增健康諮詢 Procedure 實例 `example-procedure-counseling`。
    *   更新 `composition-uc005` 與 `UC-005` Bundle，將上述實例封裝進去。

### Component 4: 靜態網頁內容更新 (Documentation)
*   [MODIFY] [adult-preventive-care.md](file:///e:/repos/occupation_IG/input/pagecontent/adult-preventive-care.md): 更新成人預防保健說明，提及新增的問卷欄位、BMI 及健康諮詢 Procedure。
*   [MODIFY] [terminology.md](file:///e:/repos/occupation_IG/input/pagecontent/terminology.md): 新增三層 LOINC 術語管理機制說明、ConceptMap 對照表以及健康諮詢代碼系統說明。

---

## 驗證與測試計畫 (Verification Plan)

### 自動化測試
*   使用 SUSHI 編譯專案，確認無 FSH 語法錯誤：
    ```bash
    npx fsh-sushi .
    ```
*   執行 HL7 IG Publisher 進行全站靜態網站與 FHIR Profile 驗證，確認 0 Error：
    ```bash
    _genonce.bat
    ```
*   利用官方 Java Validator 驗證範例 Bundle（特別是修改後的 `Bundle-UC-005`），確保其完全符合 R4 與 TW Core 的 Profile 規範：
    ```bash
    java -jar input-cache/publisher.jar -ig ig.ini -source input/fsh/examples/examples.fsh (或驗證 output 中生成的 json 檔案)
    ```

### 手動驗證
*   開啟本地編譯產生的 `output/index.html`，點擊並檢查：
    1. `TWHA-QuestionnaireResponse-HT` 的結構定義，確認已出現服藥史及憂鬱檢測欄位。
    2. `TWHA-Procedure-Counseling` 的結構定義與值集連結。
    3. `ConceptMap-TWHealthCheckLaboratoryMap` 是否正常顯示代碼映射關係。
    4. `UC-005` 範例封包是否正確包含 QuestionnaireResponse (含新問卷回覆)、BMI、健康諮詢 Procedure 以及各項生化檢驗。
