# JOB-28｜TWCR_SF 改為正式相依：刪除 9 個本地 stub，G-5 結案

| 欄位 | 內容 |
|:--|:--|
| **優先序** | **P1**（治理正確性：本 IG 不應自行定義他方命名空間下的資源） |
| **類別** | 相依治理／術語 |
| **預估** | S–M（1 人日） |
| **主要影響檔案** | 刪除 `input/fsh/codesystems/TWCRSF-mocks.fsh`、`sushi-config.yaml`（`dependencies`／移除 `special-url`）、新增 `scripts/check-dependencies.js`、`.github/workflows/build-ig.yml`、`input/fsh/valuesets/VS-CoreUploadSet.fsh`（描述修正） |
| **緣起** | 2026-08-20 因國民健康署詢問嚼檳榔欄位之代碼來源，重新查證上游可用性，發現先前判定之探測範圍不足 |
| **狀態** | ✅ **已執行（v0.3.0，2026-08-20）**——待 CI 實測驗證，見 §6 |

---

## 0. 一句話結論

**上游 TWCR_SF 其實是可用的，先前判定不成立。** JOB-10（2026-07-28）探測了三個 package
registry 與 `hapi.fhir.tw` canonical，兩者皆 404，據以走路徑 B（本地 stub）。
**該判定就其探測範圍而言正確，惟未涵蓋 IG 站台本身**——TWCR_SF 發佈於
`mitw.dicom.org.tw`，`hapi.fhir.tw` 僅為其 canonical 命名空間，而 **canonical 本即不要求可解析**。
本 JOB 改走路徑 A，刪除全部 stub。

---

## 1. 重新查證結果（2026-08-20）

| 探測對象 | 結果 |
|:--|:--|
| IG 站台 `https://mitw.dicom.org.tw/IG/TWCR_SF/` | **可用**，v0.1.1（2024-08-01 建置） |
| `package.tgz` | **HTTP 200**，734 KB，`application/gzip` |
| `ImplementationGuide-fhir.TWCRSF.json` | `packageId = fhir.TWCRSF`、`version = 0.1.1`、`status = active`、`fhirVersion = 4.0.1` |
| 授權 | **CC0-1.0**（無授權障礙） |
| 上游 CodeSystem（`sf-BetNutChewAmount`） | `status = active`、`experimental = false`、`content = complete`、**94 個 concept** |
| 本地 stub 同一 CodeSystem | **94 個 concept**——**完全一致** |
| package registry（`fhir.twcrsf`／`fhir.TWCRSF`） | **大小寫皆仍 404**（未上架） |

### 1.1 兩項降低風險之關鍵事實

1. **代碼集一致（94 = 94）**——切換不改變任何範例之有效性。原 G-5 所警示之
   「上游若發佈與 stub 內容不同的定義將產生衝突」未實現。
2. **上游非 experimental**——本 IG 引用該命名空間所產生之 experimental 提示應可消除。
   實際筆數以 CI 實測為準（`qa-baseline.json` 之 `Reference to experimental CodeSystem
   https://hapi.fhir.tw` 現為 15 筆）。

### 1.2 先前判定的檢討

JOB-10 之結論寫為「上游**既無套件、亦不服務該命名空間下的這些資源**」。
前半句至今仍成立（registry 確實無此套件）；後半句則混淆了兩件事：

- **canonical 是識別碼，不是下載位址。** FHIR 規範不要求 canonical URL 可解析。
- **IG 的實際發佈站台可以在任何網域。** 探測 canonical 得到 404，不足以推論 IG 不存在。

> **可推廣的教訓**：判定外部相依是否可用時，除 registry 與 canonical 外，
> **應一併搜尋該 IG 之發佈站台**。已納入本 JOB §5 之閘門說明。

---

## 2. 變更內容

