@echo off

cd /d %~dp0%
call env.bat

set ddd=%date%@%time%
set "ddd=%ddd:/=-%"
set "ddd=%ddd: =-%"
set "ddd=%ddd::=#%"

set ZIP_HOME=%APP_HOME%-zip

if not exist %ZIP_HOME% (
   mkdir %ZIP_HOME%
)

set /p choice=compress the app directory (y/n)?
if /I "%choice%"=="y" goto zip
if /I "%choice%"=="n" goto commit
goto end

:zip
REM rm -rf *.7z.*
REM 7z a -v5m -t7z %ZIP_HOME%\apps-%ddd%.7z %APP_HOME%\*
cd %ZIP_HOME%
rm -rf *.z*

cd %ROOT%/home
zip -r apps.zip apps
mv apps.zip %ZIP_HOME%

cd %ZIP_HOME%
REM 分卷
split -d -b 3m apps.zip apps.
ping -n 1 127.0.0.1>nul
rm -rf apps.zip
REM 合并
REM cat apps-%ddd%.zip.* > %ddd%.zip
REM unzip %ddd%.zip
REM goto end

rem cd %ROOT%
rem 生成app-fetch
rem rm -rf app-fetch
rem cp app-fetch.tpl app-fetch
rem sed -i "s/ttttt/%ddd%/g" app-fetch

rem 提交app-fetch
git reset
git add app-fetch
git status
git commit -m "modify app-fetch: %ddd%"
git push -u origin master

rem 提交app
cd %ZIP_HOME%
git reset
git add .
git status
git commit -m "modify app: %ddd%"
git push -u origin master
goto end

:commit
cd %ZIP_HOME%
git reset
git add *
git status
set /p msg=please input commit message:
git commit -m "%msg%"
git push -u origin master
goto end

:end
pause
