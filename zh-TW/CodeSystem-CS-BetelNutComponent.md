# 嚼檳榔量化元件代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.10.3

## CodeSystem: 嚼檳榔量化元件代碼系統 (實驗性) 

 
【主管機關：國民健康署】`TWHA-SocialHistory-BetelNut` 各 `component.code` 之本地代碼。前三碼與上游 TWCR_SF `sf-BetNutChewBeh` 之 `amount`／`year`／`quit` 為 1:1 對應。（**provisional**：隨本指引之嚼檳榔建模待主管機關確認，M-5。） 

下列值集之定義引用本代碼系統：

* This CodeSystem is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-BetelNutComponent",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "trial-use"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-BetelNutComponent",
  "version" : "0.10.3",
  "name" : "CS_BetelNutComponent",
  "title" : "嚼檳榔量化元件代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-22T17:09:34+00:00",
  "publisher" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
  "contact" : [{
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室 & 長庚醫療財團法人長庚紀念醫院",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  },
  {
    "name" : "衛生福利部次世代數位醫療平臺專案辦公室",
    "telecom" : [{
      "system" : "url",
      "value" : "https://twcore.mohw.gov.tw/twregistry/"
    }]
  }],
  "description" : "【主管機關：國民健康署】`TWHA-SocialHistory-BetelNut` 各 `component.code` 之本地代碼。前三碼與上游 TWCR_SF `sf-BetNutChewBeh` 之 `amount`／`year`／`quit` 為 1:1 對應。（**provisional**：隨本指引之嚼檳榔建模待主管機關確認，M-5。）",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 9,
  "concept" : [{
    "code" : "amount",
    "display" : "每日嚼食量",
    "definition" : "每日嚼食檳榔之顆數，以 UCUM 單位「{quid}/d」表達。承載主管機關最小上傳集第 10 列（醫令 30907X-2「嚼檳量」）。⚠️ 原案該列為複合欄位，同時收「平均每日嚼幾顆」與「嚼檳年數」兩個量綱不同之值，於資料交換時難以拆解；本欄僅承載每日顆數，年數移列第 11 列——第 11 列之語意經本案專家共識會議（2026-07-17）七、臨時動議決議更正為嚼食持續期間，年數乃隨之移列。單位原案記「{個}/d」，惟 UCUM 之 annotation 僅接受可列印 ASCII，「{個}」非合法 UCUM，故採「{quid}/d」——此為術語技術正確性之更正，不涉語意，數值意義完全相同。本項屬受託團隊職權範圍之技術決議，無須委託單位或主管機關另行核定。對應上游 sf-BetNutChewBeh#amount。"
  },
  {
    "code" : "duration-years",
    "display" : "嚼食持續期間",
    "definition" : "嚼食檳榔之持續期間（嚼了多久），以 UCUM 單位「a」或「mo」表達，並以原始採集粒度為準——不得將「嚼 2 年」逕行改寫為 24 個月。承載主管機關最小上傳集第 11 列（醫令 30907X-3，原案欄名「嚼檳月數」）。⚠️ 本欄不論受檢者現仍嚼食或已戒除，均應填列——嚼食持續期間是檳榔相關口腔癌之核心累積暴露指標，不因戒除而消失。戒除資訊另由 cessationDuration（戒除期間）與 cessationDate（戒除日期）承載，不佔上傳集之列位。原案該列之 r4 值規則寫「填寫戒檳月數」，經本案專家共識會議（臺灣勞工健康檢查核心資料集與 FHIR IG 專家共識討論會，2026-07-17）七、臨時動議認定係原案文字有誤，決議更正為嚼食持續期間，且不論現嚼或已戒均應填列；共同主持人曹又中主任（職業醫學科）另於 2026-07-31 回信補充說明；本項屬受託團隊職權範圍之技術決議，無須委託單位或主管機關另行核定。對應上游 sf-BetNutChewBeh#year。⚠️ 代碼 id 保留「duration-years」係因該碼已於 v0.4.0 發佈，改名屬破壞性變更；真實語意以本顯示名與定義為準。"
  },
  {
    "code" : "cessation-duration",
    "display" : "戒除期間",
    "definition" : "已戒除之期間，以 UCUM 單位「a」或「mo」表達，並以原始採集粒度為準——不得將「已戒 1 年」逕行改寫為 12 個月。⚠️ 本欄與 cessationDate 共同承接主管機關原案第 11 列 r4 所指之「戒檳月數」：該列語意經本案專家共識會議（2026-07-17）決議更正為嚼食持續期間後，戒除資訊改由本欄承載，不佔上傳集之列位。故本次語意更正並不造成任何資訊遺失。對應上游 sf-BetNutChewBeh#quit。"
  },
  {
    "code" : "cessation-date",
    "display" : "戒除日期",
    "definition" : "戒除之日期（得僅至年或年月）。日期為原始事實，期間為導出值——期間會隨檢查日改變，故兩者並存時以本欄為準。⚠️ 不得由「已戒 N 年」回推本欄。"
  },
  {
    "code" : "with-tobacco",
    "display" : "是否含菸草",
    "definition" : "所嚼食之檳榔是否含菸草。IARC 對含／不含菸草之檳榔分開評估，故流行病學分析需要此欄。"
  },
  {
    "code" : "additive",
    "display" : "添加物",
    "definition" : "所嚼食之檳榔所用之添加物（荖花／荖葉／無）。"
  },
  {
    "code" : "lime",
    "display" : "石灰種類",
    "definition" : "所嚼食之檳榔所用之石灰種類（紅灰／白灰）。"
  },
  {
    "code" : "hpa-category",
    "display" : "口腔黏膜檢查表級距",
    "definition" : "國民健康署口腔黏膜檢查表（107/7 修訂）之嚼檳榔習慣原始勾選，保留不換算成中位數（T-13）。"
  },
  {
    "code" : "amount-coded",
    "display" : "每日嚼食量（上游級距碼）",
    "definition" : "以上游 TWCR_SF 級距碼表達之每日嚼食量，供與癌症登記勾稽之用。本 component 為可選，綁定強度 extensible——移除本 component 不影響任何核心資料。"
  }]
}

```
