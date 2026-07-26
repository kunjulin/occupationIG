# TWHA IG Phase 2：ConceptMap 全面化、ValueSet 補齊、SNOMED CT 術語映射建置

本計畫書針對使用者提出的三大補強面向，逐項分析現行 IG 的缺口並提出具體修改方案。

---

## 一、ConceptMap 待補強項目（VS 已有但缺 ConceptMap）

### 現況分析
- `VS-CoreDataset` 已收錄 ~142 個 LOINC 代碼
- `ConceptMap-TWHealthCheckLaboratoryMap.fsh` 目前僅有 13 組映射（WBC×2, 尿液蛋白, 血糖, 肌酸酐, 尿酸, 總膽固醇, 三酸甘油酯, HDL, LDL, eGFR, HBsAg, anti-HCV）
- **嚴重缺口**：血液學群組 (Hb/Plt/MCV/MCH/MCHC/Neutrophil%)、肝功能群組 (AST/ALT/ALP)、內分泌與癌標群組 (HbA1c/TSH/PSA/CA-125) 完全無 ConceptMap

### 新增 ConceptMap 映射項目

#### 血液學群組 (Hematology)
| 項目 | Preferred (Layer 1) | Acceptable (Layer 2) → 待補 ConceptMap | equivalence |
|:---|:---|:---|:---|
| Hemoglobin | `718-7` (Blood) | `59260-0` (全血 by Oximetry) | equivalent |
| Platelet | `777-3` (Blood) | `26515-7` (Blood by Automated count) | equivalent |
| MCV | `787-2` (by Automated count) | `30428-7` (MCV by calculation) | equivalent |
| MCH | `785-6` (by Automated count) | `28539-5` (MCH by Automated count, 全名) | equivalent |
| MCHC | `786-4` (by Automated count) | `28540-3` (MCHC by calculation) | equivalent |
| Neutrophil % | `770-8` (by Automated count) | `26508-2` (Neutrophils/100 WBC by Manual count) | equivalent |

#### 肝功能群組 (Liver Function) — 全新建立
| 項目 | Preferred (Layer 1) | Acceptable (Layer 2) → 待補 ConceptMap | equivalence |
|:---|:---|:---|:---|
| AST (GOT) | `1920-8` (Serum/Plasma) | `14409-7` (Serum/Plasma by UV, with P5P) | equivalent |
| ALT (GPT) | `1742-6` (Serum/Plasma) | `14390-9` (Serum/Plasma by UV, with P5P) | equivalent |
| ALP | `6768-6` (Serum/Plasma) | `1783-0` (ALP method-unspecified) | equivalent |

#### 內分泌與癌標群組 (Endocrine & Tumor Markers)
| 項目 | Preferred (Layer 1) | Acceptable (Layer 2) → 待補 ConceptMap | equivalence |
|:---|:---|:---|:---|
| HbA1c | `4548-4` (NGSP %) | `59261-8` (IFCC mmol/mol) | equivalent |
| TSH | `11580-8` (Serum/Plasma) | `3016-3` (3rd gen, Serum/Plasma) | equivalent |
| PSA | `2857-1` (Serum/Plasma) | `19199-9` (PSA, method-unspecified) | equivalent |
| CA-125 | `10334-1` (Serum/Plasma) | `83085-1` (CA-125 by IA, Serum/Plasma) | equivalent |

> [!NOTE]
> 以上新增共 **13 組**映射，加上既有 13 組，ConceptMap 將達 **26 組**。

---

## 二、VS-CoreDataset 遺漏項目補齊

### 現況分析
- `VS-TWHAVitalSigns` 已有身高/體重/腰圍/收縮壓/舒張壓/BMI，但缺乏 BP Panel 代碼與腰臀比 (WHR)
- `VS-PulmonaryFunction` 有 FVC/FEV1 但未進 CoreDataset
- `VisionTest Profile` 有視力代碼但未進 CoreDataset

