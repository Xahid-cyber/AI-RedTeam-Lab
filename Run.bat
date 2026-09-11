@echo off
setlocal EnableExtensions
title AI Red-Team Lab Runner
color 0A
cd /d "%~dp0"

:menu
cls
echo ================================================
echo            AI RED-TEAM LAB RUNNER
echo ================================================
echo.
echo 1. Start FastAPI
echo 2. Garak - Prompt Injection
echo 5. Promptfoo - Security Tests
echo 6. PyRIT - Custom Security Tests
echo 7. FastAPI Health Check
echo 8. Exit
echo.
set /p choice=Choose [1,2,5,6,7,8]:

if "%choice%"=="1" goto fastapi
if "%choice%"=="2" goto garak
if "%choice%"=="5" goto promptfoo
if "%choice%"=="6" goto pyrit
if "%choice%"=="7" goto health
if "%choice%"=="8" goto end

echo Invalid option.
pause
goto menu


:fastapi
cls
echo Starting FastAPI...
start "FastAPI" cmd /k "cd /d ""%~dp0"" && call .venv\Scripts\activate.bat && python -m uvicorn app.main:app --reload --host 127.0.0.1 --port 8000"
echo.
echo FastAPI started in another window.
pause
goto menu


:garak
cls
echo Running Garak Prompt Injection test...
echo.
call .venv-garak\Scripts\activate.bat
garak --config garak-rest.json --target_type rest -G garak-rest.json --spec probes.promptinject.HijackHateHumans --generations 1
call .venv-garak\Scripts\deactivate.bat >nul 2>&1
echo.
echo Garak test complete.
pause
goto menu


:promptfoo
cls
echo Running Promptfoo Security Tests...
echo.
call promptfoo eval -c promptfooconfig-security.yaml
echo.
echo Promptfoo tests complete.
pause
goto menu


:pyrit
cls
echo Running PyRIT Security Tests...
echo.
call .venv-pyrit\Scripts\activate.bat
python pyrit_security_tests.py
call .venv-pyrit\Scripts\deactivate.bat >nul 2>&1
echo.
echo PyRIT tests complete.
pause
goto menu


:health
cls
echo Checking FastAPI...
echo.
curl.exe -s http://127.0.0.1:8000/health
echo.
echo.
pause
goto menu


:end
endlocal
exit /b