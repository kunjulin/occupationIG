---
name: fhir-tx-audit
description: Audit and fix LOINC/SNOMED codes in this FHIR IG using a real terminology server (tx.fhir.org). Use when the user asks to verify codes, fix "Wrong Display Name"/"Unknown code" errors from qa.txt, run a tx-backed build, or clean up the IG for submission (送審). Encodes the critical rule that a tx display mismatch may mean the code is WRONG, not just its display.
---

# FHIR IG terminology audit (tx.fhir.org)

Verify and correct LOINC/SNOMED codes in `input/fsh/**` against a live terminology
server, then fix only what is provably safe.

## Three things every code must pass

Checking only (a) is the single most common way wrong codes survive into a published IG.

| # | Check | How | Why it is not enough alone |
|:--|:--|:--|:--|
| (a) **Existence** | `$validate-code`, or the IG Publisher build | A code that exists but means something else still passes |
| (b) **Status** | `$lookup` → `STATUS` property | `DEPRECATED`/`DISCOURAGED` codes exist and validate fine |
| (c) **Semantic match of the display** | `$lookup` → official `display`, compared against what the IG says the code means | **This is the only check that catches a wrong code** |

**The build does not perform (c) for ValueSet members.** IG Publisher validates that a
ValueSet's `concept.code` exists in the CodeSystem, but does **not** verify that the
accompanying `concept.display` matches the code's real meaning. A ValueSet can therefore
contain 15 allergen-panel codes labelled "pure tone audiometry 500 Hz" and still build
with 0 errors. This happened in this repo (see the `21104-5` series below).

Run a display audit over **every** code the IG uses whenever codes are added or inherited
from a human-authored list — not just the ones the build complains about.

## The one rule that matters

An IG Publisher `Wrong Display Name` error has **two different root causes**. Telling
them apart is the whole job — mechanically pasting tx's display into the FSH will
silently corrupt semantics in the second case.

| Cause | Symptom | Correct action |
|:--|:--|:--|
| **(a) Display imprecision** | tx's display is the *same concept*, just more precise (case, method suffix, wording) | Safe: update the display string |
| **(b) Wrong code** | tx's display is a *different concept* than what the IG uses the code for | **Do NOT touch the display.** The code itself is wrong → find a replacement code, or escalate |

Real examples found in this repo:
- The `21104-5` "pure tone audiometry" series: **15 codes, all wrong**. Their real meanings were
  deprecated allergen RAST panels (soybean dust IgE, beef IgG, blueberry IgG), Borrelia antibodies,
  an enzyme, and cadmium/bismuth assays. They had been added from a human-authored note claiming
  "hospital LIS also uses the 21104-5 audiometry series". Every one built with 0 errors for weeks.
- `49154-8`, labelled "Uric acid in Blood" and used as an acceptable variant, is really
  **Rickettsia conorii IgG antibody titre**.
- `1558-6` IG "Fasting **G**lucose…" vs tx "Fasting **g**lucose…" → **(a)**, fixed.
- `3048-6` IG uses as *HDL cholesterol*, tx says **Triglyceride --fasting** → **(b)**. Changing the
  display would have relabelled the HDL field as triglycerides and it would then *pass validation*.
- `22326-3` IG uses as *HBsAg*, tx says **Hepatitis C virus 5-1-1 Ab** → **(b)**; correct code was
  `5195-3` (a one-digit typo from the intended `5196-1` family).

**Never guess a replacement code.** Search tx, then confirm with `$validate-code`, then apply.
If no clean replacement exists, stop and report it for a human decision.

## Environment (required — this machine)

Java, Ruby/Jekyll and Node all need help getting through the local Avast TLS interception.
Set these before any build:

```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-21.0.11.10-hotspot"
$env:Path = "C:\Ruby33-x64\bin;$env:JAVA_HOME\bin;$env:Path"
$env:NODE_OPTIONS = "--use-system-ca"
$env:JAVA_TOOL_OPTIONS = "-Djavax.net.ssl.trustStoreType=Windows-ROOT"
```

- `--use-system-ca` / `Windows-ROOT` make Node and Java trust the Avast root cert.
- Ruby needs the Avast root appended to `C:\Ruby33-x64\bin\etc\ssl\cert.pem` (already done;
  redo after a Ruby reinstall).

## Running the audit build

`_genonce.bat` is the **offline** build (`-tx n/a`) — keep it that way so builds work without
network. For an audit, invoke the publisher directly with a real tx server:

```bash
java -Xmx4096m -jar input-cache/publisher.jar -ig ig.ini -no-sushi -tx https://tx.fhir.org/r4
```

Run `npx fsh-sushi .` first if FSH changed. Expect ~6–9 minutes.

Offline (`-tx n/a`) reports ~12 `No server available` errors and **hides all code problems**;
a tx build replaces those with the real findings. A rising error count after switching to tx is
expected and is the point of the exercise.

## Classifying results

```bash
# distinct error shapes
grep -E "^ERROR:" output/qa.txt | sed -E 's/[0-9]+-[0-9]+/<C>/g' | sed 's/.*: //' | sort | uniq -c | sort -rn

# invalid LOINC codes
grep -E "^ERROR:" output/qa.txt | grep -oE "Unknown code '[0-9]+-[0-9]+' in the CodeSystem 'http://loinc.org'" | grep -oE "[0-9]+-[0-9]+" | sort -u

# invalid SNOMED codes
grep -E "^ERROR:" output/qa.txt | grep -oE "Unknown code '[0-9]+' in the CodeSystem 'http://snomed.info/sct'" | grep -oE "[0-9]+" | sort -u

# codes with display mismatches
grep -E "Wrong Display Name" output/qa.txt | grep -oE "for http://loinc.org#[0-9]+-[0-9]+" | grep -oE "[0-9]+-[0-9]+" | sort -u
```

