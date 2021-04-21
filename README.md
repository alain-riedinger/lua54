# lua54

Simple lua build for Windows

Simple said, I need **lua** and I need it under *Windows*. I need it precisely to be able to debug the *lua* scripted extensions and plugins that I realize under 2 of my favourite editors [SciTE](https://www.scintilla.org/SciTE.html) and [Textadept](https://foicica.com/textadept/).
To achieve this debugging, there are a lot of modules out there, all of them relying on a module called **luasocket**.

So far, so good, but when you work under *Windows* it becomes really difficult to get the binaries for this *luasocket* module, as it is **C** based:
- I need the module under *Windows*
- I need it in **Win32** and also **x64** release
- I have **Visual Studio 2019 Community Edition**

I searched and searched, stumbled on [LuaRocks - The Lua package manager](https://luarocks.org/), but never made it to correctly get this module, in the right release, compiled with **Visual Studio**...

So first step, is to build **lua**. I found this site: 
[How to compile Lua 5.3.5 for Windows | The curse of Dennis D. Spreen](https://blog.spreendigital.de/2019/06/25/how-to-compile-lua-5-3-5-for-windows/)
It works correctly, and was a solid base for my needs.

I added some resource files to describe the versions, with a lua icon, and a build script, that enables to build on Windows, with **Visual Studio 2017** installed. The script produces the binaries and the includes for a usable **lua**, under those sub-directories:
- **Win32**
- **x64**

Each of those build sub-directory contains:
- **bin**, the executable binaries: "lua54.dll", "lua54.exe", "luac54.exe"
- **include**, the needed includes for compiling lua modules
- **lib**, the libraries "lua54.lib" (that matches "lua54.dll") and "lua54-static.lib" (that is a self contained library for a complete **lua**)

## lua building procedure

- Get the lua sources from [Lua: download area](http://www.lua.org/ftp/) and put them under **src** sub-directory
- If needed, edit the resource files (".rc") to modify / adapt the version of **lua**
- In a DOS console, under the *lua\src* sub-directory, launch the build of the lua binaries:
```
Buid-lua.cmd Win32
Buid-lua.cmd x64
```
