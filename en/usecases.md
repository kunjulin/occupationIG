# Usecases - 臺灣健康檢查資料交換實作指引 (Taiwan Health Assessment Implementation Guide, TWHA IG) v0.1.0

## Usecases

# 使用情境 (Use Cases)

本實作指引支援多元化健康檢查情境之資料交換，特別定義以下 **6 大核心使用情境 (UC-001 ~ UC-006)**。這些情境透過對應之 Exchange Package 打包傳輸，以符合臨床端、企業雇主、個人及政府平台的介接需求。

-------

## UC-001: 一般健檢 (Common General Assessment)

* **情境背景**：適用於一般非特定政策性、個人的基礎健康檢查或入學體檢，核心著重在基本生理特徵與基礎實驗室篩檢。
* **資料對象**：一般受檢民眾。
* **資料包裝**： 
* 以 `TWHA-Bundle-Document` 進行封裝，其首個 entry 為 `TWHA-Composition`，將報告的 title 標註為「一般健康檢查報告」。
* 包含基本資料與就醫事件：`TWHA-Patient`（受檢者）、`TWHA-Encounter`（就醫/體檢事件）、`TWHA-Practitioner`（醫師/護理師）、`TWHA-Organization`（實施健檢之醫療機構）。
* 包含物理檢查與生理測量項目：`TWHA-VitalSigns`（身高、體重、BMI、腰圍、血壓）。
* 基礎實驗室檢驗項目：`TWHA-LabResult-General`（如血糖值）。
* 醫師臨床總評：`TWHA-ClinicalImpression`（健康管理分級判定）。
 
* **對應範例**：[UC-001 一般健康檢查報告封包範例](Bundle-UC-001.md)。

-------

## UC-002: 勞工一般健檢 (Occupational General Health Check)

* **情境背景**：依據《勞工健康保護規則》附表九與附表十一規定，雇主僱用新進勞工或對在職勞工進行定期一般體格及健康檢查。
* **資料對象**：受檢在職勞工。
* **資料包裝**： 
* 包含 UC-001 的所有基礎欄位，且將報告 title 標註為「勞工一般體格及健康檢查紀錄」。
* **擴充受檢者雇主資訊**：`TWHA-Patient` 必須包含雇主事業單位（統一編號）、受僱日期與所屬部門。
* **生活習慣與既往史調查**：`TWHA-SocialHistory` 記錄吸菸、飲酒、嚼檳榔與睡眠時間；`TWHA-Condition` 記錄高血壓、糖尿病等既往病史。
* **自覺症狀問卷結果**：`TWHA-QuestionnaireResponse` 記錄受檢者之自覺症狀問卷填寫紀錄。
* **法定物理與實驗室檢查**：包含視力與辨色力（`TWHA-Vision`）、聽力篩檢（`TWHA-Hearing`）以及完整的法定尿液/血液化學檢驗項目。
* **醫師適性配工建議**：針對異常個案，醫師評估後可提供 `TWHA-CarePlan`（適性配工計畫）或 `TWHA-ServiceRequest`（追蹤檢查要求）。
 
* **對應範例**：[UC-002 勞工一般體格與健康檢查報告封包範例](Bundle-UC-002.md)。

-------

## UC-003: 特殊作業健檢 (Occupational Special Health Check)

* **情境背景**：針對從事特別危害健康作業（如噪音、鉛、粉塵等 12 大類特別危害）之勞工實施定期特殊健康檢查，對應《勞工健康保護規則》附表十。
* **資料對象**：從事特別危害健康作業之勞工。
* **資料包裝**： 
* 報告 title 標註為「特殊危害健康作業檢查報告」。
* **暴露作業登錄**：`TWHA-WorkExposure` 記錄危害作業類別（如噪音、鉛）、暴露年數與詳細工作性質。
* **特殊檢查指標**： 
* 噪音作業：`TWHA-HearingTest` 記錄氣導聽閾（純音聽力圖 500Hz ~ 8000Hz 數值）。
* 鉛作業：`TWHA-LabResult-Special` 記錄血中鉛/尿中鉛/尿 delta-ALA 等生物監測值。
* 粉塵作業：`TWHA-ImagingStudy`（胸部 X 光大片造影）與 `TWHA-PulmonaryFunction`（肺功能 Spirometry：FVC, FEV1, FEV1/FVC 比值）。
 
 
* **對應範例**：[UC-003 特殊危害健康作業檢查報告封包範例](Bundle-UC-003.md)。

