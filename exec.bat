@echo off
setlocal enabledelayedexpansion

set "urlFile=urls.txt"
if not exist "%urlFile%" (
    echo URL file not found: %urlFile%
    exit /b 1
)

set count=0
set batch=

for /f "usebackq delims=" %%i in ("%urlFile%") do (
    set /a count+=1
    set "batch=!batch! %%i"
    if !count! equ 10 (
        echo Downloading batch...
        gsutil -m cp -r !batch! f:\mail2024.
        if errorlevel 1 (
            echo Error occurred while downloading batch
        )
        set count=0
        set batch=
    )
)

if !count! neq 0 (
    echo Downloading final batch...
    gsutil -m cp -r !batch! f:\mail2024.
    if errorlevel 1 (
        echo Error occurred while downloading final batch
    )
)

echo Download process completed.
endlocal

