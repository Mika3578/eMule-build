@ECHO OFF
REM Build eMule in Debug mode

CD /D %~dp0

ECHO ============================================
ECHO Building eMule (Debug)
ECHO ============================================
ECHO.

REM Setup Visual Studio environment
CALL incl_VCVARS64.cmd
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: Failed to setup Visual Studio environment
    PAUSE
    EXIT /B 1
)

REM Check if libs_debug directory exists and has content
IF NOT EXIST "libs_debug\*.lib" (
    ECHO ERROR: Debug libraries not found in libs_debug\ directory
    ECHO Please run build_all_libs_debug.cmd first to build the required debug libraries
    PAUSE
    EXIT /B 1
)

REM Build eMule
CD eMule\srchybrid

ECHO Building eMule (Debug)...
MSBuild emule.vcxproj -target:Clean,Build /property:Configuration=Debug /property:Platform=x64 /nologo /verbosity:minimal

IF %ERRORLEVEL% NEQ 0 (
    ECHO.
    ECHO ============================================
    ECHO Build Failed!
    ECHO ============================================
    CD /D %~dp0
    PAUSE
    EXIT /B 1
)

CD /D %~dp0

ECHO.
ECHO ============================================
ECHO eMule Built Successfully (Debug)!
ECHO ============================================
ECHO.
ECHO Executable location: eMule\srchybrid\x64\Debug\emule.exe
ECHO.

PAUSE
EXIT /B 0
