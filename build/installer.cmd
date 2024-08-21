@echo off
cls

Title Creating TVServer Kodi Installer

IF "%programfiles(x86)%XXX"=="XXX" GOTO 32BIT
    :: 64-bit
    SET PROGS=%programfiles(x86)%
    GOTO CONT
:32BIT
    SET PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=*" %%i IN ('..\Tools\Tools\sigcheck.exe /accepteula /nobanner /n "..\TVServerKodi\bin\Release\TVServerKodi.dll"') DO (SET version=%%i)

:: Temp xmp2 file
COPY ..\TVServerKodi\Installer\TVServerKodi.xmp2 ..\TVServerKodi\Installer\TVServerKodiTemp.xmp2

:: Build MPE1
CD ..\TVServerKodi\Installer
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" TVServerKodiTemp.xmp2 /B /V=%version% /UpdateXML
CD ..\..\build

:: Cleanup
del ..\TVServerKodi\Installer\TVServerKodiTemp.xmp2
