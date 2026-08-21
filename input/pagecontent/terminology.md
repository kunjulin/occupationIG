# 術語與代碼系統 (Terminology & CodeSystems)

本指引在國際術語標準（LOINC, SNOMED CT, ICD-10-CM）與臺灣本地化行政代碼之間建立映射，以實現數據的高級互操作性。

> **命名說明**：本指引之正式名稱為「臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG)」；`twha` 為本指引 Canonical URL 與 Profile/ValueSet/CodeSystem 前綴所使用之技術命名空間 token（沿用初版 draft 命名），非對外正式英文名稱之縮寫。

## 1. 國際臨床術語遵循

*   **LOINC (Logical Observation Identifiers Names and Codes)**：
    - 用於所有一般檢驗、生理功能檢查（肺功能、心電圖、聽力測試）及生理測量（身高、體重、血壓）的 Observation.code 定義。
    - 本指引所使用的 LOINC 代碼集已彙整至 [VS-CoreDataset](ValueSet-VS-CoreDataset.html) 與 [VS-ExtendedDataset](ValueSet-VS-ExtendedDataset.html)。
*   **SNOMED CT (Systematized Nomenclature of Medicine - Clinical Terms)**：
    - 用於生活習慣（如嚼檳榔狀態 `698188003`）、臨場服務現場發現之職業危害（`17458004`）等臨床發現與程序代碼。改善建議諮詢之 procedure 代碼 SNOMED 現無對應項，標示為 **`(-本地碼待治理)`**（原 `315640000` 經術語伺服器驗證實為「Influenza vaccination declined」，語意不符已移除；建議以 `CS-ServiceActivityType` 本地碼承載，惟該本地碼尚待治理）。
*   **ICD-10-CM (Clinical Modification)**：
    - 用於記錄勞工既往病史（`TWHA-Condition`）以及附表十二所列之不適合從事特定危害作業疾病。

---

## 2. 本地化行政代碼系統 (CodeSystems Defined in this IG)

為滿足臺灣職業安全衛生與健康服務之行政申報需求，本指引定義了以下代碼系統：

*   **[CS-ExamType](CodeSystem-CS-ExamType.html) (檢查類型代碼系統)**：
    - 定義 `general-physical` (一般體格)、`general-health` (一般健康)、`special-physical` (特殊體格) 與 `special-health` (特殊健康)。
*   **[CS-HazardType](CodeSystem-CS-HazardType.html) (危害作業類別代碼系統)**：
    - 定義高溫、噪音、輻射、異常氣壓、鉛、粉塵、有機溶劑、特定化學物質等 12 大類危害作業之代碼。（家族層）附表十（115.06.26 修正）逐號之 35 項具名作業另見 [CS-Appendix10Operation](CodeSystem-CS-Appendix10Operation.html)，家族 ↔ 具名作業對映見 [ConceptMap Appendix10-to-HazardType](ConceptMap-Appendix10-to-HazardType.html)。
*   **[CS-SmokingStatus](CodeSystem-CS-SmokingStatus.html) (吸菸狀態代碼系統)**：
    - 定義從未、偶爾、每日與已戒之狀態。
*   **[CS-HealthMgmtLevel](CodeSystem-CS-HealthMgmtLevel.html) (健康管理分級代碼系統)**：
    - 定義第一級至第四級健康管理分級。
*   **[CS-FitnessForWork](CodeSystem-CS-FitnessForWork.html) (適性配工建議代碼系統)**：
    - 定義變更場所、換工作、縮短工時、醫療限制等工作調整項目。
*   **[CS-LaborReportCode](CodeSystem-CS-LaborReportCode.html) (勞動部通報報告代碼系統)**：
    - 定義通報勞動部系統所需之大類通報報告代碼（如 `30901X` ~ `30905X`）。
*   **[CS-ServiceActivityType](CodeSystem-CS-ServiceActivityType.html) (臨場健康服務辦理事項代碼系統)**：
    - 定義附表八申報時所需之 8 大類臨場服務活動類別。
*   **[CS-HealthCounseling](CodeSystem-CS-HealthCounseling.html) (健康諮詢與衛教指導項目代碼系統)**：
    - 定義成人預防保健服務之 10 項法定衛教指導與諮詢事項。

---

## 3. LOINC 術語治理機制 (LOINC Terminology Governance)

由於各醫療院所檢驗資訊系統 (LIS) 的歷史代碼與檢驗方法存在差異（例如白血球計數可能使用自動計數或手動計數），本指引針對健康檢查檢驗項目採用 **FHIR 國際標準之術語治理模式**——`extensible binding` ＋ `preferred (primary) code` ＋ `acceptable codes via ConceptMap`，以提升互操作性並降低院所端系統對接成本。

### 3.1 治理機制定義
*   **Extensible binding（值集綁定強度）**：
    - 檢驗項目代碼綁定至值集，綁定強度為 **`extensible`**：優先使用值集內代碼；值集外之代碼亦可接受，但建議回報以利術語治理。
*   **Preferred (primary) code（優先代碼）**：
    - 每個檢驗項目指定一個最優先推薦使用的標準 LOINC 代碼。例如 WBC 優先使用 `6690-2`、腰圍優先使用 `8280-0`。
*   **Acceptable codes via ConceptMap（可接受代碼與歸一）**：
    - 同義或情境相近之 LOINC 代碼（例如 WBC 之 `804-5`、`26464-8`）列為 acceptable，收錄於對應值集，並透過 [TWHealthCheckLaboratoryMap](ConceptMap-TWHealthCheckLaboratoryMap.html) 歸一至 preferred code，供接收端進行標準化資料清洗。
*   **平行跨術語對映（SNOMED CT／UCUM）**：
    - **SNOMED CT 與 UCUM 為與 LOINC 平行之 code system**（非 LOINC 之下層）：LOINC 表達「檢驗項目」、SNOMED CT 表達臨床概念、UCUM 表達計量單位，三者於 §4 對照表並列呈現。
*   **Exclusion（治理註記）**：
    - 屬**治理註記**（非綁定層級）：明確排除不適用之過時或語意不符代碼。例如體液白血球代碼 `12227-5` 語意上不屬一般健檢血常規，於治理上標示排除。

> **用語澄清（重要，避免誤解）**：
>
> 1. **`preferred` 與 `acceptable` 均為本專案之治理術語，非 FHIR 規範用語。**
>    - 本 IG 之 **`acceptable`** 指「本專案允許並可經 ConceptMap 歸一之變異碼」，**與 FHIR 之 binding strength 無關**（FHIR binding strength 僅有 `required`／`extensible`／`preferred`／`example` 四值）。
>    - 本 IG 之 **`preferred (primary) code`** 指「**本 IG 建議之標準交換碼**」，**並非該項目之唯一臨床正確碼**；臨床上其他碼可能同樣正確，惟為利跨機構交換一致性而指定優先碼。
> 2. **本 IG 之值集綁定強度一律為 `extensible`**（與文件一 §6.3、實際建置一致），與上述治理層級之 `preferred` 為不同概念，請勿混用。

