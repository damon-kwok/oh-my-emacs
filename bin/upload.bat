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

set DIR_APPZIP=%CACHE%apps-zip
set DIR_APP=%CACHE%\apps

IF NOT EXIST %DIR_APPZIP% (
   mkdir %DIR_APPZIP%
)

7z a -v10m -t7z %DIR_APPZIP%\apps-%year%-%month%-%day%--%hour%-%minute%.7z %DIR_APP%\*

cd %DIR_APPZIP%
git add .
git commit -m "apps-%year%-%month%-%day%--%hour%-%minute%.7z"
git push -u origin master

pause
