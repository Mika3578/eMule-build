@ECHO OFF

ECHO ================================================================
ECHO DEPRECATION NOTICE
ECHO ================================================================
ECHO.
ECHO This script has been superseded by the new simplified scripts.
ECHO.
ECHO Please use instead:
ECHO   setup_emule.cmd        - Complete setup (replaces 001 and 002)
ECHO.
ECHO Or for complete automation:
ECHO   build_complete.cmd     - Setup + Build everything
ECHO.
ECHO See README.md or QUICK_START.md for more information.
ECHO.
ECHO ================================================================
ECHO.
ECHO Continuing with legacy script in 5 seconds...
TIMEOUT /T 5 /NOBREAK >NUL
ECHO.

CD /D %~dp0

MKDIR libs libs_debug
MKDIR eMule-zz-deps-links

CD eMule-zz-deps-links

SET JUNC=mklink

REM CREATING SYMLINKS TO KEEP NICE NAMING OUTSIDE AND NOT CHANGE SOURCE CODE

%JUNC% /D cryptopp      ..\eMule-cryptopp-8.4.0
%JUNC% /D CxImage       ..\eMule-CxImage-7.02\CxImage
%JUNC% /D id3           ..\eMule-id3lib-3.9.1\include\id3
%JUNC% /D mbedtls       ..\eMule-mbedtls-2.28\include\mbedtls
%JUNC% /D miniupnpc     ..\eMule-miniupnp-2.2.3\miniupnpc\include
%JUNC% /D ResizableLib  ..\eMule-ResizableLib\ResizableLib
%JUNC% /D zlib          ..\eMule-zlib-1.2.12
