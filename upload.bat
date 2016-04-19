@echo off

cd /d %~dp0%
call env.bat

rem 2.1 ���ļ�1.txt�ڵ����֡�garden���滻�ɡ�mirGarden��
rem # sed -i "s/garden/mirGarden/g" 1.txt //sed -i �ܼ�

set ddd=%date%@%time%
set "ddd=%ddd:/=-%"
set "ddd=%ddd: =-%"
set "ddd=%ddd::=#%"

set ZIP_HOME=%APP_HOME%-zip

if not exist %ZIP_HOME% (
   mkdir %ZIP_HOME%
)

echo %DIR_APPZIP%\apps-%ddd%.7z
7z a -v10m -t7z %ZIP_HOME%\apps-%ddd%.7z %APP_HOME%\*

rem ����download.bat
rm -rf download.bat
cp download.tpl download.bat
sed -i "s/ttttt/%ddd%/g" download.bat

rem �ύsrc
git reset
git add .
git status
git commit -m "apps-%ddd%.7z"
git push -u origin master

rem �ύapp
cd %ZIP_HOME%

git reset
git add .
git status
git commit -m "apps-%ddd%.7z"
git push -u origin master

pause
