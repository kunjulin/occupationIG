#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""JOB-01 第二批：把 action=rewrite-display 之代碼的 display 覆寫為 LOINC 官方用語。

資料來源（皆為術語伺服器回報，非推測）：
  A/B 類 → CSV 之 lookup_display（2026-07-26 $lookup 實測，74/74 成功）
  C  類 → CSV 之 official_display（qa.txt 中 tx 回報之 "Valid display is one of ..."）

⚠️ 只處理 action=rewrite-display。**不動 needs-clinical 那 23 筆**——
   其 display 不符正是未決臨床問題的訊號，覆寫等於把問題藏起來。
   confirmed-wrong 已於第一批換碼／移除，亦不在此列。

涵蓋檔案：所有含 `LNC#` 之 FSH（值集／profile／範例）＋ ConceptMap 之
code/display 配對（含 target）。

執行：python3 scripts/apply-job01-displays.py [--dry-run]
"""
import csv
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_PATH = os.path.join(ROOT, 'docs/optimization/evidence/display-triage-with-lookup.csv')
CM_PATH = os.path.join(ROOT, 'input/fsh/codesystems/ConceptMap-TWHealthCheckLaboratoryMap.fsh')
DRY = '--dry-run' in sys.argv

# 第一批已處理，不再重複
ALREADY_DONE = {'26505-8', '26508-2', '26511-6'}


def load_targets():
    out = {}
    with open(CSV_PATH, encoding='utf-8-sig', newline='') as f:
        for r in csv.DictReader(f):
            if r['action'] != 'rewrite-display':
                continue
            if r['code'] in ALREADY_DONE:
                continue
            # lookup_display 優先（經 $lookup 覆核）；否則用 qa.txt 之官方 display
            disp = (r['lookup_display'] or r['official_display']).strip()
            if not disp:
                continue
            if '"' in disp:
                sys.exit(f'✖ {r["code"]} 之官方 display 含雙引號，需人工處理：{disp}')
            out[r['code']] = disp
    return out


def rewrite_lnc(path, targets):
    """處理 `LNC#<code> "display"` 形式（值集／profile／範例）。"""
    s = open(path, encoding='utf-8').read()
    orig = s
    hits = {}

    def repl(m):
        code, old = m.group(1), m.group(2)
        new = targets.get(code)
        if not new or new == old:
            return m.group(0)
        hits[code] = (old, new)
        return f'LNC#{code} "{new}"'

    s = re.sub(r'LNC#([0-9]+-[0-9]+)\s+"([^"]*)"', repl, s)
    if s != orig and not DRY:
        open(path, 'w', encoding='utf-8').write(s)
    return hits


def rewrite_conceptmap(targets):
    """處理 ConceptMap：`....code = #<code>` 之後緊隨同前綴之 `....display = "..."`。"""
    lines = open(CM_PATH, encoding='utf-8').read().split('\n')
    hits = {}
    pending = {}  # prefix -> code

    for i, ln in enumerate(lines):
        mc = re.match(r'(\* group\[\d+\]\.element\[\d+\](?:\.target\[\d+\])?)\.code = #([0-9]+-[0-9]+)\s*$', ln)
        if mc:
            pending[mc.group(1)] = mc.group(2)
            continue
        md = re.match(r'(\* group\[\d+\]\.element\[\d+\](?:\.target\[\d+\])?)\.display = "([^"]*)"\s*$', ln)
        if md:
            prefix, old = md.group(1), md.group(2)
            code = pending.get(prefix)
            if code:
                new = targets.get(code)
                if new and new != old:
                    lines[i] = f'{prefix}.display = "{new}"'
                    hits.setdefault(code, []).append((old, new))
    if hits and not DRY:
        open(CM_PATH, 'w', encoding='utf-8').write('\n'.join(lines))
    return hits


def main():
    targets = load_targets()
    print(f'待覆寫 display 之代碼：{len(targets)} 個'
          f'{"（--dry-run，不寫檔）" if DRY else ""}\n')

    fsh_files = []
    for base, _, names in os.walk(os.path.join(ROOT, 'input/fsh')):
        for n in names:
            if n.endswith('.fsh'):
                fsh_files.append(os.path.join(base, n))

    touched = {}
    total = 0
    for p in sorted(fsh_files):
        if os.path.abspath(p) == os.path.abspath(CM_PATH):
            continue
        h = rewrite_lnc(p, targets)
        if h:
            rel = os.path.relpath(p, ROOT)
            print(f'{rel}: {len(h)} 筆')
            total += len(h)
            touched.update(h)

    cm = rewrite_conceptmap(targets)
    if cm:
        n = sum(len(v) for v in cm.values())
        print(f'{os.path.relpath(CM_PATH, ROOT)}: {n} 筆（{len(cm)} 個代碼）')
        total += n
        for c in cm:
            touched.setdefault(c, cm[c][0])

    print(f'\n合計覆寫 {total} 處，涉及 {len(touched)} 個代碼')

    missing = sorted(set(targets) - set(touched))
    if missing:
        print(f'\n⚠️ 有 {len(missing)} 個代碼未在任何 FSH 中找到（或 display 已相符）：')
        for c in missing:
            print(f'    {c}  → {targets[c][:70]}')
        print('  請確認這些代碼是否確實存在於本 IG——分流表來自 qa.txt，')
        print('  若代碼已於先前批次移除則屬正常。')


if __name__ == '__main__':
    main()