Then locate each code's usage: `grep -rn "<code>" input/fsh --include=*.fsh`

## Querying the terminology server

Look up what a code actually means:

```bash
curl -sk -G "https://tx.fhir.org/r4/CodeSystem/\$validate-code" \
  --data-urlencode "url=http://loinc.org" --data-urlencode "code=3048-6" \
  | python -c "import sys,json;d=json.load(sys.stdin);print({p['name']:p.get('valueString',p.get('valueBoolean')) for p in d.get('parameter',[])})"
```

Confirm a display is accepted (this is the decisive test — `result:true` means safe to use):

```bash
curl -sk -G "https://tx.fhir.org/r4/CodeSystem/\$validate-code" \
  --data-urlencode "url=http://loinc.org" --data-urlencode "code=89015-2" \
  --data-urlencode "display=Pure tone air conduction threshold audiometry panel"
```

Search for a replacement code:

```bash
curl -sk -G "https://tx.fhir.org/r4/ValueSet/\$expand" \
  --data-urlencode "url=http://loinc.org/vs" \
  --data-urlencode "filter=Cholesterol in HDL" --data-urlencode "count=12" \
  | grep -oE '"(code|display)" ?: ?"[^"]*"' | paste - - | grep -viE "LP|Deprecated"
```

Filter out `LP…` (parts, not orderable codes) and anything marked `Deprecated`.
SNOMED: use `url=http://snomed.info/sct?fhir_vs`.

Add `sleep 1` between calls in loops. If a batch of results looks implausible, re-verify the
odd ones individually before acting — but note that in this repo, implausible-looking tx
displays turned out to be **correct**, exposing genuinely wrong codes.

## Applying fixes

Prefer a small Python script over `sed`/`perl` — LOINC displays contain `/`, `[`, `]`, `--`
and Chinese comments sit on the same lines, which breaks shell quoting:

```python
import re, io, glob
fixes = {"5804-0": "Protein [Mass/volume] in Urine by Test strip"}
for p in glob.glob("input/fsh/**/*.fsh", recursive=True):
    s = o = io.open(p, encoding="utf-8").read()
    for code, disp in fixes.items():
        s = re.sub(r'(LNC#'+re.escape(code)+r' )"[^"]*"', lambda m: m.group(1)+'"'+disp+'"', s)
    if s != o:
        io.open(p, "w", encoding="utf-8").write(s)
```

Always also update, in the same change:
- **ConceptMap** `.code` / `.display` / `.target[0].display` entries for the same code.
- **Chinese comments** that the correction just invalidated (e.g. a code commented
  `// Acceptable: 全血法` that tx proves is Serum/Plasma). A stale comment contradicting the
  code is worse than no comment.
- `input/pagecontent/terminology.md` §4 cross-reference table and any `general-exam.md` mentions.

Verify the file is still valid UTF-8 after scripted edits (Chinese must not become mojibake).

## Scope and escalation

Work outward from what matters: **Core 檢驗子集 (`VS-CoreDataset`) first** — it is the
regulator upload set and the submission-critical layer — then vitals/vision/hearing, then the
long tail.

Escalate rather than decide alone when:
- a **(b) wrong code** has no clean replacement in LOINC/SNOMED;
- a SNOMED code is inactive with no stated successor;
- fixing would change a **preferred/acceptable designation** or a documented clinical rationale
  (e.g. tx showing `2089-1` has no "Direct assay" in its name undermines calling it the direct-assay
  preferred code — that is a modelling decision, not a typo).

Report these as a short list of "舊碼 → 建議新碼 / 待決", with the tx evidence for each.

## Closing the loop

Re-run SUSHI (must stay 0-Error) and the tx build; report the error count delta and confirm the
targeted layer is clean, e.g.:

```bash
for c in 2093-3 1558-6 2085-9; do n=$(grep -E "^ERROR:" output/qa.txt | grep -c "#$c\b\|'$c'"); [ "$n" -gt 0 ] && echo "$c : $n"; done
```

Commit per coherent batch, stating in the message which codes were replaced, which displays were
corrected, the error-count delta, and what remains for human decision.

## Auditing displays across the whole IG

Extract every `code`/`display` pair the IG asserts (FSH ValueSets, profile fixed codes,
ConceptMap `element.display` and `target.display`, examples), `$lookup` each code, and
compare token overlap between the asserted display and the official one:

```python
STOP = set("in of by the a and or with at to for [] / -- volume mass presence".split())
def toks(s):
    s = re.sub(r'[\[\]\(\),.:;/#\-]', ' ', s.lower())
    return set(w for w in s.split() if w and w not in STOP and not w.isdigit())
overlap = len(toks(ig) & toks(official)) / max(1, min(len(toks(ig)), len(toks(official))))
```

Triage by overlap: `>=0.7` matches, `0.4–0.7` needs a human look (usually naming variants such as
"Aminolevulinic acid" vs "Delta aminolevulinate"), `<0.4` is a probable wrong code. Always read the
low scorers yourself — the metric ranks candidates, it does not decide.

Write the result to a CSV (`code, ig_display, loinc_display, loinc_status, overlap, verdict, files`)
so the finding is reviewable and re-runnable, and record `STATUS` in the same pass to catch
deprecated/discouraged codes for free.

Practical notes: on Windows, decode `curl` output explicitly
(`subprocess.run(..., capture_output=True)` then `.decode("utf-8","replace")`) — the default cp950
decoding fails on LOINC's multilingual fields and silently loses every result. Set
`PYTHONIOENCODING=utf-8` before printing CJK or emoji. Cache `$lookup` responses to a JSON file so
re-runs are cheap.
