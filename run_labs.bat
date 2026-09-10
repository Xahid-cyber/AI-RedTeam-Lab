@echo off
setlocal
title AI Red-Team Lab Runner
cd /d "%~dp0"

:menu
cls
echo ================================
echo      AI RED-TEAM LAB RUNNER
echo ================================
echo.
echo 1. Start FastAPI
echo 2. Garak - Prompt Injection
echo 3. Garak - Base64 Attack
echo 4. Garak - ThreatenJSON
echo 5. Promptfoo Security Tests
echo 6. PyRIT Security Tests
echo 7. FastAPI Health Check
echo 8. Exit
echo.
set /p choice=Choose [1-8]:

if "%choice%"=="1" goto fastapi
if "%choice%"=="2" goto garak1
if "%choice%"=="3" goto garak2
if "%choice%"=="4" goto garak3
if "%choice%"=="5" goto promptfoo
if "%choice%"=="6" goto pyrit
if "%choice%"=="7" goto health
if "%choice%"=="8" exit
goto menu

:fastapi
start "FastAPI" cmd /k "cd /d ""%~dp0"" && call .venv\Scripts\activate.bat && python -m uvicorn app.main:app --reload --host 127.0.0.1 --port 8000"
pause
goto menu

:garak1
call .venv-garak\Scripts\activate.bat
garak --config garak-rest.json --target_type rest -G garak-rest.json --spec probes.promptinject.HijackHateHumans --generations 1
pause
goto menu

:garak2
call .venv-garak\Scripts\activate.bat
garak --config garak-rest.json --target_type rest -G garak-rest.json --spec probes.encoding.InjectBase64 --generations 1
pause
goto menu

:garak3
call .venv-garak\Scripts\activate.bat
garak --config garak-rest.json --target_type rest -G garak-rest.json --spec probes.goodside.ThreatenJSON --generations 1
pause
goto menu

:promptfoo
promptfoo eval -c promptfooconfig-security.yaml
pause
goto menu

:pyrit
call .venv-pyrit\Scripts\activate.bat
python pyrit_security_tests.py
pause
goto menu

:health
curl http://127.0.0.1:8000/health
echo.
pause
goto menu