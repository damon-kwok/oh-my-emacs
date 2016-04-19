@echo off

cd /d %~dp0%
call env.bat

rem 2.1 将文件1.txt内的文字“garden”替换成“mirGarden”
rem # sed -i "s/garden/mirGarden/g" 1.txt //sed -i 很简单

set ddd=%date%@%time%
set "ddd=%ddd:/=-%"
set "ddd=%ddd: =-%"
set "ddd=%ddd::=#%"

set ZIP_HOME=%APP_HOME%-zip

if not exist %ZIP_HOME% (
   mkdir %ZIP_HOME%
)

echo %DIR_APPZIP%\apps-%ddd%.7z
7z a -v5m -t7z %ZIP_HOME%\apps-%ddd%.7z %APP_HOME%\*

rem 生成download.bat
rm -rf app-fetch.bat
cp app-fetch.tpl app-fetchbat
sed -i "s/ttttt/%ddd%/g" app-fetch.bat

rem 提交app-fetch
git reset
git add app-fetch.bat
git status
git commit -m "modify app-fetch: %ddd%"
git push -u origin master

rem 提交app
cd %ZIP_HOME%
rm -rf *.7z.*

git reset
git add .
git status
git commit -m "modify app: %ddd%"
git push -u origin master

pause
