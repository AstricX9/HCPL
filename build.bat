@echo off
REM Windows build with gcc (MinGW / MSYS2), no make needed. Output: hcpl.exe
cd /d "%~dp0src"
gcc -std=gnu99 -O2 -Wall -o ..\hcpl.exe ^
    lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c ^
    lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c ltm.c ^
    lundump.c lvm.c lzio.c ^
    lauxlib.c lbaselib.c lcorolib.c ldblib.c liolib.c lmathlib.c loadlib.c ^
    loslib.c lstrlib.c ltablib.c lutf8lib.c linit.c ^
    lua.c
if errorlevel 1 exit /b 1
cd ..
echo Built hcpl.exe. Try: hcpl.exe examples\guess.hpl
