@echo off
title bytepack

set arg=%~1
if "%arg%" == "clean" call :clean
call haxelib run openfl build windows -Dno-deprecation-warnings
if "%arg%" == "debug" (
    if %errorlevel% equ 0 call bin\bytepack -pack testApp\assets
)
exit /b 0

:clean
echo | set /p=Cleaning...
rmdir /s /q build
echo OK
exit /b 0
