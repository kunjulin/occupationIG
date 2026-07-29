Instance: TWHA-CapabilityStatement
InstanceOf: CapabilityStatement
Title: "健康檢查資料交換平台服務宣告"
Description: "本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。"
Usage: #definition
* status = #active
* date = "2026-07-29"
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #json
* format[1] = #xml
// kind = requirements：本宣告表達「平台**應**具備什麼」，非某一實際部署之能力。
// 平台端上線後應另行發佈 kind = capability 之實例宣告（見 conformance.md §上傳介接契約）。
* description = "本實體用於宣告健康檢查資料交換平台支援的交互作用規範，主要採用 POST [base]/Bundle ($submit) 或直接交易封包 (transaction) 進行健檢資料之上傳與交換。本宣告為 requirements（規範要求）層級；實際部署之平台應發佈對應之 capability 宣告。"
* implementationGuide = "https://twcore.mohw.gov.tw/ig/twha/ImplementationGuide/mohw.tw.twha"
* rest[0].mode = #server
* rest[0].security.description = "採用 SMART on FHIR（OAuth 2.0／OIDC）與 TLS 1.3 安全傳輸協定。三類角色之建議 scope 與「雇主端欄位級隔離以 TWHA-Composition-EmployerSummary 達成」見安全與隱私頁 §2；scope 之細部語法與授權流程屬平台端決定（M-10）。"
* rest[0].security.service[0] = http://terminology.hl7.org/CodeSystem/restful-security-service#SMART-on-FHIR "SMART-on-FHIR"

// ---- Bundle：上傳入口 ----
* rest[0].resource[0].type = #Bundle
* rest[0].resource[0].profile = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction"
* rest[0].resource[0].documentation = "上傳入口。接受 TWHA-Bundle-Transaction（處理語意 transaction／batch 之抉擇為未決事項 M-9）。"
* rest[0].resource[0].interaction[0].code = #create
* rest[0].resource[0].interaction[1].code = #read
* rest[0].resource[0].operation[0].name = "submit"
* rest[0].resource[0].operation[0].definition = "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit"

// ---- 查詢面：平台端至少應支援之 searchParam（JOB-04 §3.3）----
// definition 一律指向 FHIR R4 核心 SearchParameter 之 canonical，不自創參數。
* rest[0].resource[1].type = #Patient
* rest[0].resource[1].documentation = "以識別碼（病歷號等）查詢受檢者，供上傳前判重與上傳後對帳。"
* rest[0].resource[1].interaction[0].code = #read
* rest[0].resource[1].interaction[1].code = #search-type
* rest[0].resource[1].searchParam[0].name = "identifier"
* rest[0].resource[1].searchParam[0].definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
* rest[0].resource[1].searchParam[0].type = #token

* rest[0].resource[2].type = #Observation
* rest[0].resource[2].documentation = "查詢已上傳之檢查項目。"
* rest[0].resource[2].interaction[0].code = #read
* rest[0].resource[2].interaction[1].code = #search-type
* rest[0].resource[2].searchParam[0].name = "patient"
* rest[0].resource[2].searchParam[0].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest[0].resource[2].searchParam[0].type = #reference
* rest[0].resource[2].searchParam[1].name = "code"
* rest[0].resource[2].searchParam[1].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest[0].resource[2].searchParam[1].type = #token
* rest[0].resource[2].searchParam[2].name = "date"
* rest[0].resource[2].searchParam[2].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest[0].resource[2].searchParam[2].type = #date

* rest[0].resource[3].type = #DiagnosticReport
* rest[0].resource[3].documentation = "查詢已上傳之報告；identifier 對應本 IG 之報告識別碼命名空間（sid/report-id），為冪等重傳之判重鍵。"
* rest[0].resource[3].interaction[0].code = #read
* rest[0].resource[3].interaction[1].code = #search-type
* rest[0].resource[3].searchParam[0].name = "patient"
* rest[0].resource[3].searchParam[0].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest[0].resource[3].searchParam[0].type = #reference
* rest[0].resource[3].searchParam[1].name = "date"
* rest[0].resource[3].searchParam[1].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest[0].resource[3].searchParam[1].type = #date
* rest[0].resource[3].searchParam[2].name = "identifier"
* rest[0].resource[3].searchParam[2].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest[0].resource[3].searchParam[2].type = #token

Instance: Bundle-submit
InstanceOf: OperationDefinition
Title: "Submit Bundle Operation"
Usage: #definition
* url = "https://twcore.mohw.gov.tw/ig/twha/OperationDefinition/Bundle-submit"
* name = "Submit"
* title = "健檢資料上傳作業 ($submit)"
* description = "健檢機構向主管機關平台上傳健檢資料之作業。輸入為符合 TWHA-Bundle-Transaction 之上傳封包；去重規則：Patient／Organization 以識別碼條件式建立（ifNoneExist）、DiagnosticReport 以報告識別碼（https://twcore.mohw.gov.tw/ig/twha/sid/report-id）條件式更新，同一份報告重傳為覆寫（冪等）。成功回傳 transaction-response Bundle；驗證失敗回傳 OperationOutcome，issue.expression 指向出錯之 entry。整包處理語意（transaction 全有全無 vs batch 部分成功）為未決事項 M-9，定案前平台端不得依任一語意實作錯誤處理。完整契約見 conformance.html 之「上傳介接契約」一節。"
* status = #active
* kind = #operation
* code = #submit
* resource[0] = #Bundle
* system = false
* type = true
* instance = false
* parameter[0].name = #content
* parameter[0].use = #in
* parameter[0].min = 1
* parameter[0].max = "1"
* parameter[0].type = #Bundle
* parameter[0].targetProfile = "https://twcore.mohw.gov.tw/ig/twha/StructureDefinition/TWHA-Bundle-Transaction"
* parameter[0].documentation = "上傳封包，須符合 TWHA-Bundle-Transaction（每個 entry 具 request.method 與 request.url）。範例見 Bundle-UC-008.html／Bundle-UC-009.html。"
* parameter[1].name = #return
* parameter[1].use = #out
* parameter[1].min = 1
* parameter[1].max = "1"
* parameter[1].type = #Bundle
* parameter[1].documentation = "成功時為 type = transaction-response 之 Bundle，逐 entry 回報 response.status 與伺服器指派之位址；驗證失敗時整體回應為 OperationOutcome（HTTP 422），issue.expression 指向出錯之 entry 路徑。"
