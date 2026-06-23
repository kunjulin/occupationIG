# 成人預防保健 (Adult Preventive Care)

成人預防保健服務由衛生福利部國民健康署提供，旨在提供中年國民早期的健康風險評估與慢性病篩檢。本指引依據成人預防保健服務之規定，設計對應之 FHIR 交換標準，並將自填問卷與臨床檢查項目收錄於 [健康檢查核心項目值集](ValueSet-VS-CoreDataset.html) 中。

---

## 1. 服務對象與頻率

*   **40歲至64歲**：每3年估算一次。
*   **65歲以上**：每年估算一次。
*   **罹患小兒麻痺且年在35歲以上者**：每年估算一次。
*   **55歲以上原住民**：每年估算一次。

---

## 2. 核心檢查與評估項目

成人預防保健資料交換模型主要由以下三個部分組成：

### 2.1 個人與家族史自填問卷 (Questionnaire & QuestionnaireResponse)
採用 `TWHA-QuestionnaireResponse-HT` Profile，記錄受檢者自填的健康行為、生活習慣與既往病史：
*   **吸菸習慣** (Smoking status)
*   **飲酒習慣** (Drinking status)
*   **嚼檳榔習慣** (Betel nut chewing status)
*   **規律運動** (Regular exercise)
*   **個人既往病史**（高血壓、糖尿病、高血脂症、心血管疾病）
*   **直系親屬家族史**（腦中風、心臟病、糖尿病）
*   **長期服藥史** (Medication history)
*   **憂鬱檢測** (Depression screening)：病人健康問卷-2 (PHQ-2) 二題篩檢。

### 2.2 身體與理學檢查 (Observation)
*   **身高與體重**：基本物理測量。
*   **身體質量指數 (BMI)**：LOINC `39156-5`，評估肥胖與健康風險。
*   **腰圍 (Waist Circumference)**：LOINC `56086-2`，評估代謝症候群風險。
*   **血壓測量**：收縮壓與舒張壓。

### 2.3 實驗室檢驗項目 (Observation - Core Dataset)
包含各項重要生化指標：
*   **尿蛋白 (Urine Protein)**
*   **空腹血糖 (Fasting Glucose)**：LOINC `1558-6`
*   **總膽固醇 (Total Cholesterol)**：LOINC `2093-3`
*   **三酸甘油酯 (Triglyceride)**：LOINC `2571-8`
*   **高密度脂蛋白膽固醇 (HDL-C)**：LOINC `2085-9`
*   **低密度脂蛋白膽固醇 (LDL-C)**：LOINC `13457-7`
*   **腎絲球過濾率 (eGFR)**：以肌酸酐估算之腎功能指標（LOINC `88293-6` 等）。
*   **肝炎篩檢**：B型肝炎表面抗原（HBsAg）與C型肝炎抗體（anti-HCV）。

### 2.4 健康諮詢與衛教指導 (Procedure)
採用 `TWHA-Procedure-Counseling` Profile，記錄醫護團隊實際辦理之 10 大法定衛教指導事項：
1. 戒菸諮詢與衛教
2. 節酒諮詢與衛教
3. 戒檳榔諮詢與衛教
4. 規律運動諮詢與衛教
5. 維持正常體重諮詢與衛教
6. 健康飲食諮詢與衛教
7. 事故傷害預防諮詢與衛教
8. 口腔保健諮詢與衛教
9. 慢性疾病風險評估諮詢與衛教
10. 腎病識能衛教指導

---

## 3. 封包包裝範例 (Exchange Package)

當醫療院所向國健署平台申報或與其他機構交換成人預防保健資料時，須將上述病人基本資料、就醫事件、自填問卷回覆、生理與理學檢查、實驗室檢驗數據，以及健康諮詢執行紀錄，共同包裝於 `TWHA-Bundle-Document` 格式中。

完整範例請參閱 [UC-005 成人預防保健檢查報告封包範例](Bundle-UC-005.html)。

