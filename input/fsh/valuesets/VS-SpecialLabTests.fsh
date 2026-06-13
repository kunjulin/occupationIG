ValueSet: VS_SpecialLabTests
Id: VS-SpecialLabTests
Title: "特殊健康檢查及體格檢查實驗室項目值集"
Description: "包含特殊健康檢查與體格檢查之實驗室與生理功能檢驗項目（含噪音、鉛、粉塵、高溫、異常氣壓、有機溶劑、特定化學物質、巴拉刈等作業），對應至 LOINC 代碼。"
* ^experimental = false

// 1. 噪音作業 (Noise Operations)
* LNC#89024-4 "Hearing threshold 500 Hz Ear-L" // Audiometry panel

// 2. 鉛作業 (Lead Operations)
* LNC#5671-3 "Lead [Mass/volume] in Blood"
* LNC#5676-2 "Lead [Mass/volume] in Urine"
* LNC#11212-8 "Coproporphyrin [Mass/volume] in Urine"
* LNC#11215-1 "Aminolevulinic acid [Mass/volume] in Urine"
* LNC#789-8 "Erythrocytes [#/volume] in Blood"
* LNC#4544-3 "Hematocrit [Volume Fraction] of Blood"

// 3. 粉塵作業 (Dust Operations)
* LNC#36643-5 "XR Chest 2V" // Chest X-ray study
* LNC#19868-9 "FEV1 Vol Respiratory Spirometry"
* LNC#19876-2 "FVC Vol Respiratory Spirometry"
* LNC#19926-5 "FEV1% or FEV1/FVC (%)"

// 4. 異常氣壓作業 (Abnormal Pressure Operations)
* LNC#11524-6 "EKG study"
* LNC#24579-5 "XR Bones.long Survey"

// 5. 高溫作業 (High Temperature Operations)
* LNC#2951-2 "Sodium [Moles/volume] in Serum or Plasma"
* LNC#2823-3 "Potassium [Moles/volume] in Serum or Plasma"

// 6. 有機溶劑作業 (Organic Solvent Operations)
* LNC#6709-0 "Hippurate [Mass/volume] in Urine" // Toluene metabolite
* LNC#2725-0 "p-Methylhippurate [Mass/volume] in Urine" // Xylene metabolite
* LNC#13000-5 "Mandelate [Mass/volume] in Urine" // Styrene metabolite
* LNC#3041-1 "Trichloroacetate [Mass/volume] in Urine" // Trichloroethylene metabolite
* LNC#31170-4 "2,5-Hexanedione [Mass/volume] in Urine" // n-Hexane metabolite
* LNC#2758-1 "Phenol [Mass/volume] in Urine" // Benzene metabolite
* LNC#12543-5 "Methylformamide [Mass/volume] in Urine" // DMF metabolite
* LNC#12533-6 "TTCA [Mass/volume] in Urine" // Carbon disulfide metabolite

// 7. 特定化學物質作業 (Specific Chemical Operations)
* LNC#5586-3 "Arsenic [Mass/volume] in Urine"
* LNC#5609-3 "Cadmium [Mass/volume] in Blood"
* LNC#5611-9 "Cadmium [Mass/volume] in Urine"
* LNC#5623-4 "Chromium [Mass/volume] in Urine"
* LNC#14099-6 "Nickel [Mass/volume] in Urine"
* LNC#5685-3 "Mercury [Mass/volume] in Blood"
* LNC#5689-5 "Mercury [Mass/volume] in Urine"
* LNC#72665-3 "trans,trans-Muconic acid [Mass/volume] in Urine" // Benzene metabolite
* LNC#10913-2 "4,4'-Methylenebis(2-chloroaniline) [Mass/volume] in Urine" // MOCA
* LNC#5653-1 "Formaldehyde [Mass/volume] in Urine"
* LNC#10909-0 "Benzidine [Mass/volume] in Urine"

// 8. 聯吡啶或巴拉刈作業 (Paraquat Operations)
* LNC#9827-7 "Paraquat [Mass/volume] in Urine"

// 9. 農藥與其它危害作業 (Pesticides / Other Surveillance)
* LNC#1709-5 "Acetylcholinesterase [Enzymatic activity/volume] in Red Blood Cells"
* LNC#2098-2 "Cholinesterase [Enzymatic activity/volume] in Serum or Plasma"
