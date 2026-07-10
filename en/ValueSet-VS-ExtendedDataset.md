# 健康檢查進階與領域擴充項目值集 - 臺灣勞工健康檢查交換實作指引 (Taiwan Labor Health Examination Exchange FHIR IG, TWHA IG) v0.1.0

## ValueSet: 健康檢查進階與領域擴充項目值集 

 
包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。 

 **References** 

* [特殊健檢實驗室檢驗 Profile](StructureDefinition-TWHA-LabResult-Special.md)

### Logical Definition (CLD)

 

### Expansion

No Expansion for this valueset (not supported by Publication Tooling)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VS-ExtendedDataset",
  "url" : "https://twcore.mohw.gov.tw/ig/twha/ValueSet/VS-ExtendedDataset",
  "version" : "0.1.0",
  "name" : "VS_ExtendedDataset",
  "title" : "健康檢查進階與領域擴充項目值集",
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
  "description" : "包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目，以及自費健康檢查常見之影像學檢查（如 MRI、CT、PET/CT、超音波、骨密度等）與內視鏡檢查（如胃鏡、大腸鏡），對應至 LOINC 代碼。",
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
        "display" : "Specific gravity of Urine"
      },
      {
        "code" : "89015-2",
        "display" : "Pure tone threshold audiometry panel"
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
        "display" : "Erythrocytes [#/volume] in Blood"
      },
      {
        "code" : "6690-2",
        "display" : "WBC [#/volume] in Blood"
      },
      {
        "code" : "777-3",
        "display" : "Platelets [#/volume] in Blood"
      },
      {
        "code" : "718-7",
        "display" : "Hemoglobin [Mass/volume] in Blood"
      },
      {
        "code" : "4544-3",
        "display" : "Hematocrit [Volume Fraction] of Blood"
      },
      {
        "code" : "770-8",
        "display" : "Neutrophils [Fraction] of WBC"
      },
      {
        "code" : "736-9",
        "display" : "Lymphocytes [Fraction] of WBC"
      },
      {
        "code" : "11580-8",
        "display" : "Thyrotropin [Units/volume] in Serum or Plasma"
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
        "code" : "19876-2",
        "display" : "Forced vital capacity [Volume] in Airways by Spirometry"
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
        "display" : "Aminolevulinic acid [Mass/volume] in Urine"
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
        "display" : "Gamma glutamyltransferase [Enzymatic activity/volume] in Serum or Plasma"
      },
      {
        "code" : "6709-0",
        "display" : "Hippurate [Mass/volume] in Urine"
      },
      {
        "code" : "2725-0",
        "display" : "p-Methylhippurate [Mass/volume] in Urine"
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
        "display" : "Methylformamide [Mass/volume] in Urine"
      },
      {
        "code" : "12533-6",
        "display" : "TTCA [Mass/volume] in Urine"
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
        "display" : "4,4'-Methylenebis(2-chloroaniline) [Mass/volume] in Urine"
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
        "display" : "Manganese [Mass/volume] in Urine"
      },
      {
        "code" : "34304-6",
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
        "display" : "Salmonella and Shigella [Presence] in Stool by Culture"
      },
      {
        "code" : "19266-6",
        "display" : "Amphetamines [Presence] in Urine by Screening test"
      },
      {
        "code" : "19299-7",
        "display" : "Opiates [Presence] in Urine by Screening test"
      },
      {
        "code" : "19283-1",
        "display" : "Benzodiazepines [Presence] in Urine by Screening test"
      },
      {
        "code" : "19501-6",
        "display" : "Ketamine [Presence] in Urine by Screening test"
      },
      {
        "code" : "19571-9",
        "display" : "MDMA [Presence] in Urine by Screening test"
      },
      {
        "code" : "19177-5",
        "display" : "Alpha-1-fetoprotein [Mass/volume] in Serum or Plasma"
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
        "code" : "19199-9",
        "display" : "Prostate specific Ag [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "10886-0",
        "display" : "Prostate specific Ag.free [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "97149-9",
        "display" : "[-2]pro-prostate specific antigen [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "97150-7",
        "display" : "Prostate Health Index in Serum or Plasma"
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
        "display" : "Cancer Ag 15-3 [Units/volume] in Serum or Plasma"
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
        "display" : "Epstein Barr virus VCA IgA Ab [Presence] in Serum"
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
        "display" : "Natriuretic peptide.proB-type N-terminal [Mass/volume] in Serum or Plasma"
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
        "display" : "CYFRA 21-1 [Mass/volume] in Serum or Plasma"
      },
      {
        "code" : "24606-6",
        "display" : "Mammogram screening views study"
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
        "display" : "Ultrasound of abdomen study"
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
      }]
    }]
  }
}

```