### 新增至 VS-CoreDataset 的項目

#### A. 生理測量 (現僅在 VS-TWHAVitalSigns)
| 代碼 | 名稱 | 說明 |
|:---|:---|:---|
| `55284-4` | Blood pressure panel | 收縮壓/舒張壓的 panel-level preferred code |
| `39156-5` | BMI [Ratio] | 已在 VitalSigns VS，需同步至 CoreDataset |
| `8302-2` | Body height | 身高 |
| `29463-7` | Body weight | 體重 |
| `56086-2` | Waist Circumference | 腰圍 |
| `8480-6` | Systolic blood pressure | 收縮壓 |
| `8462-4` | Diastolic blood pressure | 舒張壓 |
| `73708-3` | Waist-to-hip ratio (WHR) | **全新** — 完全未收錄 |

> [!IMPORTANT]
> `73708-3` (WHR) 為新增代碼，需同時加入 `VS-TWHAVitalSigns` 與 `VS-CoreDataset`。

#### B. 功能性檢查 (現僅在 VS-PulmonaryFunction / VS-ExtendedDataset)
| 代碼 | 名稱 | 說明 |
|:---|:---|:---|
| `19876-2` | FVC [Vol] by Spirometry | 肺功能 FVC panel entry point |
| `19868-9` | FEV1 [Vol] by Spirometry | FEV1 |
| `19926-5` | FEV1/FVC [Vol Ratio] | FEV1/FVC 比值 |

#### C. 聽力檢查個別頻率代碼 (目前僅有 Panel)
| 代碼 | 名稱 | 說明 |
|:---|:---|:---|
| `89024-4` | Hearing threshold 500 Hz | 已在 ExtendedDataset (僅 500Hz)，但缺其他頻率 |
| `89023-6` | Hearing threshold 1000 Hz | **新增** |
| `89022-8` | Hearing threshold 2000 Hz | **新增** |
| `89021-0` | Hearing threshold 4000 Hz | **新增** |

> [!NOTE]
> 聽力頻率代碼 LOINC 為 `89024-4` (500Hz)、`89023-6` (1kHz)、`89022-8` (2kHz)、`89021-0` (4kHz)。需先確認這些代碼的正確 LOINC 標識。目前 VS-ExtendedDataset 僅有 `89024-4`，其他頻率需查證後加入。

#### D. 視力檢查 (現僅在 VisionTest Profile 內嵌)
| 代碼 | 名稱 | 說明 |
|:---|:---|:---|
| `79880-1` | Vision test panel | Panel-level code |
| `70936-0` | Visual acuity Left eye | 左眼視力 |
| `70935-2` | Visual acuity Right eye | 右眼視力 |
| `48024-3` | Color vision Test | 辨色力 |

---

## 三、SNOMED CT 映射表建置

### 現況分析
- `input/assets/snomed-mappings.xlsx` 為空 placeholder（38 bytes）
- 目前 IG 缺乏完整的 SNOMED CT 跨術語映射

### 建議方案
建立一份全面的術語映射表，格式為 CSV（方便版本控制與自動處理），同時更新 `terminology.md` 網頁顯示完整映射表。

#### 映射表結構
| 欄位 | 說明 |
|:---|:---|
| `category` | 檢驗分類 |
| `item_name_zh` | 檢驗項目中文名 |
| `loinc_preferred` | LOINC Preferred Code (Layer 1) |
| `loinc_acceptable` | LOINC Acceptable Set (Layer 2) |
| `snomed_ct` | SNOMED CT 概念代碼 |
| `snomed_display` | SNOMED CT 顯示名稱 |
| `ucum_unit` | UCUM 標準計量單位 |
| `regulatory_ref` | 法規欄位參照（如附表九 CBC） |

