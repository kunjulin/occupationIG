本頁集中列出本指引**尚未定案的事項**與**已知限制**。

本指引為工業技術研究院委託研擬中之草案，尚未定稿。下列事項多數**需要外部機關或
臨床單位決定**，非本指引可片面認定。集中於此的目的是讓審查者一頁掌握「哪些還沒定、
誰要決定、延後的代價是什麼」，而非分散在各頁的引用區塊中逐頁翻找。

> **本頁不弱化任何既有警語。** 各頁原有的警示文字予以保留，本頁提供的是統一入口與
> 決策所需資訊。若某頁警語與本頁不一致，以本頁為準並請回報。

---

## 關於編號

| 前綴 | 類別 |
|:--|:--|
| `M-` | 資料模型與法規解釋 |
| `G-` | 治理與文件效力 |
| `T-` | 術語 |
| `P-` | 發佈與智財 |

`M-5`、`M-6`、`G-2` 為**既有編號，沿用不變**（已被其他頁面引用）；新項目自
`M-7`／`G-3` 起編。`T-`／`P-` 為本頁新增之前綴。

部分頁面另有早期的「議題／C-」編號（例如 `special-exam.md` 之「議題 5 / C-04」）。
本頁**不重新編號**該系統，僅於相關條目交叉註記，以免破壞既有引用。

**編號一經公開即不變更。** 已解決之項目保留編號並改標狀態，不回收再用。

---

## 一覽表

