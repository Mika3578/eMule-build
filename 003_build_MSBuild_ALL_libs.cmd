@ECHO OFF

ECHO ================================================================
ECHO DEPRECATION NOTICE
ECHO ================================================================
ECHO.
ECHO This script has been superseded by the new simplified scripts.
ECHO.
ECHO Please use instead:
ECHO   build_all_libs.cmd     - Build all libraries (Release)
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

START "" %ComSpec% /C build_MSBuild_eMule-cryptopp-8.4.0.cmd
START "" %ComSpec% /C build_MSBuild_eMule-CxImage-7.02.cmd
START "" %ComSpec% /C build_MSBuild_eMule-id3lib-3.9.1.cmd
START "" %ComSpec% /C build_MSBuild_eMule-libpng-1.5.30.cmd
START "" %ComSpec% /C build_MSBuild_eMule-mbedtls-2.28.cmd
START "" %ComSpec% /C build_MSBuild_eMule-miniupnp-2.2.3.cmd
START "" %ComSpec% /C build_MSBuild_eMule-ResizableLib.cmd
START "" %ComSpec% /C build_MSBuild_eMule-zlib-1.2.12.cmd
