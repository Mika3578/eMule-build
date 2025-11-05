@ECHO OFF
REM eMule Build Environment Setup
REM This script clones all repositories, creates symlinks, and prepares the build environment

SETLOCAL EnableDelayedExpansion

CD /D %~dp0

ECHO ============================================
ECHO eMule Build Environment Setup
ECHO ============================================
ECHO.

REM Check for git
git --version >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: Git is not installed or not in PATH
    PAUSE
    EXIT /B 1
)

ECHO [1/3] Cloning repositories...
ECHO.

REM Clone external libraries
CALL :CloneRepo "https://github.com/itlezy/eMule-libpng.git" "eMule-libpng-1.5.30" "1.5.30-eMule"
CALL :CloneRepo "https://github.com/itlezy/eMule-mbedtls.git" "eMule-mbedtls-2.28" "mbedtls-2.28-eMule"
CALL :CloneRepo "https://github.com/itlezy/eMule-cryptopp.git" "eMule-cryptopp-8.4.0" "CRYPTOPP_8_4_0-eMule"
CALL :CloneRepo "https://github.com/itlezy/eMule-zlib.git" "eMule-zlib-1.2.12" "v1.2.12-eMule"
CALL :CloneRepo "https://github.com/itlezy/eMule-miniupnp.git" "eMule-miniupnp-2.2.3" "miniupnpc_2_2_3-eMule"

REM Clone support libraries (less frequently updated)
CALL :CloneRepo "https://github.com/itlezy/eMule-CxImage.git" "eMule-CxImage-7.02" ""
CALL :CloneRepo "https://github.com/itlezy/eMule-id3lib.git" "eMule-id3lib-3.9.1" "v3.9.1"
CALL :CloneRepo "https://github.com/itlezy/eMule-ResizableLib.git" "eMule-ResizableLib" ""

REM Clone eMule main repository
CALL :CloneRepo "https://github.com/itlezy/eMule.git" "eMule" "v0.60d-build"

ECHO.
ECHO [2/3] Creating directory structure...
ECHO.

REM Create lib directories
IF NOT EXIST libs MKDIR libs
IF NOT EXIST libs_debug MKDIR libs_debug
IF NOT EXIST eMule-zz-deps-links MKDIR eMule-zz-deps-links

ECHO [3/3] Creating symbolic links...
ECHO.

CD eMule-zz-deps-links

REM Create symlinks for library references
SET JUNC=mklink

CALL :CreateSymlink "cryptopp" "..\eMule-cryptopp-8.4.0"
CALL :CreateSymlink "CxImage" "..\eMule-CxImage-7.02\CxImage"
CALL :CreateSymlink "id3" "..\eMule-id3lib-3.9.1\include\id3"
CALL :CreateSymlink "mbedtls" "..\eMule-mbedtls-2.28\include\mbedtls"
CALL :CreateSymlink "miniupnpc" "..\eMule-miniupnp-2.2.3\miniupnpc\include"
CALL :CreateSymlink "ResizableLib" "..\eMule-ResizableLib\ResizableLib"
CALL :CreateSymlink "zlib" "..\eMule-zlib-1.2.12"

CD /D %~dp0

ECHO.
ECHO ============================================
ECHO Setup Complete!
ECHO ============================================
ECHO.
ECHO Next steps:
ECHO   1. Run: build_all_libs.cmd          - Build all libraries
ECHO   2. Run: build_emule.cmd             - Build eMule executable
ECHO.
ECHO For debug builds:
ECHO   1. Run: build_all_libs_debug.cmd    - Build debug libraries
ECHO   2. Run: build_emule_debug.cmd       - Build eMule in debug mode
ECHO.
PAUSE
EXIT /B 0

REM ============================================
REM Helper Functions
REM ============================================

:CloneRepo
REM Usage: CALL :CloneRepo "url" "folder" "branch"
SET "REPO_URL=%~1"
SET "FOLDER=%~2"
SET "BRANCH=%~3"

IF EXIST "%FOLDER%" (
    ECHO   [SKIP] %FOLDER% already exists
    EXIT /B 0
)

ECHO   Cloning %FOLDER%...
git clone "%REPO_URL%" "%FOLDER%" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO   [ERROR] Failed to clone %FOLDER%
    EXIT /B 1
)

IF NOT "%BRANCH%"=="" (
    CD "%FOLDER%"
    git switch "%BRANCH%" >NUL 2>&1
    IF %ERRORLEVEL% NEQ 0 (
        ECHO   [ERROR] Failed to switch to branch %BRANCH%
        EXIT /B 1
    )
    CD /D %~dp0
)

ECHO   [OK] %FOLDER%
EXIT /B 0

:CreateSymlink
REM Usage: CALL :CreateSymlink "link_name" "target"
SET "LINK=%~1"
SET "TARGET=%~2"

IF EXIST "%LINK%" (
    ECHO   [SKIP] %LINK% already exists
    EXIT /B 0
)

%JUNC% /D "%LINK%" "%TARGET%" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO   [ERROR] Failed to create symlink %LINK%
    EXIT /B 1
)

ECHO   [OK] %LINK% -> %TARGET%
EXIT /B 0
