@echo off

cd /d %~dp0%
call env.bat

git push -u origin master
