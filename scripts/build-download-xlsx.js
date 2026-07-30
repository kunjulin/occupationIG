#!/usr/bin/env node
// 產生 input/assets/loinc-valuesets.xlsx 與 input/assets/snomed-mappings.xlsx
// —— downloads.md 對外提供之兩個「下載用試算表」。
//
// 為什麼需要這支腳本（JOB-17）：
// 這兩個檔案原本是**手工快照**（檔內時間戳 2026-07-10，早於全部 Wave/JOB），
// 已嚴重漂移：loinc-valuesets.xlsx 之 Core/Extended 分頁停在重構前的 193/123 碼，
// 且仍含 11 個已查證移除之語意錯碼（22326-3、49154-8、14390-9…）；
// snomed-mappings.xlsx 之 eGFR 一列仍為舊碼 88293-6（現行為 98979-8）。
// JOB-05 已對 fsh-source.zip 做過同類修正（改為建置時產生 + CI check:assets 攔阻），
// 但當時未涵蓋此二 xlsx。本腳本沿用同一模式補上涵蓋範圍缺口。
//
// 方向（最重要）：**以值集為真、重建下載檔**，不是拿下載檔回填值集。
//   loinc-valuesets.xlsx 之內容一律由 input/fsh/valuesets/VS-CoreDataset.fsh 與
//   VS-ExtendedDataset.fsh 逐碼產生；snomed-mappings.xlsx 之「LOINC-SNOMED 對照」分頁
//   由 input/assets/snomed-loinc-mappings.csv 產生（避免兩處各自維護）。
//
// Usage: node scripts/build-download-xlsx.js [--check]
//   --check  只比對版控中之兩檔是否與即時產生者位元組相同，不寫檔
//            （供 CI 判斷「改了值集卻忘了重建下載檔」）
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync } = require('child_process');

const repoRoot = path.resolve(__dirname, '..');
const assetsDir = path.join(repoRoot, 'input', 'assets');
const checkOnly = process.argv.includes('--check');

// zip 需可重現：固定時間戳，否則每次產生的封包位元組都不同，--check 永遠不一致。
const FIXED_MTIME = new Date('2020-01-01T00:00:00Z');

// ---------------------------------------------------------------------------
// 一、資料來源解析
// ---------------------------------------------------------------------------

// VS FSH 之區塊註解＝Section。子分節標頭形如：
//   // 1.1 高溫作業 (high-temp) — …      （Extended）
//   // 3-x 血液學                          （Extended，自 Core 移入之非上傳碼）
//   // 09001C 總膽固醇 (Total Cholesterol) — Preferred 2093-3   （Core，逐項）
// 僅「數字.數字」「數字-x」「五位數+C」開頭之整行註解算標頭；縮排續行、
// 以中文/字母/(-) 開頭之說明註解一律不算，避免把註記誤判為分節。
const SECTION_HEADER = /^\/\/\s+(\d+\.\d+\b|\d+-x\b|\d{5}C\b)/;

