// 嚼檳榔相關之本地代碼系統（JOB-29 路徑甲）
//
// 治理界線（JOB-29 §2.3）：本檔所定義者之 canonical 全部位於**本指引自己的命名空間**，
// 與 check-dependencies.js 之 D-2（不得在他方命名空間下發佈定義）所禁止的情形正好相反。
// 上游 TWCR_SF **沒有**「嚼檳狀態」之四級分類碼——其 sf-ObserBeh 提供的是行為別
// （Observation.code 用），非狀態值——故此處為補既存缺件，非重複定義他人已有之代碼。
//
// 皆依 CS-HealthMgmtLevel 之既有格式標 experimental = true 並於描述載明 provisional。

// ─────────────────────────────────────────────── 狀態（value[x] 之值）
// 與 CS-SmokingStatus 逐碼對稱，便於同一份問卷邏輯共用（JOB-29 §2.2）。
//
// ⚠️ **不含 unknown**（JOB-29 附錄 B.4）：狀態不詳者送 value.dataAbsentReason。
// 把 unknown 放進值集即為「哨兵值混編於同一代碼軸」——正是上游 sf-BetNutChewAmount
// 之 #91（偶爾嚼）／#98（量不詳）／#99（未記載）與數量碼混編所造成的問題（附錄 A.5）。
// 分開之後，「狀態不詳」與「狀態已知但量不詳」才得以區分；若 unknown 是值集成員，
// 兩者會被壓成同一種表達。
CodeSystem: CS_BetelNutStatus
Id: CS-BetelNutStatus
Title: "嚼檳榔狀態代碼系統"
Description: "勞工健檢生活習慣調查中之嚼檳榔狀態分類，與吸菸狀態（CS-SmokingStatus）逐碼對稱。（**provisional**：本代碼系統為工作小組建議之本地代碼配置，**尚待主管機關確認官方代碼與定義（M-5）**；不得表述為已對接官方申報系統。）"
* ^experimental = true
* ^caseSensitive = true
* #0-never "從未嚼食檳榔" "受檢勞工從未嚼食檳榔。"
* #1-occasional "偶爾嚼食" "受檢勞工偶爾嚼食檳榔（非每日，且無固定量）。"
* #2-daily "每日嚼食" "受檢勞工每日嚼食檳榔。"
* #3-quit "已戒除" "受檢勞工過去曾嚼食檳榔，目前已戒除。"

ValueSet: VS_BetelNutStatus
Id: VS-BetelNutStatus
Title: "嚼檳榔狀態值集"
Description: "包含嚼檳榔狀態代碼的值集。（provisional，隨 CS-BetelNutStatus 待官方確認）不含「不詳」——狀態不詳者以 `dataAbsentReason` 表達，見 CS-BetelNutStatus 之說明。"
* ^experimental = true
* include codes from system CS_BetelNutStatus

// ─────────────────────────────────────────────── component.code（結構用）
// **這是「解耦」的實際著力點**（JOB-29 §A.1）：component.code 若仍取自上游
// sf-BetNutChewBeh，則即使值改為 Quantity，建置仍須解析上游 canonical 才能完成。
// 與上游 amount／year／quit 之對應為 1:1，列於 terminology.md 之對照表。
CodeSystem: CS_BetelNutComponent
Id: CS-BetelNutComponent
Title: "嚼檳榔量化元件代碼系統"
Description: "`TWHA-SocialHistory-BetelNut` 各 `component.code` 之本地代碼。前三碼與上游 TWCR_SF `sf-BetNutChewBeh` 之 `amount`／`year`／`quit` 為 1:1 對應。（**provisional**：隨本指引之嚼檳榔建模待主管機關確認，M-5。）"
* ^experimental = true
* ^caseSensitive = true
* #amount "每日嚼食量" "每日嚼食檳榔之顆數，以 UCUM `{quid}/d` 表達。對應上游 sf-BetNutChewBeh#amount。"
* #duration-years "嚼食年數" "嚼食檳榔之總年數，以 UCUM `a` 表達。對應上游 sf-BetNutChewBeh#year。"
* #cessation-duration "戒除期間" "已戒除之期間，以 UCUM `a` 或 `mo` 表達，**以原始採集粒度為準**（不得將「已戒 1 年」逕行改寫為 12 個月，見 JOB-29 §A.6）。對應上游 sf-BetNutChewBeh#quit。"
* #cessation-date "戒除日期" "戒除之日期（得僅至年或年月）。**日期為原始事實，期間為導出值**——期間會隨檢查日改變，故兩者並存時以本欄為準（JOB-29 附錄 B.3）。**不得由「已戒 N 年」回推本欄**。"
* #with-tobacco "是否含菸草" "所嚼食之檳榔是否含菸草。IARC 對含／不含菸草之檳榔分開評估，故流行病學分析需要此欄（JOB-29 附錄 B.1 #5）。"
* #additive "添加物" "所嚼食之檳榔所用之添加物（荖花／荖葉／無）。"
* #lime "石灰種類" "所嚼食之檳榔所用之石灰種類（紅灰／白灰）。"
* #hpa-category "口腔黏膜檢查表級距" "國民健康署口腔黏膜檢查表（107/7 修訂）之嚼檳榔習慣原始勾選，保留不換算成中位數（T-13）。"
* #amount-coded "每日嚼食量（上游級距碼）" "以上游 TWCR_SF 級距碼表達之每日嚼食量，供與癌症登記勾稽之用。**可選、綁定強度 extensible**——移除本 component 不影響任何核心資料（JOB-29 路徑 C-2）。"

