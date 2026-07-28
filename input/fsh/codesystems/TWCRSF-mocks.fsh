// =============================================================================
// TWCR_SF 代碼系統與值集之【本地 stub】——非權威定義
// =============================================================================
//
// 權威來源：臺灣癌症登記短表 IG（TWCR_SF），命名空間 https://hapi.fhir.tw。
// 本檔為建置與驗證所需之**局部複本**，實作端應以 TWCR_SF 官方定義為準。
//
// ## 為何是 stub 而非正式依賴（JOB-10 路徑 B）
//
// 2026-07-28 由 CI 實測（開發環境連不到這些主機，本機測不得數）：
//
//   套件（run 30368332715）——三個 registry 之**套件根路徑**皆 404，
//   即 fhir.twcrsf 這個 package id 不存在，非版本號給錯：
//     https://packages.fhir.org/fhir.twcrsf           → 404
//     https://packages2.fhir.org/packages/fhir.twcrsf → 404
//     https://packages.simplifier.net/fhir.twcrsf     → 404
//
//   canonical 端點（run 30368750214）——本檔 9 個 canonical 加上
//   sf-BetNutChewBeh-profile，共 10 個，**全部 404**。
//   404 表示 hapi.fhir.tw 有回應，只是不服務這些資源。
//
// 故 JOB-10 路徑 A（改為正式套件依賴）無法執行，採路徑 B。
//
// ## 本次降級之內容
//
//   ^content  #complete → #fragment   ← 關鍵。#fragment 正是 FHIR 為「外部代碼
//                                        系統之局部複本」設計的機制；原本標
//                                        #complete 等於宣稱自己是權威完整定義。
//   ^status   #active   → #draft
//   ^experimental       → true
//   Title               → 冠【本地 stub】並註明非權威定義
//   ^copyright          → 載明權威來源與引用限制
//
// ⚠️ **不得**為了消除 ShareableValueSet 警告而把 experimental 設為 false——
//    那等於更強力地宣稱這是權威定義（JOB-10 §5）。
//
// ## 待辦
//
// TWCR_SF 套件一旦可用，應改為 sushi-config.yaml 之正式 dependencies 並**刪除本檔**
// （JOB-10 路徑 A）。已登記為未決事項 G-5（input/pagecontent/open-issues.md）。
// ==============================================================================

CodeSystem: sf-BetNutChewAmount-codesystem
Id: sf-BetNutChewAmount-codesystem
Title: "【本地 stub】每日嚼檳榔量代碼系統（非權威定義）"
Description: "Betel Nut Chewing Amount Code System"
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem"
* ^status = #draft
* ^experimental = true
* ^content = #fragment
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* #00 "無嚼檳榔"
* #01 "每日1顆"
* #02 "每日2顆"
* #03 "每日3顆"
* #04 "每日4顆"
* #05 "每日5顆"
* #06 "每日6顆"
* #07 "每日7顆"
* #08 "每日8顆"
* #09 "每日9顆"
* #10 "每日10顆"
* #11 "每日11顆"
* #12 "每日12顆"
* #13 "每日13顆"
* #14 "每日14顆"
* #15 "每日15顆"
* #16 "每日16顆"
* #17 "每日17顆"
* #18 "每日18顆"
* #19 "每日19顆"
* #20 "每日20顆"
* #21 "每日21顆"
* #22 "每日22顆"
* #23 "每日23顆"
* #24 "每日24顆"
* #25 "每日25顆"
* #26 "每日26顆"
* #27 "每日27顆"
* #28 "每日28顆"
* #29 "每日29顆"
* #30 "每日30顆"
* #31 "每日31顆"
* #32 "每日32顆"
* #33 "每日33顆"
* #34 "每日34顆"
* #35 "每日35顆"
* #36 "每日36顆"
* #37 "每日37顆"
* #38 "每日38顆"
* #39 "每日39顆"
* #40 "每日40顆"
* #41 "每日41顆"
* #42 "每日42顆"
* #43 "每日43顆"
* #44 "每日44顆"
* #45 "每日45顆"
* #46 "每日46顆"
* #47 "每日47顆"
* #48 "每日48顆"
* #49 "每日49顆"
* #50 "每日50顆"
* #51 "每日51顆"
* #52 "每日52顆"
* #53 "每日53顆"
* #54 "每日54顆"
* #55 "每日55顆"
* #56 "每日56顆"
* #57 "每日57顆"
* #58 "每日58顆"
* #59 "每日59顆"
* #60 "每日60顆"
* #61 "每日61顆"
* #62 "每日62顆"
* #63 "每日63顆"
* #64 "每日64顆"
* #65 "每日65顆"
* #66 "每日66顆"
* #67 "每日67顆"
* #68 "每日68顆"
* #69 "每日69顆"
* #70 "每日70顆"
* #71 "每日71顆"
* #72 "每日72顆"
* #73 "每日73顆"
* #74 "每日74顆"
* #75 "每日75顆"
* #76 "每日76顆"
* #77 "每日77顆"
* #78 "每日78顆"
* #79 "每日79顆"
* #80 "每日80顆"
* #81 "每日81顆"
* #82 "每日82顆"
* #83 "每日83顆"
* #84 "每日84顆"
* #85 "每日85顆"
* #86 "每日86顆"
* #87 "每日87顆"
* #88 "每日88顆"
* #89 "每日89顆"
* #90 "每日≧90顆"
* #91 "偶爾嚼(無規律或無定量)"
* #98 "有嚼，但量不詳"
* #99 "病歷未記載或嚼檳榔狀態完全不詳者"

