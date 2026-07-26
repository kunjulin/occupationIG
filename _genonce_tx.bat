@echo off
REM ============================================================================
REM  送審／發佈前之術語驗證建置 (Terminology-validated build)
REM
REM  與 _genonce.bat 之分工：
REM    _genonce.bat      離線建置 (-tx n/a)，日常快速建置用。
REM                      **不驗證 LOINC/SNOMED 代碼是否存在或顯示名是否正確**，
REM                      故其 0 Error 不得作為送審依據（文件一 v3.2 §6.6）。
REM    _genonce_tx.bat   本檔。連線 tx.fhir.org 逐碼驗證代碼與顯示名。
REM                      **對外發佈、送委員審查前一律以本檔重建並確認 0 Error。**
REM
REM  需可連外至 https://tx.fhir.org/r4。若公司網路以 TLS 攔截（如 Avast/proxy），
REM  請先設定 JAVA_TOOL_OPTIONS 讓 JVM 信任 Windows 憑證存放區：
REM    set JAVA_TOOL_OPTIONS=-Djavax.net.ssl.trustStoreType=Windows-ROOT
REM    set NODE_OPTIONS=--use-system-ca
REM  詳見 .claude/skills/fhir-tx-audit/SKILL.md。
REM ============================================================================
SET maxmem=4096m
SET txserver=https://tx.fhir.org/r4

echo Running SUSHI compilation...
call npx fsh-sushi .
if %errorlevel% neq 0 (
    echo SUSHI compilation failed!
    exit /b %errorlevel%
)

if not exist input-cache\publisher.jar (
    echo publisher.jar not found, downloading...
    if not exist input-cache mkdir input-cache
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar' -OutFile 'input-cache\publisher.jar'"
)

echo Running HL7 IG Publisher with terminology server %txserver% ...
java -Xmx%maxmem% -jar input-cache\publisher.jar -ig ig.ini -no-sushi -tx %txserver%

echo.
echo ============================================================================
echo  請開啟 output\qa.html 確認 Errors: 0。
echo  若出現 "Wrong Display Name" 或 "Unknown code"，代表代碼或顯示名有問題，
echo  處理流程見 .claude/skills/fhir-tx-audit/SKILL.md
echo  （注意：顯示名不符可能代表「用錯碼」而非僅顯示名不精確）。
echo ============================================================================
