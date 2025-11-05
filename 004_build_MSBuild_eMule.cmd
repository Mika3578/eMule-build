@ECHO OFF

ECHO ================================================================
ECHO DEPRECATION NOTICE
ECHO ================================================================
ECHO.
ECHO This script has been superseded by the new simplified scripts.
ECHO.
ECHO Please use instead:
ECHO   build_emule.cmd        - Build eMule (Release)
ECHO   build_emule_debug.cmd  - Build eMule (Debug)
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

START "" %ComSpec% /C build_MSBuild_eMule.cmd
