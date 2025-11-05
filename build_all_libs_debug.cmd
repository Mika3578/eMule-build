@ECHO OFF
REM Build all eMule libraries in Debug mode

SETLOCAL EnableDelayedExpansion

CD /D %~dp0

ECHO ============================================
ECHO Building All eMule Libraries (Debug)
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

ECHO [1/8] Building cryptopp (Debug)...
CALL :BuildLib "cryptopp" "eMule-cryptopp-8.4.0" "cryptlib.vcxproj" "x64\Output\Debug\cryptlib.lib" "x64\Output\Debug\cryptlib.pdb" "libs_debug"

ECHO [2/8] Building CxImage (Debug)...
CALL :BuildLib "CxImage" "eMule-CxImage-7.02" "CxImage\CxImage.vcxproj" "bin64\CxImageD.lib" "bin64\CxImageD.pdb" "libs_debug"

ECHO [3/8] Building id3lib (Debug)...
CALL :BuildLib "id3lib" "eMule-id3lib-3.9.1" "id3lib.vcxproj" "bin64\id3libD.lib" "bin64\id3libD.pdb" "libs_debug"

ECHO [4/8] Building libpng (Debug)...
CALL :BuildLib "libpng" "eMule-libpng-1.5.30" "projects\vstudio\libpng\libpng.vcxproj" "projects\vstudio\x64\Debug\libpng15d.lib" "projects\vstudio\x64\Debug\libpng15d.pdb" "libs_debug"

ECHO [5/8] Building mbedtls (Debug)...
CALL :BuildLib "mbedtls" "eMule-mbedtls-2.28" "visualc\VS2010\mbedTLS.vcxproj" "visualc\VS2010\x64\Debug\mbedTLS.lib" "visualc\VS2010\x64\Debug\mbedTLS.pdb" "libs_debug"

ECHO [6/8] Building miniupnp (Debug)...
CALL :BuildLib "miniupnp" "eMule-miniupnp-2.2.3" "miniupnpc\msvc\miniupnpc.vcxproj" "miniupnpc\msvc\x64\Debug\miniupnpc.lib" "miniupnpc\msvc\x64\Debug\miniupnpc.pdb" "libs_debug"

ECHO [7/8] Building ResizableLib (Debug)...
CALL :BuildLib "ResizableLib" "eMule-ResizableLib" "ResizableLib\ResizableLib.vcxproj" "x64\Debug\ResizableLib.lib" "x64\Debug\ResizableLib.pdb" "libs_debug"

ECHO [8/8] Building zlib (Debug)...
CALL :BuildLib "zlib" "eMule-zlib-1.2.12\contrib\vstudio\vc17" "zlibstat.vcxproj" "x64\ZlibStatDebug\zlibstat.lib" "x64\ZlibStatDebug\zlibstat.pdb" "libs_debug"

ECHO.
ECHO ============================================
IF %BUILD_FAILED% EQU 0 (
    ECHO All Debug Libraries Built Successfully!
    ECHO ============================================
    ECHO.
    ECHO Debug libraries are in: %~dp0libs_debug\
    ECHO.
    ECHO Next step: Run build_emule_debug.cmd to build eMule in debug mode
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

MSBuild "%PROJECT%" -target:Clean,Build /property:Configuration=Debug /property:Platform=x64 /nologo /verbosity:minimal
IF %ERRORLEVEL% NEQ 0 (
    ECHO   [ERROR] Build failed for %LIB_NAME%
    SET BUILD_FAILED=1
    CD /D %~dp0
    EXIT /B 1
)

CD /D %~dp0

REM Copy output files to libs_debug directory
IF EXIST "%LIB_PATH%\%LIB_OUTPUT%" (
    COPY /Y "%LIB_PATH%\%LIB_OUTPUT%" "%DEST%\" >NUL
    ECHO   [OK] %LIB_NAME% built successfully (Debug)
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
