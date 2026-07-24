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
  "date" : "2026-07-24T13:54:16+08:00",
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
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "26464-8",
      "display" : "WBC [#/volume] in Blood",
      "target" : [{
        "code" : "6690-2",
        "display" : "Leukocytes [#/volume] in Blood",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "2888-6",
      "display" : "Protein [Mass/volume] in Urine",
      "target" : [{
        "code" : "5804-0",
        "display" : "Protein [Presence] in Urine by Test strip",
        "equivalence" : "wider"
      }]
    },
    {
      "code" : "2339-0",
      "display" : "Glucose [Mass/volume] in Blood",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting Glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "wider"
      }]
    },
    {
      "code" : "38483-4",
      "display" : "Creatinine [Mass/volume] in Blood",
      "target" : [{
        "code" : "2160-0",
        "display" : "Creatinine [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "49154-8",
      "display" : "Uric acid [Mass/volume] in Blood",
      "target" : [{
        "code" : "3084-1",
        "display" : "Uric acid [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "35200-5",
      "display" : "Cholesterol [Mass/volume] in Blood",
      "target" : [{
        "code" : "2093-3",
        "display" : "Cholesterol [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "3043-7",
      "display" : "Triglyceride [Mass/volume] in Blood",
      "target" : [{
        "code" : "2571-8",
        "display" : "Triglyceride [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "3048-6",
      "display" : "Cholesterol in HDL [Mass/volume] in Blood",
      "target" : [{
        "code" : "2085-9",
        "display" : "Cholesterol in HDL [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "13457-7",
      "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation",
      "target" : [{
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "33914-3",
      "display" : "Glomerular filtration rate/1.73 sq M.predicted by MDRD equation",
      "target" : [{
        "code" : "88293-6",
        "display" : "Glomerular filtration rate/1.73 sq M.predicted by Creatinine-based formula (CKD-EPI 2021)",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "22326-3",
      "display" : "Hepatitis B virus surface Ag [Presence] in Serum or Plasma",
      "target" : [{
        "code" : "5196-1",
        "display" : "Hepatitis B virus surface Ag [Presence] in Serum",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "47365-2",
      "display" : "Hepatitis C virus Ab [Presence] in Blood",
      "target" : [{
        "code" : "13955-0",
        "display" : "Hepatitis C virus Ab [Presence] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "26515-7",
      "display" : "Platelets [#/volume] in Blood by Automated count",
      "target" : [{
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "30428-7",
      "display" : "MCV [Entitic volume] by calculation",
      "target" : [{
        "code" : "787-2",
        "display" : "MCV [Entitic volume] by Automated count",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "28539-5",
      "display" : "MCH [Entitic mass] by Automated count",
      "target" : [{
        "code" : "785-6",
        "display" : "MCH [Entitic mass] by Automated count",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "26508-2",
      "display" : "Neutrophils/100 leukocytes in Blood by Manual count",
      "target" : [{
        "code" : "770-8",
        "display" : "Neutrophils/100 leukocytes in Blood by Automated count",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "14409-7",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "14390-9",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "1783-0",
      "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma",
      "target" : [{
        "code" : "6768-6",
        "display" : "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "59261-8",
      "display" : "Hemoglobin A1c/Hemoglobin.total in Blood by IFCC protocol",
      "target" : [{
        "code" : "4548-4",
        "display" : "Hemoglobin A1c/Hemoglobin.total in Blood",
        "equivalence" : "equivalent",
        "comment" : "Unit conversion required: NGSP(%) = IFCC(mmol/mol) * 0.9148 + 2.152"
      }]
    },
    {
      "code" : "3016-3",
      "display" : "Thyrotropin [Units/volume] in Serum or Plasma by 3rd IS",
      "target" : [{
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "19199-9",
      "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma",
      "target" : [{
        "code" : "2857-1",
        "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "83082-8",
      "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "10334-1",
        "display" : "Cancer Ag 125 [Units/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "83085-1",
      "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma by Immunoassay",
      "target" : [{
        "code" : "2039-6",
        "display" : "Carcinoembryonic Ag [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "88112-8",
      "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1920-8",
        "display" : "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "1744-2",
      "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by No addition of P-5'-P",
      "target" : [{
        "code" : "1742-6",
        "display" : "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "2345-7",
      "display" : "Glucose [Mass/volume] in Serum or Plasma -- post fasting",
      "target" : [{
        "code" : "1558-6",
        "display" : "Fasting Glucose [Mass/volume] in Serum or Plasma",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "18262-6",
      "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay",
      "target" : [{
        "code" : "2089-1",
        "display" : "Cholesterol in LDL [Mass/volume] in Serum or Plasma by Direct assay",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "23749-5",
      "display" : "Lead [Mass/volume] in Specimen",
      "target" : [{
        "code" : "5671-3",
        "display" : "Lead [Mass/volume] in Blood",
        "equivalence" : "equivalent"
      }]
    },
    {
      "code" : "56086-2",
      "display" : "Waist Circumference",
      "target" : [{
        "code" : "8280-0",
        "display" : "Waist Circumference at umbilicus by Tape measure",
        "equivalence" : "wider"
      }]
    },
    {
      "code" : "21104-5",
      "display" : "Pure tone audiometry - Audiometry study",
      "target" : [{
        "code" : "89015-2",
        "display" : "Pure tone threshold audiometry panel",
        "equivalence" : "equivalent"
      }]
    }]
  }]
}

```