| 項目 | 變更 |
|:--|:--|
| `dependencies` | 新增 `fhir.TWCRSF: {version: 0.1.1, uri: https://hapi.fhir.tw/fhir/ImplementationGuide/fhir.TWCRSF}` |
| `input/fsh/codesystems/TWCRSF-mocks.fsh` | **整檔刪除**（5 CodeSystem ＋ 4 ValueSet） |
| `parameters.special-url` | **整段移除**（原 9 條 `hapi.fhir.tw` 例外） |
| `input/fsh/aliases.fsh` | **不變**——別名指向 canonical，切換後 canonical 相同 |
| `input/fsh/profiles/TWHA-SocialHistory.fsh` | **不變**——綁定寫法與 canonical 均相同 |
| `VS-CoreUploadSet.fsh` 描述 | 修正（見 §3） |

> **範例與 profile 皆無須修改**，是本次切換成本低的主因：別名以 canonical 表達，
> 而 canonical 在 stub 與上游之間是同一個字串。

---

## 3. 附帶修正：`VS-CoreUploadSet` 描述引用了不存在的 extension

原描述載明：

> 嚼檳量／嚼檳月數屬本地 Extension（`ext-betelnut-quantity`），無國際碼，於文件註記。

兩處皆誤：

1. **`ext-betelnut-quantity` 不存在**——本 IG 之 11 個 extension 中並無此項。
2. **並非「本地 Extension」承載**——實際由 TWCR_SF 之 component ＋ 值集承載
   （`sf-BetNutChewAmount`／`sf-BetNutChewYear`／`sf-BetNutChewQuit`，**required 綁定**）。

已改寫為正確敘述，並補上一項對外說明時需注意的差異：**上游以「年」計
（戒嚼檳榔年），與吸菸之戒除「月數」（`LNC#63632-4`）單位不同。**

> ⚠️ 此類錯誤 `check-pagecontent-refs.js` 抓不到——它只掃 `pagecontent` 內文，
> 不掃 FSH 之 `Description`。目前無自動化防護，屬已知缺口。

---

## 4. CI 取得套件之方式

套件未上架 registry，故 CI 自 IG 站台取得：

```yaml
- name: Fetch TWCR_SF package
  env:
    TWCRSF_VERSION: '0.1.1'
    TWCRSF_URL: 'https://mitw.dicom.org.tw/IG/TWCR_SF/package.tgz'
```

要點：

- 置於 `Cache FHIR packages` **之後**，快取命中時下載為 no-op（先檢查目錄是否存在）。
- 解至 `~/.fhir/packages/fhir.TWCRSF#0.1.1`，即標準 FHIR 套件快取路徑。
- **下載後驗證 `package.json` 之 `name` 與 `version` 與預期相符**，
  避免取到錯誤頁或上游改版後的內容而不自知。

### 4.1 大小寫：SUSHI 會把套件 id 正規化為小寫（首次 CI 實測，run 32346874349）

上游 `package.json` 之 `name` 為 **`fhir.TWCRSF`**（含大寫），`sushi-config.yaml` 之相依鍵
亦照此宣告。但 SUSHI 於載入時印出

```
warn  fhir.TWCRSF contains uppercase characters, which is discouraged.
      SUSHI will use fhir.twcrsf as the package name.
```

並**只到 `~/.fhir/packages/fhir.twcrsf#0.1.1` 查找**。首次 CI 僅解至原大小寫之目錄，
SUSHI 遂判定快取未命中，回頭連 registry——該套件未上架，必然 404：

```
info  Attempting to download fhir.twcrsf#0.1.1 from https://packages.fhir.org/...
error Failed to load fhir.twcrsf#0.1.1: Failed to download from the registry
```

SUSHI 以 `1 Error` 結束（exit 1），建置在 IG Publisher 之前即中止。

**處置**：兩種大小寫之目錄都提供同一份套件——小寫供 SUSHI 查找，原大小寫保留以對應
上游宣告之 `name` 與 `sushi-config.yaml` 之相依鍵。以複本而非符號連結提供，
避免快取打包／還原與套件管理器對連結之處理差異。步驟結尾驗證兩者皆就位：
**SUSHI 找不到就會回頭連 registry，而該套件未上架，必然失敗**——與其讓它在
下一步以較難判讀的形式爆掉，不如在取得階段就明講缺了哪個目錄。