> ⚠️ **代碼驗證之五項要件（治理要求）**：
>
> **`$validate-code` 通過僅代表「代碼存在」，不代表「語意正確」。** 新增或引用任何代碼前，須完成下列五項；
> 前三項與後二項均已閘門化，均於送審用 tx 建置階段自動攔阻：
>
> | 要件 | 方法 | 單獨檢查為何不足 | CI 閘門 |
> |:--|:--|:--|:--|
> | (a) **代碼存在性** | `$validate-code` 或 IG Publisher 建置 | 代碼存在但語意不同者仍會通過 | ✅ tx 建置 |
> | (b) **代碼狀態** | `$lookup` 之 `STATUS` 屬性 | `DEPRECATED`／`DISCOURAGED` 之代碼同樣存在且通過驗證 | ✅ 具名類別 `has a status of DISCOURAGED` |
> | (c) **顯示名語意相符性** | `$lookup` 取得官方 display，與本 IG 標示之意義**人工確認** | **唯有此項能攔截「用錯碼」** | ✅ `Wrong Display Name = 0` |
> | (d) **建議單位（UCUM）** | `$lookup` 取 `EXAMPLE_UCUM_UNITS`，與 `extended-ucum-reference.csv` 逐碼四態比對 | display 對而單位錯仍量綱不符（如吸菸量以「支/日」碼承載「包/日」值） | ✅ `scripts/audit-ucum.js --gate`（不符 = 0） |
> | (e) **跨術語對映一致性** | `snomed-loinc-mappings.csv` 之 `loinc_preferred` 須存在於某 IG 值集 | CSV 之 LOINC 側曾四度與 IG 本體脫節而 `VERIFIED` 未被質疑 | ✅ `scripts/check-asset-consistency.js` |
>
> **IG Publisher 不執行 (c)–(e)**：其驗證 ValueSet 之 `concept.code` 是否存在於 CodeSystem，
> 但**不檢查 `concept.display` 是否與該代碼真實語意相符**，亦不檢查建議單位與跨術語對映。
> 故一個值集可收錄 15 個過敏原檢測代碼、標示為「純音聽力各頻率」，仍以 0 Error 通過建置——
> 此情形已實際發生於本 IG（見 §6.3）。
>
> 凡代碼來源為人工建議清單者，**均須執行全面 display 語意比對**，比對報告見
> [display-verification-report.csv](display-verification-report.csv)；UCUM 四態稽核結果見
> [extended-ucum-reference.csv](extended-ucum-reference.csv) 之 `verification` 欄。

### 3.2 代碼映射 ConceptMap
本指引建置了 [TWHealthCheckLaboratoryMap](ConceptMap-TWHealthCheckLaboratoryMap.html) 資源，定義了 acceptable code 至 preferred (primary) code 的映射關係，供接收端系統進行標準化資料清洗與歸一化處理。目前已涵蓋 **41 組映射**，包含血液學（WBC、血小板、MCV、MCH、嗜中性球%）、肝功能（AST、ALT、ALP，含無 P-5'-P 之 AST/ALT 變異法）、生化代謝（血糖、肌酸酐、eGFR、飯後血糖）、脂質（總膽固醇、TG、LDL-C，Preferred `2089-1` 為方法通用碼）、肝炎（HBsAg、anti-HCV）以及內分泌與癌標（HbA1c、TSH、PSA、CA-125、CEA）等群組；v20260724 另補齊血中鉛（`23749-5`→`5671-3`）與腰圍（`56086-2`→`8280-0`）。**v20260726（Wave 9）移除 3 組語意錯誤之對應**：聽力 `21104-5`（實為 Deprecated 大豆粉塵 IgE）、尿酸 `49154-8`（實為 Rickettsia conorii IgG Ab）、HDL `3048-6`（實為 Triglyceride --fasting），該三項之 acceptable 均改標 `(-確定無合適碼)`。**v20260729 新增尿沉渣自動計數 9 組**（/HPF 面積碼 → /µL 體積碼，以 `#relatedto` 歸一），回收先前整組刪除之 ACTIVE 面積碼，使以 /HPF 報告之機構亦可實作。 另建置 [Appendix10-to-HazardType](ConceptMap-Appendix10-to-HazardType.html)，對映附表十 35 項法定作業至 12 危害家族（family），供由法定作業編號歸併家族。

#### 3.2.1 `equivalence` 判準與 R4／R5 對照（v20260730 更正）

