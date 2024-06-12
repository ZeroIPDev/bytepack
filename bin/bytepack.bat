@echo off
if "%~1" == "" goto :help
if "%~1" == "-gen" goto :gen
if "%~1" == "-pack" call :pack %~2
if "%~1" == "-clean" call :clean %~2
if "%~1" == "-template" call :template
exit /b %errorlevel%

:pack
if not exist "%bytepack%\build\windows\bin\BytePack.exe" (
    echo ERROR: BytePack Utility not built!
    exit /b 1
)
call :gen
call :clean %~1
call %bytepack%\build\windows\bin\BytePack -pack %~1 %bp_key% %bp_iv %
exit /b 0

:clean
if exist %~1\.bytepack rmdir /s /q %~1\.bytepack
md %~1\.bytepack
exit /b 0

:gen
set OPENSSL_CONF=%bytepack%\tools\ssl\openssl.cfg
call %bytepack%\tools\ssl\openssl enc -aes-256-cbc -pass pass:%random%%random% -P -md sha1 >%bytepack%\out\aes.txt
call :setbpvars
exit /b 0

:setbpvars
for /f "delims=*" %%a in (%bytepack%\out\aes.txt) do (
    set bp_%%a
)
set BYTEPACK_FLAGS=-Dbytepack -Dbp_key=%bp_key% -Dbp_iv=%bp_iv %
exit /b 0

:template
echo | set /p=Creating template project...
robocopy "%bytepack%\template" "%cd%" /e /nfl /ndl /njh /njs /nc /ns /np >nul
echo OK
exit /b %errorlevel%

:help
echo --bytepack--
echo USAGE:
echo bytepack [options]
echo.
echo OPTIONS:
echo gen - Generate new AES keys and set variables
exit /b 0
