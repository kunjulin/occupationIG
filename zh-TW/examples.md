# 範例 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.3.3

## 範例

# 範例 (Examples)

本頁為**導覽用策展頁**，依使用情境與資源類別列出本指引之 **67 個範例實例**（另有 10 個內嵌於上傳封包之 inline 實例，見 §8）。

> **權威清單見[資源總覽 (artifacts.html)](artifacts.md) 之 Example Instances 區段。** 本頁僅提供分類與閱讀路徑。

所有範例共用同一組虛構人物與機構（受檢勞工「王大同」、事業單位「大同電子」、健檢醫師「林職醫」）， 使跨情境之資源可互相參照，便於整段閱讀。**範例資料均為虛構，不得作為臨床或法規判斷依據。**

-------

## 0. 建議閱讀路徑

| | |
| :--- | :--- |
| 第一次接觸本指引 | §1 交換封包一覽 → 挑一個封包展開看其組成 |
| 健檢機構資訊人員（產出報告） | §1 UC-001～UC-007 → §2 對應情境 → §3 共用角色 |
| 平台端（接收上傳） | §1 UC-008／UC-009 → §7 上傳路徑特殊示範 → §8 inline 實例 |
| 委員／審查人員 | §1 → §7（缺值處理、雇主端揭露界線） |

-------

## 1. 交換封包一覽（建議先看這裡）

每個封包（Bundle）即一次完整交換之最小單位，其內含之各項資源可自封包頁面逐一展開。

| | | | |
| :--- | :--- | :--- | :--- |
| **UC-001**一般健康檢查 | [Bundle-UC-001](Bundle-UC-001.md) | Document | 一般健康檢查結果之報告封包 |
| **UC-002**勞工一般體格與健康檢查 | [Bundle-UC-002](Bundle-UC-002.md) | Document | 《勞工健康保護規則》附表九項目之報告封包 |
| **UC-003**特殊危害健康作業檢查 | [Bundle-UC-003](Bundle-UC-003.md) | Document | 噪音／鉛／粉塵等附表十作業之報告封包 |
| **UC-004**企業自費健康檢查 | [Bundle-UC-004](Bundle-UC-004.md) | Document | 含自費影像造影與內視鏡檢查項目 |
| **UC-005**成人預防保健 | [Bundle-UC-005](Bundle-UC-005.md) | Document | 國健署成人預防保健自填問卷與理學生化檢查 |
| **UC-006**勞工健康服務臨場服務紀錄 | [Bundle-UC-006](Bundle-UC-006.md) | Document | 附表八臨場服務紀錄 |
| **UC-007**職業健康急診友善摘要 | [Bundle-UC-007](Bundle-UC-007.md) | Document | 供急診醫師快速掌握職業暴露背景 |
| **UC-008**一般健檢結果上傳（首次） | [Bundle-UC-008](Bundle-UC-008.md) | Transaction | 向主管機關平台上傳；示範 urn:uuid 內部參照與條件式建立 |
| **UC-009**特殊健檢結果上傳（含缺值與冪等重傳） | [Bundle-UC-009](Bundle-UC-009.md) | Transaction | 示範以報告識別碼條件式更新，重傳不產生重複資料 |

> UC-001～UC-007 為**報告交換**（`type = document`），UC-008／UC-009 為**上傳**（`type = transaction`）。 二者之語意差異與 `$submit` 契約見[遵從性與依賴](conformance.md)；transaction／batch 之最終語意仍待平台端定案（見[未決事項](open-issues.md)）。

-------

## 2. 報告文件骨架 (Composition)

每個 Document Bundle 之第一個 entry 均為 Composition，決定該份報告之章節結構。

| | |
| :--- | :--- |
| [composition-uc001](Composition-composition-uc001.md) | 一般健檢報告組成文件範例 (UC-001) |
| [composition-uc002](Composition-composition-uc002.md) | 勞工一般體格與健康檢查報告組成文件範例 (UC-002) |
| [composition-uc003](Composition-composition-uc003.md) | 特殊危害健康作業檢查報告組成文件範例 (UC-003) |
| [composition-uc004](Composition-composition-uc004.md) | 自費健康檢查與進階影像鏡檢報告組成文件範例 (UC-004) |
| [composition-uc005](Composition-composition-uc005.md) | 成人預防保健檢查報告組成文件範例 (UC-005) |
| [example-composition-service](Composition-example-composition-service.md) | 臨場服務紀錄組成文件範例 (UC-006) |
| [composition-emergency-summary](Composition-composition-emergency-summary.md) | 職業健康急診友善摘要範例 (UC-007) |
| [example-composition-employer-summary](Composition-example-composition-employer-summary.md) | 雇主端健康管理摘要範例 |

> **注意揭露界線**：`example-composition-employer-summary`（雇主端）與 `composition-emergency-summary`（醫護端）為刻意對照之一組—— 前者僅含健康管理分級、適性配工建議與臨場服務發現，**不含任何檢驗數值**；後者含關鍵檢驗值。相關政策界線見[未決事項](open-issues.md)。

