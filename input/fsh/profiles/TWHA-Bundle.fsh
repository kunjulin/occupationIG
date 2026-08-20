// 文件封包之結構不變條件。描述文字宣稱「第一個 entry 必須為 Composition」，
// 原本 FSH 無對應約束——文件寫了規則、機器不檢查（JOB-04 §1(4)）。
// 以 invariant 而非 entry slicing 表達：R4 之 Bundle.entry 排序 slicing
// 需要 discriminator，對「第一個」這種位置性條件反而迂迴。
Invariant: twha-bnd-1
Description: "Document Bundle 之第一個 entry 必須為 Composition"
Expression: "entry.first().resource.is(Composition)"
Severity: #error

Profile: TWHABundleDocumentProfile
Parent: Bundle
Id: TWHA-Bundle-Document
Title: "健康檢查報告交換封包 (Document Bundle) Profile"
Description: "【技術規格】用於健檢報告交換的 Document Bundle，其第一個 entry 必須為 Composition（以 twha-bnd-1 不變條件驗證），且型態 (type) 必須為 document。"
* type = #document
* entry 1..*
* entry.resource 1..1
* obeys twha-bnd-1

Profile: TWHABundleTransactionProfile
Parent: Bundle
Id: TWHA-Bundle-Transaction
Title: "健康檢查資料上傳封包 (Transaction Bundle) Profile"
Description: "【技術規格】用於健檢系統或醫療院所向主管機關平台進行批次上傳/新增資料之 Transaction Bundle，其型態 (type) 必須為 transaction，且 entry 必須包含 HTTP 請求方法資訊。去重與冪等重傳之契約見 conformance.html「上傳介接契約」；整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，若定案採 batch，本 profile 之 type 固定值需隨之調整。範例：UC-008（首次上傳）、UC-009（含缺值與冪等重傳）。"
* type = #transaction
* entry 1..*
* entry.request 1..1
* entry.request.method from http://hl7.org/fhir/ValueSet/http-verb (required)
* entry.resource 1..1

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use