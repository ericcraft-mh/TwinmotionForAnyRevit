@echo off
setlocal
echo Finding newest Twinmotion folder...
for /f "delims=" %%a in ('powershell -Command "Get-ChildItem -Path 'C:\Program Files\Epic Games' -Directory | Where-Object { $_.Name -like '*Twinmotion*' } | Sort-Object -Descending | Select-Object -First 1 -ExpandProperty Name"') do (
    set "folderName=%%a"
)
echo Found folder: %folderName%

:: Extract year from folder name
set "versionPart="
for /f "tokens=2 delims= " %%a in ("%folderName%") do set "versionPart=%%a"
for /f "tokens=1 delims=-" %%a in ("%versionPart%") do set "yearPart=%%a"
set "year=%yearPart:~0,4%"

:: Determine correct executable path
if %year% LEQ 2023 (
    set "fullPath=C:\Program Files\Epic Games\%folderName%\Twinmotion.exe"
) else (
    set "fullPath=C:\Program Files\Epic Games\%folderName%\Twinmotion\Binaries\Win64\TwinmotionCookedEditor-Win64-Shipping.exe"
)

reg add "HKCU\Software\Microsoft\Twinmotion 2022.2-Revit" /v "Installed" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Twinmotion 2023.1-Revit" /v "Installed" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Twinmotion 2023.2-Revit" /v "Installed" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Twinmotion 2024.1-Revit" /v "Installed" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Twinmotion 2025.1-Revit" /v "Installed" /t REG_DWORD /d 1 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\Twinmotion2022.2-Revit.exe" /v "" /t REG_SZ /d "%fullPath%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\Twinmotion2023.1-Revit.exe" /v "" /t REG_SZ /d "%fullPath%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\Twinmotion2023.2-Revit.exe" /v "" /t REG_SZ /d "%fullPath%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\Twinmotion2024.1-Revit.exe" /v "" /t REG_SZ /d "%fullPath%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\Twinmotion2025.1-Revit.exe" /v "" /t REG_SZ /d "%fullPath%" /f

echo Twinmotion Registry path: %fullPath%
timeout /t 10
