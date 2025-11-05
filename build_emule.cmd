@ECHO OFF
REM Build eMule in Release mode

CD /D %~dp0

ECHO ============================================
ECHO Building eMule (Release)
ECHO ============================================
ECHO.

REM Setup Visual Studio environment
CALL incl_VCVARS64.cmd
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: Failed to setup Visual Studio environment
    PAUSE
    EXIT /B 1
)

REM Check if libs directory exists and has content
IF NOT EXIST "libs\*.lib" (
    ECHO ERROR: Libraries not found in libs\ directory
    ECHO Please run build_all_libs.cmd first to build the required libraries
    PAUSE
    EXIT /B 1
)

REM Build eMule
CD eMule\srchybrid

ECHO Building eMule...
MSBuild emule.vcxproj -target:Clean,Build /property:Configuration=Release /property:Platform=x64 /nologo /verbosity:minimal

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
ECHO eMule Built Successfully!
ECHO ============================================
ECHO.
ECHO Executable location: eMule\srchybrid\x64\Release\emule.exe
ECHO.

PAUSE
EXIT /B 0
