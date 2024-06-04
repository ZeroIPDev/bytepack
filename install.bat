::Run during first time setup of repo!
@echo off
title bytepack installer
::Variables
set _path=%~dp0
::Checks
::Folder setup
echo | set /p=Creating folders...
cd %_path%
if not exist "out" md out
echo Complete!
::Environment Variables
echo | set /p=Updating environment variables...
setx bytepack "%_path%\" >nul
call haxelib dev BytePack %_path% >nul
call tools\pathman add %_path%bin\ >nul 2>&1
echo Complete!
exit /b 0