-------

## 3. 共用角色與基礎資料

以下六個實例為所有情境共用之人物、機構與就醫事件，先讀這一組再看檢查結果會較易理解資源之間的參照關係。

| | |
| :--- | :--- |
| [example-worker](Patient-example-worker.md) | 受檢勞工範例 - 王大同 |
| [example-employer](Organization-example-employer.md) | 雇主事業單位範例 - 大同電子 |
| [example-hospital](Organization-example-hospital.md) | 實施健檢之醫療機構範例 - 航空醫務中心 |
| [example-doctor](Practitioner-example-doctor.md) | 執業醫護人員範例 - 林職醫 |
| [example-nurse](Practitioner-example-nurse.md) | 執業醫護人員範例 - 陳健護 |
| [example-encounter-general](Encounter-example-encounter-general.md) | 健檢就醫事件範例 - 一般定期健康檢查 |
| [example-encounter-special](Encounter-example-encounter-special.md) | 健檢就醫事件範例 - 噪音作業特殊健康檢查 |
| [example-encounter-service](Encounter-example-encounter-service.md) | 臨場服務事件範例 |
| [obs-occupation](Observation-obs-occupation.md) | 工作經歷與職業別範例 |

> `example-doctor` 與 `example-nurse` 為刻意並列——用以示範 `Observation.performer` 之「人員」型態； 機構型態則以 `example-hospital` 承載。

-------

## 4. 檢查結果範例

### 4.1 生命徵象與理學檢查

| | |
| :--- | :--- |
| [obs-height](Observation-obs-height.md) | 身高測量結果範例 |
| [obs-weight](Observation-obs-weight.md) | 體重測量結果範例 |
| [obs-waist](Observation-obs-waist.md) | 腰圍測量結果範例 |
| [obs-bmi](Observation-obs-bmi.md) | 身體質量指數 (BMI) 測量結果範例 |
| [obs-bloodpressure](Observation-obs-bloodpressure.md) | 血壓測量結果範例 |
| [obs-physical](Observation-obs-physical.md) | 理學檢查結果範例 |

### 4.2 生理功能檢查

| | |
| :--- | :--- |
| [obs-vision](Observation-obs-vision.md) | 視力及辨色力檢查結果範例 |
| [obs-hearing](Observation-obs-hearing.md) | 聽力檢查結果範例 |
| [obs-pulmonary](Observation-obs-pulmonary.md) | 肺功能檢查結果範例 |
| [obs-ecg](Observation-obs-ecg.md) | 心電圖檢查結果範例 |

### 4.3 實驗室檢驗

| | |
| :--- | :--- |
| [obs-lab-glucose](Observation-obs-lab-glucose.md) | 實驗室檢驗範例 - 空腹血糖 |
| [obs-lab-egfr-absent](Observation-obs-lab-egfr-absent.md) | 實驗室檢驗缺值範例 - eGFR 未檢測（dataAbsentReason） |

### 4.4 影像檢查

| | |
| :--- | :--- |
| [example-imaging-chest-xray](ImagingStudy-example-imaging-chest-xray.md) | 健檢影像檢查範例 - 胸部 X 光 |

### 4.5 生活習慣 (Social History)

| | |
| :--- | :--- |
| [obs-smoking](Observation-obs-smoking.md) | 吸菸狀態與菸量範例 |
| [obs-smoking-former](Observation-obs-smoking-former.md) | 吸菸狀態與菸量範例 - 已戒菸 |
| [obs-betelnut](Observation-obs-betelnut.md) | 嚼檳榔狀態與量化資料範例 |
| [obs-alcohol](Observation-obs-alcohol.md) | 飲酒歷史與狀態範例 |
| [obs-sleep](Observation-obs-sleep.md) | 睡眠狀況測量範例 |

> `obs-smoking` 與 `obs-smoking-former` 為一組對照：後者示範 `ext-smoking-quantity` 與 `ext-cessation-duration` 之填寫方式。

### 4.6 職業暴露、判定與後續處置

| | |
| :--- | :--- |
| [obs-exposure-lead](Observation-obs-exposure-lead.md) | 特別危害作業暴露史範例 - 鉛作業 |
| [example-clinical-impression](ClinicalImpression-example-clinical-impression.md) | 醫師臨床總評與分級範例 |
| [obs-health-mgmt-level](Observation-obs-health-mgmt-level.md) | 健康管理分級判定範例 - 第四級管理 |
| [example-careplan-fitness](CarePlan-example-careplan-fitness.md) | 適性配工計畫範例 - 第四級管理之工作調整 |
| [example-servicerequest-followup](ServiceRequest-example-servicerequest-followup.md) | 追蹤檢查要求範例 - 三個月後聽力複檢 |
| [example-past-condition](Condition-example-past-condition.md) | 既往病史範例 - 高血壓 |
| [example-diagnostic-report](DiagnosticReport-example-diagnostic-report.md) | 健檢診斷報告範例 - 噪音作業特殊健康檢查 |

