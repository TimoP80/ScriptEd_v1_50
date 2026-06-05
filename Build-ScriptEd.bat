@echo off
chcp 65001 >nul
setlocal

rem Resolve source directory (script location)
set "SRC_DIR=%~dp0"
if /i "%SRC_DIR:~-1%"=="\" set "SRC_DIR=%SRC_DIR:~0,-1%"

rem Default BDS path; override with set BDS=... before calling this script if needed
if not defined BDS set "BDS=C:\Program Files (x86)\Embarcadero\Studio\20.0"

if not exist "%BDS%\bin\dcc32.exe" (
    echo ERROR: Delphi compiler not found at "%BDS%\bin\dcc32.exe"
    echo       Set BDS environment variable to your RAD Studio 10.3 install path.
    endlocal
    exit /b 1
)

set "DCC32=%BDS%\bin\dcc32.exe"

set "CONFIG=Release"
set "TARGET=Build"
set "QUIET="

:parse_args
if "%~1"=="" goto run_build
if /i "%~1"=="-Debug"   set "CONFIG=Debug"   & shift & goto parse_args
if /i "%~1"=="-Clean"   set "TARGET=Clean"    & shift & goto parse_args
if /i "%~1"=="-Rebuild" set "TARGET=Rebuild"  & shift & goto parse_args
if /i "%~1"=="-Quiet"   set "QUIET=-Q"        & shift & goto parse_args
shift
goto parse_args

:run_build
pushd "%SRC_DIR%" >nul

if not exist "ScriptEd.dpr" (
    echo ERROR: ScriptEd.dpr not found in "%SRC_DIR%"
    popd
    endlocal
    exit /b 1
)

echo.
echo ============================================================
echo  ScriptEd build  ^|  Config: %CONFIG%  ^|  Platform: Win32
echo ============================================================
echo.

if /i "%TARGET%"=="Clean" goto do_clean

if /i "%TARGET%"=="Rebuild" (
    call :do_clean
    if errorlevel 1 (
        popd
        endlocal
        exit /b 1
    )
    echo.
)

set "PASS1=%QUIET% -B"

if /i "%CONFIG%"=="Debug" (
    set "PASS1=%PASS1% -V -Y -#0"
) else (
    set "PASS1=%PASS1% -GD"
)

echo [1/4] ScriptEd ...
"%DCC32%" %PASS1% ScriptEd.dpr
if errorlevel 1 (
    echo.
    echo *** BUILD FAILED: ScriptEd ***
    popd
    endlocal
    exit /b 1
)

echo [2/4] DLG_SpeechApi (SAPI5Plugin) ...
if not exist "plugins\SAPI5Plugin\DLG_SpeechApi.dpr" (
    echo SKIP: plugins\SAPI5Plugin\DLG_SpeechApi.dpr not found
) else (
    pushd "plugins\SAPI5Plugin" >nul
    "%DCC32%" %PASS1% DLG_SpeechApi.dpr
    if errorlevel 1 (
        echo *** BUILD FAILED: DLG_SpeechApi ***
        popd
        popd
        endlocal
        exit /b 1
    )
    popd >nul
)

echo [3/4] PLG_ScriptDebugInfo (DebugScriptInfo) ...
if not exist "plugins\DebugScriptInfo\PLG_ScriptDebugInfo.dpr" (
    echo SKIP: plugins\DebugScriptInfo\PLG_ScriptDebugInfo.dpr not found
) else (
    pushd "plugins\DebugScriptInfo" >nul
    "%DCC32%" %PASS1% PLG_ScriptDebugInfo.dpr
    if errorlevel 1 (
        echo *** BUILD FAILED: PLG_ScriptDebugInfo ***
        popd
        popd
        endlocal
        exit /b 1
    )
    popd >nul
)

echo [4/4] PLG_CheckRefs (DependencyChecker) ...
if not exist "plugins\DependencyChecker\PLG_CheckRefs.dpr" (
    echo SKIP: plugins\DependencyChecker\PLG_CheckRefs.dpr not found
) else (
    pushd "plugins\DependencyChecker" >nul
    "%DCC32%" %PASS1% PLG_CheckRefs.dpr
    if errorlevel 1 (
        echo *** BUILD FAILED: PLG_CheckRefs ***
        popd
        popd
        endlocal
        exit /b 1
    )
    popd >nul
)

goto report

:do_clean
echo Cleaning artefacts from src\ ...
del /q /f "%~dp0*.dcu"       2>nul
del /q /f "%~dp0*.dcp"       2>nul
del /q /f "%~dp0*.drc"       2>nul
del /q /f "%~dp0*.identcache" 2>nul
del /q /f "%~dp0*.~*"        2>nul

echo Cleaning artefacts from plugins\ ...
for %%D in (plugins\SAPI5Plugin plugins\DebugScriptInfo plugins\DependencyChecker) do (
    del /q /f "%%~D\*.dcu" 2>nul
    del /q /f "%%~D\*.dcp" 2>nul
    del /q /f "%%~D\*.drc" 2>nul
    del /q /f "%%~D\*.identcache" 2>nul
    del /q /f "%%~D\*.~*"  2>nul
)

echo Clean complete.
exit /b 0

:report
set "EXE_PATH=C:\CodeProjects\ScriptEd_v1_50\ScriptEd.exe"
echo.
echo ============================================================
if exist "%EXE_PATH%" (
    for %%F in ("%EXE_PATH%") do echo  Build Succeeded  ^|  %%~fF
    for %%F in ("%EXE_PATH%") do echo  Size: %%~zF bytes
) else (
    echo  Build reported success but EXE not found at:
    echo  %EXE_PATH%
)
echo ============================================================
echo.
popd
endlocal
exit /b 0
