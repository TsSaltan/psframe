@echo off
setlocal ENABLEDELAYEDEXPANSION
chcp 65001 > nul

:: Mask for powershell files
set srcFrame=%cd%\src-frame
set srcScript=%cd%\src
set maskFrame=%srcFrame%\*.ps1
set maskSource=%srcScript%\*.ps1

:: Create build folder if not exists
set outputDir=%cd%\build
mkdir "%outputDir%" 2> nul

set resSrc=%cd%\res
set resDst=%outputDir%\res\

set outputFile=%outputDir%\app.tmp
set outputBasename=app.ps1
set launcherFile=%outputDir%\launcher.vbs

:: Remove temp and old-build files
rem del "%outputDir%\*.ps1" 2> nul
rem rd "%resDst%" /S /Q 2> nul
rd "%outputDir%" /S /Q 2> nul
md "%outputDir%"

echo [Builder] Current directory: %cd%
echo # PScript builder > %outputFile%
echo. >> %outputFile%

echo # [Builder] Import framework >> %outputFile%
for /f %%f in ('dir "%maskFrame%" /b/s') do (
	echo [Builder] Import file: %%f
	echo # [Builder] Import file: %%~nf >> %outputFile%
	type %%f >> %outputFile%
	echo. >> %outputFile%
)

echo # [Builder] Import source >> %outputFile%
for /f %%f in ('dir "%maskSource%" /b/s') do (
	echo [Builder] Import file: %%f
	echo # [Builder] Import file: %%~nf >> %outputFile%
	type %%f >> %outputFile%
	echo. >> %outputFile%
)

rename "%outputFile%" "%outputBasename%"

if not exist "%launcherFile%" (
	echo ' generated by PSFrame builder > "%launcherFile%"
	echo set Shell = CreateObject("WScript.Shell"^) >> "%launcherFile%"
	echo set FSO = CreateObject("Scripting.FileSystemObject"^) >> "%launcherFile%"
	echo Path = "powershell.exe -ExecutionPolicy UnRestricted -WindowStyle hidden -File " ^& FSO.GetParentFolderName(FSO.GetFile(WScript.ScriptFullName^)^) ^& "\\%outputBasename%" >> "%launcherFile%"
	echo Shell.Run Path, 0, true >> "%launcherFile%"
rem	echo Shell.Run Path, 4, true >> "%launcherFile%"
)

echo [Builder] Copying resources ...
xcopy "%resSrc%" "%resDst%" /E


if "%~1" == "-launch" (
	goto launch
)

set /p launch=Launch builded script [y/n]?: 

echo "%launch%"

if "%launch%"=="y" (
	:launch
	cd ./build/
	echo Execute from path "%outputDir%\%outputBasename%"
	powershell.exe -ExecutionPolicy UnRestricted -File "%outputDir%\%outputBasename%"
)