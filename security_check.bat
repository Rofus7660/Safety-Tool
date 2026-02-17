@echo off
chcp 65001 >nul
title FIRE SECURITY SCANNER

:: ANSI escape
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

cls

:: ===== FIRE BANNER =====
echo.
echo.
echo %ESC%[38;2;120;0;0m     ███████╗ █████╗ ███████╗███████╗████████╗██╗   ██╗    ████████╗ ██████╗  ██████╗ ██╗
echo %ESC%[38;2;180;0;0m     ██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝╚██╗ ██╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║
echo %ESC%[38;2;220;40;0m     ███████╗███████║█████╗  █████╗     ██║    ╚████╔╝        ██║   ██║   ██║██║   ██║██║
echo %ESC%[38;2;255;80;0m     ╚════██║██╔══██║██╔══╝  ██╔══╝     ██║     ╚██╔╝         ██║   ██║   ██║██║   ██║██║
echo %ESC%[38;2;255;140;0m     ███████║██║  ██║██║     ███████╗   ██║      ██║          ██║   ╚██████╔╝╚██████╔╝███████╗
echo %ESC%[38;2;255;200;50m     ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝   ╚═╝      ╚═╝          ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo %ESC%[0m

echo %ESC%[38;2;255;170;50m     [~] V1.0.0%ESC%[0m
echo %ESC%[38;2;255;170;50m     [~] Created by Rofus%ESC%[0m
echo.

:: ===== INPUT =====
set /p url=%ESC%[38;2;255;170;50mEnter website URL (https://example.com): %ESC%[0m

echo.
echo %ESC%[38;2;255;120;0m[ FIRE SCAN INITIALIZING... ]%ESC%[0m
timeout /t 1 >nul

curl -Is %url% > headers.txt 2>nul

if errorlevel 1 (
    echo %ESC%[38;2;255;0;0mTARGET NOT REACHABLE%ESC%[0m
    del headers.txt >nul 2>&1
    pause
    exit
)

set score=0

findstr /i "Strict-Transport-Security" headers.txt >nul && set /a score+=20
findstr /i "Content-Security-Policy" headers.txt >nul && set /a score+=20
findstr /i "X-Frame-Options" headers.txt >nul && set /a score+=15
findstr /i "X-Content-Type-Options" headers.txt >nul && set /a score+=15
findstr /i "Referrer-Policy" headers.txt >nul && set /a score+=10

echo.
echo %ESC%[38;2;255;150;40m==============================%ESC%[0m
echo %ESC%[38;2;255;200;80m SECURITY SCORE: %score% / 100 %ESC%[0m
echo %ESC%[38;2;255;150;40m==============================%ESC%[0m
echo.

if %score% LSS 40 (
    echo %ESC%[38;2;255;0;0mSTATUS: LOW SECURITY%ESC%[0m
) else if %score% LSS 70 (
    echo %ESC%[38;2;255;140;0mSTATUS: MEDIUM SECURITY%ESC%[0m
) else (
    echo %ESC%[38;2;0;255;0mSTATUS: HIGH SECURITY%ESC%[0m
)

echo.
echo %ESC%[38;2;255;170;50mRecommended Hardening:%ESC%[0m
echo %ESC%[38;2;255;170;50m- Enable HSTS%ESC%[0m
echo %ESC%[38;2;255;170;50m- Add Content-Security-Policy%ESC%[0m
echo %ESC%[38;2;255;170;50m- Add X-Frame-Options%ESC%[0m
echo %ESC%[38;2;255;170;50m- Implement rate limiting on login%ESC%[0m
echo %ESC%[38;2;255;170;50m- Add CAPTCHA after failed attempts%ESC%[0m
echo %ESC%[38;2;255;170;50m- Hide server header%ESC%[0m

del headers.txt >nul 2>&1

echo.
pause
