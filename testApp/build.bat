@echo off
title bytepack test

set args=%*
if "%args%" == "" set args=release
call :checkcmd clean
call :checkcmd refresh
call :checkcmd debug
call :checkcmd release
exit /b 0

:release
call bytepack -pack assets
if %errorlevel% equ 0 call haxelib run openfl build windows -Dno-deprecation-warnings %BYTEPACK_FLAGS%
exit /b 0

:debug
call bytepack -clean assets
call haxelib run openfl test windows -Dno-deprecation-warnings -debug
exit /b 0

:clean
echo | set /p=Cleaning...
rmdir /s /q build
echo OK
exit /b 1

:refresh
echo | set /p=Cleaning...
rmdir /s /q build\windows\bin
echo OK
exit /b 1

:checkcmd
echo.%args% | findstr /i /c:"%~1" 1>nul
if %errorlevel% equ 0 call :%~1
exit /b %errorlevel%