// ─────────────────────────────────────────────── 添加物與石灰（兩個軸）
// JOB-29 附錄 B.6：委員原案之 bq-type 將「荖花／荖葉／紅灰／白灰」列為單一 0..1，
// 但那是**兩個軸**——添加物與石灰種類——一個人可以「荖葉＋白灰」。以單一 0..1 承載
// 會強迫填報者二選一而失真，其性質與附錄 A.5(一) 所指之混編同型。故拆為兩個 component。
CodeSystem: CS_BetelNutAdditive
Id: CS-BetelNutAdditive
Title: "檳榔添加物代碼系統"
Description: "嚼食檳榔所用之添加物。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）"
* ^experimental = true
* ^caseSensitive = true
* #betel-inflorescence "荖花" "以荖花（檳榔花）為添加物。"
* #betel-leaf "荖葉" "以荖葉為添加物。"
* #none "無添加物" "未使用荖花或荖葉。"

ValueSet: VS_BetelNutAdditive
Id: VS-BetelNutAdditive
Title: "檳榔添加物值集"
Description: "包含檳榔添加物代碼之值集。（provisional，隨 CS-BetelNutAdditive 待官方確認）"
* ^experimental = true
* include codes from system CS_BetelNutAdditive

CodeSystem: CS_BetelNutLime
Id: CS-BetelNutLime
Title: "檳榔石灰種類代碼系統"
Description: "嚼食檳榔所用之石灰種類。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）"
* ^experimental = true
* ^caseSensitive = true
* #red-lime "紅灰" "使用紅灰。"
* #white-lime "白灰" "使用白灰。"

ValueSet: VS_BetelNutLime
Id: VS-BetelNutLime
Title: "檳榔石灰種類值集"
Description: "包含檳榔石灰種類代碼之值集。（provisional，隨 CS-BetelNutLime 待官方確認）"
* ^experimental = true
* include codes from system CS_BetelNutLime

// ─────────────────────────────────────────────── 資料來源
// JOB-29 附錄 B.1 #6：以 LOINC 48766-0（Information source）為 component.code，
// 值為本地之三分類。標註資料來源可使「自述」與「病歷／篩檢表」之可信度差異被保留。
CodeSystem: CS_BetelNutInfoSource
Id: CS-BetelNutInfoSource
Title: "嚼檳榔資料來源代碼系統"
Description: "嚼檳榔資訊之取得來源。（**provisional**：本地代碼配置，尚待主管機關確認官方代碼與定義（M-5）。）"
* ^experimental = true
* ^caseSensitive = true
* #self-report "受檢者自述" "由受檢者於問診或問卷中自行陳述。"
* #medical-record "病歷紀錄" "自既有病歷紀錄取得。"
* #screening-form "篩檢表" "自口腔黏膜檢查等篩檢表取得。"

ValueSet: VS_BetelNutInfoSource
Id: VS-BetelNutInfoSource
Title: "嚼檳榔資料來源值集"
Description: "包含嚼檳榔資料來源代碼之值集。（provisional，隨 CS-BetelNutInfoSource 待官方確認）"
* ^experimental = true
* include codes from system CS_BetelNutInfoSource

