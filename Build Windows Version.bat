@echo off
rem Builds the standalone Windows version of Strikepoint (Packaged\Windows\Strikepoint.exe).
rem Run this on a Windows PC that has Unreal Engine 5.8 and Visual Studio 2022 ("Game development with C++") installed.
rem Optional: pass the engine folder if it is not in the default place, e.g.
rem   "Build Windows Version.bat" "D:\Epic Games\UE_5.8"
setlocal
set "UE=C:\Program Files\Epic Games\UE_5.8"
if not "%~1"=="" set "UE=%~1"
set "UAT=%UE%\Engine\Build\BatchFiles\RunUAT.bat"

if not exist "%UAT%" (
  echo Could not find Unreal Engine 5.8 at "%UE%".
  echo Install it from the Epic Games Launcher, or run:  "Build Windows Version.bat" "path\to\UE_5.8"
  pause
  exit /b 1
)

echo Building Strikepoint for Windows. This takes a while the first time...
call "%UAT%" BuildCookRun -project="%~dp0Strikepoint.uproject" -platform=Win64 -clientconfig=Shipping -build -cook -stage -pak -archive -archivedirectory="%~dp0Packaged" -nop4 -utf8output -unattended
if errorlevel 1 (
  echo.
  echo Build failed. Scroll up for the first error.
  pause
  exit /b 1
)

echo.
echo Done. The game is in "%~dp0Packaged\Windows" - run Strikepoint.exe. Copy that whole folder to share it.
explorer "%~dp0Packaged\Windows"
pause