> ⚠️ **FHIR R4 之 `narrower`／`wider` 以 target 為主詞**，與直覺相反。R4 官方定義
> （[ConceptMapEquivalence](https://hl7.org/fhir/R4/codesystem-concept-map-equivalence.html)，v4.0.1）：
>
> * `narrower` — The **target** mapping is narrower in meaning than the source concept.
> * `wider` — The **target** mapping is wider in meaning than the source concept.

| 本 IG 之語意意圖 | R4（現行，`equivalence`） | R5（未來，`relationship`） | 數值可否直接比較 |
|:--|:--|:--|:--|
| source 為方法特化、target 為通用碼 | **`wider`** | `source-is-narrower-than-target` | 可 |
| source 較廣、target 較窄（如指定空腹、指定方法、指定偵測極限） | **`narrower`** | `source-is-broader-than-target` | 須注意條件差異 |
| 不同量綱／不同具體方法／不同檢體，需換算 | `relatedto` | `related-to` | **不可** |
| 完全等義 | `equivalent` | `equivalent` | 可 |

1. **R5 已改名為 `source-is-…-than-target`**，把主詞寫進代碼名稱本身，消除 R4 裸用
   `narrower`／`wider` 之歧義。**本表即為升 R5 之遷移對照。**
2. **R4 之 `relatedto` 為階層頂點（Level 1），官方定義為「概念間有關聯、語意有部分重疊，
   惟確切關係未知」。** 本 IG 以之承載「需換算／不同量測方式／不同檢體」，係因 R4 無
   「需單位換算」之專用代碼；**實作端不得據以自動換算數值**，此一用法限制特此揭露。

> **v20260730 之更正**：本 IG 原依內部文件之 **source-relative** 定義填寫
> `equivalence`，與 R4 之 target-relative 定義方向相反，致 16 組值顛倒；另 6 組之 comment
> 與 display 相互矛盾（先前僅修 display 未同步修 comment 之殘留）。已全數更正，
> 更正後（39 組時）之分佈為 `wider` 10／`narrower` 6／`relatedto` 23／`equivalent` 0；
> 其後移除 `2888-6`（見 §3.2.2）並補列 3 組原無歸一路徑者，**現行分佈為
> `wider` 12／`narrower` 6／`relatedto` 23／`equivalent` 0（共 41 組）**。
> **v20260729 及更早之下載檔或網站快照，其 `narrower`／`wider` 方向為錯誤值**，請以本版為準。
> 為防再度脫節，comment 之方向敘述與 `equivalence` 值之一致性已納入 CI 閘門
> （`scripts/fix-conceptmap-equivalence.js --check`）。

> **`equivalent` 為 0 係刻意結果，非遺漏**：R4 之 `equivalent` 僅適用於「概念定義完全等義」。
> 經 41 組逐組覆核，本 IG 無任何一組符合——原標 `equivalent` 之 2 組（`26464-8`→`6690-2`、
> `28539-5`→`785-6`）實為「source 方法未指定、target 指定 Automated count」，屬包含關係而非等義，
> 已於 v20260730 改為 `narrower`。凡本 IG 收為 acceptable 者，皆與其 preferred 至少差一軸
> （方法、檢體、量綱或條件），故不存在完全等義之配對。

#### 3.2.2 `2888-6`／`5804-0` 之關係（v20260730 移除誤設之歸一）

`2888-6`（尿蛋白**定量**，Protein [Mass/volume] in Urine，醫令 06003C-1）與
`5804-0`（尿蛋白**定性**，Protein [Presence] in Urine by Test strip，醫令 06003C-2）
**各為獨立醫令項目之 Preferred**，於主管機關（國健署）最小上傳集為兩個獨立列。

原 ConceptMap 曾將 `2888-6 → 5804-0` 列為歸一（`relatedto`），已於 v20260730 **移除**。
理由：歸一之語意為「送 A 時視為 B」，而定量與定性係**不同檢驗、不同醫令代碼、不同 Property**
（`Mass/volume` vs `Presence`），不可互相取代——該 element 自身之 comment 即載明「非包含關係」，
與歸一之用途相牴觸。

> 本 IG 之 acceptable 實含三種性質不同之情形，僅前二者可歸一：
>
> | 實際關係 | 可否歸一 | 例 |
> |:--|:--|:--|
> | 方法特化／通用 | 可，數值可比較 | `13457-7` → `2089-1`（`wider`） |
> | 不同量綱，需換算 | 可交換但**須換算** | 尿沉渣 `33218-9` → `51480-2`（`relatedto`） |
> | **不同檢驗項目** | **不可，非 acceptable** | **`2888-6` vs `5804-0`** |
>
> 二者之臨床關聯僅在於同屬醫令 06003C 之定量與定性兩子項；該關聯以本段敘述記載，
> **不以 ConceptMap 承載**。

---

## 4. 跨術語對照表

> **⚠️ 本節分為兩區，效力不同，請勿混用：**
> - **§4.1 已驗證之綁定代碼（verified）**：實際供 profile／ValueSet 綁定或正式 mapping 使用，且已通過術語伺服器 `$validate-code` 驗證。
> - **§4.2 跨術語對照（draft／informative）**：僅供參考之對照資訊。其中 **SNOMED CT 欄位除 §4.1 所列者外，均未經術語伺服器驗證，不得作為正式建議 mapping 使用**。

### 4.1 已驗證之綁定 SNOMED CT 代碼（verified）

下列 SNOMED CT 代碼為本 IG **實際綁定使用**者，已於 **2026-07-26** 透過 `tx.fhir.org`（SNOMED International Edition）逐一完成 `$validate-code` 代碼有效性驗證：

| SNOMED CT | 顯示名 | 使用位置 | 驗證狀態 |
|:---|:---|:---|:---|
| `698188003` | Chews betel quid | `TWHA-SocialHistory-BetelNut`／`VS-CoreUploadSet` | ✅ 已驗證 2026-07-26 |
| `266919005` | Never smoked | 吸菸狀態範例（`obs-smoking`） | ✅ 已驗證 2026-07-26 |
| `17458004` | Occupational hazard | `TWHA-Observation-ServiceFinding.code` | ✅ 已驗證 2026-07-26 |
| `406221003` | Health status | `TWHA-HealthManagementLevel.code` | ✅ 已驗證 2026-07-26 |

> 註：LOINC 代碼部分，凡被 profile／ValueSet 引用者，均已於同日以 `_genonce_tx.bat`（連線 `tx.fhir.org`，LOINC 2.82）完成代碼有效性與顯示名驗證。**惟此驗證不含臨床適切性與法規符合性**。

### 4.2 跨術語對照（draft／informative）

本節提供健康檢查資料集中各主要項目的跨術語對照，整合 LOINC（preferred 優先碼／acceptable 可接受碼）、SNOMED CT 概念、UCUM 計量單位及法規欄位參照——三者為**平行之 code system**。

> **⚠️ SNOMED CT 欄位之效力限制**：本表 SNOMED CT 欄位（§4.1 所列 4 碼除外）係先前以 SNOMED International Browser 人工填載，**未經術語伺服器逐碼驗證**，屬 **draft／informative** 性質，**僅供參考，不得作為正式建議 mapping 或交換要求使用**。實務上曾發現此類未驗證之人工對照有相當比例語意不符（本 IG 於 2026-07-26 之術語稽核即更正 4 個職業健康相關 SNOMED／LOINC 錯碼）。正式採用前應逐碼完成驗證（列為 backlog，見[未決事項 T-3](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#t-3)）。

> **標示慣例**：`—` 表示該欄位不適用或無需列出。`(-)` 系列表示**經術語伺服器查證後之缺碼狀態**（非尚未填寫），依成因區分為三態：
>
> | 標示 | 意義 | 後續處置 |
> |:--|:--|:--|
> | `(-未找到)` | 已查詢但**未能檢索到**合適代碼，不排除存在但檢索策略未涵蓋 | 擴大檢索或請術語專家協助 |
> | `(-確定無合適碼)` | 已確認國際術語系統**確無**語意相符之代碼 | 提報 LOINC／SNOMED 新增申請，或俟版本更新 |
> | `(-本地碼待治理)` | 概念存在但**應以本地代碼承載**，惟本地碼尚未完成治理 | 納入本地 CodeSystem 治理流程 |
>
> 凡標示 `(-)` 系列者，均已移除原先語意不符之代碼，以免實作端誤用。

| 類別 | 中文名 | LOINC Preferred | LOINC Acceptable | SNOMED CT<br>(informative・未驗證) | UCUM | 法規 |
|:---|:---|:---|:---|:---|:---|:---|
| 血液學 | 白血球計數 | `6690-2` | `{804-5, 26464-8}` | 767002 | 10\*3/uL | 附表九 |
| 血液學 | 紅血球計數 RBC | `789-8` | — | 41653003 | 10\*6/uL | 附表九（115.06.26 新增）|
| 血液學 | 血紅素 | `718-7` | — | 38082009 | g/dL | 附表九 |
| 血液學 | 血小板 | `777-3` | `{26515-7}` | 61928009 | 10\*3/uL | 附表九 |
| 血液學 | MCV | `787-2` | `{30428-7}` | 104133003 | fL | 附表九 |
| 血液學 | MCH | `785-6` | `{28539-5}` | 85505000 | pg | 附表九 |
| 血液學 | MCHC | `786-4` | — | 37254006 | g/dL | 附表九 |
| 血液學 | 嗜中性球% | `770-8` | — | 271036002 | % | 附表九 |
| 生化/腎 | 空腹血糖 | `1558-6` | `{2339-0}` | 33747003 | mg/dL | 附表九/成健 |
| 生化/腎 | 肌酸酐 | `2160-0` | `{38483-4}` | 15373003 | mg/dL | 附表九 |
| 生化/腎 | eGFR | `98979-8` | `{33914-3}` | 80274001 | mL/min/{1.73_m2} | 成健（`98979-8` 適用 115.01.01 起；`33914-3` 適用 114 年及以前，見 §6.2a） |
| 生化/腎 | 尿酸 | `3084-1` | (-確定無合適碼) | 86228006 | mg/dL | 附表九 |
| 肝功能 | AST (GOT) | `1920-8` | `{30239-8}` | 45896001 | U/L | 附表九/成健 |
| 肝功能 | ALT (GPT) | `1742-6` | `{1743-4}` | 34608000 | U/L | 附表九/成健 |
| 肝功能 | ALP | `6768-6` | — | 88810008 | U/L | 附表九 |
| 脂質 | 總膽固醇 | `2093-3` | `{35200-5}` | 77068002 | mg/dL | 成健 |
| 脂質 | 三酸甘油酯 | `2571-8` | `{3043-7}` | 14740000 | mg/dL | 成健 |
| 脂質 | HDL-C | `2085-9` | (-確定無合適碼) | 17888004 | mg/dL | 成健 |
| 脂質 | LDL-C (方法通用) | `2089-1` | `{13457-7, 18262-6}` | 113079009 | mg/dL | 成健 |
| 內分泌 | HbA1c (NGSP) | `4548-4` | `{59261-8}` | 43396009 | % | 成健/進階 |
| 內分泌 | TSH | `11580-8` | `{3016-3}` | 61167004 | mIU/L | 進階 |
| 癌標 | PSA | `2857-1` | — | 63476009 | ng/mL | 進階 |
| 癌標 | CA-125 | `10334-1` | `{83082-8}` | 50610001 | U/mL | 進階 |
| 癌標 | CEA | `2039-6` | `{83085-1}` | 60267001 | ng/mL | 進階 |
| 肝炎 | HBsAg | `5196-1` | `{5195-3}` | 39082004 | — | 成健 |
| 肝炎 | anti-HCV | `13955-0` | `{16128-1}` | 32218006 | — | 成健 |
| 尿液 | 尿蛋白 (試紙) | `5804-0` | `{2888-6}` | 167273002 | — | 附表九/成健 |
| 尿沉渣 | 細菌 Bacteria | `51480-2` | `{33218-9}` | — | /uL | — |
| 尿沉渣 | 鱗狀上皮細胞 | `51486-9` | `{33219-7}` | — | /uL | — |
| 尿沉渣 | 透明圓柱 | `51484-4` | `{33223-9}` | — | /uL | — |
| 尿沉渣 | 上皮細胞 | `87926-2` | `{33342-7}` | — | /uL | — |
| 尿沉渣 | 圓柱 Casts | `51483-6` | `{43755-8}` | — | /uL | — |
| 尿沉渣 | 紅血球 RBC | `798-9` | `{46419-8}` | — | /uL | — |
| 尿沉渣 | 白血球 WBC | `51487-7` | `{46702-7}` | — | /uL | — |
| 尿沉渣 | 黏液 Mucus | `51478-6` | `{50235-1}` | — | /uL | — |
| 尿沉渣 | 精子 Spermatozoa | `51479-4` | `{53324-0}` | — | /uL | — |
| 生理 | BMI | `39156-5` | — | 60621009 | kg/m2 | 成健 |
| 生理 | 腰臀比 WHR | (-確定無合適碼) | — | 248362002 | {ratio} | 成健 |
| 生理 | 血壓 Panel | `85354-9` | — | 75367002 | — | 成健（v20260730 由 `55284-4`（DISCOURAGED）汰換） |
| 生理 | 腰圍 | `8280-0` | (-確定無合適碼) | 276361009 | cm | 附表九/成健 |
| 肺功能 | FVC | `19868-9` | `{19876-2, 19870-5}` | 50834005 | L | 職業 |
| 肺功能 | FEV1 | `20150-9` | — | 59328004 | L | 職業 |
| 視力 | 視力 Panel | `98497-1` | — | 363983007 | — | 職業 |
| 聽力 | 純音聽力 Panel | `89015-2` | — | 406081008 | dB | 職業 |

> **尿沉渣自動計數之雙軌收錄**：本 IG 對尿沉渣採「**體積碼（/µL 全尿自動計數）為 preferred、
> 面積碼（/HPF 鏡檢沉渣）為 acceptable**」。理由為國內各機構尿液分析儀報告單位不一致——本院 Sysmex
> UF-5000/UD-10 報每 µL，他院則以每高倍視野（/HPF）報告；兩量綱需依儀器係數換算、不可直接比較數值，
> 故以 `#relatedto` 歸一而非 `equivalent`。此為先前「整組換為體積碼」之範圍修正：面積碼為 ACTIVE
> 之合法 LOINC，回收為 acceptable 使以 /HPF 報告之機構亦可實作（見 ConceptMap `element[28]–[36]`）。

> **社會史量化碼之單位與性質**：
> - `64218-1`（吸菸量，*How many cigarettes do you smoke per day now* [PhenX]）之官方 Property 為 **NRat（Count/Time）**，
>   例示單位為 **`/d`（支/日）**，**非「包/日」**（`{pack}/d`）。以本碼承載「包/日」之值，將使實作端把 20 支誤讀為 20 包（量綱不符）。
>   若須交換 pack-year 或 packs/day，應另尋對應代碼並經 `$lookup` 查證，**不得沿用本碼**。
> - `63632-4`（戒菸月數，*About how long has it been since you completely quit smoking cigarettes* [TUS-CPS]）之 Class 為 **PHENX**、
>   Method 為 **TUS-CPS**（調查工具情境碼）。依「與官方對齊並揭露」原則保留，交換時應知其為調查量表脈絡之代碼。

---

## 5. 術語資源下載與補充說明

### 5.0 情境值集（③）與「第一期草案子集」之區別

本指引有兩組**看似相近但語意不同**的必驗相關值集，切勿混用（此為 index.md「三層資料集」
之延伸，不是第四層）：

| 值集 | 回答的問題 | 內容 |
|:--|:--|:--|
| [VS-Appendix9-RequiredSet](ValueSet-VS-Appendix9-RequiredSet.html)／[VS-Appendix10-RequiredSet](ValueSet-VS-Appendix10-RequiredSet.html) | **法規本身**要求什麼（③ 情境資料集） | 依附表九／十逐項核對之法定應執行**檢驗與量測**項目，與本 IG 實作進度無關 |
| [VS-OccHealthCheck-Required](ValueSet-VS-OccHealthCheck-Required.html) | **本 IG 這一期**優先結構化了哪些 | 第一期實作範圍之草案子集（一般項目＋噪音／鉛／粉塵三模組） |

兩者**並存、不互相取代**：前者是「法規要求」，後者是「本期實作到哪」。
`VS-OccHealthCheck-Required` 之成員為 `VS-Appendix9-RequiredSet` ∪ 附表十四家族值集之
子集——即「法規要求」中，本期已完成結構化者。附表十未審家族（M-8）補齊後，
兩者之差距即為「法規要求但本 IG 尚未結構化」之項目，可據以規劃後續期別。

### 5.1 術語對照表下載
完整的 LOINC–SNOMED CT–UCUM 跨術語對照表（CSV 格式）可從以下連結下載：
- [snomed-loinc-mappings.csv](snomed-loinc-mappings.csv)

CSV 欄位說明：`category`（類別）、`item_name_zh`（中文名）、`item_name_en`（英文名）、`loinc_preferred`（優先碼）、`loinc_acceptable`（可接受碼集合）、`snomed_ct`（代碼）、`snomed_display`（顯示名稱）、`snomed_status`（驗證狀態）、`ucum_unit`（UCUM 單位）、`regulatory_ref`（法規欄位）。

### 5.2 肺功能代碼雙 ValueSet 說明
本指引中，肺功能代碼（`19868-9` FVC、`20150-9` FEV1、`19926-5` FEV1/FVC 比值）同時收錄於兩個不同的 ValueSet，用途各異：

*   **[VS-PulmonaryFunction](ValueSet-VS-PulmonaryFunction.html)**：供 `TWHAPulmonaryFunctionProfile` 完整代碼集查詢使用，包含所有肺功能相關代碼（含 TLC、RV、DLCO 等）。
*   **[VS-CoreDataset](ValueSet-VS-CoreDataset.html)**：供術語查詢與跨資料集完整性核對使用，僅收錄最核心的三個代碼。

兩者並非重複，而是服務不同的查詢情境。`TWHAPulmonaryFunctionProfile` 的 `Observation.code` 為固定值（`= LNC#19868-9`），不受 VS 繫結直接限制，但兩個 VS 均供文件與術語服務查詢使用。

### 5.3 聽力頻率代碼設計說明
聽力測試之代碼結構層次如下（此為 panel／component 之**資源結構**設計，與 §3 之術語治理機制為不同概念）：
1. **Panel（`89015-2`）**：記錄整場聽力測試，進入 `VS-CoreDataset` 作為 Observation.code
2. **個別頻率/耳別代碼（`89024-4` 等 8 個）**：作為 `component.code` 由 `TWHAHearingTestProfile` 的 8 個 component 切片處理，收錄於 `VS-ExtendedDataset`
3. **結果解釋**：臨床人員依 ISO 1999 標準判定各頻率閾值是否超過 25 dB HL
4. **⚠️ 關於 `21104-5` 系列（更正）**：先前依「院所 LIS／職業病醫師另採純音聽力研究系列」之敘述，將 `21104-5` 等 15 碼列為 Acceptable 變異碼。經 `tx.fhir.org` 逐碼查證，**該等代碼之真實語意為過敏原 RAST 檢測、酵素及重金屬等項目，與聽力無關**，多數並為 LOINC `DEPRECATED` 狀態。**該系列不得作為聽力代碼使用**，已於 v20260726 自 `VS-ExtendedDataset` 與 ConceptMap 全數移除（見 §6.3）；聽力 acceptable 變異碼標 `(-確定無合適碼)`。本 IG 之聽力代碼以 `89015-2` panel 及其 0.5–8 kHz 雙耳 14 個成員碼為準。

---

## 6. Extended 量值項目建議單位對照（UCUM）

> 本表所列為 **LOINC 官方建議單位**（`EXAMPLE_UCUM_UNITS` 欄位，經 `tx.fhir.org` `$lookup` 查詢，LOINC 2.82），供實作參照；
> **實際單位以各機構 LIS 報告為準，跨機構比較前應確認單位一致或完成換算。**
>
> ⚠️ **全部項目之驗證狀態均為「需覆核」**，須經檢驗醫學專業確認後方可改為「已覆核」。
> 本節**未修改任何 ValueSet 綁定**——UCUM 於 FHIR 中係存在於 Observation 實例之
> `valueQuantity.system = "http://unitsofmeasure.org"` 與 `.code`，ValueSet 本身不承載單位。

### 6.1 盤點結果

**統計基準**：`scripts/audit-ucum.js` 於送審用 tx 建置逐碼 `$lookup` 之實測結果
（2026-07-30，CI run 30534387613）。稽核全集**由值集展開**（`VS-ExtendedDataset`
288 碼 ∪ `VS-CoreDataset` ∪ `VS-TWHAVitalSigns` ∪ `VS-CoreUploadSet` 社會史碼，
去重共 320 碼），非以對照檔之列為全集——後者曾因凍結於 Extended 尚為 292 碼時期而
漏稽核 44 個量值碼。

| 項目 | 筆數 |
|:--|--:|
| 稽核全集（由上開值集展開，去重） | 320 |
| ─ 納入比對之量值碼（Scale ∈ `Qn` 231／`SemiQn` 10） | **241** |
| ─ 非量值型（`Ord` 53／`Doc` 17／`Nom` 7／`-` 2；主動排除並記錄 Scale） | 79 |
| ─ Scale 未對映之答案清單碼 | **0**（[T-12](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#t-12) 已結案） |
| **建議單位與 LOINC 官方 `EXAMPLE_UCUM_UNITS` 相符** | **234** |
| LOINC 未提供建議單位（其中量值碼 7 筆） | 74 |
| **不符（量綱或代碼錯誤）** | **0** |
| **未列於對照檔（值集有量值碼而對照檔無）** | **0** |

> 「相符 234 ／未提供 74」為對照檔之 **308 列**（234 ＋ 74）；其中 241 列為納入比對之
> 量值碼（相符 234 ＋ 官方未提供 7），餘 67 列為對照檔亦收錄之非量值型碼（不列單位）。
> `SemiQn`（`LP436123-6`，2023-07-05 新增之 Scale）經 loinc.org 查證後納入比對，
> 10 筆之官方單位皆經 tx `$lookup` 取回（9 筆有值、`20621-9` 官方未提供）。
>
> 上開數值均為 CI 閘門之具名基準
> （`--max 0 --max-missing 0 --max-unknown 0 --min-inscope-ratio 0.5`）：值集新增量值碼而未
> 回寫對照檔（「未列於對照檔」）、或出現新的未對映 Scale 碼，即建置失敗。
> 另設**分類失效自我檢查**——納入比對之量值碼占全集之比率若低於 50%（實測 75.3%），
> 即視為 Scale 判定失效而失敗，避免「全部判為不適用卻閘門全綠」之空過。

完整對照表（308 筆，含 LOINC 官方顯示名與來源標註）：
**[extended-ucum-reference.csv](extended-ucum-reference.csv)**

CSV 欄位：`loinc`、`ig_display`（本 IG 標示）、`loinc_display`（LOINC 官方顯示名）、
`ucum_suggested`（建議單位）、`source`（來源）、`verification`（驗證狀態）、`note`（註記）。

### 6.2 重點項目與單位陷阱（覆核時優先檢視）

下列項目之單位**易生誤用且誤差可達 10 倍以上，屬病人安全風險**，覆核時應優先確認：

| LOINC | 項目 | LOINC 建議單位 | 來源 | 驗證狀態 |
|:---|:---|:---|:---|:---|
| `5671-3` | 血中鉛（LOINC 狀態：DISCOURAGED） | `ug/dL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5676-2` | 尿中鉛 | `ug/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5685-3` | 血中汞 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5689-5` | 尿中汞 | `ug/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5609-3` | 血中鎘 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5611-9` | 尿中鎘 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5622-6` | 血清鉻 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5623-4` | 尿中鉻 | `ug/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `14099-6` | 尿中鎳 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5586-3` | 尿中砷 | `ug/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `5681-2` | 血中錳 | `ng/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `42221-2` | 尿中錳（莫耳） | `nmol/L` | LOINC EXAMPLE_UCUM_UNITS | 批3 確認官方為莫耳；院方以質量報告，質量碼見 `5684-6` |
| `5684-6` | 尿中錳（質量，院方所用） | `ug/L` | LOINC EXAMPLE_UCUM_UNITS | 批3 新增（Q2-1），經 CI $lookup 覆核 |
| `6709-0` | 尿中馬尿酸（甲苯） | `g/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `2725-0` | 尿中甲基馬尿酸（二甲苯） | `mg/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `13000-5` | 尿中扁桃酸（苯乙烯） | — | **LOINC 未提供** | 需覆核 |
| `3041-1` | 尿中三氯乙酸 | `ug/mL` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `31170-4` | 尿中2,5-己二酮（正己烷） | `mg/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `2758-1` | 尿中酚（苯） | `mg/L` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `12533-6` | 尿中TTCA（二硫化碳） | — | **LOINC 未提供** | 需覆核 |
| `4548-4` | HbA1c (NGSP) | `%` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `59261-8` | HbA1c (IFCC) | `%` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `98979-8` | eGFR (CKD-EPI 2021) | `mL/min/{1.73_m2}` | LOINC EXAMPLE_UCUM_UNITS | 需覆核 |
| `33914-3` | eGFR (MDRD)（LOINC 狀態：DISCOURAGED） | `mL/min/{1.73_m2}` | LOINC EXAMPLE_UCUM_UNITS | 職醫科已確認保留（2026-07-27）；依國健署 115.01.15 國健慢病字第1150660003號函，適用 114 年（2025）及以前之成健 eGFR（MDRD 為 VPN 必填、機構自行填入），115.01.01 起改採 CKD-EPI 2021（`98979-8`）；沿革見 §6.2a、多公式並存見 T-11 |

**特別提醒：**
- **重金屬單位不一致**：血中鉛為 `ug/dL`、尿中鉛為 `ug/L`、血中汞與鎘為 `ng/mL`——**量級不同，不可互換**。
- **肌酸酐校正**：尿中代謝物實務上常以 `mg/g{creatinine}` 報告（經肌酸酐校正），與 LOINC 建議之 `g/L`／`mg/mL` **非同一量測基礎**，交換時須明確標示是否已校正。
- **HbA1c**：NGSP（`%`）與 IFCC（`mmol/mol`）需換算，換算式見 ConceptMap 之 comment。
- **eGFR**：`mL/min/{1.73_m2}`；另注意 MDRD 與 CKD-EPI 2021 為不同公式，數值不可直接互換。
- **聽閾**：`dB`（已於 `TWHA-HearingTest` 規範，見該 Profile 說明）。

### 6.2a eGFR 估算公式之沿革（國健署 115.01.15 公文）

依 **衛生福利部國民健康署 115 年 1 月 15 日國健慢病字第 1150660003 號函**（配合中央健康保險署
公告腎絲球過濾率 eGFR 計算公式調整為 CKD-EPI），成人預防保健（成健）之 eGFR 估算公式沿革如下
（民國紀年：114 年 ＝ 2025、115 年 ＝ 2026）：

| 時期 | MDRD 4-variable（`33914-3`） | CKD-EPI（`98979-8`，2021 版） |
|:--|:--|:--|
| **114 年（2025）雙軌併行** | **必填欄位，由成健機構自行填入** | 「腎絲球過濾率(新)(eGFR-CKD-EPI)」**非必填欄位**，由系統帶入年齡、性別、肌酸酐等數值**自動計算** |
| **115 年（2026）1 月 1 日起** | 停止採用 | 採 **2021 年版 CKD-EPI** 取代 MDRD；健保署**取消原自動計算功能**，改由機構自行填入 |

健保署於 **115.01.16** 完成成健結果檔上傳 VPN 系統介面調整；衛生福利部「醫事服務機構辦理
預防保健服務注意事項」修正作業刻正辦理。

> **資料來源語意**：依公文，兩個時期之 eGFR **均為機構自行填入**（114 年之 CKD-EPI 自動計算功能
> 已於 115 年取消，MDRD 則一貫為必填、機構填入），其產生者為**申報機構而非檢驗儀器**；交換時
> `Observation.performer` 之語意宜予區辨（填報機構 vs 檢驗執行者）。eGFR **僅用於成健**，
> 不屬《勞工健康保護規則》附表九／附表十之法定項目（國健署原案 21 列收 `09015C` 肌酸酐、未收 eGFR）。

### 6.2b 嚼檳榔之建模與三套資料來源

> 本節於 v0.4.0 全面改寫。**0.3.0 以前之敘述（本指引以【本地 stub】承載 TWCR_SF 定義）
> 已不適用**——該批 stub 已於 v0.3.0 刪除、改為正式相依，
> [未決事項 G-5](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#g-5) 亦已結案。

#### 6.2b-1 ⚠️ 三套來源不可混為一談

嚼檳榔欄位現有**三套**不同粒度的來源，性質與效力各異：

| 來源 | 粒度 | 與本指引之關係 |
|:--|:--|:--|
| **國健署健檢上傳欄位**（原案） | 嚼檳狀態／量／月數，**無編碼** | **本指引 Core 之對標對象**，正式公告版本待確認（[M-5](index.html#before-you-start)） |
| **口腔黏膜檢查表**（107/7 修訂） | 6 選 1 之 ordinal 級距（年數 × 每日顆數） | **癌症篩檢用表，非健檢上傳欄位**。原始勾選以 `component[hpaCategory]` 保留（[VS-BetelNutHpaCategory](ValueSet-VS-BetelNutHpaCategory.html)），**不換算成中位數**；但**不得因此把篩檢表欄位當成健檢上傳欄位** |
| **TWCR_SF**（癌症登記短表） | 逐顆／逐年之列舉碼 | 正式相依 `fhir.TWCRSF#0.1.1`；於本指引降為**可選對照**（見 6.2b-3） |

#### 6.2b-2 本指引之建模（v0.4.0 起）

| 語意 | 承載位置 | 綁定／單位 |
|:--|:--|:--|
| Observation.code | `code` | SNOMED `698188003`（Chews betel quid） |
| 嚼檳狀態 | `value[x]`（CodeableConcept） | [VS-BetelNutStatus](ValueSet-VS-BetelNutStatus.html)（required，provisional） |
| 每日嚼食量 | `component[amount]` | `Quantity`，UCUM `{quid}/d` |
| 嚼食年數 | `component[durationYears]` | `Quantity`，UCUM `a` |
| 戒除期間 | `component[cessationDuration]` | `Quantity`，UCUM `a` 或 `mo`（[VS-TimeUnitYearMonth](ValueSet-VS-TimeUnitYearMonth.html)） |
| 戒除日期 | `component[cessationDate]` | `dateTime` |
| 是否含菸草 | `component[withTobacco]` | `boolean` |
| 添加物 | `component[additive]` | [VS-BetelNutAdditive](ValueSet-VS-BetelNutAdditive.html)（required） |
| 石灰種類 | `component[lime]` | [VS-BetelNutLime](ValueSet-VS-BetelNutLime.html)（required） |
| 資料來源 | `component[informationSource]` | LOINC `48766-0`；值 [VS-BetelNutInfoSource](ValueSet-VS-BetelNutInfoSource.html)（extensible） |
| 口腔黏膜檢查表級距 | `component[hpaCategory]` | [VS-BetelNutHpaCategory](ValueSet-VS-BetelNutHpaCategory.html)（required，**原始勾選，不換算**） |
| 上游級距碼（對照） | `component[amountCoded]` | TWCR_SF `sf-BetNutChewAmount`（**extensible、可選**） |

**與吸菸建模對稱**：吸菸量走 `64218-1` ＋ UCUM `/d`（數值），嚼檳量亦走 UCUM 數值；
`CS-BetelNutStatus` 與 `CS-SmokingStatus` 四碼逐碼對稱，便於同一份問卷邏輯共用。

> ⚠️ **「不詳」不在狀態值集內。** 狀態不詳者送 `value.dataAbsentReason`；
> 「狀態已知但量不詳」則送 `component[amount].dataAbsentReason`。兩者藉此得以區分——
> 若把 `unknown` 放進值集，會被壓成同一種表達。

> ⚠️ **戒除期間之單位以原始採集粒度為準。** 原始以「年」收集者送 `1 a`，
> **不得逕行改寫為 `12 mo`**——原始資料並未主張「恰好 12 個月」，轉換會偽造精度。

> ⚠️ **搜尋時必須併帶 `code=`。** UCUM 之註記（`{...}`）不影響可換算性，
> 故 `{quid}.a`（累積顆-年）與 `a`（嚼食年數）為**同量綱**，
> `value-quantity=gt10||a` 會同時命中兩者。**單位不足以區辨語意。**

> ⚠️ **兩個「附表九」不是同一份。** 口腔黏膜檢查表在其來源文件中標為
> 【附表九】（國民健康署），與本指引反覆援引之《勞工健康保護規則》**附表九**
> （一般體格及健康檢查項目）**分屬不同法規、內容全然無關**。
> 本指引凡未加註者，「附表九」一律指《勞工健康保護規則》者。
>
> ⚠️ **級距可導出界限，但不得取中點。** 該表 ❷–❺ 四項各自綁定「嚼食年數」與
> 「每日顆數」兩個維度之區間，可據以導出 `component[durationYears]` 與
> `component[amount]` 之**界限**（例如第 6 項 ⇒ 年數 > 10、每日 ≧ 20），
> 應以 `Quantity.comparator` 表達；**取區間中點充作實測值會造成假精確，
> 污染 dose-response 分析**（[T-9](https://github.com/kunjulin/occupationIG/blob/main/docs/known-limitations.md#t-9) 之同一原則）。
>
> 附帶觀察：同表「2.吸菸習慣」為結構完全相同之六選項，僅單位由「顆」改「支」。
> 本指引之吸菸 Profile 繼承 TW Core，未納入此級距。

#### 6.2b-3 上游級距碼 → 本模型之落點對照

**這張表本身就是「不宜硬套 ConceptMap」的證據**：同一個代碼清單裡的代碼，
會落到 FHIR 的**三個不同位置**（`value`／`component.valueQuantity`／`dataAbsentReason`）。
ConceptMap 對映的是概念與概念，不是概念與數值。

| 上游 `sf-BetNutChewAmount` | 語意 | 本模型落點 |
|:--|:--|:--|
| `00` | 無嚼檳榔 | `value = 0-never`；不送 amount |
| `01`–`89` | 每日 N 顆 | `component[amount].valueQuantity = N {quid}/d` |
| `90` | 每日 **≧90** 顆 | `valueQuantity.comparator = >=`，`value = 90` |
| `91` | **偶爾嚼（無規律或無定量）** | `value = 1-occasional`；amount 不送 |
| `98` | 有嚼，但量不詳 | `component[amount].dataAbsentReason = unknown` |
| `99` | 病歷未記載／完全不詳 | 整筆 `value.dataAbsentReason = unknown` |

`sf-BetNutChewYear`：`00` 無嚼檳榔 → 不送；`01`–`97` → `N a`；`98` 年不詳 →
`dataAbsentReason`；`99` 未記載 → 整筆不詳。

`sf-BetNutChewQuit`：`00` 無戒 → `value = 2-daily`、不送 cessation；`01`–`87` → `N a`；
**`88` 無嚼檳榔** → `value = 0-never`；`98` 已戒但年不詳 → `3-quit` ＋ `dataAbsentReason`；
`99` 未記載 → 整筆不詳。

> ⚠️ **跨清單同碼異義**：`88` 於 `sf-BetNutChewAmount` 是「每日 88 顆」，
> 於 `sf-BetNutChewQuit` 是「無嚼檳榔」。兩者皆為合法代碼、僅所屬 CodeSystem 不同，
> 實作端若在 component 之間錯置代碼系統，會產生「每日 88 顆」↔「從未嚼檳榔」之反向誤讀，
> **而 required 綁定攔不住**（兩個綁定各自都通過，只是綁錯 component）。
> 改為 `Quantity` 後，該類錯置會直接呈現為單位或量綱不符，可被機器攔下。

#### 6.2b-4 `component.code` 為何改用本地碼

`component.code` 若續用上游 `sf-BetNutChewBeh`，則即使值改為 `Quantity`，
**建置仍須解析上游 canonical 才能完成**。改用本地
[CS-BetelNutComponent](CodeSystem-CS-BetelNutComponent.html) 後，
核心三項（量／年數／戒除期間）不再依賴上游；上游級距碼僅存於可選之
`component[amountCoded]`，移除該 component 不影響任何核心資料。

本地碼與上游之對應為 1:1：`amount` ↔ `amount`、`duration-years` ↔ `year`、
`cessation-duration` ↔ `quit`。

### 6.3 代碼狀態異常（本次盤點附帶發現，與 UCUM 無關但影響代碼適用性）

盤點時以 `$lookup` 一併取得 LOINC 代碼狀態，發現下列情形，一併列出供後續處置：

| LOINC | 本 IG 標示 | LOINC 官方語意／狀態 | 說明 |
|:---|:---|:---|:---|
| `21104-5` 等 **15 碼** | 純音聽力 panel 與各頻率 | 大豆粉塵 IgE、牛肉 IgG、藍莓 IgG（**Deprecated** 過敏原檢測）、Borrelia 抗體、β-N-乙醯己醣胺酶、24 小時尿中鉍、鎘等 | ✅ **已於 v20260726 全數移除**（ValueSet 與 ConceptMap） |
| `49154-8` | 尿酸全血法（acceptable） | **Rickettsia conorii IgG Ab [Titer]**（地中海斑疹熱抗體效價） | ✅ **已於 v20260726 移除**；尿酸 acceptable 標 `(-確定無合適碼)` |
| `5671-3` | 血中鉛（原 Preferred） | 狀態 **DISCOURAGED** | ✅ **已處置**：Preferred 改為 `77307-7`（Venous blood, ACTIVE），本碼降為 acceptable 並經 ConceptMap 歸一 |
| `33914-3` | eGFR MDRD（Acceptable） | 狀態 **DISCOURAGED** | 同上 |
| `2532-0` | LDH | 狀態 **DISCOURAGED** | 同上 |
| `1709-5` | RBC 乙醯膽鹼酯酶 | 狀態 **DISCOURAGED** | 同上 |
| `35200-5` | 總膽固醇（acceptable） | 狀態 **DISCOURAGED** | v20260726 全面比對新發現 |
| `55284-4` | 血壓 panel | 狀態 **DISCOURAGED** | ✅ **已處置**：改為 `85354-9`（Blood pressure panel with all children optional, ACTIVE），全指引統一；`55284-4` 已不再出現於任何值集 |
| `19571-9` 等 **5 碼** | 尿液毒品篩檢（安非他命／鴉片／苯二氮平／K他命／MDMA） | 均為 **cutoff（閾值濃度）概念碼**（`[Mass/volume] ... for Screen method`，單位 ng/mL），非篩檢結果碼 | ✅ **已處置**：改列對應之 `[Presence]` 結果碼（`3349-8`／`3879-4`／`3390-2`／`12327-3`／`14267-9`） |
| `29771-3` | 糞便潛血（免疫法 FIT） | Hemoglobin [Presence] in Stool from gastrointestinal lower by Immunoassay | ✅ **已覆核**：概念相符（下消化道人類血紅蛋白免疫分析），顯示名已校正 |

> ⚠️ **關於 `21104-5` 系列（重要）**：該 15 碼係先前依「職業病醫師／院內 LIS 另採純音聽力研究系列」之敘述加入，
> 惟經 `tx.fhir.org` `$lookup` 逐碼查證，其**真實語意為過敏原 RAST 檢測、酵素與重金屬等項目，與聽力無關**，
> 且多數已為 LOINC `DEPRECATED` 狀態。
>
> **此類錯誤不會被 IG Publisher 攔截**——建置驗證僅確認「代碼於 LOINC 中存在」，
> **不檢查 ValueSet 內之顯示名是否與代碼語意相符**；故該 15 碼雖語意全錯，仍可通過驗證。
> 此為術語治理之已知盲區，處置方式應比照 `(-)` 標註原則。
>
> **血中鉛 Preferred 更換（Wave 9-3，已拍板）**：`5671-3` 之 LOINC 狀態為 DISCOURAGED；經檢索並確認，
> 現行 ACTIVE 之 **`77307-7` Lead [Mass/volume] in Venous blood** 符合職業血鉛監測慣用之靜脈血檢體，
> 已於 v20260726 改列為 **Preferred**；`5671-3` 降為 acceptable 並於 ConceptMap 建立歸一對應（equivalence = relatedto）。
> 院內 LIS 之 `23749-5`（Lead in Specimen）之歸一 target 同步改為 `77307-7`。
>
> **處置結果（v20260726 / Wave 9）**：上述 `21104-5` 系列 15 碼與 `49154-8` 共 **16 碼已全數移除**（ValueSet 與 ConceptMap），
> 相關 acceptable 欄位改標 `(-確定無合適碼)`。錯誤紀錄保留於本節供追溯。
