@echo off

cd ..
call medusa.bat env
Omnisharp.exe -s D:\Projects\Orc\Orc.sln
pause