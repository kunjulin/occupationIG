#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""JOB-01 第一批：套用 7 筆 confirmed-wrong 之換碼／移除，以及嗜中性球三碼之 display 修正。

依據：docs/optimization/evidence/lookup-2026-07-26.json（74 碼 $lookup）
      ＋ 2026-07-26 之替代碼 $lookup 覆核（8 碼全部成功，display 與預期一致）

⚠️ 兩筆是「移除」而非「換碼」：
   19199-9（精液 PSA）與 1783-0（全血 ALP）之 Preferred 對應碼
   （2857-1／6768-6）**本來就已在值集中**，逕行替換會產生重複代碼。
   兩者原意皆為「Acceptable 替代碼」，但實際上根本不是替代（檢體不同），故移除。

執行：python3 scripts/apply-job01-batch1.py
"""
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
VS = os.path.join(ROOT, 'input/fsh/valuesets/VS-ExtendedDataset.fsh')
CM = os.path.join(ROOT, 'input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh')

# ── 值集：換碼（舊行片段 → 新行）────────────────────────────────────
REPLACE = [
    (
        '* LNC#14390-9 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"  // Acceptable: ALT UV',
        '* LNC#1743-4 "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5\'-P"  // Acceptable: ALT with P-5\'-P（2026-07-26 換碼，原 14390-9 實為透析液澱粉酶）',
    ),
    (
        '* LNC#14409-7 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P" // Acceptable: AST UV',
        '* LNC#30239-8 "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5\'-P" // Acceptable: AST with P-5\'-P（2026-07-26 換碼，原 14409-7 檢體為胸膜液）',
    ),
    (
        '* LNC#46986-6 "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"',
        '* LNC#13458-5 "Cholesterol in VLDL [Mass/volume] in Serum or Plasma by calculation"  // 2026-07-26 換碼，原 46986-6 實為 VLDL 3 次分群',
    ),
    (
        '* LNC#20627-6 "Color of Urine"',
        '* LNC#5778-6 "Color of Urine"  // 2026-07-26 換碼，原 20627-6 實為尿液濁度 (Turbidity)',
    ),
    (
        '* LNC#13705-9 "Albumin/Creatinine [Mass Ratio] in Urine"',
        '* LNC#9318-7 "Albumin/Creatinine [Mass Ratio] in Urine"  // 2026-07-26 換碼，原 13705-9 檢體為 24 小時尿；'
        '⚠️ 待確認：健檢 ACR 若驗微白蛋白應改用 14959-1（Microalbumin/Creatinine）',
    ),
    # ── 嗜中性球三碼：代碼正確，僅 display 錯位 ──
    (
        '* LNC#26505-8 "Hypersegmented neutrophils/100 leukocytes in Blood"',
        '* LNC#26505-8 "Segmented neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標 Hypersegmented）；'
        '⚠️ 待確認：如確需「過度分葉核」項目應另加 30450-1',
    ),
    (
        '* LNC#26508-2 "Neutrophils/100 leukocytes in Blood by Manual count" // Acceptable: Neutrophil Manual',
        '* LNC#26508-2 "Band form neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標為總嗜中性球手工計數）',
    ),
    (
        '* LNC#26511-6 "Neutrophils.segmented/100 leukocytes in Blood"',
        '* LNC#26511-6 "Neutrophils/Leukocytes in Blood"  // 2026-07-26 更正 display（原誤標 segmented）；'
        '⚠️ 待確認：如確需「手工計數」版本應另加 23761-0',
    ),
]

# ── 值集：整行移除（Preferred 碼已存在，逕行替換會重複）────────────
REMOVE_LINES = [
    '* LNC#19199-9 "Prostate specific Ag [Mass/volume] in Serum or Plasma"   // Acceptable: PSA unspecified method',
    '* LNC#1783-0 "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"                      // Acceptable: ALP unspecified',
]

# ── ConceptMap：換 source 碼 ────────────────────────────────────────
CM_REPLACE = [
    ('* group[0].element[15].code = #14409-7', '* group[0].element[15].code = #30239-8'),
    ('* group[0].element[15].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"',
     '* group[0].element[15].display = "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5\'-P"'),
    ('* group[0].element[16].code = #14390-9', '* group[0].element[16].code = #1743-4'),
    ('* group[0].element[16].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by UV with P5P"',
     '* group[0].element[16].display = "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma by With P-5\'-P"'),
    ('// AST / GOT (Acceptable: 14409-7 by UV with P5P → Preferred: 1920-8)',
     "// AST / GOT (Acceptable: 30239-8 with P-5'-P → Preferred: 1920-8)"),
    ('// ALT / GPT (Acceptable: 14390-9 by UV with P5P → Preferred: 1742-6)',
     "// ALT / GPT (Acceptable: 1743-4 with P-5'-P → Preferred: 1742-6)"),
]

# ── ConceptMap：整段移除之元素索引（其 source 碼已自值集移除）──────
CM_DROP = {17, 20}


def apply_vs():
    s = open(VS, encoding='utf-8').read()
    for old, new in REPLACE:
        if old not in s:
            sys.exit(f'✖ 值集中找不到待替換之行：\n  {old[:90]}')
        s = s.replace(old, new, 1)
    for line in REMOVE_LINES:
        if line not in s:
            sys.exit(f'✖ 值集中找不到待移除之行：\n  {line[:90]}')
        # 連同行尾換行一併移除
        s = s.replace(line + '\n', '', 1)
    open(VS, 'w', encoding='utf-8').write(s)
    print(f'值集：換碼／改 display {len(REPLACE)} 筆、移除 {len(REMOVE_LINES)} 筆')


def apply_cm():
    lines = open(CM, encoding='utf-8').read().split('\n')

    # 1) 先換 source 碼與註解
    text = '\n'.join(lines)
    for old, new in CM_REPLACE:
        if old not in text:
            sys.exit(f'✖ ConceptMap 中找不到：\n  {old[:90]}')
        text = text.replace(old, new, 1)
    lines = text.split('\n')

    # 2) 移除待刪元素之所有行，以及其上方緊鄰的註解行
    out = []
    dropped = 0
    for ln in lines:
        m = re.search(r'group\[0\]\.element\[(\d+)\]', ln)
        if m and int(m.group(1)) in CM_DROP:
            dropped += 1
            # 若上一行是該元素的說明註解，一併移除
            while out and out[-1].lstrip().startswith('//') and (
                'Acceptable' in out[-1] or 'Preferred' in out[-1]
            ):
                out.pop()
            continue
        out.append(ln)
    print(f'ConceptMap：移除 element[17]／element[20] 共 {dropped} 行')

    # 3) 重新編號——FSH 之數字索引必須連續，留缺口會導致匯出錯誤。
    #
    # ⚠️ 不可用「逐一字串替換」：無論由大到小或由小到大都會碰撞——
    #    先把 29→27 之後，再處理 27→25 時會連剛產生的 27 一併改掉。
    #    必須以單次 regex 回呼一次到位。
    text = '\n'.join(out)
    remaining = sorted({int(x) for x in re.findall(r'group\[0\]\.element\[(\d+)\]', text)})
    mapping = {old: new for new, old in enumerate(remaining)}
    text = re.sub(
        r'group\[0\]\.element\[(\d+)\]',
        lambda m: f'group[0].element[{mapping[int(m.group(1))]}]',
        text,
    )
    open(CM, 'w', encoding='utf-8').write(text)

    final = sorted({int(x) for x in re.findall(r'group\[0\]\.element\[(\d+)\]', text)})
    ok = final == list(range(len(final)))
    print(f'ConceptMap：重新編號後 {len(final)} 個元素，索引 0–{final[-1]}，'
          f'{"連續 ✅" if ok else "有缺口 ✖"}')
    if not ok:
        sys.exit('✖ 索引不連續，請檢查')


if __name__ == '__main__':
    apply_vs()
    apply_cm()
    print('\n完成。請執行 npx sushi . 確認語法，並以 CI 之 QA 閘門驗收。')
