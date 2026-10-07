@echo off
rem Strikepoint launcher for Windows: opens the game in its own fast browser window.
rem A separate browser profile means these settings always apply (your normal Chrome is untouched):
rem   always use the graphics card, prefer the high-performance GPU, no background throttling, no tabs/address bar.
setlocal
set "GAME=%~dp0index.html"
if not exist "%GAME%" (
  echo Keep this launcher in the same folder as index.html.
  pause
  exit /b 1
)
set "URL=file:///%GAME:\=/%"
set "PROFILE=%LOCALAPPDATA%\Strikepoint\Browser"
call :run "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
call :run "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
call :run "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
call :run "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
call :run "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
call :run "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\Application\brave.exe"
call :run "%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe"
rem no Chromium-based browser found: use the default browser
start "" "%GAME%"
exit /b 0

:run
if exist "%~1" (
  start "" "%~1" --user-data-dir="%PROFILE%" --app="%URL%" --start-maximized --no-first-run --no-default-browser-check --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy --force_high_performance_gpu --disable-background-timer-throttling --disable-renderer-backgrounding --disable-backgrounding-occluded-windows --autoplay-policy=no-user-gesture-required
  exit 0
)
exit /b 0
