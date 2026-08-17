@echo off
REM ============================================================================
REM  Terminology-validated build (for pre-submission / pre-publish use)
REM
REM  Division of labor with _genonce.bat:
REM    _genonce.bat      Offline build (-tx n/a). Use for everyday quick builds.
REM                      Does NOT verify that LOINC/SNOMED codes exist or that
REM                      display names are correct, so its 0 Error result must
REM                      NOT be used as evidence of submission readiness.
REM    _genonce_tx.bat   This file. Connects to tx.fhir.org to validate every
REM                      code and display name.
REM                      Always rebuild with this file and confirm 0 Error
REM                      before external release or committee review.
REM
REM  Requires outbound access to https://tx.fhir.org/r4. If your network does
REM  TLS interception (e.g. Avast/corporate proxy), set JAVA_TOOL_OPTIONS so
REM  the JVM trusts the Windows certificate store:
REM    set JAVA_TOOL_OPTIONS=-Djavax.net.ssl.trustStoreType=Windows-ROOT
REM    set NODE_OPTIONS=--use-system-ca
REM  See .claude/skills/fhir-tx-audit/SKILL.md for details.
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
echo  Open output\qa.html and confirm Errors: 0.
echo  If you see "Wrong Display Name" or "Unknown code", the code or display
echo  name has a problem. See .claude/skills/fhir-tx-audit/SKILL.md for the
echo  process (note: a display mismatch can mean the CODE itself is wrong,
echo  not just an imprecise display name).
echo ============================================================================
