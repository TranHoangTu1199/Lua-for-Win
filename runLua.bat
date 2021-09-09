::code by Cmy 草莓
@echo off
CHCP 1258 >nul 2>&1
CHCP 65001 >nul 2>&1
title Run code Lua
cls
set patlink=%0
set patlink1=%1
set patlink=%patlink:~1,-11%
echo %patlink1%>"%patlink%RunCodeFileLink.txt"
"%patlink%lua.exe" "%patlink%RunCode.lua"
pause