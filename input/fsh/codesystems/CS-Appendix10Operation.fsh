CodeSystem: CS_Appendix10Operation
Id: CS-Appendix10Operation
Title: "附表十特別危害健康作業具名代碼系統"
Description: "《勞工健康保護規則》附表十（115.06.26 修正）逐號列舉之 35 項特別危害健康作業具名代碼。本代碼系統為「具名作業層」，與 CS-HazardType（12 危害家族層）以 ConceptMap Appendix10-to-HazardType 對映。編號 33/34/35（苯乙烯、甲苯、二甲苯）為 115.06.26 修正新增。"
* ^experimental = false
* ^caseSensitive = true
* #app-01 "高溫作業"
* #app-02 "噪音作業"
* #app-03 "游離輻射作業"
* #app-04 "異常氣壓作業"
* #app-05 "鉛作業"
* #app-06 "四烷基鉛作業"
* #app-07 "1,1,2,2-四氯乙烷作業"
* #app-08 "四氯化碳作業"
* #app-09 "二硫化碳作業"
* #app-10 "三氯乙烯作業"
* #app-11 "二甲基甲醯胺作業"
* #app-12 "正己烷作業"
* #app-13 "聯苯胺及其鹽類作業"
* #app-14 "鈹及其化合物作業"
* #app-15 "氯乙烯作業"
* #app-16 "苯作業"
* #app-17 "2,4-二異氰酸甲苯作業"
* #app-18 "石綿作業"
* #app-19 "砷及其化合物作業"
* #app-20 "錳及其化合物作業"
* #app-21 "黃磷作業"
* #app-22 "聯吡啶或巴拉刈作業"
* #app-23 "粉塵作業"
* #app-24 "鉻酸及其鹽類作業"
* #app-25 "鎘及其化合物作業"
* #app-26 "鎳及其化合物作業"
* #app-27 "乙基汞化合物作業"
* #app-28 "溴丙烷作業"
* #app-29 "1,3-丁二烯作業"
* #app-30 "甲醛作業"
* #app-31 "銦及其化合物作業"
* #app-32 "汞及其無機化合物作業"
* #app-33 "苯乙烯作業"  // 115.06.26 新增
* #app-34 "甲苯作業"  // 115.06.26 新增
* #app-35 "二甲苯作業"  // 115.06.26 新增

ValueSet: VS_Appendix10Operation
Id: VS-Appendix10-Operation
Title: "附表十特別危害健康作業值集（35 項）"
Description: "包含《勞工健康保護規則》附表十 35 項法定具名作業之代碼。"
* ^experimental = false
* include codes from system CS_Appendix10Operation