#### 核心映射範例 (將涵蓋所有 CoreDataset 項目)
| 類別 | 中文名 | Preferred | Acceptable | SNOMED CT | UCUM | 法規 |
|:---|:---|:---|:---|:---|:---|:---|
| 血液學 | 白血球計數 | 6690-2 | {804-5, 26464-8} | 767002 | 10*3/uL | 附表九 CBC |
| 血液學 | 血紅素 | 718-7 | {59260-0} | 38082009 | g/dL | 附表九 |
| 血液學 | 血小板 | 777-3 | {26515-7} | 61928009 | 10*3/uL | 附表九 |
| 生化 | 空腹血糖 | 1558-6 | {2339-0} | 33747003 | mg/dL | 附表九 |
| 生化 | 肌酸酐 | 2160-0 | {38483-4} | 15373003 | mg/dL | 附表九 |
| 生化 | 尿酸 | 3084-1 | {49154-8} | 86228006 | mg/dL | 附表九 |
| 肝功能 | AST (GOT) | 1920-8 | {14409-7} | 45896001 | U/L | 附表九 |
| 肝功能 | ALT (GPT) | 1742-6 | {14390-9} | 34608000 | U/L | 附表九 |
| 肝功能 | ALP | 6768-6 | {1783-0} | 88810008 | U/L | 附表九 |
| 腎功能 | eGFR | 88293-6 | {33914-3} | 80274001 | mL/min/{1.73_m2} | 附表九 |
| 脂質 | 總膽固醇 | 2093-3 | {35200-5} | 77068002 | mg/dL | 附表九 |
| 脂質 | 三酸甘油酯 | 2571-8 | {3043-7} | 14740000 | mg/dL | 附表九 |
| 脂質 | HDL-C | 2085-9 | {3048-6} | 17888004 | mg/dL | 附表九 |
| 脂質 | LDL-C | 13457-7 | {18262-6} | 113079009 | mg/dL | 附表九 |
| 內分泌 | HbA1c | 4548-4 | {59261-8} | 43396009 | % | 成健 |
| 內分泌 | TSH | 11580-8 | {3016-3} | 61167004 | mIU/L | 進階 |
| 癌標 | PSA | 2857-1 | {19199-9} | 63476009 | ng/mL | 進階 |
| 癌標 | CA-125 | 10334-1 | {83085-1} | 50610001 | U/mL | 進階 |
| 肝炎 | HBsAg | 5196-1 | {22326-3} | 39082004 | — | 成健 |
| 肝炎 | anti-HCV | 13955-0 | {47365-2} | 32218006 | — | 成健 |
| 尿液 | 尿蛋白 | 5804-0 | {2888-6} | 271000 | — | 附表九 |
| 生理 | 血壓 Panel | 55284-4 | — | 75367002 | — | 成健 |
| 生理 | BMI | 39156-5 | — | 60621009 | kg/m2 | 成健 |
| 生理 | 腰臀比 | 73708-3 | — | 248362002 | {ratio} | 成健 |

---

## Proposed Changes

### Component 1: ConceptMap 擴充

#### [MODIFY] [ConceptMap-TWHealthCheckLaboratoryMap.fsh](file:///e:/repos/occupation_IG/input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh)
- 新增 **13 組**映射：血液學 6 組 (Hb/Plt/MCV/MCH/MCHC/Neutrophil%)、肝功能 3 組 (AST/ALT/ALP)、內分泌&癌標 4 組 (HbA1c/TSH/PSA/CA-125)
- 維持既有 13 組不變

#### [MODIFY] [VS-CoreDataset.fsh](file:///e:/repos/occupation_IG/input/fsh/valuesets/VS-CoreDataset.fsh)
- 在適當的 section 加入 Layer 2 可接受代碼：
  - 血液學：`59260-0` (Hb 全血), `26515-7` (Plt Automated), `30428-7` (MCV calc), `28539-5` (MCH), `28540-3` (MCHC calc), `26508-2` (Neutrophil Manual)
  - 肝功能：`14409-7` (AST UV), `14390-9` (ALT UV), `1783-0` (ALP unspecified)
  - 內分泌：`59261-8` (HbA1c IFCC), `3016-3` (TSH 3rd gen), `19199-9` (PSA unspecified), `83085-1` (CA-125 by IA)

