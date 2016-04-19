@echo off

cd /d %~dp0%
call env.bat

git reset
git add .
git status

set /p a=please input commit message:
git commit -m "%a%"

git push -u origin master