# 嚼檳榔量化元件代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.8.1

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
  "version" : "0.8.1",
  "name" : "CS_BetelNutComponent",
  "title" : "嚼檳榔量化元件代碼系統",
  "status" : "active",
  "experimental" : true,
  "date" : "2026-08-21T04:20:36+00:00",
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
    "definition" : "每日嚼食檳榔之顆數，以 UCUM `{quid}/d` 表達。對應上游 sf-BetNutChewBeh#amount。"
  },
  {
    "code" : "duration-years",
    "display" : "嚼食持續期間",
    "definition" : "嚼食檳榔之持續期間（嚼了多久），以 UCUM `a` 或 `mo` 表達，**以原始採集粒度為準**（不得將「嚼 2 年」逕行改寫為 24 個月）。承載主管機關最小上傳集第 11 列（醫令 30907X-3「嚼檳月數」，經主管機關答覆確認其語意為嚼食持續期間而非戒檳月數）。對應上游 sf-BetNutChewBeh#year。⚠️ 代碼 id 保留 `duration-years` 係因該碼已於 v0.4.0 發佈，改名屬破壞性變更；真實語意以本顯示名與定義為準。"
  },
  {
    "code" : "cessation-duration",
    "display" : "戒除期間",
    "definition" : "已戒除之期間，以 UCUM `a` 或 `mo` 表達，**以原始採集粒度為準**（不得將「已戒 1 年」逕行改寫為 12 個月）。對應上游 sf-BetNutChewBeh#quit。"
  },
  {
    "code" : "cessation-date",
    "display" : "戒除日期",
    "definition" : "戒除之日期（得僅至年或年月）。**日期為原始事實，期間為導出值**——期間會隨檢查日改變，故兩者並存時以本欄為準。**不得由「已戒 N 年」回推本欄**。"
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
    "definition" : "以上游 TWCR_SF 級距碼表達之每日嚼食量，供與癌症登記勾稽之用。**可選、綁定強度 extensible**——移除本 component 不影響任何核心資料。"
  }]
}

```
