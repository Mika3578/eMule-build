@ECHO OFF
REM Complete build script - Setup and build everything in one go

SETLOCAL

CD /D %~dp0

ECHO ============================================
ECHO eMule Complete Build Process
ECHO ============================================
ECHO.
ECHO This script will:
ECHO   1. Setup the build environment (if needed)
ECHO   2. Build all libraries
ECHO   3. Build eMule
ECHO.
ECHO This may take several minutes...
ECHO.
PAUSE

REM Check if setup is needed
IF NOT EXIST "eMule" (
    ECHO.
    ECHO Running initial setup...
    CALL setup_emule.cmd
    IF %ERRORLEVEL% NEQ 0 (
        ECHO Setup failed!
        PAUSE
        EXIT /B 1
    )
)

ECHO.
ECHO ============================================
ECHO Building Libraries...
ECHO ============================================
ECHO.

CALL build_all_libs.cmd
IF %ERRORLEVEL% NEQ 0 (
    ECHO Library build failed!
    PAUSE
    EXIT /B 1
)

ECHO.
ECHO ============================================
ECHO Building eMule...
ECHO ============================================
ECHO.

CALL build_emule.cmd
IF %ERRORLEVEL% NEQ 0 (
    ECHO eMule build failed!
    PAUSE
    EXIT /B 1
)

ECHO.
ECHO ============================================
ECHO Complete Build Successful!
ECHO ============================================
ECHO.
ECHO Executable: %~dp0eMule\srchybrid\x64\Release\emule.exe
ECHO.
ECHO You can now run eMule or create a release package.
ECHO.

PAUSE
EXIT /B 0