function parseValueSetFsh(file) {
  const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
  let section = '(未分節)';
  const rows = [];
  for (const ln of lines) {
    if (SECTION_HEADER.test(ln)) {
      section = ln.replace(/^\/\/\s+/, '').trim();
      continue;
    }
    // * LNC#<code> "<display>"  [// 行內註解]
    const m = ln.match(/^\*\s+LNC#(\S+)\s+"([^"]*)"/);
    if (m) {
      const i = ln.indexOf('//');
      const note = i === -1 ? '' : ln.slice(i + 2).trim();
      rows.push([section, m[1], m[2], note]);
    }
  }
  return rows;
}

// ---- ConceptMap 解析（JOB-21 §3.1／§3.2）------------------------------------
// 層級判定**以 ConceptMap 為準**，非以 FSH 之 // Acceptable 註解為準：
// 註解不受任何檢查、易漏（JOB-21 規劃時即查出 8 筆漏註），而 ConceptMap 是結構化資源
// 且已受 check-asset-consistency.js 之對稱差檢查。註解跟上與否由該閘門反向確保。
function parseConceptMap() {
  const f = path.join(repoRoot, 'input', 'fsh', 'codesystems', 'ConceptMap-TWHealthCheckLaboratoryMap.fsh');
  const el = {};
  for (const line of fs.readFileSync(f, 'utf8').split(/\r?\n/)) {
    const m = line.match(/^\*\s*group\[0\]\.element\[(\d+)\](\.target\[0\])?\.(code|display|equivalence|comment)\s*=\s*(.+)$/);
    if (!m) continue;
    const i = Number(m[1]);
    el[i] = el[i] || {};
    el[i][(m[2] ? 't_' : 's_') + m[3]] = m[4].trim().replace(/^"|"$/g, '').replace(/^#/, '');
  }
  const rows = Object.keys(el).map(Number).sort((a, b) => a - b).map((i) => el[i]);
  const bySource = new Map();
  const targets = new Set();
  for (const r of rows) {
    bySource.set(r.s_code, r);
    targets.add(r.t_code);
  }
  return { rows, bySource, targets };
}

// `relatedto` 之視覺區別（JOB-21 §3.5）：該值意為「需換算、數值不可直接比較」。
// 尿沉渣 9 組、eGFR（MDRD↔CKD-EPI）、血鉛皆為 relatedto——實作端若誤以為可直接比較數值，
// 會把 /HPF 當 /µL、把 MDRD 值當 CKD-EPI 值，屬可致臨床誤判之風險，故加警示字樣。
function equivalenceLabel(eq) {
  if (!eq) return '';
  if (eq === 'relatedto') return '⚠ relatedto（需換算，數值不可直接比較）';
  return eq;
}

// 最小之 CSV 解析（處理雙引號欄位內之逗號，如 "{804-5, 26464-8}"）。
function parseCsv(text) {
  const records = [];
  let field = '';
  let record = [];
  let inQuotes = false;
  for (let i = 0; i < text.length; i++) {
    const ch = text[i];
    if (inQuotes) {
      if (ch === '"') {
        if (text[i + 1] === '"') { field += '"'; i++; } else inQuotes = false;
      } else field += ch;
    } else if (ch === '"') {
      inQuotes = true;
    } else if (ch === ',') {
      record.push(field); field = '';
    } else if (ch === '\r') {
      // 忽略；換行由 \n 觸發
    } else if (ch === '\n') {
      record.push(field); field = '';
      if (record.length > 1 || record[0] !== '') records.push(record);
      record = [];
    } else field += ch;
  }
  if (field !== '' || record.length) {
    record.push(field);
    if (record.length > 1 || record[0] !== '') records.push(record);
  }
  return records;
}

function loincValuesetsSheets() {
  const header = ['Section', 'LOINC Code', 'Display Name', '層級 Tier', '歸一至 Normalizes To', 'equivalence', '備註 Note'];
  const cols = [{ width: 55 }, { width: 14 }, { width: 65 }, { width: 12 }, { width: 34 }, { width: 40 }, { width: 60 }];
  const cm = parseConceptMap();

  // 層級以 ConceptMap 為準：為 source 者 Acceptable、為 target 者 Preferred。
  // 僅當該碼於 ConceptMap 完全未出現（無 acceptable 變異碼之單一項目）時，才退而由
  // Core 之區塊註解判定——Core 之 Section 標頭本身即載明「— Preferred <code>」
  //（如「// 06003C 尿蛋白定量 — Preferred 2888-6」）。此不動搖「ConceptMap 為準」之原則：
  // ConceptMap 仍是 Acceptable／Preferred **配對**之唯一權威，區塊註解只補「無配對之 Preferred」。
  // 需要此一補充之案例：2888-6（尿蛋白定量，醫令 06003C-1）於 JOB-21 §3.4 移除其誤設之歸一後
  // 已不在 ConceptMap 中，但它確為該醫令項目之 Preferred，標為「（單一碼）」會與 Core 主表不一致。
  const SECTION_PREFERRED = /Preferred\s+(\S+)/;
  const enrich = (r) => {
    const [section, code, display, note] = r;
    const src = cm.bySource.get(code);
    let tier = '（單一碼）';
    if (src) tier = 'Acceptable';
    else if (cm.targets.has(code)) tier = 'Preferred';
    else {
      const sm = SECTION_PREFERRED.exec(section || '');
      if (sm && sm[1].replace(/[（(].*$/, '') === code) tier = 'Preferred';
    }
    return [
      section, code, display, tier,
      src ? `${src.t_code}　${src.t_display || ''}`.trim() : '',
      src ? equivalenceLabel(src.t_equivalence) : '',
      note,
    ];
  };

  const sheet = (name, file) => ({
    name,
    cols,
    rows: [header, ...parseValueSetFsh(path.join(repoRoot, 'input', 'fsh', 'valuesets', file)).map(enrich)],
  });

  const cmHeader = ['source', 'source display', 'target', 'target display', 'equivalence', 'comment'];
  const cmRows = cm.rows.map((r) => [
    r.s_code, r.s_display || '', r.t_code || '', r.t_display || '',
    equivalenceLabel(r.t_equivalence), r.t_comment || '',
  ]);

  return [
    sheet('VS-CoreDataset', 'VS-CoreDataset.fsh'),
    sheet('VS-ExtendedDataset', 'VS-ExtendedDataset.fsh'),
    {
      name: 'ConceptMap 歸一',
      cols: [{ width: 14 }, { width: 58 }, { width: 14 }, { width: 58 }, { width: 40 }, { width: 80 }],
      rows: [cmHeader, ...cmRows],
    },
  ];
}

// 「生活習慣與危害類別」分頁：5 列，源自各 profile/example 之 SNOMED 綁定，
// 屬人工策展之對照（非值集碼，無漂移風險），於此以常數維護以保可重現。
const SOCIAL_HAZARD_ROWS = [
  ['類別 Category', 'SNOMED CT Code', 'Display', '用途/來源 (FSH)'],
  ['生活習慣-嚼檳榔', '698188003', 'Chews betel quid', 'TWHA-SocialHistory-BetelNut.code (fsh/profiles/TWHA-SocialHistory.fsh)'],
  ['生活習慣-吸菸', '266919005', 'Never smoked tobacco', 'obs-smoking example (fsh/examples/examples.fsh)'],
  ['健康管理分級', '371607000', 'Classification of health status (finding)', 'TWHA-HealthManagementLevel.code'],
  ['臨場服務-危害發現', '278486003', 'Occupational health hazard (finding)', 'TWHA-Observation-ServiceFinding.code'],
  ['臨場服務-健康諮詢', '315640000', 'Occupational health counseling (procedure)', 'TWHA-Task-ServiceTask.code'],
];

function snomedMappingsSheets() {
  const csv = parseCsv(fs.readFileSync(path.join(assetsDir, 'snomed-loinc-mappings.csv'), 'utf8'));
  const nCol = csv[0].length;
  const mappingCols = Array.from({ length: nCol }, () => ({ width: 20 }));
  return [
    {
      name: '生活習慣與危害類別',
      cols: [{ width: 22 }, { width: 16 }, { width: 42 }, { width: 55 }],
      rows: SOCIAL_HAZARD_ROWS,
    },
    {
      name: 'LOINC-SNOMED 對照(核心資料集)',
      cols: mappingCols,
      rows: csv,
    },
  ];
}

// ---------------------------------------------------------------------------
// 二、最小 OOXML（.xlsx）產生器（inlineStr，固定樣式，可位元組重現）
// ---------------------------------------------------------------------------

function xmlEscape(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function colRef(n) { // 1 -> A, 27 -> AA
  let s = '';
  while (n > 0) { const r = (n - 1) % 26; s = String.fromCharCode(65 + r) + s; n = Math.floor((n - 1) / 26); }
  return s;
}

function sheetXml(sheet) {
  const cols = sheet.cols
    .map((c, i) => `<col min="${i + 1}" max="${i + 1}" width="${c.width}" customWidth="1"/>`)
    .join('');
  const body = sheet.rows.map((row, ri) => {
    const cells = row.map((val, ci) => {
      const ref = `${colRef(ci + 1)}${ri + 1}`;
      const style = ri === 0 ? ' s="1"' : '';
      if (val === '' || val == null) return `<c r="${ref}"${style}/>`;
      return `<c r="${ref}"${style} t="inlineStr"><is><t xml:space="preserve">${xmlEscape(val)}</t></is></c>`;
    }).join('');
    return `<row r="${ri + 1}">${cells}</row>`;
  }).join('');
  return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
    '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' +
    `<cols>${cols}</cols><sheetData>${body}</sheetData></worksheet>`;
}

const STYLES_XML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
  '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' +
  '<fonts count="2"><font><sz val="11"/><name val="Calibri"/></font>' +
  '<font><b/><sz val="11"/><name val="Calibri"/></font></fonts>' +
  '<fills count="2"><fill><patternFill patternType="none"/></fill>' +
  '<fill><patternFill patternType="gray125"/></fill></fills>' +
  '<borders count="1"><border/></borders>' +
  '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>' +
  '<cellXfs count="2"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>' +
  '<xf numFmtId="0" fontId="1" fillId="0" borderId="0" xfId="0" applyFont="1"/></cellXfs>' +
  '<cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>' +
  '</styleSheet>';

function xlsxParts(sheets) {
  const parts = {};
  parts['[Content_Types].xml'] = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
    '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">' +
    '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>' +
    '<Default Extension="xml" ContentType="application/xml"/>' +
    '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>' +
    '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>' +
    sheets.map((_, i) => `<Override PartName="/xl/worksheets/sheet${i + 1}.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>`).join('') +
    '</Types>';
  parts['_rels/.rels'] = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' +
    '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>' +
    '</Relationships>';
  parts['xl/workbook.xml'] = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
    '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets>' +
    sheets.map((s, i) => `<sheet name="${xmlEscape(s.name)}" sheetId="${i + 1}" r:id="rId${i + 1}"/>`).join('') +
    '</sheets></workbook>';
  parts['xl/_rels/workbook.xml.rels'] = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n' +
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' +
    sheets.map((_, i) => `<Relationship Id="rId${i + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet${i + 1}.xml"/>`).join('') +
    `<Relationship Id="rId${sheets.length + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>` +
    '</Relationships>';
  parts['xl/styles.xml'] = STYLES_XML;
  sheets.forEach((s, i) => { parts[`xl/worksheets/sheet${i + 1}.xml`] = sheetXml(s); });
  return parts;
}

// 固定之封包內檔序（zip 依此序寫入，確保可重現）。
const PART_ORDER = (n) => [
  '[Content_Types].xml',
  '_rels/.rels',
  'xl/workbook.xml',
  'xl/_rels/workbook.xml.rels',
  'xl/styles.xml',
  ...Array.from({ length: n }, (_, i) => `xl/worksheets/sheet${i + 1}.xml`),
];

function buildXlsx(outPath, sheets) {
  const parts = xlsxParts(sheets);
  const order = PART_ORDER(sheets.length);
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'xlsxgen-'));
  try {
    for (const rel of order) {
      const full = path.join(tmp, rel);
      fs.mkdirSync(path.dirname(full), { recursive: true });
      fs.writeFileSync(full, parts[rel]);
      fs.utimesSync(full, FIXED_MTIME, FIXED_MTIME);
    }
    fs.rmSync(outPath, { force: true });
    // -X 去除額外屬性（uid/gid/extended-timestamp），使同輸入在不同機器產生相同封包。
    execFileSync('zip', ['-qX', outPath, ...order], { cwd: tmp });
  } finally {
    fs.rmSync(tmp, { recursive: true, force: true });
  }
}

// ---------------------------------------------------------------------------
// 三、產生 / 檢查
// ---------------------------------------------------------------------------

const targets = [
  { file: path.join(assetsDir, 'loinc-valuesets.xlsx'), sheets: loincValuesetsSheets() },
  { file: path.join(assetsDir, 'snomed-mappings.xlsx'), sheets: snomedMappingsSheets() },
];

if (checkOnly) {
  let failed = false;
  for (const t of targets) {
    const rel = path.relative(repoRoot, t.file);
    if (!fs.existsSync(t.file)) {
      console.error(`✖ 找不到 ${rel}——請執行 npm run build:assets`);
      failed = true;
      continue;
    }
    const tmpOut = `${t.file}.check`;
    buildXlsx(tmpOut, t.sheets);
    const same = Buffer.compare(fs.readFileSync(t.file), fs.readFileSync(tmpOut)) === 0;
    fs.rmSync(tmpOut, { force: true });
    if (!same) {
      console.error(`✖ ${rel} 與當前值集/對照表不一致——請執行 npm run build:assets 後提交。`);
      failed = true;
    } else {
      const dataRows = t.sheets.reduce((n, s) => n + (s.rows.length - 1), 0);
      console.log(`OK: ${rel} 與來源一致（${t.sheets.length} 分頁，共 ${dataRows} 列資料）。`);
    }
  }
  if (failed) process.exit(1);
} else {
  for (const t of targets) {
    buildXlsx(t.file, t.sheets);
    const size = fs.statSync(t.file).size;
    const perSheet = t.sheets.map((s) => `${s.name} ${s.rows.length - 1}`).join('、');
    console.log(`已產生 ${path.relative(repoRoot, t.file)}（${perSheet}；${size} bytes）。`);
  }
}
