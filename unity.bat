@echo off

call medusa.bat env

set UNITY_HOME="C:\Program Files\Unity"
set UNITY_BIN=%UNITY_HOME%\Editor

REM ::code by LZ-MyST QQ:8450919 BLOG:http://hi.baidu.com/lzmyst http://www.clxp.net.cn
if "%1" neq "1" (
>"%temp%\tmp.vbs" echo set WshShell = WScript.CreateObject^(^"WScript.Shell^"^)
>>"%temp%\tmp.vbs" echo WshShell.Run chr^(34^) ^& %0 ^& chr^(34^) ^& ^" 1^",0
start /d "%temp%" tmp.vbs
exit
) 

%UNITY_BIN%\Unity.exe




