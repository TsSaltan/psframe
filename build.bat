@echo off
setlocal ENABLEDELAYEDEXPANSION
chcp 65001 > nul

:: Mask for powershell files
set mask="%cd%\*.ps1"

:: Create build folder if not exists
mkdir "%cd%\build" 2> nul
set outputFile="%cd%\build\script.tmp"

:: Remove temp and old-build files
del %outputFile% 2> nul
del %outputFile:.tmp=.ps1% 2> nul

echo Current directory: %cd%
echo # Script builder > %outputFile%

echo Find files on mask %mask% ...
echo # Script builder > %outputFile%
echo. >> %outputFile%

for /f %%f in ('dir %mask% /b/s') do (
	if not "%%~nf" == "index" (
		echo Import file: %%f
		echo # [Builder] Import %%~nf ; >> %outputFile%
		type %%f >> %outputFile%
		echo. >> %outputFile%
	)
)
echo Import index file
echo. >> %outputFile%
echo # [Builder] Import index file ; >> %outputFile%
echo. >> %outputFile%
type "%cd%\index.ps1" >> %outputFile%

rename "%outputFile%" "script.ps1"

if "%~1" == "-launch" (
	goto launch
)

echo Press any key to launch script
set /p launch=Launch builded script [y/n]?: 

if "%launch%" == "y"(
	:launch
	powershell.exe -ExecutionPolicy UnRestricted -File "%outputFile:.tmp=.ps1%"
)

pause