| 編號 | 標題 | 決定者 | 狀態 |
|:--|:--|:--|:--|
| [M-5](#m-5) | Core 資料集之來源與效力 | 國民健康署 | 待決 |
| [M-6](#m-6) | 第 19 條保存期限之起算點 | 勞動部（函釋） | 待決 |
| [M-7](#m-7) | 保存期限尚未結構化 | 本專案（俟 M-6） | 待決 |
| [M-8](#m-8) | 情境資料集尚未以值集定義 | 本專案 | 待決 |
| [M-9](#m-9) | 上傳語意採 `transaction` 或 `batch` | 主管機關平台端 | 待決 |
| [M-10](#m-10) | 雇主端資料隔離之實作機制 | 主管機關／平台端 | 待決 |
| [M-11](#m-11) | 情境資料集③ 之範疇界定與法規版本 | 主管機關／職安署 | 待決 |
| [G-2](#g-2) | 驗證結果之意義界定 | — （已界定，屬永久性聲明） | 已界定 |
| [G-3](#g-3) | 建置驗證不檢查 display 語意 | — （已知盲區，屬永久性聲明） | 已揭露 |
| [G-4](#g-4) | 文件狀態：研製中草案 | 工研院／主管機關 | 待決 |
| [G-5](#g-5) | TWCR_SF 相依套件之可用性 | 上游 | 待決 |
| [T-1](#t-1) | 23 個檢驗代碼待臨床確認 | 檢驗醫學部／職業醫學科 | **✅ 全數處理完畢（批1–3＋Q4-1＋2 缺口皆已裁示，2026-07-29）** |
| [T-2](#t-2) | 醫事人員證書字號無命名空間 | 衛福部／TW Core | 待決 |
| [T-3](#t-3) | SNOMED CT 對照未逐碼驗證 | 本專案 | 待決 |
| [T-4](#t-4) | 臺灣境內 SNOMED CT 授權管道 | 主管機關 | 待決 |
| [T-5](#t-5) | OID 根節點來源 | 主管機關 | 待決 |
| [T-6](#t-6) | 六個值集被排除於驗證之外 | 本專案（俟 T-1） | 待決 |
| [T-7](#t-7) | 去識別化 Token 之使用方式 | 主管機關／平台端 | 待決 |
| [T-8](#t-8) | 事業單位識別碼之選擇 | 主管機關 | 待決 |
| [T-9](#t-9) | 特殊健檢部分項目未結構化 | 本專案 | 待決 |
| [T-10](#t-10) | DiagnosticReport 無法彙整非檢驗類結果 | TW Core／本專案 | 待決 |
| [T-11](#t-11) | eGFR 多估算公式並存 | 職醫科／平台端 | 待決（MDRD 保留已具公文依據、T-5 結案；餘 Cystatin C 公式範圍待定） |
| [T-12](#t-12) | UCUM 稽核之 Scale 未對映碼（29 筆） | 執行團隊／術語 | 待決（已閘門追蹤，上限 29；判定後可望轉為納入或明確排除） |
| [P-1](#p-1) | canonical 命名空間為 provisional | 主管機關 | 待決 |
| [P-2](#p-2) | 授權條款未宣告 | 委託契約雙方 | 待決 |

---

## M-5　Core 資料集之來源與效力 <a id="m-5"></a>

**現況**　本指引之 Core（`VS-CoreUploadSet`，21 列）係依據國民健康署健檢上傳欄位之
**工作原案**建立。

**待決**　正式公告版本之內容與生效時點。

**所需輸入**　國民健康署之正式公告。

**影響範圍**　`VS-CoreUploadSet`、`datamodel.md`、`index.md`。

**若決策不同**　欄位增減會直接改變 `VS-CoreUploadSet` 之成員，並連帶影響上傳封包之
必填欄位與相關範例。範圍可控，但屬規範性變更。

**⚠️ 常見誤解**　Core（②）≠ 本指引能表達的範圍（①）≠ 某法定情境依法應做的項目（③）。
**不得**以「某項目不在 Core」推論該項目不重要或非 Must Support。三者之界定見
[資料模型](datamodel.html)。

**出處**　`index.md` §3、`datamodel.md` §5

---

## M-6　第 19 條保存期限之起算點 <a id="m-6"></a>

**現況**　《勞工健康保護規則》第 19 條之保存期間，起算點應為「檢查日」「報告日」
或「勞工離職日」尚無定論。本指引**未於資料層固定任一解釋**。

**待決**　法定起算點之解釋。

**所需輸入**　勞動部函釋或主管機關認定。

**影響範圍**　`background.md` §3.1.1；未來之 `ext-retention-period`（backlog，見 M-7）。

**若決策不同**　三種解釋對同一筆紀錄可產生數年的保存期限差異，直接影響資料刪除時點。
在解釋確定前結構化保存期限，等於把一個未定的法律解釋寫死進規範。

**出處**　`background.md` §3.1.1

---

## M-7　保存期限尚未結構化 <a id="m-7"></a>

**現況**　保存期限以敘述方式說明，**未以 extension 結構化**（backlog：`ext-retention-period`）。

**待決**　是否建立該 extension，以及其計算基準。

**所需輸入**　M-6 之解釋確定後方可進行。

**影響範圍**　新增 extension；`background.md`。

**若決策不同**　若最終不結構化，實作端須自行依敘述計算，跨系統一致性無法由規範保證。

**出處**　`background.md` §3.1.1

---

## M-8　情境資料集之值集落地（附表十未審家族待補） <a id="m-8"></a>

**現況（2026-07-29 部分完成，JOB-07）**　情境資料集③已開始以 ValueSet 落地：

- `VS-Appendix9-RequiredSet`（附表九一般健檢）：**完整落地**，代碼全數為已審／已驗。
- `VS-Appendix10-RequiredSet`（附表十）：grouping，**目前僅含四家族**——噪音／鉛／
  粉塵／有機溶劑（`special-exam.md` 涵蓋表標為「已審／已驗」者）。

**尚待補**　附表十其餘**八家族**之專屬值集：高溫、游離輻射、異常氣壓、四烷基鉛、
特定化學物質、黃磷、聯吡啶。其專屬代碼在涵蓋表中多為「未審／部分驗證」，
**刻意尚未納入值集**——依 JOB-07 §5，未經 JOB-01 臨床確認之代碼不得寫進法定必驗值集。

**所需輸入**　T-1（23 個 LOINC 代碼之臨床確認，確認單已備妥）。逐家族之未審代碼
確認後，於 `VS-Appendix10-RequiredSet.fsh` 增列對應子值集並更新涵蓋表之審查狀態欄。

**影響範圍**　`VS-Appendix10-RequiredSet.fsh`（增列子值集）、`special-exam.md` 涵蓋表。

**若決策不同**　在未審家族之代碼確認前強行納入，會把可能錯誤的代碼賦予「法定必驗」
之權威性，撤回成本更高——這正是 §5 所警告者。分期落地是刻意選擇，非疏漏。

**出處**　`index.md` §3、`general-exam.md` §4；JOB-07；T-1（JOB-01）

---

## M-9　上傳語意採 `transaction` 或 `batch` <a id="m-9"></a>

**現況**　上傳封包之處理語意未定。`transaction` 為全有全無，`batch` 允許部分成功。
JOB-04 已完成上傳契約與範例（UC-008／UC-009，暫依現行 profile 採 `transaction`
為預設），兩種語意之比較與「定案後需調整之處」列於
[遵從性要求](conformance.html)之「上傳介接契約」一節——範例之 entry 結構兩者通用，
故本項定案不影響已發佈之範例。

**待決**　採何種語意；若採 `batch`，部分成功之回報格式。

**所需輸入**　主管機關平台端之實作決定。

**影響範圍**　`TWHA-Bundle-Transaction`、`$submit` OperationDefinition、上傳路徑之範例。

**若決策不同**　兩者對實作端的錯誤處理邏輯完全不同；此項未定，上傳介接無法定案。

**出處**　`downloads.md`；JOB-04

---

## M-10　雇主端資料隔離之實作機制 <a id="m-10"></a>

**現況**　`security.md` 以原則層次說明雇主僅得取得健康管理分級而非檢查明細，
**未對應至具體 FHIR 機制**（`Consent`／`Provenance`／`AuditEvent`／SMART scope）。

**待決**　以何種機制落實；`Consent`／`AuditEvent` 是否納入本期範圍。

**所需輸入**　主管機關與平台端之架構決定。

**影響範圍**　`security.md`；可能新增 profile。

**若決策不同**　僅有原則宣示而無可驗證機制，實作端各行其是，隔離效果無法稽核。

**出處**　`security.md`；JOB-11

---

## M-11　情境資料集③ 之範疇界定與法規版本 <a id="m-11"></a>

**現況**　JOB-07 已將情境資料集③（附表九／附表十之法定應執行項目）以機器可讀值集落地
（`VS-Appendix9-RequiredSet`、`VS-Appendix10-*-RequiredSet`）。落地過程浮現兩項界定問題：

1. **「法定應執行」之範疇**：`docs/regulations/` 之附表十 PDF 逐號僅列高階項目——多數危害
   作業之化學生物偵測項僅列「肝腎功能／CBC／尿液」，**未逐項列出尿中代謝物**（例如二硫化碳
   作業之附表十本文僅列 ALT／γ-GT ＋心電圖，未列尿中 TTCA）。本 IG 之家族專屬值集
   （鉛作業之尿中鉛／共聚卟啉／δ-ALA、有機溶劑各作業之尿中代謝物）係採**職安署特殊健康
   檢查細項生物偵測**之口徑，經 `special-exam.md` 涵蓋表歸屬至附表十危害家族，非逐字取自
   附表十本文。兩種口徑對「某次特殊健檢是否做齊」之稽核結果不同。

2. **法規版本**：`docs/regulations/` 現存之附表九／附表十 PDF 為**修正前版本**
   （附表十列 32 項、附表九第(5)項未含紅血球數／MCV）。本 IG 依 **115.06.26 修正**編碼
   （附表十 35 項、附表九增列 RBC／MCV），但**修正版 PDF 未納入 repo**，該批新增項目
   目前無 repo 內權威原文可逐項核對。

**待決**　(1) ③ 之範疇採「附表十本文最低項目」或「職安署特殊健檢細項（含生物偵測）」；
(2) 取得並歸檔 115.06.26 修正版之附表九／附表十 PDF。

**所需輸入**　主管機關／職安署對「法定應執行項目」口徑之認定；修正版法規附表原文。

**影響範圍**　`VS-Appendix10-Lead-RequiredSet`、`VS-Appendix10-OrganicSolvent-RequiredSet`
（含生物偵測項者）；`special-exam.md` 涵蓋表之「代表專屬項目」欄；`VS-Appendix9-RequiredSet`
之 RBC／MCV 成員。

**若決策不同**　若採「附表十本文最低項目」口徑，鉛作業值集將縮為血中鉛、有機溶劑值集將縮為
ALT／γ-GT（＋二硫化碳之心電圖），各家族之尿中生物偵測項須移出「法定必驗」另立「建議監測」
值集。稽核之嚴格度與臨床價值將隨此決策大幅改變——這正是不宜由本 IG 片面認定之處。

**出處**　JOB-07（§3.1／§4）；`special-exam.md` 涵蓋表；`docs/regulations/`

---

## G-2　驗證結果之意義界定 <a id="g-2"></a>

**這不是待決事項，是一項永久性聲明。**

IG Publisher 驗證通過**僅**證明語法正確，且**已被引用之術語**通過代碼有效性檢查。
它**不包含**：

- 臨床適切性；
- 法規符合性；
- 情境完整性；
- 未被任何 profile／ValueSet 引用之對照表代碼。

**不得**以「`0 Error`」或任何 QA 統計作為本指引整體品質之表述。

**出處**　`README.md`、`index.md`

---

## G-3　建置驗證不檢查 display 語意 <a id="g-3"></a>

**這是已知盲區，非待決事項。**

IG Publisher 只檢查「代碼是否存在於該 CodeSystem」，**不檢查 `display` 是否與代碼
真實語意相符**，且該訊息僅為 INFORMATION 等級。因此語意完全錯誤的代碼可一路通過
`0 Error` 建置。

實例：`14390-9` 曾於本指引標為「ALT」，LOINC 官方為
**「Amylase [Enzymatic activity/volume] in Dialysis fluid」**（透析液澱粉酶）。

**已採取之對策**　2026-07-26／27 之術語稽核逐碼以術語伺服器 `$lookup` 覆核，
`Wrong Display Name` 由 133 降至 23（餘 23 筆見 T-1）。新增或引用代碼時，
須逐碼人工確認 LOINC 六軸語意，不可只比對字串相似度。

**⚠️ 另一個相關盲點**　IG Publisher 摘要行的 `err` 計數**不含斷鏈區段**。
目前有 2,078 筆斷鏈未被 `err` 涵蓋（其中 2,026 筆見 P-1）。

**出處**　`README.md`、`CLAUDE.md` §2.2

---

## G-4　文件狀態：研製中草案 <a id="g-4"></a>

**現況**　本指引為工業技術研究院委託研擬中之草案，**尚未定稿**，後續得依共識會議、
委員意見及主管機關規範調整。

**待決**　定稿時點與程序。

**所需輸入**　工研院委託案之結案程序；主管機關之採認。

**影響範圍**　全文件；`sushi-config.yaml` 之 `status`／`version`；`package-list.json`。

**出處**　`README.md`、各頁首

---

## G-5　TWCR_SF 相依套件之可用性 <a id="g-5"></a>

**現況（2026-07-28 已查證）**　`sf-*` 系列（5 個 CodeSystem、4 個 ValueSet）之 canonical
位於 `hapi.fhir.tw` 命名空間。CI 實測結果：

| 探測對象 | 結果 |
|:--|:--|
| `fhir.twcrsf` 套件（3 個 registry 之**根路徑**） | **全部 404**——套件 ID 不存在，非版本號給錯 |
| 10 個 canonical 於 `hapi.fhir.tw` | **全部 404**——伺服器有回應，只是不服務這些資源 |

即**上游既無套件、亦不服務該命名空間下的這些資源**。

已依 JOB-10 路徑 B 處置：本 IG 之複本明確降級為 stub——
`content = #fragment`（FHIR 為「外部代碼系統之局部複本」設計的機制，
原標 `#complete` 等於宣稱自己是權威完整定義）、`status = #draft`、
`experimental = true`、標題冠【本地 stub】、`copyright` 載明權威來源。

**待決**　TWCR_SF 是否會正式發佈套件。

**所需輸入**　上游維護者之答覆（屬行政協調，JOB-10 §4 列為範圍外）。

**影響範圍**　`TWCRSF-mocks.fsh`、`sushi-config.yaml` 之 `special-url`、
`TWHA-SocialHistory` 之綁定、嚼檳榔範例。

**若決策不同**　套件一旦可用，應改為正式 `dependencies` 並**刪除整個 stub 檔**
（JOB-10 路徑 A）。在此之前，本 IG 產出中仍存在 9 個掛在他方命名空間下的資源——
`#fragment` 已將其正名為「局部複本」而非權威定義，但**命名空間本身仍非本專案所有**。

> ⚠️ **未解的殘留風險**：若 TWCR_SF 日後於同一 canonical 發佈與本 stub 內容不同的定義，
> 同時載入兩者的系統會遇到衝突。本 stub 之代碼清單（嚼檳榔量 91 碼、年 100 碼、
> 戒檳榔年 91 碼）**未經上游核對**——無從核對，因為上游不可達。

**出處**　`sushi-config.yaml`；JOB-10；CI run 30368332715／30368750214

---

## T-1　23 個檢驗代碼待臨床確認 <a id="t-1"></a>

**現況（2026-07-29 更新：全數處理完畢）**　檢驗醫學部（張永達醫師，
2026-07-27）與職業醫學科已回覆確認單，並就後續之裁示點回覆。23 碼經批 1–3、Q4-1 裁示
與 2 項 LOINC 缺口裁示全數處理完畢，Wrong Display Name 歸零（見 `qa-baseline.json`）。依回覆分批處理：

- **批 1（已處理，5 碼）**：代碼經確認**正確、僅顯示名漂移**者——沙門/志賀氏菌培養
  `43371-4`（報菌種）、試紙尿糖/尿酮 `5792-7`/`5797-6`（報濃度）、維生素 D `62292-8`
  （報總量 D2+D3）、MDRD eGFR `33914-3`（第 8 題確認保留為 Acceptable）——顯示名已改為
  LOINC 官方用語。附錄 A 之 `snomed-loinc-mappings.csv` 內部不一致（`88293-6` vs 本體
  `98979-8`）亦一併統一。（CI 實測 `43371-4`、`33914-3` 兩碼之批1 顯示名有轉抄誤，已於批2 更正，見下。）
- **批 2（已處理，經 CI 覆核）**：第 2-2/2-3/2-4 題、第 3 題、第 7 題之顯示名更正皆已生效
  （尿氟 `34304-6` 改莫耳、AFP `19177-5` 改莫耳、同半胱胺酸 `2428-1` 改質量、Anti-HBs
  `22322-2`/`5193-8` 標示對調回正確位置），一併更正批1 兩筆轉抄誤（`43371-4` 多一個 sp、
  `33914-3` 舊式長名）——以上 7 碼於 CI 之 Wrong Display Name 已全數清除。
  **關鍵：臨床所建議之 5 個新候選碼，經 CI `$lookup` 覆核，3 個不成立、2 個成立**——正好
  印證「未照單全收臨床建議之碼」之稽核紀律（§2.2）：
    - ❌ `5605-7`（建議之尿氟質量碼）：**LOINC 未知碼**（不存在於 2.82，產生 ERROR）→ 剔除。
    - ❌ `65633-0`（建議之 Anti-HBs 定量碼）：官方實為 **HBsAg 表面「抗原」確認法**、非 Anti-HBs
      抗體 → 剔除（定量 Anti-HBs 由已更正之 `5193-8` 承載）。
    - ❌ `62858-6`（建議之完整巨核細胞碼）：官方實為 **Micromegakaryocytes（微小巨核細胞）**、
      亦非完整巨核細胞 → 剔除，`70028-6`（細胞核）以官方顯示名暫留為最接近之有效碼。
    - ✅ `13965-9`（同半胱胺酸莫耳碼）：正確，顯示名一次到位。
    - ✅ `53962-7`（AFP 質量碼）：碼有效，官方為**腫瘤標記型** AFP 質量碼，顯示名依官方更正後保留。
- **批 3（已處理，經 CI 覆核；候選碼由 WebSearch 取自 loinc.org——本環境無法直連 tx/loinc，
  故以 CI 之 tx 建置作最終覆核）**：
    - 第 1 題 8 個尿沉渣碼換為 `[#/volume] in Urine by Automated count`（全尿自動計數，Sysmex UF 之報告型態）：
      Bacteria `51480-2`、Squamous EC `51486-9`、Hyaline casts `51484-4`、Epithelial cells `87926-2`、
      Casts `51483-6`、Erythrocytes `798-9`、Leukocytes `51487-7`、Mucus `51478-6`（同屬套組 LOINC `50554-5`）。
      **JOB-14（2026-07-29）修正**：批3 把單一機構之 /µL 報告習慣當成全國唯一選項、將 9 個 ACTIVE 之 `[#/area]`
      面積碼整組刪除，致以 /HPF 報告之機構無碼可用。JOB-14 已將該 9 個面積碼回收為 **acceptable**（display 逐字採
      LOINC 官方）並補 ConceptMap `element[28]–[36]` 之 `#relatedto` 歸一，改為 preferred（體積）／acceptable（面積）
      雙軌收錄（見 [JOB-14](https://github.com/kunjulin/occupationIG/blob/main/docs/optimization/JOB-14-preferred-acceptable-recovery.md)）。
    - 第 2-1 題尿錳：`42221-2` 顯示名改回莫耳（官方）＋加院方所用之質量碼 `5684-6`。
    - 第 7 題巨核細胞：換為 `19252-6`「Megakaryocytes/100 leukocytes in Blood」（完整巨核細胞，IG 原欲表達者），
      填補批2 剔除 `62858-6` 之缺口。
    - 尿氟質量碼缺口：批2 誤薦之 `5605-7` 不存在，正確碼為 `5650-7`（mg/L），已補。
    - 第 4-2 題 EBV VCA IgA `9633-9`：顯示名改回官方 IFA 效價。
- **批3 兩項 LOINC 缺口（已裁示，2026-07-29）**：
    - **精子（尿）定量**：使用者提供 LOINC `51479-4`「Spermatozoa `[#/volume]` in Urine by Automated count」
      （同屬套組 `50554-5`，先前 WebSearch 未浮出），**缺口不成立**——已比照其餘 8 項換碼（`53324-0`→`51479-4`）。
    - **EBV VCA IgA 定量（EIA）**：確為真正 LOINC 缺口（LOINC 僅 capsid IgG `5157-3`／IgM `5159-9` 之 EIA 定量，
      無 IgA 之 EIA 定量碼）。此項屬鼻咽癌篩檢自費腫瘤標記、不在附表九/十/成人預防保健。經使用者裁示
      **保留 `9633-9`**（capsid IgA `[Titer]` IF，LOINC FSN 為 SemiQn/IF）為本 IG 表達 VCA IgA 之碼；
      院方 EIA/定量與本碼之方法/量表落差，為已知並接受之 LOINC 缺口（如需精準表達，須另循方法變更或向
      Regenstrief 申請新碼）。
- **第 4-1 題 H. pylori IgG `5176-3`（已裁示，2026-07-29）**：原回覆為「本院健檢未執行」，
  無報告型態可判定定性/定量。經使用者提供 LOINC 官方查詢裁示採**選項 (b)**：保留該碼並逕採
  LOINC 官方定量顯示名 `Helicobacter pylori IgG Ab [Units/volume] in Serum by Immunoassay`
  （官方 Scale = Qn、Method = IA；舊標 `[Presence]` 有誤）。屬本院未執行、無臨床背書之保留碼，
  於延伸資料集表達「本 IG 能承載此項」而非「某院實作此項」。此碼 Wrong Display Name 就此清除。

原始 8 題如下（保留供追溯）：

**待決**　8 個問題，涵蓋 23 個代碼：

| 題 | 主題 | 代碼數 |
|--:|:--|--:|
| 1 | 尿沉渣自動計數：每 µL 或每視野 | 9 |
| 2 | 質量濃度 vs 莫耳濃度（尿錳／尿氟／AFP／同半胱胺酸） | 4 |
| 3 | Anti-HBs 定性 vs 定量（兩碼標示疑似互換） | 2 |
| 4 | H. pylori IgG／EBV VCA IgA／沙門志賀氏菌培養之報告型態 | 3 |
| 5 | 試紙尿糖尿酮：分級或濃度 | 2 |
| 6 | 維生素 D 總量或僅 D3 | 1 |
| 7 | 巨核細胞或巨核細胞核 | 1 |
| 8 | MDRD eGFR（`DISCOURAGED`）去留 | 1 |

**所需輸入**　檢驗醫學部（第 1–7 題）與職業醫學科（第 8 題）之答覆。
**可逕行發文之確認單已備妥**：`docs/optimization/CLINICAL-QUERY-JOB-01.md`。

**影響範圍**　`VS-ExtendedDataset`、ConceptMap、`terminology.md`、相關範例。

**若決策不同**　量綱或量表選錯會使接收端以錯誤的單位或型態解讀數值。
第 1 題一個答案即涵蓋 9 個代碼，建議優先確認。

**出處**　JOB-01

---

## T-2　醫事人員證書字號無命名空間 <a id="t-2"></a>

**現況**　TW Core 1.0.0 **未提供**醫事人員證書字號之識別碼命名空間
（經 `scripts/inspect-package.js` 盤點實測：30 個 CodeSystem 中無此項；
`Practitioner` 固定之 `identifier.system` 僅內政部、移民署、護照三者，皆為人別識別碼）。

範例現以 `http://example.org/fhir/sid/tw-practitioner-license` **佔位**，
並於範例中標明「不是可實作的值，實作端不得沿用」。

> 「暫時留空」經實測不可行——`TWCorePractitioner` 要求 `identifier.system` 必填（min 1）。

**待決**　正式命名空間之核定。

**所需輸入**　衛生福利部（發放機關）或 TW Core 之定義。

**影響範圍**　`input/fsh/examples/01-actors-and-encounter.fsh` 之 `example-doctor` 與 `example-nurse`；未來之 `Practitioner` slicing。

**若決策不同**　目前之佔位值不具跨機構唯一性。**第 19 條之稽核追溯若需跨機構識別
執行者，此項必須先解決**——它不是可以無限期擱置的項目。

**出處**　JOB-06 §8.3

---

## T-3　SNOMED CT 對照未逐碼驗證 <a id="t-3"></a>

**現況**　`terminology.md` 之 SNOMED CT 欄位（§4.1 所列 4 碼除外）係以
SNOMED International Browser **人工填載，未經術語伺服器逐碼驗證**，
屬 draft／informative，**不得作為正式建議 mapping 或交換要求使用**。

**待決**　是否逐碼驗證並轉為正式對照。

**所需輸入**　本專案工作量；且相依於 T-4（無授權則無法以術語伺服器驗證）。

**影響範圍**　`terminology.md` 之對照表。

**若決策不同**　未驗證之人工對照曾被實測有相當比例語意不符
（本指引 2026-07-26 之稽核即更正 4 個職業健康相關錯碼）。維持現狀則該欄位僅供參考。

**出處**　`terminology.md` §4

---

## T-4　臺灣境內 SNOMED CT 授權管道 <a id="t-4"></a>

**現況**　SNOMED CT 為授權術語。臺灣境內之授權管道與費用歸屬未確認。

**待決**　實作機構取得授權之管道。

**所需輸入**　主管機關說明或 SNOMED International 之國家會員資訊。

**影響範圍**　`ip-statements.md`；引用 SNOMED CT 之所有值集之可實作性。

**若決策不同**　若實作端無法取得授權，SNOMED CT 相關內容將無法落地。

**出處**　`ip-statements.md`

---

## T-5　OID 根節點來源 <a id="t-5"></a>

**現況**　本指引之 artifact **未指派 OID**。IG Publisher 就此提出 95 筆提示
（40 筆 `should have an OID assigned`、55 筆 `could usefully have an OID assigned`）。

**待決**　可用之 OID 根節點（`auto-oid-root` 參數）。

**所需輸入**　主管機關核配之 OID 根節點；不得自行捏造。

**影響範圍**　`sushi-config.yaml` 之 `parameters`；全部 artifact。

**若決策不同**　取得後可一次消除該 95 筆提示；未取得則維持現狀，不影響功能。

**出處**　JOB-09；`qa-baseline.json`

---

## T-6　六個值集被排除於驗證之外 <a id="t-6"></a>

**現況**　`sushi-config.yaml` 之 `no-validate` 排除六個值集
（`VS-CoreDataset`、`VS-ExtendedDataset`、`VS-OccHealthCheck-Required`、
`VS-PulmonaryFunction`、`VS-TWHAVitalSigns`、`VS-UnfitDiseases`）。
**原始理由未見於任何文件或 commit 訊息。**

這六個正是本指引的核心術語資產，將其排除會削弱「`0 Error`」的說服力。

**待決**　能否移除；若須保留，逐項理由為何。

**所需輸入**　T-1 完成後重新評估——移除後可能一次浮出大量訊息，
須有術語稽核結果為基礎才能判斷何者為真問題。

**影響範圍**　`sushi-config.yaml`；QA 統計。

**出處**　`sushi-config.yaml` 註解；JOB-09

---

## T-7　去識別化 Token 之使用方式 <a id="t-7"></a>

**現況**　`security.md` 提及「身分證字號改以雜湊 Token 代替」，但**未定義**
該 Token 之命名空間、雜湊演算法要求、salt 保管方式，
以及**去識別化後是否仍可跨機構比對**。

**待決**　上述四項；其中「是否保留跨機構可比對性」是關鍵取捨。

**所需輸入**　主管機關與平台端之決定。

**影響範圍**　`security.md`；未來之識別碼命名空間定義。

**若決策不同**　保留可比對性則可追蹤同一勞工跨機構之健檢，但去識別化強度較低；
不保留則相反。此取捨直接決定監理系統能做什麼。

**出處**　`security.md`；JOB-06 §3.4

---

## T-8　事業單位識別碼之選擇 <a id="t-8"></a>

**現況**　範例以**統一編號**（`https://gcis.nat.gov.tw`，經濟部商業司）識別事業單位；
該命名空間由 TW Core 定義於 `Organization-co-twcore`，故模型層面已對齊上游。

**待決**　勞工健檢之監理情境是否應改以**勞保投保單位編號**識別。

**所需輸入**　主管機關之決定。

**影響範圍**　`input/fsh/examples/01-actors-and-encounter.fsh`；`TWHA-Organization-Employer`。

**若決策不同**　兩者對應關係非一對一（同一統編可有多個投保單位），
若監理以投保單位為基準而資料以統編記錄，將無法直接勾稽。

**出處**　JOB-06

---

## T-9　特殊健檢部分項目未結構化 <a id="t-9"></a>

**現況**　附表十部分作業之檢查項目尚未以結構化代碼承載，改以通用方式記錄：

- 氯乙烯作業之**手部 X 光**；
- 聯苯胺類作業之**尿液細胞學**；
- 鈹作業之生物偵測（**無公認定量 LOINC**，以定性／理學評估記錄）。

**待決**　各項之代碼結構化方式。

**所需輸入**　本專案工作量；部分項目可能確無合適國際代碼，需提報新增或以本地碼承載。

**影響範圍**　`special-exam.md`；相關值集。

**出處**　`special-exam.md` §臨床適當性註記

---

## T-10　DiagnosticReport 無法彙整非檢驗類結果 <a id="t-10"></a>

**現況**　`TWCoreDiagnosticReport`（本 IG `TWHA-DiagnosticReport` 之上游）將
`result` 限定為 `Reference(Observation-laboratoryResult-twcore)`。健檢報告中的
聽力、肺功能、心電圖、理學檢查等**非檢驗類** Observation 一律不符
（CI run 30406136544 實測 3 筆 `Unable to find a profile match`）。
現行範例（`example-diagnostic-report`）因此**刻意不填 `result`**，
非檢驗結果之彙整改由 `Composition` 之 section 承載。

**待決**　健檢報告之彙整資源選擇：(a) 維持現狀——`DiagnosticReport.result`
僅收檢驗項目，其餘一律走 Composition；(b) 本 IG 對 `result` 放寬型別——
但 FHIR profile **不得放寬**上游約束，此路徑需改為不繼承 TWCoreDiagnosticReport；
(c) 向 TW Core 提案放寬。

**所需輸入**　TW Core 維護團隊對 `result` 約束意圖之說明；平台端對
「報告容器」之實際需求（僅檢驗？或含全部健檢項目？）。

**影響範圍**　`TWHA-DiagnosticReport`；`example-diagnostic-report`；
`general-exam.md` 之報告章節；上傳封包之組成建議。

**若決策不同**　若採 (b) 脫離 TW Core 繼承，將失去 TW Core 對
DiagnosticReport 之全部約束與互通性主張，代價大於效益，除非 TW Core
明確表示 `result` 之限縮並非有意。在此之前，實作端**不應**把非檢驗
Observation 塞進 `result`——那會在上游驗證失敗。

**出處**　JOB-05 補範例時之 CI 實測（run 30406136544）

---

## T-11　eGFR 多估算公式並存 <a id="t-11"></a>

**現況**　JOB-01 第 8 題（職業醫學科，2026-07-27）確認：eGFR 應**多公式並存**，
不宜只留單一公式。本 IG 現以 CKD-EPI 2021（`98979-8`）為 Preferred、MDRD（`33914-3`，
LOINC 狀態 DISCOURAGED）為 Acceptable，並以 ConceptMap 註明「不同公式數值不可直接互換」。
職醫科並指出**部分院所採用合併 Creatinine／Cystatin C 之公式**，該類尚未於本 IG 收碼。

**T-5 結案（2026-07-30）**　共同主持人曹又中主任（職業醫學）答覆第三次書面確認單第 5 題並檢附
主管機關公文——**衛生福利部國民健康署 115.01.15 國健慢病字第 1150660003 號函**。據此，MDRD
（`33914-3`）之保留具一級權威依據，且各公式分層已確定：**CKD-EPI 2021（`98979-8`）為 Preferred、
MDRD 為 Acceptable**。公式沿革（民國 114＝2025、115＝2026）：

| 時期 | MDRD 4-variable | CKD-EPI 2021 |
|:--|:--|:--|
| 114 年（含）及以前 | 成健 VPN **必填欄位、機構自行填入** | 114 年為**非必填**欄位、系統**自動計算**（帶入年齡／性別／肌酸酐） |
| 115.01.01 起 | 停止採用 | 取代 MDRD；健保署**取消自動計算**、改由機構自行填入 |

範圍事實：eGFR **僅用於成健**、不屬附表九／十；國健署原案 21 列收 `09015C` 肌酸酐而**未收 eGFR**
（eGFR 為成健申報端之衍生欄位，非院端上傳欄位）。詳見[術語頁 §6.2a](terminology.html)。

**待決**　是否新增 Cystatin C 相關 eGFR 公式之 LOINC 代碼（**各公式之 Preferred／Acceptable 分層已於
2026-07-30 依公文確定**：CKD-EPI 2021 為 Preferred、MDRD 為 Acceptable——此項已非待決）。

**所需輸入**　平台端／職醫科對「本 IG 應涵蓋哪些 eGFR 公式」之範圍認定；新增碼須經
術語伺服器 $lookup 逐碼驗證六軸。

**影響範圍**　`VS-ExtendedDataset`、`ConceptMap-TWHealthCheckLaboratoryMap`、`terminology.md`。

**若決策不同**　僅收單一公式會使以其他公式報告之院所無法以本 IG 標準碼交換；
全收則需維護多碼並持續追蹤各公式之 LOINC 狀態。MDRD 之保留（不移除）已由本題確認。

**出處**　JOB-01 第 8 題臨床回覆（2026-07-27）

---

## T-12　UCUM 稽核之 Scale 未對映碼（29 筆） <a id="t-12"></a>

**現況**　`scripts/audit-ucum.js` 以 `$lookup` 之 `SCALE_TYP` 判定代碼是否為量值型（UCUM 適用）。
tx.fhir.org 於部分代碼以 **LOINC 答案清單碼**回傳且未附 display，現有對映表僅涵蓋
`LP7753-9`（Qn）／`LP7752-1`（OrdQn）／`LP7751-3`（Ord）／`LP7750-5`（Nom）／`LP7749-7`（Nar）。
尚有 **29 碼**之 Scale 為未對映之答案清單碼：`LP32888-7`（17 筆）、`LP436123-6`（10 筆）、
`LP7747-1`（2 筆，`89015-2`／`98497-1` panel）。該 29 碼現列為具名狀態「Scale 未知」
並以實測值 29 為閘門上限（`--max-unknown 29`），**新增即失敗**。

**待決**　上開三個答案清單碼各對應何種 LOINC Scale，以及其代碼是否應納入 UCUM 稽核範圍。
初步線索：`LP436123-6` 之 10 筆多為試紙／效價項目（`5804-0` 尿蛋白試紙、`9633-9` EBV 效價），
且其中部分**確有官方 `EXAMPLE_UCUM_UNITS`**（如 `5804-0` 為 `mg/dL`），研判可能為 SemiQn；
惟此係由項目性質推得，**未經權威查證，故不逕行納入**。

**所需輸入**　對 `LP32888-7`／`LP436123-6`／`LP7747-1` 三個 LOINC part 代碼執行
`$lookup`（或查 loinc.org 之 part 頁面）取得其正式 Scale 名稱。本容器之 proxy 封鎖
tx.fhir.org 與 loinc.org（403），無法於開發環境完成；須於可連外環境或由 CI 增設查詢步驟。

**影響範圍**　`scripts/audit-ucum.js` 之 `SCALE_BY_LP` 對映與 `--max-unknown` 基準、
`extended-ucum-reference.csv` 之列數（若判定納入，該等碼須補列官方單位）、
`terminology.md` §6.1 之統計。

**若決策不同**　若判定為量值型（如 SemiQn）而應納入，則現行稽核仍有最多 29 碼之涵蓋缺口，
其建議單位未經比對——與 JOB-19 補充事項 §2 所指之缺陷同型，須補列並將
`--max-unknown` 降為 0；若判定為非量值型（如 Doc／Multi），則現況正確，
僅需將該三碼補入 `SCALE_BY_LP` 使其歸為「不適用」，`--max-unknown` 亦可降為 0。
兩種結果都應使該基準歸零——**保留 29 不是結論，是待辦**。

**出處**　JOB-19 補充事項施作（2026-07-30）；CI run 30534387613 實測

## P-1　canonical 命名空間為 provisional <a id="p-1"></a>

**現況**　canonical 為 `https://twcore.mohw.gov.tw/ig/twha`，**provisional**——
正式命名空間之核定機關與命名尚待確認。該站尚未建立。

**連帶影響（重要）**　publish box 之「Directory of published versions」連結由
canonical 推導為 `.../ig/twha/history.html`，該頁不存在，**網站每一頁都因此產生一個斷鏈**
——目前計 **2,026 筆**。已將 `path-history` 暫指向 GitHub Pages 之實際位址以供審閱，
正式發佈後應改回官方站並改由發佈流程依 `package-list.json` 產生。

> **此數字會隨文件成長。** publish box 出現在每一個輸出頁面，故每新增一個敘述頁面
> 即增加 2 筆（根層與 `zh-TW` 語言層各一）、每新增一個 artifact 即增加 12 筆
> （6 種渲染變體 × 2 層）。本頁自身即貢獻了 2 筆。**這不是品質退步，是 P-1 未解的
> 機械性後果**；P-1 一旦解決，此類斷鏈將整批歸零。

**待決**　正式 canonical 之核定機關與命名。

**所需輸入**　主管機關核定。

**影響範圍**　`sushi-config.yaml`（`canonical`、`path-history`）、全部 artifact 之
canonical URL、`NS-ReportIdentifier` 之 `uniqueId`、`package-list.json`。

**若決策不同**　canonical 變更會使所有已發佈之 artifact URL 失效。
**此時變更之成本遠低於定稿後**——這也是本指引之識別碼命名空間刻意採 `/sid/` 路徑
（與 artifact canonical 分層）的原因。

**出處**　`sushi-config.yaml`、`history.md` §2、`README.md`

---

## P-2　授權條款未宣告 <a id="p-2"></a>

**現況**　`sushi-config.yaml` **刻意未填 `license` 欄位**——本指引自訂之
CodeSystem／ValueSet／Profile／Extension 之授權條件尚待確認。

**待決**　授權條款與著作權歸屬。

**所需輸入**　工研院委託契約之約定；委託方與受託方之協議。

**影響範圍**　`sushi-config.yaml`；`ip-statements.md`；下載專區之使用條件。

**若決策不同**　未宣告授權即實作端無從判斷可否使用、修改或再散布本指引之內容，
這是**可實作性的前提條件**，非僅形式問題。

**出處**　`ip-statements.md` §5

---

## 維護慣例

後續工作若遇到**需外部決策**之事項，一律回填本頁，不要只寫在該頁的引用區塊裡。
新增時：

1. 依前綴分類取新編號（不重用已解決者之編號）；
2. 填齊「現況／待決／所需輸入／影響範圍／若決策不同」五項——
   **「若決策不同」不可省略**，那是審查者判斷可否先行採用的關鍵資訊；
3. 於一覽表加列；
4. 於原出處頁面留簡短提示並連結至本頁對應條目。

已解決者**保留編號**，狀態改為「已決」並註記決議日期與依據，不從本頁刪除——
審查者需要看到決策軌跡。