// ─────────────────────────────────────────────── 口腔黏膜檢查表之級距（T-13）
// 逐字錄自**國民健康署口腔黏膜檢查表（107 年 7 月修訂）**「菸檳習慣」欄之
// 「1.嚼檳榔習慣」，六個選項、單選。原文用語一字未改。
//
// ⚠️ **這是癌症篩檢用表，不是健檢上傳欄位**（JOB-29 附錄 B.9）。收錄其原始勾選是為了
// 可回溯與可稽核，**不得因此把篩檢表欄位當成健檢上傳欄位**——後者才是 M-5 之標的。
//
// ⚠️ **代碼編號之依據**：該表六個選項之印刷編號末項為 ❺，六項而止於 5，
// 故首項為 ⓿——本檔之 0–5 前綴即依此順序，非另行編號。命名沿用 CS-SmokingStatus
// 之「數字前綴＋語意」house style。
//
// ⚠️ **不換算成中位數**（委員意見，附錄 B.1 #7；與 T-9「保留原始 coding」同一原則）。
// ❷–❺ 四項各自綁定「嚼食年數」與「每日顆數」兩個維度之區間，可據以導出
// component[durationYears] 與 component[amount] 之**界限**（例如 ❺ ⇒ 年數 > 10、
// 每日 ≧ 20），但**不得取區間中點充作實測值**——假精確會污染 dose-response 分析。
// 導出界限時應以 Quantity.comparator 表達，與 §A.4 對上游 #90（≧90 顆）之處置一致。
//
// 附帶觀察（未實作）：同表「2.吸菸習慣」為結構完全相同之六選項，僅單位由「顆」改「支」。
// 本指引之吸菸 Profile 繼承 TW Core，未納入此級距；如日後需要，應比照本代碼系統辦理。
CodeSystem: CS_BetelNutHpaCategory
Id: CS-BetelNutHpaCategory
Title: "口腔黏膜檢查表嚼檳榔習慣級距代碼系統"
Description: "逐字錄自國民健康署**口腔黏膜檢查表（107 年 7 月修訂）**「菸檳習慣」欄之「1.嚼檳榔習慣」六個選項。**該表為癌症篩檢用表，非健檢上傳欄位**（見 open-issues T-13、術語頁 §6.2b-1）。（**provisional**：選項文字為該表原文，惟「篩檢表級距是否納入健檢交換」之範疇問題尚待主管機關確認，M-5。）"
* ^experimental = true
* ^caseSensitive = true
* #0-none "無" "表列第 1 項（⓿）：無嚼檳榔習慣。"
* #1-quit "已戒" "表列第 2 項（❶）：已戒除。"
* #2-lt10y-lt20 "嚼 10 年以下，每天少於 20 顆" "表列第 3 項（❷）。可導出：年數 < 10、每日 < 20 顆。"
* #3-lt10y-ge20 "嚼 10 年以下，每天 20 顆及以上" "表列第 4 項（❸）。可導出：年數 < 10、每日 ≧ 20 顆。"
* #4-ge10y-lt20 "嚼超過 10 年，每天少於 20 顆" "表列第 5 項（❹）。可導出：年數 > 10、每日 < 20 顆。"
* #5-ge10y-ge20 "嚼超過 10 年，每天 20 顆及以上" "表列第 6 項（❺）。可導出：年數 > 10、每日 ≧ 20 顆。"

ValueSet: VS_BetelNutHpaCategory
Id: VS-BetelNutHpaCategory
Title: "口腔黏膜檢查表嚼檳榔習慣級距值集"
Description: "包含口腔黏膜檢查表（107/7 修訂）嚼檳榔習慣六個級距之值集。（provisional，隨 CS-BetelNutHpaCategory）"
* ^experimental = true
* include codes from system CS_BetelNutHpaCategory

// ─────────────────────────────────────────────── 時間單位（戒除期間用）
// JOB-29 §A.6：戒除期間之單位以**原始採集粒度**為準，不得強制轉換。
// 上游以「年」收集（sf-BetNutChewQuit#01 = 已戒 1 年），強制轉為 12 mo 會**偽造精度**
// ——原始資料並未主張「恰好 12 個月」。吸菸之 63632-4 官方例示單位本即為
// d／wk／mo／a 四者並列，故並行不破壞與吸菸的對稱性。
ValueSet: VS_TimeUnitYearMonth
Id: VS-TimeUnitYearMonth
Title: "時間單位值集（年／月）"
Description: "戒除期間所允許之 UCUM 時間單位：`a`（年）與 `mo`（月）。**以原始採集粒度為準**——原始以年收集者送 `a`，不得逕行乘 12（JOB-29 §A.6）。兩者皆為 UCUM 時間量綱，術語伺服器可自動換算，跨機構統計不受影響。"
* ^experimental = false
* UCUM#a "年"
* UCUM#mo "月"