-------

## UC-004: 企業健檢 (Corporate Premium Health Assessment)

* **情境背景**：企業為員工提供之進階自費高階健康檢查，或個人於健檢中心進行之自費檢查，通常包含許多影像造影與鏡檢。
* **資料對象**：受檢勞工或一般民眾。
* **資料包裝**： 
* 報告 title 標註為「自費健康檢查報告」。
* **進階影像造影與鏡檢**：以 Observation 資源記錄多項高階檢查結果，如乳房攝影（LOINC `24606-6`）、腦部 MRI（LOINC `24590-2`）、低劑量電腦斷層 LDCT（LOINC `79086-5`）、全身正子造影 PET/CT（LOINC `81555-5`）、心臟冠狀動脈攝影 CTA（LOINC `79073-3`）、胃鏡鏡檢 EGD（LOINC `28014-9`）、大腸鏡鏡檢（LOINC `28023-0`）。
 
* **對應範例**：[UC-004 企業自費健康檢查報告封包範例](Bundle-UC-004.md)。

-------

## UC-005: 成人預防保健 (Adult Preventive Care)

* **情境背景**：衛生福利部國民健康署提供之中老年人定期成人預防保健服務之申報與交換。
* **資料對象**：符合成人預防保健篩檢資格之受檢者。
* **資料包裝**： 
* 報告 title 標註為「成人預防保健檢查報告」。
* **生活習慣與家屬史自填問卷**：`TWHA-QuestionnaireResponse-HT` 包含個人既往病史、直系親屬家族史（腦中風、心臟病、糖尿病）、吸菸習慣、飲酒習慣、嚼檳榔習慣及運動習慣。
* **精簡社會決定因素**：`TWHA-SDOH-Questionnaire` (精簡版 PRAPARE 社會風險問卷) 包含受檢者之教育程度、就業狀態、經濟困難等社會經濟指標。
* **生理測量與實驗室生化檢驗**：身高、體重、腰圍、血壓、空腹血糖、三酸甘油酯、總膽固醇、HDL-C、LDL-C、尿蛋白定性以及以肌酸酐估算之腎絲球過濾率 (eGFR)。
 
* **對應範例**：[UC-005 成人預防保健檢查報告封包範例](Bundle-UC-005.md)。

-------

## UC-006: 臨場服務紀錄 (On-site Labor Health Service Record)

* **情境背景**：特約醫護人員（職安衛醫護、職醫、職護）至事業單位進行臨場健康服務活動時之執行紀錄申報，對應《勞工健康保護規則》附表八。
* **資料對象**：事業單位、工作場所部門、作業環境或員工群組。
* **資料包裝**： 
* 以 `TWHA-Bundle-Document` 進行封裝，報告 title 標註為「勞工健康服務執行紀錄表」。
* 報告組成核心：`TWHA-Composition-ServiceRecord`。
* **服務訪談與事件**：`TWHA-Encounter-Service` 記錄服務活動之時程與對應事業單位部門。
* **臨場服務執行活動**：`TWHA-Procedure-ServiceActivity` 記錄該次臨場服務之主要執行工作（如健康指導、健康諮詢、現場危害分析）。
* **環境危害發現**：`TWHA-Observation-ServiceFinding` 記錄在作業現場發現之職業危害因子（如噪音暴露、局部排氣裝置異常）。
* **改善建議與追蹤任務**：`TWHA-Task-ServiceTask` 定義指派給雇主公司之改善措施及後續追蹤項目。
 
* **對應範例**：[UC-006 勞工健康服務臨場服務紀錄封包範例](Bundle-UC-006.md)。

