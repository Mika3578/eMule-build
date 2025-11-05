@ECHO OFF
REM Build all eMule libraries in Release mode

SETLOCAL EnableDelayedExpansion

CD /D %~dp0

ECHO ============================================
ECHO Building All eMule Libraries (Release)
ECHO ============================================
ECHO.

REM Setup Visual Studio environment
CALL incl_VCVARS64.cmd
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: Failed to setup Visual Studio environment
    PAUSE
    EXIT /B 1
)

SET BUILD_FAILED=0

ECHO [1/8] Building cryptopp...
CALL :BuildLib "cryptopp" "eMule-cryptopp-8.4.0" "cryptlib.vcxproj" "x64\Output\Release\cryptlib.lib" "x64\Output\Release\cryptlib.pdb" "libs"

ECHO [2/8] Building CxImage...
CALL :BuildLib "CxImage" "eMule-CxImage-7.02" "CxImage\CxImage.vcxproj" "bin64\CxImage.lib" "bin64\CxImage.pdb" "libs"

ECHO [3/8] Building id3lib...
CALL :BuildLib "id3lib" "eMule-id3lib-3.9.1" "id3lib.vcxproj" "bin64\id3lib.lib" "bin64\id3lib.pdb" "libs"

ECHO [4/8] Building libpng...
CALL :BuildLib "libpng" "eMule-libpng-1.5.30" "projects\vstudio\libpng\libpng.vcxproj" "projects\vstudio\x64\Release\libpng15.lib" "projects\vstudio\x64\Release\libpng15.pdb" "libs"

ECHO [5/8] Building mbedtls...
CALL :BuildLib "mbedtls" "eMule-mbedtls-2.28" "visualc\VS2010\mbedTLS.vcxproj" "visualc\VS2010\x64\Release\mbedTLS.lib" "visualc\VS2010\x64\Release\mbedTLS.pdb" "libs"

ECHO [6/8] Building miniupnp...
CALL :BuildLib "miniupnp" "eMule-miniupnp-2.2.3" "miniupnpc\msvc\miniupnpc.vcxproj" "miniupnpc\msvc\x64\Release\miniupnpc.lib" "miniupnpc\msvc\x64\Release\miniupnpc.pdb" "libs"

ECHO [7/8] Building ResizableLib...
CALL :BuildLib "ResizableLib" "eMule-ResizableLib" "ResizableLib\ResizableLib.vcxproj" "x64\Release\ResizableLib.lib" "x64\Release\ResizableLib.pdb" "libs"

ECHO [8/8] Building zlib...
CALL :BuildLib "zlib" "eMule-zlib-1.2.12\contrib\vstudio\vc17" "zlibstat.vcxproj" "x64\ZlibStatRelease\zlibstat.lib" "x64\ZlibStatRelease\zlibstat.pdb" "libs"

ECHO.
ECHO ============================================
IF %BUILD_FAILED% EQU 0 (
    ECHO All Libraries Built Successfully!
    ECHO ============================================
    ECHO.
    ECHO Libraries are in: %~dp0libs\
    ECHO.
    ECHO Next step: Run build_emule.cmd to build eMule
    ECHO.
) ELSE (
    ECHO Build Failed!
    ECHO ============================================
    ECHO One or more libraries failed to build.
    ECHO Please check the output above for errors.
    ECHO.
)

PAUSE
EXIT /B %BUILD_FAILED%

REM ============================================
REM Helper Function to Build Library
REM ============================================
:BuildLib
REM Usage: CALL :BuildLib "name" "path" "project" "lib_output" "pdb_output" "dest"
SET "LIB_NAME=%~1"
SET "LIB_PATH=%~2"
SET "PROJECT=%~3"
SET "LIB_OUTPUT=%~4"
SET "PDB_OUTPUT=%~5"
SET "DEST=%~6"

IF NOT EXIST "%LIB_PATH%" (
    ECHO   [ERROR] Directory not found: %LIB_PATH%
    SET BUILD_FAILED=1
    EXIT /B 1
)

CD /D %~dp0
CD "%LIB_PATH%"

MSBuild "%PROJECT%" -target:Clean,Build /property:Configuration=Release /property:Platform=x64 /nologo /verbosity:minimal
IF %ERRORLEVEL% NEQ 0 (
    ECHO   [ERROR] Build failed for %LIB_NAME%
    SET BUILD_FAILED=1
    CD /D %~dp0
    EXIT /B 1
)

CD /D %~dp0

REM Copy output files to libs directory
IF EXIST "%LIB_PATH%\%LIB_OUTPUT%" (
    COPY /Y "%LIB_PATH%\%LIB_OUTPUT%" "%DEST%\" >NUL
    ECHO   [OK] %LIB_NAME% built successfully
) ELSE (
    ECHO   [ERROR] Output file not found: %LIB_OUTPUT%
    SET BUILD_FAILED=1
    EXIT /B 1
)

REM Copy PDB if it exists
IF EXIST "%LIB_PATH%\%PDB_OUTPUT%" (
    COPY /Y "%LIB_PATH%\%PDB_OUTPUT%" "%DEST%\" >NUL
)

EXIT /B 0