> ⚠️ 此為**取得步驟之缺陷，非「上游不可用」**。站台下載與 `name`／`version` 驗證
> 於同一次 CI 均已通過（§6 第 1 項達標）。依 §6 之處置原則，正確修法是修取得步驟，
> **不得還原 stub**。

---

## 5. 新增閘門 `scripts/check-dependencies.js`

| 規則 | 判定 | 失敗行為 |
|:--|:--|:--|
| **D-1** | `dependencies` 須宣告 `fhir.TWCRSF` | `exit 1` |
| **D-2** | FSH 中不得以 `^url` 自行定義 `https://hapi.fhir.tw/` 命名空間下的資源 | `exit 1` |
| **D-3** | `special-url` 不得復現該命名空間 | `exit 1` |
| **D-4** | 已刪除之 9 個 stub id 不得復現 | `exit 1` |

**設此閘門之理由**：CI 若某次抓不到套件，建置會失敗；此時最容易發生的「修法」是把
stub 貼回來讓 CI 轉綠——**那是還原成舊的權宜作法，而非修復，且不會有任何錯誤訊息**。
閘門把「他方命名空間之資源一律由上游套件提供」這條規則固定下來。

**負向測試**：內建 4 組必失敗案例（D-1～D-4）＋ 1 組**正向對照**（乾淨狀態不得誤報），
CI 中先跑負向測試再跑實檢，比照 JOB-20～25。

**回歸佐證**：對 0.2.5 之舊狀態實跑，攔下 D-1 一筆、D-2 九筆、D-3 一筆，共 11 筆。

> D-3 首版以單一正則取 `special-url` 區塊，因 `\s` 跨行吃掉換行而誤判區塊邊界，
> **負向測試當場抓到靜默放行**；已改為明確的行狀態機。這正是負向測試存在的理由。

---

## 6. 待 CI 實測驗證（本容器無法完成）

本容器之 egress proxy 封鎖 `packages.fhir.org`／`packages2.fhir.org`／`mitw.dicom.org.tw`，
無法執行 SUSHI 或 IG Publisher，故下列須由 CI 首次執行時確認：

| # | 待驗證 | 預期 |
|:--|:--|:--|
| 1 | `Fetch TWCR_SF package` 步驟可成功下載並通過 name／version 驗證 | 成功 |
| 2 | SUSHI 能解析 `hapi.fhir.tw` 之 9 個 canonical（改由套件提供） | 成功 |
| 3 | `Reference to experimental CodeSystem https://hapi.fhir.tw` | 由 15 筆降低（實際值以實測為準，**不預先承諾數字**） |
| 4 | 移除 `special-url` 後無新增之未解析 canonical 訊息 | 無 |
| 5 | `err = 0` | 維持 |

**若第 2 項失敗**：正確處置是修 `Fetch TWCR_SF package` 步驟（例如上游改版、路徑變更），
**不得還原 stub**——`check-dependencies.js` 之 D-4 會擋下。

---

## 7. 驗收標準

1. `TWCRSF-mocks.fsh` 已刪除，且 `git log` 可追溯。
2. `sushi-config.yaml` 有 `fhir.TWCRSF` 相依，且 `special-url` 已無 `hapi.fhir.tw` 條目。
3. `npm run check:deps:selftest` 5 組全過；`npm run check:deps` 通過。
4. `VS-CoreUploadSet` 描述不再提及 `ext-betelnut-quantity`。
5. `open-issues.md` 之 G-5 標為已解決，並載明先前判定之檢討。
6. CI 之 §6 五項全部通過，`qa-baseline.json` 依實測更新並具名說明。

---

## 8. 交給 Claude 規劃用提示

```
請依 docs/optimization/JOB-28-twcrsf-upstream-dependency.md §6 驗證 CI 首次執行結果。
取得 qa.txt 後，依實測值更新 qa-baseline.json 並於註記中具名說明變動來源
（Reference to experimental 之增減、special-url 移除後之影響）。
鐵則：不得預先猜測 QA 數字；CI 若抓不到套件，修取得步驟，不得還原 stub（D-4 會擋）。
```
