# 健康檢查檢驗項目代碼對應 ConceptMap - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ConceptMap: 健康檢查檢驗項目代碼對應 ConceptMap 



## Resource Content

```json
{
  "resourceType" : "ConceptMap",
  "id" : "TWHealthCheckLaboratoryMap",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ConceptMap/TWHealthCheckLaboratoryMap",
  "version" : "0.1.0",
  "name" : "TWHealthCheckLaboratoryMap",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-26",
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
  "sourceUri" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset",
  "targetUri" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset",
  "group" : [{
    "source" : "http://loinc.org",
    "target" : "http://loinc.org",
    "element" : [{
      "code" : "804-5",
      "display" : "WBC [#/volume] in Blood by Manual count",
      "target" : [{
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood",
        "equivalence" : "narrower",
        "comment" : "source 指定 Manual count，target 方法未指定，source 為其特化"
      }]
    },
    {
      "code" : "26464-8",
      "display" : "WBC [#/volume] in Blood",
      "target" : [{
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood",
        "equivalence" : "equivalent",
        "comment" : "同概念、同檢體、方法均未指定"
      }]
    },
    {
      "code" : "2888-6",
      "display" : "Protein [Mass/volume] in Urine",
      "target" : [{
        "code" : "5804-0",
        "display" : "Protein [Mass/volume] in Urine by Test strip",
        "equivalence" : "relatedto",
        "comment" : "定量(Mass/volume)與試紙法屬不同量測方式，非包含關係"
      }]
    },
    {
      "code" : "2339-0",
      "display" : "Glucose [Mass/volume] in Blood",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣；另檢體不同"
      }]
    },
    {
      "code" : "38483-4",
      "display" : "Creatinine [Mass/volume] in Blood",
      "target" : [{
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma",
        "equivalence" : "relatedto",
        "comment" : "檢體不同(Blood vs Serum/Plasma)，非包含關係"
      }]
    },
    {
      "code" : "35200-5",
      "display" : "Cholesterol [Mass or Moles/volume] in Serum or Plasma",
      "target" : [{
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 允許質量或莫耳濃度兩種尺度，語意較 target 廣"
      }]
    },
    {
      "code" : "3043-7",
      "display" : "Triglyceride [Mass/volume] in Blood",
      "target" : [{
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma",
        "equivalence" : "relatedto",
        "comment" : "檢體不同(Blood vs Serum/Plasma)"
      }]
    },
    {
      "code" : "13457-7",
      "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation",
      "target" : [{
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定計算法，target 方法未指定"
      }]
    },
    {
      "code" : "33914-3",
      "display" : "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation",
      "target" : [{
        "code" : "98979-8",
        "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M",
        "equivalence" : "relatedto",
        "comment" : "MDRD 與 CKD-EPI 2021 為不同估算公式，數值不可直接互換"
      }]
    },
    {
      "code" : "5195-3",
      "display" : "Hepatitis B virus surface Ag [Presence] in Serum",
      "target" : [{
        "code" : "5196-1",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay",
        "equivalence" : "relatedto",
        "comment" : "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"
      }]
    },
    {
      "code" : "16128-1",
      "display" : "Hepatitis C virus Ab [Presence] in Serum",
      "target" : [{
        "code" : "13955-0",
        "display" : "Hepatitis C virus Ab [Presence] in Serum or Plasma by Immunoassay",
        "equivalence" : "relatedto",
        "comment" : "source 限 Serum、target 為 Serum or Plasma 且指定 Immunoassay，兩者互有寬窄"
      }]
    },
    {
      "code" : "26515-7",
      "display" : "Platelets [#/volume] in Blood by Automated count",
      "target" : [{
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood",
        "equivalence" : "narrower",
        "comment" : "source 指定 Automated count，target 方法未指定"
      }]
    },
    {
      "code" : "30428-7",
      "display" : "MCV [Entitic volume] by calculation",
      "target" : [{
        "code" : "787-2",
        "display" : "MCV [Entitic volume] by Automated count",
        "equivalence" : "relatedto",
        "comment" : "calculation 與 Automated count 為不同具體方法，無包含關係"
      }]
    },
    {
      "code" : "28539-5",
      "display" : "MCH [Entitic mass] by Automated count",
      "target" : [{
        "code" : "785-6",
        "display" : "MCH [Entitic mass] by Automated count",
        "equivalence" : "equivalent",
        "comment" : "同概念、同方法(Automated count)，僅顯示名長短不同"
      }]
    },
    {
      "code" : "26508-2",
      "display" : "Neutrophils/100 leukocytes in Blood by Manual count",
      "target" : [{
        "code" : "770-8",
        "display" : "Neutrophils/100 leukocytes in Blood by Automated count",
        "equivalence" : "relatedto",
        "comment" : "Manual 與 Automated 為不同具體方法，無包含關係"
      }]
    },
    {
      "code" : "14409-7",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 UV with P5P，target 方法未指定"
      }]
    },
    {
      "code" : "14390-9",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 UV with P5P，target 方法未指定"
      }]
    },
    {
      "code" : "1783-0",
      "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma",
      "target" : [{
        "code" : "6768-6",
        "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent",
        "comment" : "同概念同檢體，兩碼方法均未指定"
      }]
    },
    {
      "code" : "59261-8",
      "display" : "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol",
      "target" : [{
        "code" : "4548-4",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood",
        "equivalence" : "relatedto",
        "comment" : "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"
      }]
    },
    {
      "code" : "3016-3",
      "display" : "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS",
      "target" : [{
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 3rd IS 標準品，target 未指定"
      }]
    },
    {
      "code" : "19199-9",
      "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma",
      "target" : [{
        "code" : "2857-1",
        "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent",
        "comment" : "同概念同檢體，方法均未指定"
      }]
    },
    {
      "code" : "83082-8",
      "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "10334-1",
        "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 Immunoassay，target 方法未指定"
      }]
    },
    {
      "code" : "83085-1",
      "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "2039-6",
        "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 Immunoassay，target 方法未指定"
      }]
    },
    {
      "code" : "88112-8",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 No addition of P-5'-P，target 方法未指定"
      }]
    },
    {
      "code" : "1744-2",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 No addition of P-5'-P，target 方法未指定"
      }]
    },
    {
      "code" : "2345-7",
      "display" : "Glucose [Mass/volume] in Serum or Plasma",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting Glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣"
      }]
    },
    {
      "code" : "18262-6",
      "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay",
      "target" : [{
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 指定 Direct assay，target 方法未指定"
      }]
    },
    {
      "code" : "23749-5",
      "display" : "Lead [Mass/volume] in Specimen",
      "target" : [{
        "code" : "77307-7",
        "display" : "Lead [Mass/volume] in Venous blood",
        "equivalence" : "relatedto",
        "comment" : "source 檢體為泛稱 Specimen、target 限 Blood，非單純包含"
      }]
    },
    {
      "code" : "56086-2",
      "display" : "Waist Circumference",
      "target" : [{
        "code" : "8280-0",
        "display" : "Waist Circumference at umbilicus by Tape measure",
        "equivalence" : "relatedto",
        "comment" : "source 為 PhenX 之量測 protocol 碼、target 為臍位皮尺量測碼，性質不同"
      }]
    },
    {
      "code" : "5671-3",
      "display" : "Lead [Mass/volume] in Blood",
      "target" : [{
        "code" : "77307-7",
        "display" : "Lead [Mass/volume] in Venous blood",
        "equivalence" : "relatedto",
        "comment" : "source 之檢體為未指定之 Blood、target 限 Venous blood；職業血鉛監測慣用靜脈血。source 之 LOINC 狀態為 DISCOURAGED。"
      }]
    }]
  }]
}

```
