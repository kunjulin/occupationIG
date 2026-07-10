# 健康檢查核心項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 健康檢查核心項目值集 

 
包含一般健康檢查及體格檢查之核心檢驗與實驗室項目，對應至 LOINC 代碼。 

 **References** 

* [一般健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-General.md)

### Logical Definition (CLD)

 

### Expansion

No Expansion for this valueset (not supported by Publication Tooling)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-CoreDataset",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-CoreDataset",
  "version" : "0.1.0",
  "name" : "VS_CoreDataset",
  "title" : "健康檢查核心項目值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-10T21:30:50+08:00",
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
  "description" : "包含一般健康檢查及體格檢查之核心檢驗與實驗室項目，對應至 LOINC 代碼。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "718-7",
        "display" : "Hemoglobin [Mass/volume] in Blood"
      },
      {
        "code" : "4544-3",
        "display" : "Hematocrit [Volume Fraction] of Blood"
      },
      {
        "code" : "789-8",
        "display" : "Erythrocytes [#/volume] in Blood"
      },
      {
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood"
      },
      {
        "code" : "804-5",
        "display" : "WBC [#/volume] in Blood by Manual count"
      },
      {
        "code" : "26464-8",
        "display" : "WBC [#/volume] in Blood"
      },
      {
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood"
      },
      {
        "code" : "26515-7",
        "display" : "Platelets [#/volume] in Blood by Automated count"
      },
      {
        "code" : "787-2",
        "display" : "MCV [Entitic volume] by Automated count"
      },
      {
        "code" : "30428-7",
        "display" : "MCV [Entitic volume] by calculation"
      },
      {
        "code" : "785-6",
        "display" : "MCH [Entitic mass] by Automated count"
      },
      {
        "code" : "28539-5",
        "display" : "MCH [Entitic mass] by Automated count"
      },
      {
        "code" : "786-4",
        "display" : "MCHC [Mass/volume] by Automated count"
      },
      {
        "code" : "788-0",
        "display" : "Erythrocyte distribution width [Ratio] by Automated count"
      },
      {
        "code" : "770-8",
        "display" : "Neutrophils/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "26508-2",
        "display" : "Neutrophils/100 leukocytes in Blood by Manual count"
      },
      {
        "code" : "736-9",
        "display" : "Lymphocytes/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "5905-5",
        "display" : "Monocytes/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "713-8",
        "display" : "Eosinophils/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "706-2",
        "display" : "Basophils/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "751-8",
        "display" : "Neutrophils [#/volume] in Blood by Automated count"
      },
      {
        "code" : "731-0",
        "display" : "Lymphocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "19048-8",
        "display" : "Erythroblasts/100 leukocytes in Blood by Automated count"
      },
      {
        "code" : "13046-8",
        "display" : "Atypical lymphocytes/100 leukocytes in Blood"
      },
      {
        "code" : "34921-7",
        "display" : "Plasmacytoid lymphocytes/100 leukocytes in Blood"
      },
      {
        "code" : "30466-7",
        "display" : "Promonocytes/100 leukocytes in Blood"
      },
      {
        "code" : "26505-8",
        "display" : "Hypersegmented neutrophils/100 leukocytes in Blood"
      },
      {
        "code" : "30441-0",
        "display" : "Abnormal monocytes/100 leukocytes in Blood"
      },
      {
        "code" : "70028-6",
        "display" : "Megakaryocytes/100 leukocytes in Blood"
      },
      {
        "code" : "30413-9",
        "display" : "Abnormal lymphocytes/100 leukocytes in Blood"
      },
      {
        "code" : "26446-5",
        "display" : "Blasts/100 leukocytes in Blood"
      },
      {
        "code" : "26524-9",
        "display" : "Promyelocytes/100 leukocytes in Blood"
      },
      {
        "code" : "26498-6",
        "display" : "Myelocytes/100 leukocytes in Blood"
      },
      {
        "code" : "28541-1",
        "display" : "Metamyelocytes/100 leukocytes in Blood"
      },
      {
        "code" : "26511-6",
        "display" : "Neutrophils.segmented/100 leukocytes in Blood"
      },
      {
        "code" : "26478-8",
        "display" : "Lymphocytes/100 leukocytes in Blood by Manual count"
      },
      {
        "code" : "26485-3",
        "display" : "Monocytes/100 leukocytes in Blood by Manual count"
      },
      {
        "code" : "26450-7",
        "display" : "Eosinophils/100 leukocytes in Blood by Manual count"
      },
      {
        "code" : "30180-4",
        "display" : "Basophils/100 leukocytes in Blood by Manual count"
      },
      {
        "code" : "13047-6",
        "display" : "Plasma cells/100 leukocytes in Blood"
      },
      {
        "code" : "1558-6",
        "display" : "Fasting Glucose [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2339-0",
        "display" : "Glucose [Mass/volume] in Blood"
      },
      {
        "code" : "2345-7",
        "display" : "Glucose [Mass/volume] in Serum or Plasma -- post fasting"
      },
      {
        "code" : "4548-4",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood"
      },
      {
        "code" : "59261-8",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol"
      },
      {
        "code" : "20448-7",
        "display" : "Insulin [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "47214-2",
        "display" : "Homeostasis model assessment"
      },
      {
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "38483-4",
        "display" : "Creatinine [Mass/volume] in Blood"
      },
      {
        "code" : "3094-0",
        "display" : "Urea nitrogen [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "33914-3",
        "display" : "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation"
      },
      {
        "code" : "88293-6",
        "display" : "Glomerular filtration rate/1.73 sq M.predicted by Creatinine-based formula (CKD-EPI 2021)"
      },
      {
        "code" : "33863-2",
        "display" : "Cystatin C [Mass/volume] in Serum, Plasma or Blood"
      },
      {
        "code" : "3084-1",
        "display" : "Uric acid [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "49154-8",
        "display" : "Uric acid [Mass/volume] in Blood"
      },
      {
        "code" : "17861-6",
        "display" : "Calcium [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2777-1",
        "display" : "Phosphate [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "30522-7",
        "display" : "C reactive protein [Mass/volume] in Serum or Plasma by High sensitivity method"
      },
      {
        "code" : "2428-1",
        "display" : "Homocysteine [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "14409-7",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
      },
      {
        "code" : "88112-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
      },
      {
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "14390-9",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"
      },
      {
        "code" : "1744-2",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
      },
      {
        "code" : "6768-6",
        "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1783-0",
        "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2324-2",
        "display" : "Gamma glutamyltransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1975-2",
        "display" : "Bilirubin.total [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1968-7",
        "display" : "Bilirubin.direct [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1751-7",
        "display" : "Albumin [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2885-2",
        "display" : "Protein [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "10834-0",
        "display" : "Globulin [Mass/volume] in Serum or Plasma by calculation"
      },
      {
        "code" : "1759-0",
        "display" : "Albumin/Globulin [Mass Ratio] in Serum or Plasma"
      },
      {
        "code" : "2532-0",
        "display" : "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1798-8",
        "display" : "Amylase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "3040-3",
        "display" : "Lipase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "35200-5",
        "display" : "Cholesterol [Mass/volume] in Blood"
      },
      {
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3043-7",
        "display" : "Triglyceride [Mass/volume] in Blood"
      },
      {
        "code" : "2085-9",
        "display" : "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3048-6",
        "display" : "Cholesterol in HDL [Mass/volume] in Blood"
      },
      {
        "code" : "13457-7",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
      },
      {
        "code" : "18262-6",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
      },
      {
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay"
      },
      {
        "code" : "46986-6",
        "display" : "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"
      },
      {
        "code" : "9830-1",
        "display" : "Cholesterol/Cholesterol in HDL [Mass Ratio] in Serum or Plasma"
      },
      {
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "3016-3",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS"
      },
      {
        "code" : "3024-7",
        "display" : "Thyroxine (T4) free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3051-0",
        "display" : "Triiodothyronine (T3) free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3026-2",
        "display" : "Thyroxine (T4) total [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3053-6",
        "display" : "Triiodothyronine (T3) total [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "8099-4",
        "display" : "Thyroid peroxidase Ab [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "62292-8",
        "display" : "25-hydroxyvitamin D3 [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2132-9",
        "display" : "Cobalamin (Vitamin B12) [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2284-8",
        "display" : "Folate [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5196-1",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum"
      },
      {
        "code" : "22326-3",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma"
      },
      {
        "code" : "22322-2",
        "display" : "Hepatitis B virus surface Ab [Units/volume] in Serum"
      },
      {
        "code" : "5193-8",
        "display" : "Hepatitis B virus surface Ab [Presence] in Serum or Plasma"
      },
      {
        "code" : "13952-7",
        "display" : "Hepatitis B virus core Ab [Presence] in Serum or Plasma"
      },
      {
        "code" : "63557-3",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "13955-0",
        "display" : "Hepatitis C virus Ab [Presence] in Serum or Plasma"
      },
      {
        "code" : "47365-2",
        "display" : "Hepatitis C virus Ab [Presence] in Blood"
      },
      {
        "code" : "20507-0",
        "display" : "Reagin Ab [Presence] in Serum by RPR"
      },
      {
        "code" : "31147-2",
        "display" : "Reagin Ab [Presence] in Serum by RPR -- titer"
      },
      {
        "code" : "24110-9",
        "display" : "Treponema pallidum Ab [Presence] in Serum by Immunoassay"
      },
      {
        "code" : "56888-1",
        "display" : "HIV 1 and 2 Ag and Ab panel [Presence] in Serum or Plasma"
      },
      {
        "code" : "13950-1",
        "display" : "Hepatitis A virus IgM Ab [Presence] in Serum or Plasma"
      },
      {
        "code" : "51913-2",
        "display" : "Hepatitis A virus Ab [Presence] in Serum or Plasma"
      },
      {
        "code" : "7962-4",
        "display" : "Measles virus IgG Ab [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "5403-1",
        "display" : "Varicella zoster virus IgG Ab [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "5334-8",
        "display" : "Rubella virus IgG Ab [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "5176-3",
        "display" : "Helicobacter pylori IgG Ab [Presence] in Serum"
      },
      {
        "code" : "17780-8",
        "display" : "Helicobacter pylori Ag [Presence] in Stool"
      },
      {
        "code" : "29771-3",
        "display" : "Hemoglobin.occult [Mass/volume] in Stool by Immunochemical method"
      },
      {
        "code" : "21440-3",
        "display" : "Human papilloma virus 16+18+31+33+35+45+51+52+56 DNA [Presence] in Cervix by Probe"
      },
      {
        "code" : "5803-2",
        "display" : "pH of Urine by Test strip"
      },
      {
        "code" : "50560-2",
        "display" : "pH of Urine by Test strip"
      },
      {
        "code" : "5804-0",
        "display" : "Protein [Presence] in Urine by Test strip"
      },
      {
        "code" : "57735-3",
        "display" : "Protein [Presence] in Urine by Test strip"
      },
      {
        "code" : "2888-6",
        "display" : "Protein [Mass/volume] in Urine"
      },
      {
        "code" : "5792-7",
        "display" : "Glucose [Presence] in Urine by Test strip"
      },
      {
        "code" : "50555-2",
        "display" : "Glucose [Presence] in Urine by Test strip"
      },
      {
        "code" : "5794-3",
        "display" : "Hemoglobin [Presence] in Urine by Test strip"
      },
      {
        "code" : "57751-0",
        "display" : "Hemoglobin [Presence] in Urine by Test strip"
      },
      {
        "code" : "5797-6",
        "display" : "Ketones [Presence] in Urine by Test strip"
      },
      {
        "code" : "57734-6",
        "display" : "Ketones [Presence] in Urine by Test strip"
      },
      {
        "code" : "5802-4",
        "display" : "Nitrite [Presence] in Urine by Test strip"
      },
      {
        "code" : "50558-6",
        "display" : "Nitrite [Presence] in Urine by Test strip"
      },
      {
        "code" : "5770-3",
        "display" : "Bilirubin [Presence] in Urine by Test strip"
      },
      {
        "code" : "50551-1",
        "display" : "Bilirubin [Presence] in Urine by Test strip"
      },
      {
        "code" : "13658-0",
        "display" : "Urobilinogen [Presence] in Urine by Test strip"
      },
      {
        "code" : "62487-4",
        "display" : "Urobilinogen [Presence] in Urine by Test strip"
      },
      {
        "code" : "5810-7",
        "display" : "Specific gravity of Urine"
      },
      {
        "code" : "50562-8",
        "display" : "Specific gravity of Urine by Refractometer"
      },
      {
        "code" : "5799-2",
        "display" : "Leukocyte esterase [Presence] in Urine by Test strip"
      },
      {
        "code" : "60026-2",
        "display" : "Leukocyte esterase [Presence] in Urine by Test strip"
      },
      {
        "code" : "13945-1",
        "display" : "Erythrocytes [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "5821-4",
        "display" : "Leukocytes [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "11277-1",
        "display" : "Epithelial cells.squamous [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "5796-8",
        "display" : "Hyaline casts [#/area] in Urine sediment by Microscopy low power field"
      },
      {
        "code" : "25145-4",
        "display" : "Bacteria [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "20627-6",
        "display" : "Color of Urine"
      },
      {
        "code" : "20621-9",
        "display" : "Albumin/Creatinine [Ratio] in Urine by Test strip"
      },
      {
        "code" : "11218-5",
        "display" : "Microalbumin [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "30004-6",
        "display" : "Creatinine [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "46419-8",
        "display" : "Erythrocytes [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "46702-7",
        "display" : "Leukocytes [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "33219-7",
        "display" : "Epithelial cells.squamous [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "33342-7",
        "display" : "Epithelial cells [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "33223-9",
        "display" : "Hyaline casts [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "43755-8",
        "display" : "Casts [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "12453-7",
        "display" : "Amorphous phosphate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5774-5",
        "display" : "Calcium oxalate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5817-2",
        "display" : "Uric acid crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5814-9",
        "display" : "Calcium magnesium ammonium phosphate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5773-7",
        "display" : "Calcium carbonate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "53975-9",
        "display" : "Drug crystals [Presence] in Urine sediment"
      },
      {
        "code" : "32356-8",
        "display" : "Yeast [Presence] in Urine sediment"
      },
      {
        "code" : "33218-9",
        "display" : "Bacteria [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "5813-1",
        "display" : "Trichomonas vaginalis [Presence] in Urine sediment"
      },
      {
        "code" : "20456-0",
        "display" : "Fungi yeast-like [Presence] in Urine sediment"
      },
      {
        "code" : "53324-0",
        "display" : "Spermatozoa [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "50235-1",
        "display" : "Mucus [#/volume] in Urine sediment by Automated count"
      },
      {
        "code" : "5788-5",
        "display" : "Oval fat bodies [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "5766-1",
        "display" : "Ammonium acid urate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "12454-5",
        "display" : "Amorphous urate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5771-1",
        "display" : "Bilirubin crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5775-2",
        "display" : "Calcium phosphate crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5784-4",
        "display" : "Cystine crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5777-8",
        "display" : "Cholesterol crystals [Presence] in Urine sediment"
      },
      {
        "code" : "5787-7",
        "display" : "Epithelial cells [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "1988-5",
        "display" : "C reactive protein [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "13705-9",
        "display" : "Albumin/Creatinine [Mass Ratio] in Urine"
      },
      {
        "code" : "14957-5",
        "display" : "Microalbumin [Mass/volume] in Urine"
      },
      {
        "code" : "2161-8",
        "display" : "Creatinine [Mass/volume] in Urine"
      },
      {
        "code" : "4588-0",
        "display" : "Hemoglobin H/Hemoglobin.total in Blood"
      },
      {
        "code" : "19876-2",
        "display" : "Forced vital capacity [Volume] in Airways by Spirometry"
      },
      {
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
      },
      {
        "code" : "20150-9",
        "display" : "Forced expiratory volume in 1 second [Volume] in Airways by Spirometry"
      },
      {
        "code" : "19926-5",
        "display" : "Forced expiratory volume in 1 second/Forced vital capacity [Volume Ratio] in Airways by Spirometry"
      },
      {
        "code" : "79880-1",
        "display" : "Vision test panel"
      },
      {
        "code" : "89015-2",
        "display" : "Pure tone threshold audiometry panel"
      },
      {
        "code" : "9397-1",
        "display" : "Color of Stool"
      },
      {
        "code" : "42524-9",
        "display" : "Mucus [Presence] in Stool by Microscopy"
      },
      {
        "code" : "2335-8",
        "display" : "Hemoglobin [Presence] in Stool"
      },
      {
        "code" : "10704-5",
        "display" : "Ova and parasites [Presence] in Stool by Microscopy"
      },
      {
        "code" : "13655-6",
        "display" : "Leukocytes [Presence] in Stool by Microscopy"
      },
      {
        "code" : "33668-5",
        "display" : "Erythrocytes [Presence] in Stool by Microscopy"
      },
      {
        "code" : "10701-1",
        "display" : "Ova and parasites [Presence] in Stool by Concentration method"
      }]
    }]
  }
}

```
