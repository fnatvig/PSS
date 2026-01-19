@echo off

where py >nul 2>&1
if errorlevel 1 goto NO_PY

py -3.11 --version >nul 2>&1
if errorlevel 1 goto NO_311

py -3.11 -m venv pp-venv
if errorlevel 1 goto FAIL

call pp-venv\Scripts\activate.bat
python -m pip install --upgrade pip

if exist requirements.txt pip install -r requirements.txt

echo.
echo Setup complete.
echo Activate later with:
echo   call .\pp-venv\Scripts\activate.bat
echo.

pause
exit /b 0

:NO_PY
echo Python Launcher (py) not found.
pause
exit /b 1

:NO_311
echo Python 3.11 not found. Install Python 3.11.x.
pause
exit /b 1

:FAIL
echo Failed to create virtual environment.
pause
exit /b 1
