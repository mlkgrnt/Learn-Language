@echo off
echo ===================================
echo  Language Learning Assistant Setup
echo ===================================
echo.

REM Check Python
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Python not found. Please install Python 3.8+ first.
    echo   https://www.python.org/downloads/
    pause
    exit /b 1
)

for /f "delims=" %%i in ('python --version 2^>^&1') do set PY_VERSION=%%i
echo Found: %PY_VERSION%

REM Install dependencies
echo.
echo Installing dependencies...
python -m pip install --upgrade pip -q
python -m pip install -r requirements.txt -q
echo Dependencies installed.

REM Create directory structure
echo.
echo Creating directories...
if not exist "materials\input" mkdir "materials\input"
if not exist "materials\chapters" mkdir "materials\chapters"
echo Directory structure ready.

REM Done
echo.
echo ===================================
echo  Setup complete!
echo ===================================
echo.
echo Next steps:
echo   1. Place your learning materials in materials\input\
echo   2. Open Claude Code and run /process-material
echo   3. Then run /learn-language to start learning
echo.
pause