### 4.7 自費健檢項目（UC-004）

以下七項為企業自費健檢常見之進階影像與內視鏡項目，非法定必檢項目。

| | |
| :--- | :--- |
| [obs-imaging-mammo](Observation-obs-imaging-mammo.md) | 自費健檢項目 - 乳房攝影 |
| [obs-imaging-brain-mri](Observation-obs-imaging-brain-mri.md) | 自費健檢項目 - 腦部核磁共振造影 |
| [obs-imaging-lung-ct](Observation-obs-imaging-lung-ct.md) | 自費健檢項目 - 肺部低劑量電腦斷層 |
| [obs-imaging-pet](Observation-obs-imaging-pet.md) | 自費健檢項目 - 全身正子造影 |
| [obs-imaging-cta](Observation-obs-imaging-cta.md) | 自費健檢項目 - 心臟冠狀動脈電腦斷層血管攝影 |
| [obs-endoscopy-egd](Observation-obs-endoscopy-egd.md) | 自費健檢項目 - 胃鏡檢查 |
| [obs-endoscopy-colon](Observation-obs-endoscopy-colon.md) | 自費健檢項目 - 大腸鏡檢查 |

-------

## 5. 問卷 (Questionnaire / QuestionnaireResponse)

| | |
| :--- | :--- |
| [example-questionnaire](Questionnaire-example-questionnaire.md) | 自覺症狀問卷定義範例 |
| [example-symptoms-response](QuestionnaireResponse-example-symptoms-response.md) | 自覺症狀問卷回覆範例 |
| [adult-preventive-care-response](QuestionnaireResponse-adult-preventive-care-response.md) | 成人預防保健問卷回覆實例 |
| [sdoh-questionnaire-response](QuestionnaireResponse-sdoh-questionnaire-response.md) | SDOH 社會決定因素問卷回覆實例 |

> `example-questionnaire` 為**題目定義**，其餘三者為**填答結果**。二者為不同資源類型，實作時勿混用。

-------

## 6. 臨場健康服務（附表八，UC-006）

臨場服務之資源鏈：服務事件 → 服務對象群組 → 執行活動 → 現場發現 → 改善任務。

| | |
| :--- | :--- |
| [example-group-workers](Group-example-group-workers.md) | 服務對象勞工群組範例 |
| [example-procedure-activity](Procedure-example-procedure-activity.md) | 臨場服務執行活動項目範例 |
| [example-procedure-counseling](Procedure-example-procedure-counseling.md) | 健康諮詢與衛教指導範例 |
| [example-service-finding](Observation-example-service-finding.md) | 臨場服務現場發現問題範例 |
| [example-service-task](Task-example-service-task.md) | 臨場服務建議改善措施與追蹤任務範例 |

-------

## 7. 特殊示範（教學價值較高者）

下列範例並非為了展示某一資源，而是為了示範**規範中容易做錯的作法**，建議實作前先讀。

| | | |
| :--- | :--- | :--- |
| 缺值處理 | [obs-lab-egfr-absent](Observation-obs-lab-egfr-absent.md) | 檢驗未執行時以`dataAbsentReason = not-performed`標明，Observation 仍保留於封包中，不得整筆省略 |
| 揭露界線 | [example-composition-employer-summary](Composition-example-composition-employer-summary.md) | 雇主端摘要不含任何檢驗數值 |
| 上傳冪等性 | [Bundle-UC-009](Bundle-UC-009.md) | 以報告識別碼做條件式更新，重傳不產生重複資料 |
| 內部參照 | [Bundle-UC-008](Bundle-UC-008.md) | `urn:uuid`內部參照與識別碼條件式建立之組合用法 |
| 擴充填寫 | [obs-smoking-former](Observation-obs-smoking-former.md) | 量化與戒除時間擴充之完整填寫 |

-------

## 8. 內嵌實例 (inline instances)

上傳封包 UC-008／UC-009 內含 10 個 `Usage: #inline` 實例（`tx-*`／`tx9-*`）。 此類實例**不會產生獨立頁面**，僅存在於其所屬封包之內容中，請自封包頁面展開檢視：

| | |
| :--- | :--- |
| [Bundle-UC-008](Bundle-UC-008.md) | `tx-patient`、`tx-org-hospital`、`tx-obs-glucose`、`tx-report-general` |
| [Bundle-UC-009](Bundle-UC-009.md) | `tx9-patient`、`tx9-org-hospital`、`tx9-practitioner`、`tx9-obs-exposure`、`tx9-obs-egfr-absent`、`tx9-report-special` |

-------

## 9. 範例覆蓋度

* 本指引之範例覆蓋率與尚未補齊之 Profile 清單，見[資源總覽](artifacts.md)與[未決事項](open-issues.md)。
* 範例之 FSH 原始碼可自[結構定義與範例檔下載](downloads.md)取得。

