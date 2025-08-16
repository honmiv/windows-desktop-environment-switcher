@echo off
setlocal enabledelayedexpansion

:: 1. Go to home directory
cd /d "%USERPROFILE%"

:: 2. Create folder Desktop_Switcher
if not exist "Desktop_Switcher" mkdir "Desktop_Switcher"
cd "Desktop_Switcher"

:: 3. Download zip
echo Downloading DesktopOK.zip...
powershell -command "Invoke-WebRequest -Uri 'https://www.softwareok.de/Download/DesktopOK.zip' -OutFile 'DesktopOK.zip'"

:: 4. Unzip zip and remove all .txt and downloaded ZIP
echo Extracting DesktopOK.zip...
powershell -command "Expand-Archive -Force 'DesktopOK.zip' ."
del /q *.txt
del /q DesktopOK.zip

:: 5. Create empty file DesktopOK.ini
type nul > "DesktopOK.ini"

:: 6. Ask for environment name
set /p ENV_NAME=Enter new environment name: 

:: 7. Create folder Desktop_<ENV_NAME>
set ENV_FOLDER=Desktop_%ENV_NAME%
if not exist "%USERPROFILE%\%ENV_FOLDER%" mkdir "%USERPROFILE%\%ENV_FOLDER%"

:: 7.1 Create to_home.bat
(
echo @echo off
echo cd /d "%USERPROFILE%\Desktop_Switcher"
echo.
echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop /t REG_EXPAND_SZ /d "%%USERPROFILE%%\Desktop" /f
echo.
echo DesktopOK.exe /save %ENV_NAME%.dok
echo.
echo taskkill /f /im explorer.exe ^>nul 2^>^&1
echo start explorer.exe
echo.
echo timeout /t 1 /nobreak ^>nul
echo.
echo DesktopOK.exe /load home.dok
) > "to_home.bat"

:: 7.2 Create to_<ENV_NAME>.bat
(
echo @echo off
echo cd /d "%USERPROFILE%\Desktop_Switcher"
echo.
echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop /t REG_EXPAND_SZ /d "%%USERPROFILE%%\%ENV_FOLDER%" /f
echo.
echo DesktopOK.exe /save home.dok
echo.
echo taskkill /f /im explorer.exe ^>nul 2^>^&1
echo start explorer.exe
echo.
echo timeout /t 1 /nobreak ^>nul
echo.
echo DesktopOK.exe /load %ENV_NAME%.dok
) > "to_%ENV_NAME%.bat"

:: 8. Create shortcuts for these bat files
set SHORTCUT_HOME=%USERPROFILE%\Desktop_Switcher\to_home.lnk
set SHORTCUT_ENV=%USERPROFILE%\Desktop_Switcher\to_%ENV_NAME%.lnk

powershell -command ^
 "$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT_HOME%');$s.TargetPath='%USERPROFILE%\Desktop_Switcher\to_home.bat';$s.Save()"

powershell -command ^
 "$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT_ENV%');$s.TargetPath='%USERPROFILE%\Desktop_Switcher\to_%ENV_NAME%.bat';$s.Save()"

:: 9. Place shortcut to_<ENV_NAME>.lnk on Desktop
copy /y "%SHORTCUT_ENV%" "%USERPROFILE%\Desktop\"

:: 10. Place shortcut to_home.lnk in Desktop_<ENV_NAME>
copy /y "%SHORTCUT_HOME%" "%USERPROFILE%\%ENV_FOLDER%\"

echo Done!
pause


