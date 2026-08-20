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
