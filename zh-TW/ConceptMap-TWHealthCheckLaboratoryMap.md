# 健康檢查檢驗項目代碼對應 ConceptMap - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.4.0

## ConceptMap: 健康檢查檢驗項目代碼對應 ConceptMap 



## Resource Content

```json
{
  "resourceType" : "ConceptMap",
  "id" : "TWHealthCheckLaboratoryMap",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ConceptMap/TWHealthCheckLaboratoryMap",
  "version" : "0.4.0",
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
      "display" : "Leukocytes [#/volume] in Blood by Manual count",
      "target" : [{
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood by Automated count",
        "equivalence" : "relatedto",
        "comment" : "Manual 與 Automated 為不同具體方法，無包含關係；數值不可直接比較（比照 element[5] 之處理）"
      }]
    },
    {
      "code" : "26464-8",
      "display" : "Leukocytes [#/volume] in Blood",
      "target" : [{
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood by Automated count",
        "equivalence" : "narrower",
        "comment" : "source 方法未指定，target 指定 Automated count；target 語意較窄"
      }]
    },
    {
      "code" : "2339-0",
      "display" : "Glucose [Mass/volume] in Blood",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "relatedto",
        "comment" : "空腹狀態與檢體均不同（source 為未指定空腹之全血、target 為空腹血漿），無包含關係；全血與血漿葡萄糖數值不可直接比較（比照 element[5] 之處理）"
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
        "equivalence" : "narrower",
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
        "equivalence" : "wider",
        "comment" : "source 指定計算法，target 方法未指定"
      }]
    },
    {
      "code" : "33914-3",
      "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum or Plasma by Creatinine-based formula (MDRD)/1.73 sq M",
      "target" : [{
        "code" : "98979-8",
        "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M",
        "equivalence" : "relatedto",
        "comment" : "MDRD 與 CKD-EPI 2021 為不同估算公式，數值不可直接互換。114 年成健採雙軌併行（MDRD 必填、CKD-EPI 非必填），同一份報告可能同時含兩碼，屬正常情形而非重複上傳；115.01.01 起僅採 CKD-EPI 2021。依國健署 115.01.15 國健慢病字第1150660003號函。"
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
      "display" : "Platelets [#/volume] in Blood",
      "target" : [{
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood by Automated count",
        "equivalence" : "narrower",
        "comment" : "source 方法未指定，target 指定 Automated count；target 語意較窄"
      }]
    },
    {
      "code" : "30428-7",
      "display" : "MCV [Entitic mean volume] in Red Blood Cells",
      "target" : [{
        "code" : "787-2",
        "display" : "MCV [Entitic mean volume] in Red Blood Cells by Automated count",
        "equivalence" : "relatedto",
        "comment" : "calculation 與 Automated count 為不同具體方法，無包含關係"
      }]
    },
    {
      "code" : "28539-5",
      "display" : "MCH [Entitic mass]",
      "target" : [{
        "code" : "785-6",
        "display" : "MCH [Entitic mass] by Automated count",
        "equivalence" : "narrower",
        "comment" : "source 方法未指定（MCH [Entitic mass]），target 指定 Automated count；target 語意較窄"
      }]
    },
    {
      "code" : "26508-2",
      "display" : "Neutrophils/100 leukocytes in Blood by Manual count",
      "target" : [{
        "code" : "770-8",
        "display" : "Neutrophils/Leukocytes in Blood by Automated count",
        "equivalence" : "relatedto",
        "comment" : "Manual 與 Automated 為不同具體方法，無包含關係"
      }]
    },
    {
      "code" : "30239-8",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 UV with P5P，target 方法未指定"
      }]
    },
    {
      "code" : "1743-4",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 UV with P5P，target 方法未指定"
      }]
    },
    {
      "code" : "59261-8",
      "display" : "Hemoglobin A1c/Hemoglobin.total standardized per IFCC-RMP for CDT in Blood",
      "target" : [{
        "code" : "4548-4",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood",
        "equivalence" : "relatedto",
        "comment" : "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"
      }]
    },
    {
      "code" : "3016-3",
      "display" : "Thyrotropin [Units/volume] in Serum or Plasma",
      "target" : [{
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma by Detection limit <= 0.005 mIU/L",
        "equivalence" : "narrower",
        "comment" : "source 為一般 TSH（未指定偵測極限），target 指定高敏感度（Detection limit <= 0.005 mIU/L）；target 語意較窄"
      }]
    },
    {
      "code" : "83082-8",
      "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "10334-1",
        "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 Immunoassay，target 方法未指定"
      }]
    },
    {
      "code" : "83085-1",
      "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "2039-6",
        "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 Immunoassay，target 方法未指定"
      }]
    },
    {
      "code" : "88112-8",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 No addition of P-5'-P，target 方法未指定"
      }]
    },
    {
      "code" : "1744-2",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "wider",
        "comment" : "source 指定 No addition of P-5'-P，target 方法未指定"
      }]
    },
    {
      "code" : "2345-7",
      "display" : "Glucose [Mass/volume] in Serum or Plasma",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting Glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "narrower",
        "comment" : "source 為未指定空腹狀態之一般血糖，語意較 target(空腹)廣"
      }]
    },
    {
      "code" : "18262-6",
      "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay",
      "target" : [{
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider",
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
    },
    {
      "code" : "33218-9",
      "display" : "Bacteria [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51480-2",
        "display" : "Bacteria [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "33219-7",
      "display" : "Epithelial cells.squamous [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51486-9",
        "display" : "Epithelial cells.squamous [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "33223-9",
      "display" : "Hyaline casts [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51484-4",
        "display" : "Hyaline casts [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "33342-7",
      "display" : "Epithelial cells [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "87926-2",
        "display" : "Epithelial cells [#/volume] in Urine by Automated",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "43755-8",
      "display" : "Casts [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51483-6",
        "display" : "Casts [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "46419-8",
      "display" : "Erythrocytes [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "798-9",
        "display" : "Erythrocytes [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "46702-7",
      "display" : "Leukocytes [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51487-7",
        "display" : "Leukocytes [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "50235-1",
      "display" : "Mucus [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51478-6",
        "display" : "Mucus [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "53324-0",
      "display" : "Spermatozoa [#/area] in Urine sediment by Automated count",
      "target" : [{
        "code" : "51479-4",
        "display" : "Spermatozoa [#/volume] in Urine by Automated count",
        "equivalence" : "relatedto",
        "comment" : "source 為每高倍視野（/HPF）鏡檢沉渣計數、target 為每體積（/µL）全尿自動計數；兩者需依儀器換算係數（離心速度、沉渣濃縮倍率、視野面積）轉換，不可直接比較數值。"
      }]
    },
    {
      "code" : "3137-7",
      "display" : "Body height Measured",
      "target" : [{
        "code" : "8302-2",
        "display" : "Body height",
        "equivalence" : "wider",
        "comment" : "source 指定量測方法（Method = Measured），target 方法未指定；二者為同一身高量測概念之方法特化與通用，屬包含關係，數值可直接比較。"
      }]
    },
    {
      "code" : "3141-9",
      "display" : "Body weight Measured",
      "target" : [{
        "code" : "29463-7",
        "display" : "Body weight",
        "equivalence" : "wider",
        "comment" : "source 指定量測方法（Method = Measured），target 方法未指定；二者為同一體重量測概念之方法特化與通用，屬包含關係，數值可直接比較。"
      }]
    },
    {
      "code" : "57735-3",
      "display" : "Protein [Presence] in Urine by Automated test strip",
      "target" : [{
        "code" : "5804-0",
        "display" : "Protein [Mass/volume] in Urine by Test strip",
        "equivalence" : "wider",
        "comment" : "source 指定自動化試紙判讀，target 方法未指定自動化；target 語意較廣"
      }]
    },
    {
      "code" : "63557-3",
      "display" : "Hepatitis B virus surface Ag [Units/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "5196-1",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay",
        "equivalence" : "relatedto",
        "comment" : "source 為定量（Units/volume）、target 為定性（Presence），Property 不同而無包含關係；定量值不可直接當作定性結果比較，須依判讀閾值轉換"
      }]
    },
    {
      "code" : "19876-2",
      "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation",
      "target" : [{
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry",
        "equivalence" : "wider",
        "comment" : "source 指定支氣管擴張劑給藥前之特定條件，target 未指定給藥前後；target 語意較廣"
      }]
    }]
  }]
}

```
