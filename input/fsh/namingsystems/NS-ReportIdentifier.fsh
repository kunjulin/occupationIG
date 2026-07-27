// 健檢報告封包識別碼之命名空間。
//
// 為什麼只定義這一個：JOB-06 §3.1 要求「先盤點 TW Core 已定義什麼，能沿用的一律沿用」——
// 同一個識別碼有兩個 canonical 比現況更糟。身分證統一編號、事業單位統一編號、
// 醫事機構代號、醫事人員證書字號等**極可能已由 TW Core 定義**，在盤點完成前
// 不得自行另定（見 JOB-06 §7 之待辦）。
//
// 「健檢報告封包識別碼」則無此疑慮：這是本 IG 的上傳語意所特有，TW Core 沒有理由定義它。
//
// ⚠️ canonical namespace 目前為 provisional（見 CLAUDE.md §6）。本 uniqueId 隨之為暫定，
//    正式核定後須一併更新，並依 FHIR 慣例保留舊值為非 preferred 之 uniqueId。

Instance: NS-ReportIdentifier
InstanceOf: NamingSystem
Usage: #definition
Title: "健檢報告封包識別碼"
Description: "勞工健康檢查報告封包（Bundle）之識別碼命名空間。用於上傳去重、跨機構參照與稽核追溯。"

* name = "TWHAReportIdentifier"
* status = #draft
* kind = #identifier
* date = "2026-07-27"
* publisher = "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院"

// responsible 指「負責發放此識別碼者」，非本 IG 之發布者：
// 封包識別碼由**產生該封包的健檢機構**自行發放，本 IG 只規範其命名空間與唯一性要求。
* responsible = "產生封包之健檢機構（本 IG 僅規範命名空間，不集中發放）"

* description = """
勞工健康檢查報告封包（Bundle）之識別碼命名空間。

**唯一性要求**：值在同一健檢機構內須唯一且不重複使用；跨機構之唯一性由
「命名空間 + 值」的組合達成。上傳端據此判定是否為同一份封包之重送（去重）。

**穩定性要求**：同一份健檢報告重新上傳（例如更正後重送）時**應沿用相同的識別碼**，
否則監理端無從判斷這是更正還是新的一筆。若確為另一次健檢，則須給新的識別碼。

**不得**以流水號以外可回推受檢者身分之內容組成（例如身分證號、病歷號）。
"""

* uniqueId[0].type = #uri
* uniqueId[0].value = "https://twcore.mohw.gov.tw/ig/twha/sid/report-id"
* uniqueId[0].preferred = true
* uniqueId[0].comment = "canonical namespace 為 provisional，正式核定後須更新（CLAUDE.md §6）。"