CodeSystem: sf-BetNutChewBeh-codesystem
Id: sf-BetNutChewBeh-codesystem
Title: "【本地 stub】Betel Nut Chewing Behavior Code System（非權威定義）"
Description: "Betel Nut Chewing Behavior Code System"
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem"
* ^status = #draft
* ^experimental = true
* ^content = #fragment
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* #amount "每日嚼檳榔量，以 ”顆” 計算"
* #year "嚼檳榔年"
* #quit "戒嚼檳榔年"

CodeSystem: sf-BetNutChewQuit-codesystem
Id: sf-BetNutChewQuit-codesystem
Title: "【本地 stub】戒嚼檳榔年代碼系統（非權威定義）"
Description: "Betel Nut Chewing Quit Code System"
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewQuit-codesystem"
* ^status = #draft
* ^experimental = true
* ^content = #fragment
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* #00 "無戒嚼檳榔"
* #01 "已戒1年"
* #02 "已戒2年"
* #03 "已戒3年"
* #04 "已戒4年"
* #05 "已戒5年"
* #06 "已戒6年"
* #07 "已戒7年"
* #08 "已戒8年"
* #09 "已戒9年"
* #10 "已戒10年"
* #11 "已戒11年"
* #12 "已戒12年"
* #13 "已戒13年"
* #14 "已戒14年"
* #15 "已戒15年"
* #16 "已戒16年"
* #17 "已戒17年"
* #18 "已戒18年"
* #19 "已戒19年"
* #20 "已戒20年"
* #21 "已戒21年"
* #22 "已戒22年"
* #23 "已戒23年"
* #24 "已戒24年"
* #25 "已戒25年"
* #26 "已戒26年"
* #27 "已戒27年"
* #28 "已戒28年"
* #29 "已戒29年"
* #30 "已戒30年"
* #31 "已戒31年"
* #32 "已戒32年"
* #33 "已戒33年"
* #34 "已戒34年"
* #35 "已戒35年"
* #36 "已戒36年"
* #37 "已戒37年"
* #38 "已戒38年"
* #39 "已戒39年"
* #40 "已戒40年"
* #41 "已戒41年"
* #42 "已戒42年"
* #43 "已戒43年"
* #44 "已戒44年"
* #45 "已戒45年"
* #46 "已戒46年"
* #47 "已戒47年"
* #48 "已戒48年"
* #49 "已戒49年"
* #50 "已戒50年"
* #51 "已戒51年"
* #52 "已戒52年"
* #53 "已戒53年"
* #54 "已戒54年"
* #55 "已戒55年"
* #56 "已戒56年"
* #57 "已戒57年"
* #58 "已戒58年"
* #59 "已戒59年"
* #60 "已戒60年"
* #61 "已戒61年"
* #62 "已戒62年"
* #63 "已戒63年"
* #64 "已戒64年"
* #65 "已戒65年"
* #66 "已戒66年"
* #67 "已戒67年"
* #68 "已戒68年"
* #69 "已戒69年"
* #70 "已戒70年"
* #71 "已戒71年"
* #72 "已戒72年"
* #73 "已戒73年"
* #74 "已戒74年"
* #75 "已戒75年"
* #76 "已戒76年"
* #77 "已戒77年"
* #78 "已戒78年"
* #79 "已戒79年"
* #80 "已戒80年"
* #81 "已戒81年"
* #82 "已戒82年"
* #83 "已戒83年"
* #84 "已戒84年"
* #85 "已戒85年"
* #86 "已戒86年"
* #87 "已戒87年"
* #88 "無嚼檳榔"
* #98 "已戒，但年不詳"
* #99 "病歷未記載或戒嚼檳榔狀態完全不詳者"

