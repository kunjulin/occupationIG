# 健康檢查進階與領域擴充項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.5.0

## ValueSet: 健康檢查進階與領域擴充項目值集 

 
【技術規格】包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。 

 **References** 

* [特殊健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-Special.md)

### Logical Definition (CLD)

 

### 展開

-------

 [上表之說明](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-ExtendedDataset",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ExtendedDataset",
  "version" : "0.5.0",
  "name" : "VS_ExtendedDataset",
  "title" : "健康檢查進階與領域擴充項目值集",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-08-20T16:35:38+00:00",
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
  "description" : "【技術規格】包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。",
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "11524-6",
        "display" : "EKG study"
      },
      {
        "code" : "2951-2",
        "display" : "Sodium [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "2823-3",
        "display" : "Potassium [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "2075-0",
        "display" : "Chloride [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "3094-0",
        "display" : "Urea nitrogen [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5810-7",
        "display" : "Specific gravity of Urine by Refractometry"
      },
      {
        "code" : "89015-2",
        "display" : "Pure tone air conduction threshold audiometry panel"
      },
      {
        "code" : "89024-4",
        "display" : "Hearing threshold Ear - left --500 Hz"
      },
      {
        "code" : "89016-0",
        "display" : "Hearing threshold Ear - left --1000 Hz"
      },
      {
        "code" : "89018-6",
        "display" : "Hearing threshold Ear - left --2000 Hz"
      },
      {
        "code" : "89020-2",
        "display" : "Hearing threshold Ear - left --3000 Hz"
      },
      {
        "code" : "89022-8",
        "display" : "Hearing threshold Ear - left --4000 Hz"
      },
      {
        "code" : "89026-9",
        "display" : "Hearing threshold Ear - left --6000 Hz"
      },
      {
        "code" : "89028-5",
        "display" : "Hearing threshold Ear - left --8000 Hz"
      },
      {
        "code" : "89025-1",
        "display" : "Hearing threshold Ear - right --500 Hz"
      },
      {
        "code" : "89017-8",
        "display" : "Hearing threshold Ear - right --1000 Hz"
      },
      {
        "code" : "89019-4",
        "display" : "Hearing threshold Ear - right --2000 Hz"
      },
      {
        "code" : "89021-0",
        "display" : "Hearing threshold Ear - right --3000 Hz"
      },
      {
        "code" : "89023-6",
        "display" : "Hearing threshold Ear - right --4000 Hz"
      },
      {
        "code" : "89027-7",
        "display" : "Hearing threshold Ear - right --6000 Hz"
      },
      {
        "code" : "89029-3",
        "display" : "Hearing threshold Ear - right --8000 Hz"
      },
      {
        "code" : "789-8",
        "display" : "Erythrocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood by Automated count"
      },
      {
        "code" : "718-7",
        "display" : "Hemoglobin [Mass/volume] in Blood"
      },
      {
        "code" : "4544-3",
        "display" : "Hematocrit [Volume Fraction] of Blood by Automated count"
      },
      {
        "code" : "770-8",
        "display" : "Neutrophils/Leukocytes in Blood by Automated count"
      },
      {
        "code" : "736-9",
        "display" : "Lymphocytes/Leukocytes in Blood by Automated count"
      },
      {
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma by Detection limit <= 0.005 mIU/L"
      },
      {
        "code" : "3024-7",
        "display" : "Thyroxine (T4) free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "24579-5",
        "display" : "XR Bones.long Survey"
      },
      {
        "code" : "19868-9",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry"
      },
      {
        "code" : "20150-9",
        "display" : "FEV1"
      },
      {
        "code" : "19926-5",
        "display" : "FEV1/FVC"
      },
      {
        "code" : "77307-7",
        "display" : "Lead [Mass/volume] in Venous blood"
      },
      {
        "code" : "5671-3",
        "display" : "Lead [Mass/volume] in Blood"
      },
      {
        "code" : "5676-2",
        "display" : "Lead [Mass/volume] in Urine"
      },
      {
        "code" : "23749-5",
        "display" : "Lead [Mass/volume] in Specimen"
      },
      {
        "code" : "11212-8",
        "display" : "Coproporphyrin [Mass/volume] in Urine"
      },
      {
        "code" : "11215-1",
        "display" : "Delta aminolevulinate [Mass/volume] in Urine"
      },
      {
        "code" : "36643-5",
        "display" : "XR Chest 2 Views"
      },
      {
        "code" : "24648-8",
        "display" : "XR Chest PA upright"
      },
      {
        "code" : "2324-2",
        "display" : "Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "6709-0",
        "display" : "Hippurate [Mass/volume] in Urine"
      },
      {
        "code" : "2725-0",
        "display" : "Para methylhippurate [Mass/volume] in Urine"
      },
      {
        "code" : "13000-5",
        "display" : "Mandelate [Mass/volume] in Urine"
      },
      {
        "code" : "3041-1",
        "display" : "Trichloroacetate [Mass/volume] in Urine"
      },
      {
        "code" : "31170-4",
        "display" : "2,5-Hexanedione [Mass/volume] in Urine"
      },
      {
        "code" : "2758-1",
        "display" : "Phenol [Mass/volume] in Urine"
      },
      {
        "code" : "12543-5",
        "display" : "Methyl formamide [Mass/volume] in Urine"
      },
      {
        "code" : "12533-6",
        "display" : "Thiazolidine-2-Thione-4-Carboxylic acid [Mass/volume] in Urine"
      },
      {
        "code" : "5586-3",
        "display" : "Arsenic [Mass/volume] in Urine"
      },
      {
        "code" : "5609-3",
        "display" : "Cadmium [Mass/volume] in Blood"
      },
      {
        "code" : "5611-9",
        "display" : "Cadmium [Mass/volume] in Urine"
      },
      {
        "code" : "13471-8",
        "display" : "Cadmium/Creatinine [Mass Ratio] in Urine"
      },
      {
        "code" : "5622-6",
        "display" : "Chromium [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5623-4",
        "display" : "Chromium [Mass/volume] in Urine"
      },
      {
        "code" : "13464-3",
        "display" : "Chromium/Creatinine [Mass Ratio] in Urine"
      },
      {
        "code" : "14099-6",
        "display" : "Nickel [Mass/volume] in Urine"
      },
      {
        "code" : "5685-3",
        "display" : "Mercury [Mass/volume] in Blood"
      },
      {
        "code" : "5689-5",
        "display" : "Mercury [Mass/volume] in Urine"
      },
      {
        "code" : "72665-3",
        "display" : "trans,trans-Muconic acid [Mass/volume] in Urine"
      },
      {
        "code" : "10913-2",
        "display" : "4,4'-Methylene bis(2-Chloroaniline) [Mass/volume] in Urine"
      },
      {
        "code" : "5653-1",
        "display" : "Formaldehyde [Mass/volume] in Urine"
      },
      {
        "code" : "10909-0",
        "display" : "Benzidine [Mass/volume] in Urine"
      },
      {
        "code" : "5681-2",
        "display" : "Manganese [Mass/volume] in Blood"
      },
      {
        "code" : "5683-8",
        "display" : "Manganese [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "42221-2",
        "display" : "Manganese [Moles/volume] in Urine"
      },
      {
        "code" : "5684-6",
        "display" : "Manganese [Mass/volume] in Urine"
      },
      {
        "code" : "34304-6",
        "display" : "Fluoride [Moles/volume] in Urine"
      },
      {
        "code" : "5650-7",
        "display" : "Fluoride [Mass/volume] in Urine"
      },
      {
        "code" : "2777-1",
        "display" : "Phosphate [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "24829-4",
        "display" : "XR Mandible Views"
      },
      {
        "code" : "9827-7",
        "display" : "Paraquat [Mass/volume] in Urine"
      },
      {
        "code" : "60090-8",
        "display" : "Indium [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5665-5",
        "display" : "Indium [Mass/volume] in Blood"
      },
      {
        "code" : "5627-5",
        "display" : "Cobalt [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "5625-9",
        "display" : "Cobalt [Mass/volume] in Blood"
      },
      {
        "code" : "1984-4",
        "display" : "Bromide [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1985-1",
        "display" : "Bromide [Mass/volume] in Urine"
      },
      {
        "code" : "1709-5",
        "display" : "Acetylcholinesterase [Enzymatic activity/volume] in Red Blood Cells"
      },
      {
        "code" : "2098-2",
        "display" : "Cholinesterase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "43371-4",
        "display" : "Salmonella and Shigella sp identified in Stool by Organism specific culture"
      },
      {
        "code" : "3349-8",
        "display" : "Amphetamines [Presence] in Urine"
      },
      {
        "code" : "3879-4",
        "display" : "Opiates [Presence] in Urine"
      },
      {
        "code" : "3390-2",
        "display" : "Benzodiazepines [Presence] in Urine"
      },
      {
        "code" : "12327-3",
        "display" : "Ketamine [Presence] in Urine"
      },
      {
        "code" : "14267-9",
        "display" : "Methylenedioxymethamphetamine [Presence] in Urine"
      },
      {
        "code" : "19177-5",
        "display" : "Alpha-1-Fetoprotein [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "53962-7",
        "display" : "Alpha-1-fetoprotein.tumor marker [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2039-6",
        "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2857-1",
        "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "10886-0",
        "display" : "Prostate Specific Ag Free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "97149-9",
        "display" : "proPSA isoform 2 [Mass/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "97150-7",
        "display" : "Prostate health index in Serum or Plasma by calculation"
      },
      {
        "code" : "10334-1",
        "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "83082-8",
        "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "83085-1",
        "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "24108-3",
        "display" : "Cancer Ag 19-9 [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "83084-4",
        "display" : "Cancer Ag 19-9 [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "83083-6",
        "display" : "Cancer Ag 15-3 [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "83112-3",
        "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "1834-1",
        "display" : "Alpha-1-fetoprotein [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "9679-2",
        "display" : "Squamous cell carcinoma Ag [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "19113-0",
        "display" : "IgE [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "9633-9",
        "display" : "Epstein Barr virus capsid IgA Ab [Titer] in Serum by Immunofluorescence"
      },
      {
        "code" : "10835-7",
        "display" : "Lipoprotein A [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1869-7",
        "display" : "Apolipoprotein A-I [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1884-6",
        "display" : "Apolipoprotein B [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "33762-6",
        "display" : "Natriuretic peptide.B prohormone N-Terminal [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "42254-3",
        "display" : "Nuclear Ab [Presence] in Serum by Immunofluorescence"
      },
      {
        "code" : "11572-5",
        "display" : "Rheumatoid factor [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "25390-6",
        "display" : "Cytokeratin 19 [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "24606-6",
        "display" : "MG Breast Screening"
      },
      {
        "code" : "103892-6",
        "display" : "DBT Brst Screening"
      },
      {
        "code" : "24590-2",
        "display" : "MR Brain"
      },
      {
        "code" : "79086-5",
        "display" : "CT Chest Screening WO contr"
      },
      {
        "code" : "87279-6",
        "display" : "CT Chest Screening"
      },
      {
        "code" : "81555-5",
        "display" : "PT+CT Whole body Tum loc W 18F-FDG IV"
      },
      {
        "code" : "79073-3",
        "display" : "CTA Hrt+CA W contr IV"
      },
      {
        "code" : "28014-9",
        "display" : "EGD Study"
      },
      {
        "code" : "28023-0",
        "display" : "Colonoscopy Study"
      },
      {
        "code" : "24558-9",
        "display" : "US Abdomen"
      },
      {
        "code" : "24616-5",
        "display" : "US Carotid aa"
      },
      {
        "code" : "25010-0",
        "display" : "US Thyroid"
      },
      {
        "code" : "38268-9",
        "display" : "DXA Skeletal Sys Views for BMD"
      },
      {
        "code" : "13046-8",
        "display" : "Variant lymphocytes/Leukocytes in Blood"
      },
      {
        "code" : "13047-6",
        "display" : "Plasma cells/Leukocytes in Blood"
      },
      {
        "code" : "19048-8",
        "display" : "Nucleated erythrocytes/Leukocytes [Ratio] in Blood"
      },
      {
        "code" : "26446-5",
        "display" : "Blasts/Leukocytes in Blood"
      },
      {
        "code" : "26450-7",
        "display" : "Eosinophils/Leukocytes in Blood"
      },
      {
        "code" : "26464-8",
        "display" : "Leukocytes [#/volume] in Blood"
      },
      {
        "code" : "26478-8",
        "display" : "Lymphocytes/Leukocytes in Blood"
      },
      {
        "code" : "26485-3",
        "display" : "Monocytes/Leukocytes in Blood"
      },
      {
        "code" : "26498-6",
        "display" : "Myelocytes/Leukocytes in Blood"
      },
      {
        "code" : "26505-8",
        "display" : "Segmented neutrophils/Leukocytes in Blood"
      },
      {
        "code" : "26508-2",
        "display" : "Band form neutrophils/Leukocytes in Blood"
      },
      {
        "code" : "26511-6",
        "display" : "Neutrophils/Leukocytes in Blood"
      },
      {
        "code" : "26515-7",
        "display" : "Platelets [#/volume] in Blood"
      },
      {
        "code" : "26524-9",
        "display" : "Promyelocytes/Leukocytes in Blood"
      },
      {
        "code" : "28539-5",
        "display" : "MCH [Entitic mass]"
      },
      {
        "code" : "28541-1",
        "display" : "Metamyelocytes/Leukocytes in Blood"
      },
      {
        "code" : "30180-4",
        "display" : "Basophils/Leukocytes in Blood"
      },
      {
        "code" : "30413-9",
        "display" : "Abnormal lymphocytes/Leukocytes in Blood"
      },
      {
        "code" : "30428-7",
        "display" : "MCV [Entitic mean volume] in Red Blood Cells"
      },
      {
        "code" : "30441-0",
        "display" : "Monocytes Abnormal/Leukocytes in Blood"
      },
      {
        "code" : "30466-7",
        "display" : "Promonocytes/Leukocytes in Blood"
      },
      {
        "code" : "34921-7",
        "display" : "Lymphocytes Plasmacytoid/Leukocytes in Blood"
      },
      {
        "code" : "5905-5",
        "display" : "Monocytes/Leukocytes in Blood by Automated count"
      },
      {
        "code" : "19252-6",
        "display" : "Megakaryocytes/Leukocytes in Blood"
      },
      {
        "code" : "706-2",
        "display" : "Basophils/Leukocytes in Blood by Automated count"
      },
      {
        "code" : "713-8",
        "display" : "Eosinophils/Leukocytes in Blood by Automated count"
      },
      {
        "code" : "731-0",
        "display" : "Lymphocytes [#/volume] in Blood by Automated count"
      },
      {
        "code" : "751-8",
        "display" : "Neutrophils [#/volume] in Blood by Automated count"
      },
      {
        "code" : "785-6",
        "display" : "MCH [Entitic mass] by Automated count"
      },
      {
        "code" : "786-4",
        "display" : "MCHC [Entitic Mass/volume] in Red Blood Cells by Automated count"
      },
      {
        "code" : "787-2",
        "display" : "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
      },
      {
        "code" : "788-0",
        "display" : "Erythrocyte [DistWidth] in Blood by Automated count"
      },
      {
        "code" : "804-5",
        "display" : "Leukocytes [#/volume] in Blood by Manual count"
      },
      {
        "code" : "17861-6",
        "display" : "Calcium [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "20448-7",
        "display" : "Insulin [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "2428-1",
        "display" : "Homocysteine [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "13965-9",
        "display" : "Homocysteine [Moles/volume] in Serum or Plasma"
      },
      {
        "code" : "30522-7",
        "display" : "C reactive protein [Mass/volume] in Serum or Plasma by High sensitivity method"
      },
      {
        "code" : "3084-1",
        "display" : "Urate [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "33863-2",
        "display" : "Cystatin C [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "33914-3",
        "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum or Plasma by Creatinine-based formula (MDRD)/1.73 sq M"
      },
      {
        "code" : "4548-4",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood"
      },
      {
        "code" : "47214-2",
        "display" : "Homeostasis model assessment"
      },
      {
        "code" : "59261-8",
        "display" : "Hemoglobin A1c/Hemoglobin.total standardized per IFCC-RMP for CDT in Blood"
      },
      {
        "code" : "98979-8",
        "display" : "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
      },
      {
        "code" : "10834-0",
        "display" : "Globulin [Mass/volume] in Serum by calculation"
      },
      {
        "code" : "1743-4",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P"
      },
      {
        "code" : "30239-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5'-P"
      },
      {
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1744-2",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
      },
      {
        "code" : "1751-7",
        "display" : "Albumin [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1759-0",
        "display" : "Albumin/Globulin [Mass Ratio] in Serum or Plasma"
      },
      {
        "code" : "1798-8",
        "display" : "Amylase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "1968-7",
        "display" : "Bilirubin.direct [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "1975-2",
        "display" : "Bilirubin.total [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "2532-0",
        "display" : "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "2885-2",
        "display" : "Protein [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3040-3",
        "display" : "Lipase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "6768-6",
        "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "88112-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P"
      },
      {
        "code" : "13458-5",
        "display" : "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"
      },
      {
        "code" : "9830-1",
        "display" : "Cholesterol.total/Cholesterol in HDL [Mass Ratio] in Serum or Plasma"
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
        "code" : "3016-3",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "3026-2",
        "display" : "Thyroxine (T4) [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3051-0",
        "display" : "Triiodothyronine (T3) free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "3053-6",
        "display" : "Triiodothyronine (T3) [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "62292-8",
        "display" : "25-Hydroxyvitamin D3+25-Hydroxyvitamin D2 [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "8099-4",
        "display" : "Thyroperoxidase Ab [Units/volume] in Serum or Plasma"
      },
      {
        "code" : "13950-1",
        "display" : "Hepatitis A virus IgM Ab [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "13952-7",
        "display" : "Hepatitis B virus core Ab [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "17780-8",
        "display" : "Helicobacter pylori Ag [Presence] in Stool by Immunoassay"
      },
      {
        "code" : "20507-0",
        "display" : "Reagin Ab [Presence] in Serum by RPR"
      },
      {
        "code" : "21440-3",
        "display" : "Human papilloma virus 16+18+31+33+35+45+51+52+56 DNA [Presence] in Cervix by Probe"
      },
      {
        "code" : "22322-2",
        "display" : "Hepatitis B virus surface Ab [Presence] in Serum"
      },
      {
        "code" : "24110-9",
        "display" : "Treponema pallidum Ab [Presence] in Serum by Immunoassay"
      },
      {
        "code" : "29771-3",
        "display" : "Hemoglobin [Presence] in Stool from gastrointestinal lower by Immunoassay"
      },
      {
        "code" : "31147-2",
        "display" : "Reagin Ab [Titer] in Serum by RPR"
      },
      {
        "code" : "5176-3",
        "display" : "Helicobacter pylori IgG Ab [Units/volume] in Serum by Immunoassay"
      },
      {
        "code" : "51913-2",
        "display" : "Hepatitis A virus IgG+IgM Ab [Presence] in Serum"
      },
      {
        "code" : "5193-8",
        "display" : "Hepatitis B virus surface Ab [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "5334-8",
        "display" : "Rubella virus IgG Ab [Units/volume] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "5403-1",
        "display" : "Varicella zoster virus IgG Ab [Units/volume] in Serum by Immunoassay"
      },
      {
        "code" : "56888-1",
        "display" : "HIV 1+2 Ab+HIV1 p24 Ag [Presence] in Serum or Plasma by Immunoassay"
      },
      {
        "code" : "7962-4",
        "display" : "Measles virus IgG Ab [Units/volume] in Serum"
      },
      {
        "code" : "11218-5",
        "display" : "Microalbumin [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "11277-1",
        "display" : "Epithelial cells.squamous [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "12453-7",
        "display" : "Phosphate crystals amorphous [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "12454-5",
        "display" : "Urate crystals amorphous [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "13658-0",
        "display" : "Urobilinogen [Presence] in Urine"
      },
      {
        "code" : "13945-1",
        "display" : "Erythrocytes [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "20456-0",
        "display" : "Fungi.yeastlike [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "20621-9",
        "display" : "Albumin/Creatinine [Mass Ratio] in Urine by Test strip"
      },
      {
        "code" : "5778-6",
        "display" : "Color of Urine"
      },
      {
        "code" : "25145-4",
        "display" : "Bacteria [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "30004-6",
        "display" : "Creatinine [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "32356-8",
        "display" : "Yeast [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "51480-2",
        "display" : "Bacteria [#/volume] in Urine by Automated count"
      },
      {
        "code" : "33218-9",
        "display" : "Bacteria [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "51486-9",
        "display" : "Epithelial cells.squamous [#/volume] in Urine by Automated count"
      },
      {
        "code" : "33219-7",
        "display" : "Epithelial cells.squamous [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "51484-4",
        "display" : "Hyaline casts [#/volume] in Urine by Automated count"
      },
      {
        "code" : "33223-9",
        "display" : "Hyaline casts [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "87926-2",
        "display" : "Epithelial cells [#/volume] in Urine by Automated"
      },
      {
        "code" : "33342-7",
        "display" : "Epithelial cells [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "51483-6",
        "display" : "Casts [#/volume] in Urine by Automated count"
      },
      {
        "code" : "43755-8",
        "display" : "Casts [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "798-9",
        "display" : "Erythrocytes [#/volume] in Urine by Automated count"
      },
      {
        "code" : "46419-8",
        "display" : "Erythrocytes [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "51487-7",
        "display" : "Leukocytes [#/volume] in Urine by Automated count"
      },
      {
        "code" : "46702-7",
        "display" : "Leukocytes [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "51478-6",
        "display" : "Mucus [#/volume] in Urine by Automated count"
      },
      {
        "code" : "50235-1",
        "display" : "Mucus [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "50551-1",
        "display" : "Bilirubin.total [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "50555-2",
        "display" : "Glucose [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "50558-6",
        "display" : "Nitrite [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "50560-2",
        "display" : "pH of Urine by Automated test strip"
      },
      {
        "code" : "50562-8",
        "display" : "Specific gravity of Urine by Refractometry automated"
      },
      {
        "code" : "51479-4",
        "display" : "Spermatozoa [#/volume] in Urine by Automated count"
      },
      {
        "code" : "53324-0",
        "display" : "Spermatozoa [#/area] in Urine sediment by Automated count"
      },
      {
        "code" : "53975-9",
        "display" : "Drug crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5766-1",
        "display" : "Ammonium urate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5770-3",
        "display" : "Bilirubin.total [Presence] in Urine by Test strip"
      },
      {
        "code" : "5771-1",
        "display" : "Bilirubin crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5773-7",
        "display" : "Calcium carbonate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "57734-6",
        "display" : "Ketones [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "5774-5",
        "display" : "Calcium oxalate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5775-2",
        "display" : "Calcium phosphate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "57751-0",
        "display" : "Hemoglobin [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "5777-8",
        "display" : "Cholesterol crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5784-4",
        "display" : "Cystine crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5787-7",
        "display" : "Epithelial cells [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "5788-5",
        "display" : "Oval fat bodies (globules) [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "5792-7",
        "display" : "Glucose [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "5794-3",
        "display" : "Hemoglobin [Presence] in Urine by Test strip"
      },
      {
        "code" : "5796-8",
        "display" : "Hyaline casts [#/area] in Urine sediment by Microscopy low power field"
      },
      {
        "code" : "5797-6",
        "display" : "Ketones [Mass/volume] in Urine by Test strip"
      },
      {
        "code" : "5799-2",
        "display" : "Leukocyte esterase [Presence] in Urine by Test strip"
      },
      {
        "code" : "5802-4",
        "display" : "Nitrite [Presence] in Urine by Test strip"
      },
      {
        "code" : "5803-2",
        "display" : "pH of Urine by Test strip"
      },
      {
        "code" : "5813-1",
        "display" : "Trichomonas vaginalis [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5814-9",
        "display" : "Triple phosphate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5817-2",
        "display" : "Urate crystals [Presence] in Urine sediment by Light microscopy"
      },
      {
        "code" : "5821-4",
        "display" : "Leukocytes [#/area] in Urine sediment by Microscopy high power field"
      },
      {
        "code" : "60026-2",
        "display" : "Leukocyte esterase [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "62487-4",
        "display" : "Urobilinogen [Presence] in Urine by Automated test strip"
      },
      {
        "code" : "9318-7",
        "display" : "Albumin/Creatinine [Mass Ratio] in Urine"
      },
      {
        "code" : "14957-5",
        "display" : "Microalbumin [Mass/volume] in Urine"
      },
      {
        "code" : "1988-5",
        "display" : "C reactive protein [Mass/volume] in Serum or Plasma"
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
        "code" : "10701-1",
        "display" : "Ova and parasites identified in Stool by Concentration"
      },
      {
        "code" : "10704-5",
        "display" : "Ova and parasites identified in Stool by Light microscopy"
      },
      {
        "code" : "13655-6",
        "display" : "Leukocytes [Presence] in Stool by Light microscopy"
      },
      {
        "code" : "2335-8",
        "display" : "Hemoglobin [Presence] in Stool from gastrointestinal"
      },
      {
        "code" : "33668-5",
        "display" : "Erythrocytes [Presence] in Stool"
      },
      {
        "code" : "42524-9",
        "display" : "Mucus [Presence] in Stool by Light microscopy"
      },
      {
        "code" : "9397-1",
        "display" : "Color of Stool"
      },
      {
        "code" : "19876-2",
        "display" : "Forced vital capacity [Volume] Respiratory system by Spirometry --pre bronchodilation"
      },
      {
        "code" : "98497-1",
        "display" : "Visual acuity panel"
      }]
    }]
  }
}

```
