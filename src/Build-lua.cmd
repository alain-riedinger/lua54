@ECHO OFF

SET TARGET=Win32
IF "%1"=="x64" SET TARGET=x64

ECHO Build lua for Windows (target platform is %TARGET%) ?
ECHO (must be launched from the lua "src" directory)
PAUSE

IF NOT EXIST ..\%TARGET%\bin MKDIR ..\%TARGET%\bin
IF NOT EXIST ..\%TARGET%\lib MKDIR ..\%TARGET%\lib

IF NOT EXIST ..\%TARGET%\include MKDIR ..\%TARGET%\include
COPY .\lualib.h  ..\%TARGET%\include\
COPY .\lauxlib.h ..\%TARGET%\include\
COPY .\lua.h     ..\%TARGET%\include\
COPY .\lua.hpp   ..\%TARGET%\include\
COPY .\luaconf.h ..\%TARGET%\include\

IF "%TARGET%"=="Win32" (
	CALL "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
) ELSE (
	CALL "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
)

CL -MP -MD -O2 -c -DLUA_BUILD_AS_DLL *.c
MOVE /Y luac.obj luac.o
RC lua.rc
RC luac.rc
RC lua_dll.rc
LINK -subsystem:console -dll -implib:..\%TARGET%\lib\lua54.lib -out:..\%TARGET%\bin\lua54.dll *.obj lua_dll.res
LINK -out:..\%TARGET%\bin\lua54.exe lua.obj lua.res ..\%TARGET%\lib\lua54.lib
LIB -out:..\%TARGET%\lib\lua54-static.lib *.obj
LINK -out:..\%TARGET%\bin\luac54.exe luac.o luac.res ..\%TARGET%\lib\lua54-static.lib 

DEL ..\%TARGET%\bin\*.lib
DEL ..\%TARGET%\bin\*.exp

PAUSE
