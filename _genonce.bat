@echo off
SET maxmem=4096m

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
echo Running HL7 IG Publisher...
java -Xmx%maxmem% -jar input-cache\publisher.jar -ig ig.ini -no-sushi -tx n/a
