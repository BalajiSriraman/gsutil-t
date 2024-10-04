@echo off
setlocal

set "urlFile=urls.txt"
if not exist "%urlFile%" (
    echo URL file not found: %urlFile%
    exit /b 1
)

for /f "usebackq delims=" %%i in ("%urlFile%") do (
    echo Downloading: %%i
    gsutil -m cp -r "%%i" f:\mail2024.
    if errorlevel 1 (
        echo Error occurred while downloading: %%i
    )
)

echo Download process completed.
endlocal

