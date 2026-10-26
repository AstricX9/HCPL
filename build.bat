@echo off
REM Windows build, no make needed. Output: hcpl.exe
REM Uses gcc if it is on PATH, otherwise Visual Studio's cl.
setlocal
cd /d "%~dp0src"
set SRC=lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c ^
 lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c ltm.c ^
 lundump.c lvm.c lzio.c ^
 lauxlib.c lbaselib.c lcorolib.c ldblib.c liolib.c lmathlib.c loadlib.c ^
 loslib.c lstrlib.c ltablib.c lutf8lib.c linit.c ^
 lua.c

where gcc >nul 2>nul
if errorlevel 1 goto msvc
gcc -std=gnu99 -O2 -Wall -o ..\hcpl.exe %SRC%
goto built

:msvc
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" goto nocompiler
set VSDIR=
for /f "usebackq delims=" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSDIR=%%i"
if not defined VSDIR goto nocompiler
call "%VSDIR%\VC\Auxiliary\Build\vcvars64.bat" >nul
cl /nologo /O2 /std:c11 /D_CRT_SECURE_NO_WARNINGS /Fe..\hcpl.exe %SRC%
if errorlevel 1 goto failed
del *.obj 2>nul

:built
if errorlevel 1 goto failed
echo Built hcpl.exe. Try: .\hcpl.exe examples\guess.hpl
exit /b 0

:failed
echo Build failed.
exit /b 1

:nocompiler
echo No C compiler found. Install one of these, then open a new terminal:
echo   Visual Studio Build Tools with "Desktop development with C++"
echo   or gcc:  winget install BrechtSanders.WinLibs.POSIX.UCRT
exit /b 1
