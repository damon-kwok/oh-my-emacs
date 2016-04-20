@echo off

cd /d %~dp0%
call env.bat

git reset
git add .
git status
set /p msg=please input commit message:
git commit -m "%msg%"
git push -u origin master
pause