CodeSystem: sf-BetNutChewYear-codesystem
Id: sf-BetNutChewYear-codesystem
Title: "【本地 stub】嚼檳榔年代碼系統（非權威定義）"
Description: "Betel Nut Chewing Year Code System"
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewYear-codesystem"
* ^status = #draft
* ^experimental = true
* ^content = #fragment
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* #00 "無嚼檳榔"
* #01 "嚼1年"
* #02 "嚼2年"
* #03 "嚼3年"
* #04 "嚼4年"
* #05 "嚼5年"
* #06 "嚼6年"
* #07 "嚼7年"
* #08 "嚼8年"
* #09 "嚼9年"
* #10 "嚼10年"
* #11 "嚼11年"
* #12 "嚼12年"
* #13 "嚼13年"
* #14 "嚼14年"
* #15 "嚼15年"
* #16 "嚼16年"
* #17 "嚼17年"
* #18 "嚼18年"
* #19 "嚼19年"
* #20 "嚼20年"
* #21 "嚼21年"
* #22 "嚼22年"
* #23 "嚼23年"
* #24 "嚼24年"
* #25 "嚼25年"
* #26 "嚼26年"
* #27 "嚼27年"
* #28 "嚼28年"
* #29 "嚼29年"
* #30 "嚼30年"
* #31 "嚼31年"
* #32 "嚼32年"
* #33 "嚼33年"
* #34 "嚼34年"
* #35 "嚼35年"
* #36 "嚼36年"
* #37 "嚼37年"
* #38 "嚼38年"
* #39 "嚼39年"
* #40 "嚼40年"
* #41 "嚼41年"
* #42 "嚼42年"
* #43 "嚼43年"
* #44 "嚼44年"
* #45 "嚼45年"
* #46 "嚼46年"
* #47 "嚼47年"
* #48 "嚼48年"
* #49 "嚼49年"
* #50 "嚼50年"
* #51 "嚼51年"
* #52 "嚼52年"
* #53 "嚼53年"
* #54 "嚼54年"
* #55 "嚼55年"
* #56 "嚼56年"
* #57 "嚼57年"
* #58 "嚼58年"
* #59 "嚼59年"
* #60 "嚼60年"
* #61 "嚼61年"
* #62 "嚼62年"
* #63 "嚼63年"
* #64 "嚼64年"
* #65 "嚼65年"
* #66 "嚼66年"
* #67 "嚼67年"
* #68 "嚼68年"
* #69 "嚼69年"
* #70 "嚼70年"
* #71 "嚼71年"
* #72 "嚼72年"
* #73 "嚼73年"
* #74 "嚼74年"
* #75 "嚼75年"
* #76 "嚼76年"
* #77 "嚼77年"
* #78 "嚼78年"
* #79 "嚼79年"
* #80 "嚼80年"
* #81 "嚼81年"
* #82 "嚼82年"
* #83 "嚼83年"
* #84 "嚼84年"
* #85 "嚼85年"
* #86 "嚼86年"
* #87 "嚼87年"
* #88 "嚼88年"
* #89 "嚼89年"
* #90 "嚼90年"
* #91 "嚼91年"
* #92 "嚼92年"
* #93 "嚼93年"
* #94 "嚼94年"
* #95 "嚼95年"
* #96 "嚼96年"
* #97 "嚼97年"
* #98 "嚼檳榔，但年不詳"
* #99 "病歷未記載或嚼檳榔狀態完全不詳者"

CodeSystem: sf-ObserBeh-codesystem
Id: sf-ObserBeh-codesystem
Title: "【本地 stub】相關行為代碼系統（非權威定義）"
Description: "Observation Behavior Code System"
* ^url = "https://hapi.fhir.tw/fhir/CodeSystem/sf-ObserBeh-codesystem"
* ^status = #draft
* ^experimental = true
* ^content = #fragment
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* #Smoking "吸菸行為"
* #BetelNutChewing "嚼檳榔行為"
* #Drinking "喝酒行為"

ValueSet: SFBetNutChewAmountValueSet
Id: sf-BetNutChewAmount-valueset
Title: "【本地 stub】每日嚼檳榔量值集（非權威定義）"
Description: "Betel Nut Chewing Amount Value Set"
* ^url = "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewAmount-valueset"
* ^status = #draft
* ^experimental = true
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* include codes from system https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewAmount-codesystem

ValueSet: SFBetNutChewBehValueSet
Id: sf-BetNutChewBeh-valueset
Title: "【本地 stub】嚼檳榔行為值集（非權威定義）"
Description: "Betel Nut Chewing Behavior Value Set"
* ^url = "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewBeh-valueset"
* ^status = #draft
* ^experimental = true
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* include codes from system https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewBeh-codesystem

ValueSet: SFBetNutChewQuitValueSet
Id: sf-BetNutChewQuit-valueset
Title: "【本地 stub】戒嚼檳榔年值集（非權威定義）"
Description: "Betel Nut Chewing Quit Value Set"
* ^url = "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewQuit-valueset"
* ^status = #draft
* ^experimental = true
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* include codes from system https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewQuit-codesystem

ValueSet: SFBetNutChewYearValueSet
Id: sf-BetNutChewYear-valueset
Title: "【本地 stub】嚼檳榔年值集（非權威定義）"
Description: "Betel Nut Chewing Year Value Set"
* ^url = "https://hapi.fhir.tw/fhir/ValueSet/sf-BetNutChewYear-valueset"
* ^status = #draft
* ^experimental = true
* ^copyright = "權威定義來源為臺灣癌症登記短表 IG（TWCR_SF）。本 IG 僅為建置與驗證所需之局部複本（content = fragment），非權威定義；實作端應以 TWCR_SF 官方定義為準。"
* include codes from system https://hapi.fhir.tw/fhir/CodeSystem/sf-BetNutChewYear-codesystem

