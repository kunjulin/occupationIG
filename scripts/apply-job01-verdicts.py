#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把 JOB-01 之 A／B 類人工判定寫入分流 CSV。

判定依據為 docs/optimization/evidence/lookup-2026-07-26.json（tx.fhir.org 之
$lookup 實測結果，74/74 成功）與各碼於本 IG 之標示比對。

三種 action：
  confirmed-wrong  官方六軸與 IG 標示在分析物或檢體上根本不同 → 確認用錯碼。
                   本階段**不填 replacement_code**——替代碼必須經 $expand 搜尋
                   並以 $lookup 覆核後才可填入，見 RUNBOOK §2b。
  rewrite-display  代碼正確，僅官方用語與 IG 標示不同 → 以官方 display 覆寫。
  needs-clinical   須由檢驗科或職業醫學科決定，AI 不得代為決定。

執行：python3 scripts/apply-job01-verdicts.py
"""
import csv
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# 由「乾淨的分流 CSV」＋「已取得之 lookup JSON」重新合成，不需再次查詢 tx。
CSV_IN = os.path.join(ROOT, 'docs/optimization/evidence/display-triage-2026-07-26.csv')
LOOKUP_JSON = os.path.join(ROOT, 'docs/optimization/evidence/lookup-2026-07-26.json')
CSV_OUT = os.path.join(ROOT, 'docs/optimization/evidence/display-triage-with-lookup.csv')
LOOKUP_COLS = ['lookup_display', 'lookup_component', 'lookup_property', 'lookup_system',
               'lookup_scale', 'lookup_method', 'lookup_status', 'lookup_error']
VERIFIED_BY = 'lookup=tx.fhir.org(2026-07-26); 判定=Claude Opus 5（待人工覆核）'
VERIFIED_DATE = '2026-07-26'

W = 'confirmed-wrong'
R = 'rewrite-display'
C = 'needs-clinical'

# code -> (action, rationale)
V = {
    # ── 確認用錯碼：分析物或檢體根本不同 ──────────────────────────────
    '14390-9': (W, '分析物與檢體皆不同：IG 標血清 ALT（UV with P5P），官方為 Amylase in Dialysis fluid（透析液澱粉酶）。需改為 ALT with P-5\'-P in Ser/Plas。'),
    '14409-7': (W, '檢體不同：IG 標 Serum or Plasma，官方為 Pleural fluid（胸膜液）。分析物 AST 相同但檢體錯誤。'),
    '19199-9': (W, '檢體不同：IG 標 Serum or Plasma，官方為 Semen（精液）。健檢之 PSA 應為血清總 PSA。'),
    '1783-0':  (W, '檢體不同：IG 標 Serum or Plasma，官方為 Blood（全血）。ALP 健檢報告為血清值。'),
    '46986-6': (W, '分析物不同：IG 標 VLDL-C（計算法），官方為 Cholesterol in VLDL 3——VLDL 之次分群，非總 VLDL 膽固醇。'),
    '20627-6': (W, '分析物完全不同：IG 標「Color of Urine（尿液顏色）」，官方為「Turbidity（濁度）of Urine Qualitative」。顏色與濁度為兩個不同檢驗項目。'),
    '13705-9': (W, '檢體不同：IG 標 Urine（隨機尿），官方為 24 hour Urine（24 小時尿）。健檢之白蛋白／肌酸酐比值採隨機單次尿，非 24 小時收集尿，臨床意義與採檢方式皆不同。'),
    '26505-8': (W, '概念不同：IG 標 Hypersegmented neutrophils（過度分葉核），官方為 Segmented neutrophils（分葉核）。兩者為不同之血液形態學所見。'),
    '26508-2': (W, '概念不同：IG 標 Neutrophils by Manual count（總嗜中性球），官方為 Band form neutrophils（帶狀核）。'),
    '26511-6': (W, '概念不同：IG 標 Neutrophils.segmented（分葉核），官方為 Neutrophils（總嗜中性球）。與 26505-8／26508-2 合觀，嗜中性球分類整組錯置，須一併重排。'),

    # ── 須臨床／檢驗科決定 ───────────────────────────────────────────
    '42221-2': (C, '量綱不符：IG 標 Mass/volume，官方為 Moles/volume。尿錳為附表十錳作業之指標。須確認院內 LIS 以 µg/L（質量）或 µmol/L（莫耳）報告——前者須換碼，後者須改單位宣告。決定者：檢驗科。'),
    '34304-6': (C, '量綱不符（同 42221-2）：尿氟，IG 標 Mass/volume，官方為 Moles/volume。決定者：檢驗科。'),
    '19177-5': (C, '量綱不符：IG 標 Mass/volume，官方為 Moles/volume。AFP 國內慣以 ng/mL（質量濃度）報告，若確認如此則本碼為誤用，須換質量濃度碼。決定者：檢驗科。'),
    '2428-1':  (C, '量綱不符（反向）：IG 標 Moles/volume，官方為 Mass/volume。同半胱胺酸國內慣以 µmol/L 報告，若確認如此則本碼為誤用。決定者：檢驗科。'),
    '22322-2': (C, '⚠️ 與 5193-8 疑似對調：本碼官方為 [Presence]（定性），IG 卻標 Units/volume；5193-8 官方為 [Units/volume]，IG 卻標 Presence。兩碼皆為 B 型肝炎表面抗體，標示恰好互換。須確認院內報定性或定量後一併重排。決定者：檢驗科。'),
    '5193-8':  (C, '⚠️ 與 22322-2 疑似對調（詳見該碼）。本碼官方為 [Units/volume] in Ser/Plas by Immunoassay，IG 標 [Presence]。決定者：檢驗科。'),
    '5176-3':  (C, '量表不符：IG 標 [Presence]（定性），官方為 [Units/volume] by Immunoassay（定量）。須確認幽門螺旋桿菌 IgG 報定性或定量。決定者：檢驗科。'),
    '9633-9':  (C, '量表不符：IG 標 [Presence]（定性），官方為 [Titer] by Immunofluorescence（效價）。須確認 EBV VCA IgA 報定性或效價。決定者：檢驗科。'),
    '5792-7':  (C, '量表不符：IG 標 [Presence]，官方為 [Mass/volume]。試紙尿糖若採定性判讀，本碼為誤用（定性另有專碼）。與 5797-6 同一決策。決定者：檢驗科。'),
    '5797-6':  (C, '量表不符（同 5792-7）：試紙尿酮，IG 標 [Presence]，官方為 [Mass/volume]。決定者：檢驗科。'),
    '62292-8': (C, '分析物範圍不同：IG 標 25-hydroxyvitamin D3（僅 D3），官方為 25-OH-D3＋25-OH-D2（總量）。須確認健檢報「總 25-OH 維生素 D」或「僅 D3」。決定者：檢驗科。'),
    '70028-6': (C, '概念可能不同：IG 標 Megakaryocytes（巨核細胞），官方為 Megakaryocytic nuclei（巨核細胞核）by Manual count。須確認所欲記錄之形態學概念。決定者：檢驗科。'),
    '33914-3': (C, 'LOINC STATUS = DISCOURAGED（本次 $lookup 74 碼中唯一非 ACTIVE 者）。MDRD 公式已為臨床所不建議，Core 已收 CKD-EPI 之 88293-6。須決定移除或保留。決定者：職業醫學科。'),
    '43371-4': (C, '量表不符：IG 標 [Presence] by Culture，官方為「sp identified」by Organism specific culture（鑑定出菌種，Nominal 量表）。須確認糞便培養報「有無」或「菌種」。決定者：檢驗科。'),

    # ── 尿沉渣自動化計數：9 碼同一系統性問題 ─────────────────────────
    **{code: (C, f'量綱不符（尿沉渣自動化計數 9 碼之系統性問題）：IG 標 [#/volume]，官方為 [#/area]。'
                 f'須確認院內自動尿液分析儀報「每 µL」或「每視野／面積」——前者則此 9 碼全數誤用，'
                 f'後者則僅需修正 display。9 碼為 33218-9／33219-7／33223-9／33342-7／43755-8／'
                 f'46419-8／46702-7／50235-1／53324-0，屬同一決策。決定者：檢驗科。')
       for code in ['33218-9', '33219-7', '33223-9', '33342-7', '43755-8', '46419-8', '46702-7', '50235-1', '53324-0']},

    # ── 代碼正確，僅 display 用語漂移 ────────────────────────────────
    '770-8':   (R, '同一概念之命名差異：LOINC 現行用語為 Neutrophils/Leukocytes in Blood by Automated count。'),
    '2725-0':  (R, '拼寫差異：p-Methylhippurate → Para methylhippurate。'),
    '12543-5': (R, '拼寫差異：Methylformamide → Methyl formamide。'),
    '12533-6': (R, 'IG 使用縮寫 TTCA，官方為全名 Thiazolidine-2-Thione-4-Carboxylic acid。'),
    '10913-2': (R, '拼寫與大小寫差異：Methylenebis(2-chloroaniline) → Methylene bis(2-Chloroaniline)。'),
    '10886-0': (R, '大小寫與構詞差異：Prostate specific Ag.free → Prostate Specific Ag Free。'),
    '97149-9': (R, '同一分析物之命名差異：[-2]pro-prostate specific antigen → proPSA isoform 2；官方另含 by Immunoassay。'),
    '33762-6': (R, '同一分析物之命名差異：Natriuretic peptide.proB-type N-terminal → Natriuretic peptide.B prohormone N-Terminal（NT-proBNP）。'),
    '24558-9': (R, 'IG 使用敘述式名稱，官方短名為 US Abdomen。同一檢查。'),
    '13046-8': (R, 'LOINC 現行用語：Atypical lymphocytes → Variant lymphocytes；/100 leukocytes → /Leukocytes。'),
    '19048-8': (R, '同一概念之命名差異：Erythroblasts → Nucleated erythrocytes；官方無 by Automated count 且量表為 [Ratio]。'),
    '30441-0': (R, '詞序差異：Abnormal monocytes → Monocytes Abnormal；/100 leukocytes → /Leukocytes。'),
    '34921-7': (R, '詞序差異：Plasmacytoid lymphocytes → Lymphocytes Plasmacytoid。'),
    '30428-7': (R, '同一分析物：MCV [Entitic volume] by calculation → MCV [Entitic mean volume] in Red Blood Cells。'),
    '786-4':   (R, '同一分析物：MCHC，官方 display 補上 [Entitic Mass/volume] 與 in Red Blood Cells。'),
    '787-2':   (R, '同一分析物：MCV，官方 display 補上 [Entitic mean volume] 與 in Red Blood Cells。'),
    '788-0':   (R, '同一分析物 RDW：Erythrocyte distribution width [Ratio] → Erythrocyte [DistWidth] in Blood。'),
    '33863-2': (R, '檢體描述收斂：IG 標 Serum, Plasma or Blood，官方為 Serum or Plasma。同一分析物 Cystatin C。'),
    '59261-8': (R, '同一分析物 HbA1c：官方 display 為 standardized per IFCC-RMP for CDT in Blood。'),
    '10834-0': (R, '檢體描述差異：IG 標 Serum or Plasma，官方為 Serum。球蛋白為血清計算值，官方描述較精確。'),
    '9830-1':  (R, '命名差異：Cholesterol/Cholesterol in HDL → Cholesterol.total/Cholesterol in HDL。同一比值。'),
    '3026-2':  (R, '命名差異：Thyroxine (T4) total → Thyroxine (T4)。同一分析物。'),
    '3053-6':  (R, '命名差異：Triiodothyronine (T3) total → Triiodothyronine (T3)。同一分析物。'),
    '8099-4':  (R, '命名差異：Thyroid peroxidase Ab → Thyroperoxidase Ab（anti-TPO）。'),
    '51913-2': (R, '官方 display 較精確：Hepatitis A virus Ab → Hepatitis A virus IgG+IgM Ab；檢體 Serum。同一總抗體檢驗。'),
    '5403-1':  (R, '檢體與方法之描述差異：官方為 in Serum by Immunoassay。同一分析物 VZV IgG。'),
    '7962-4':  (R, '檢體描述差異：官方為 in Serum。同一分析物 Measles IgG。'),
    '56888-1': (R, '命名差異：HIV 1 and 2 Ag and Ab panel → HIV 1+2 Ab+HIV1 p24 Ag by Immunoassay。同一第四代複合檢驗。'),
    '12453-7': (R, '詞序與方法差異：Amorphous phosphate crystals → Phosphate crystals amorphous by Light microscopy。'),
    '12454-5': (R, '詞序與方法差異：Amorphous urate crystals → Urate crystals amorphous by Light microscopy。'),
    '20456-0': (R, '構詞差異：Fungi yeast-like → Fungi.yeastlike；官方另含 by Light microscopy。'),
    '5766-1':  (R, '命名差異：Ammonium acid urate → Ammonium urate crystals by Light microscopy。'),
    '5788-5':  (R, '官方 display 補充語：Oval fat bodies → Oval fat bodies (globules)。同一項目。'),
    '5814-9':  (R, '同一結晶之不同稱法：Calcium magnesium ammonium phosphate → Triple phosphate crystals（磷酸銨鎂結晶之慣用名）by Light microscopy。'),
    '2335-8':  (R, '檢體描述差異：官方為 Stool from gastrointestinal。同一糞便潛血項目。'),
    '10701-1': (R, '量表用語差異：[Presence] in Stool by Concentration method → identified by Concentration。同一寄生蟲鏡檢。'),
    '10704-5': (R, '量表用語差異：[Presence] by Microscopy → identified by Light microscopy。同一寄生蟲鏡檢。'),
    '31147-2': (R, 'IG 標示自相矛盾（[Presence] 卻附註 -- titer），官方為 [Titer] by RPR。以官方為準即可。'),
    '20621-9': (R, '量綱描述精確化：[Ratio] → [Mass Ratio]。同一白蛋白／肌酸酐比值試紙。'),
    '50551-1': (R, '⚠️ 本碼與 5770-3 在本 IG 中之 display 完全相同，但為兩個不同代碼：本碼官方為 by Automated test strip，5770-3 為 by Test strip。須確認是否兩者皆需保留；若僅需其一，另一應移除。'),
    '5770-3':  (R, '⚠️ 與 50551-1 之 IG display 完全相同（詳見該碼）。本碼官方為 Bilirubin.total [Presence] in Urine by Test strip。'),
}


def main():
    for p in (CSV_IN, LOOKUP_JSON):
        if not os.path.exists(p):
            sys.exit(f'找不到 {p}')

    with open(CSV_IN, encoding='utf-8-sig', newline='') as f:
        rows = list(csv.DictReader(f))
    fields = list(rows[0].keys()) + LOOKUP_COLS

    with open(LOOKUP_JSON, encoding='utf-8') as f:
        lk = {r['code']: r for r in json.load(f)['results']}

    for r in rows:
        hit = lk.get(r['code'])
        a = (hit or {}).get('axes', {})
        r['lookup_display'] = (hit or {}).get('display', '')
        r['lookup_component'] = a.get('component', '')
        r['lookup_property'] = a.get('property', '')
        r['lookup_system'] = a.get('system', '')
        r['lookup_scale'] = a.get('scale', '')
        r['lookup_method'] = a.get('method', '')
        r['lookup_status'] = a.get('status', '')
        r['lookup_error'] = (hit or {}).get('error', '')

    stats = {W: 0, R: 0, C: 0, 'untouched': 0}
    for r in rows:
        v = V.get(r['code'])
        if not v or r['class'] not in ('A', 'B'):
            stats['untouched'] += 1
            continue
        action, rationale = v
        r['action'] = action
        r['rationale'] = rationale
        r['replacement_code'] = ''      # 一律留空：替代碼須經 $expand 搜尋＋$lookup 覆核
        r['verified_by'] = VERIFIED_BY
        r['verified_date'] = VERIFIED_DATE
        stats[action] += 1

    with open(CSV_OUT, 'w', encoding='utf-8', newline='') as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(rows)

    print(f'confirmed-wrong : {stats[W]}')
    print(f'needs-clinical  : {stats[C]}')
    print(f'rewrite-display : {stats[R]}')
    print(f'未處理（C 類等）: {stats["untouched"]}')
    print(f'\n已寫回 {os.path.relpath(CSV_OUT, ROOT)}')
    missing = set(V) - {r['code'] for r in rows}
    if missing:
        print(f'⚠️ 判定表中有 CSV 找不到的代碼：{sorted(missing)}')


if __name__ == '__main__':
    main()
