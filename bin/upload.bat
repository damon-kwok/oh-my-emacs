@echo off

cd /d %~dp0%
call env.bat

set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%
set week=%date:~10,6%
set hour=%time:~0,2%
set minute=%time:~3,2%
set second=%time:~6,2%
set ms=%time:~9,2%

mkdir ..\cache\uploads
7z a -v10m -t7z "..\cache\uploads\apps-%year%-%month%-%day%--%hour%-%minute%.7z" "..\cache\apps\*"

git add .
git commit -m "apps-%year%-%month%-%day%--%hour%-%minute%.7z"
git push -u origin master
