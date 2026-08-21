# 身體檢查系統部位代碼系統 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.9.0

## CodeSystem: 身體檢查系統部位代碼系統 

 
【依據：勞工健康保護規則附表】附表十一理學檢查中所涉及之身體系統部位分類。 

下列值集之定義引用本代碼系統：

* [VS_PhysicalExamSystems](ValueSet-VS-PhysicalExamSystems.md)

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "CS-PhysicalExamSystems",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
    "valueCode" : "draft"
  }],
  "url" : "https://twcore.mohw.gov.tw/ig/twha/CodeSystem/CS-PhysicalExamSystems",
  "version" : "0.9.0",
  "name" : "CS_PhysicalExamSystems",
  "title" : "身體檢查系統部位代碼系統",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-08-21T14:27:31+00:00",
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
  "description" : "【依據：勞工健康保護規則附表】附表十一理學檢查中所涉及之身體系統部位分類。",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 7,
  "concept" : [{
    "code" : "head-neck",
    "display" : "頭頸部",
    "definition" : "包含眼、耳、鼻、喉、口腔及頸部之檢查。"
  },
  {
    "code" : "respiratory",
    "display" : "呼吸系統",
    "definition" : "包含胸腔、肺部及呼吸音之聽診檢查。"
  },
  {
    "code" : "cardiovascular",
    "display" : "心臟血管系統",
    "definition" : "包含心臟聽診、心音、心率及周邊血管之檢查。"
  },
  {
    "code" : "digestive",
    "display" : "消化系統",
    "definition" : "包含腹部觸診、肝脾腫大及腸胃道系統之檢查。"
  },
  {
    "code" : "neurological",
    "display" : "神經系統",
    "definition" : "包含意識狀態、肌腱反射及感覺運動系統之檢查。"
  },
  {
    "code" : "musculoskeletal",
    "display" : "肌肉骨骼系統",
    "definition" : "包含脊椎、四肢關節活動度及肌肉力量之檢查。"
  },
  {
    "code" : "skin",
    "display" : "皮膚",
    "definition" : "包含皮膚疹、黃疸、疤痕或潰瘍之檢查。"
  }]
}

```