---

### Component 2: VS-CoreDataset 遺漏項目補齊

#### [MODIFY] [VS-CoreDataset.fsh](file:///e:/repos/occupation_IG/input/fsh/valuesets/VS-CoreDataset.fsh)
- **新增 Section 10: 生理測量 (Vital Signs / Anthropometry)**：收入 `55284-4`, `39156-5`, `8302-2`, `29463-7`, `56086-2`, `8480-6`, `8462-4`, `73708-3`
- **新增 Section 11: 肺功能檢查 (Pulmonary Function)**：收入 `19876-2`, `19868-9`, `19926-5`
- **新增 Section 12: 聽力檢查 (Audiometry)**：收入 `89024-4`, `89023-6`, `89022-8`, `89021-0`
- **新增 Section 13: 視力檢查 (Vision)**：收入 `79880-1`, `70936-0`, `70935-2`, `48024-3`

#### [MODIFY] [VS-TWHAVitalSigns.fsh](file:///e:/repos/occupation_IG/input/fsh/valuesets/VS-TWHAVitalSigns.fsh)
- 新增 `LNC#73708-3 "Waist-to-hip ratio"` (WHR)

---

### Component 3: SNOMED CT 映射表

#### [NEW] [snomed-loinc-mappings.csv](file:///e:/repos/occupation_IG/input/assets/snomed-loinc-mappings.csv)
- 建立完整 CSV 格式的術語映射表，涵蓋 VS-CoreDataset 中所有核心項目的 LOINC Preferred/Acceptable、SNOMED CT、UCUM 單位、法規欄位參照
- 取代原有的空 placeholder `snomed-mappings.xlsx`

#### [MODIFY] [terminology.md](file:///e:/repos/occupation_IG/input/pagecontent/terminology.md)
- 在 Section 3.2 後新增 **Section 4: 核心檢驗項目 LOINC–SNOMED CT 跨術語對照表**
- 以 Markdown 表格呈現完整映射
- 新增 Section 5 說明 CSV 下載與使用方式

---

## Open Questions

> [!IMPORTANT]
> **聽力頻率 LOINC 代碼確認**：目前 VS-ExtendedDataset 僅有 `89024-4` (標註為 "Hearing threshold 500 Hz Ear-L")，但 LOINC 中 89024-4 對應的可能是左耳 500Hz，是否需要同時收錄左/右耳的代碼？目前規劃以代表性頻率代碼為主 (500/1k/2k/4kHz)，左右耳 panel 可在 Profile 層級處理。

> [!NOTE]
> **ConceptMap 中的 equivalence 選擇**：
> - 同一檢體 (如血清) 但不同分析法的代碼使用 `equivalent`
> - 不同檢體範圍 (如 Serum/Plasma vs Blood) 使用 `equivalent`（因實務上健檢場景中差異可忽略）
> - 定性 vs 定量（如尿蛋白試紙 vs 定量）維持 `wider`
> - NGSP% vs IFCC mmol/mol (HbA1c) 使用 `equivalent`（需標示單位轉換）

---

## Verification Plan

### Automated Tests
```bash
# 1. SUSHI FSH 編譯
npx fsh-sushi .

# 2. HL7 IG Publisher 完整編譯
_genonce.bat
```

### Manual Verification
1. 確認 `ConceptMap-TWHealthCheckLaboratoryMap` 頁面顯示所有 26 組映射
2. 確認 `VS-CoreDataset` 頁面新增的 Section 10-13 代碼均正確列出
3. 確認 `terminology.md` 頁面顯示完整 SNOMED CT 映射表
4. 驗證 CSV 術語映射表格式正確，可正常下載
