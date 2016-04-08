@echo off

cd /d %~dp0%
call env.bat

set DIR_APPZIP=%CACHE%\apps-zip
set DIR_APP=%CACHE%\apps

IF EXIST %DIR_APP% (
   echo apps exist!
) ELSE (
  echo apps missing!
  IF EXIST %DIR_APPZIP% (
     git fetch
     7z x %DIR_APPZIP%p\apps-2016-02-28--15-05.7z.001 -y -aos -o%DIR_APP%
  ) ELSE (
     git clone https://github.com/damon-kwok/my-emacs-apps.git ..\cache\apps-zip
     7z x %DIR_APPZIP%p\apps-2016-02-28--15-05.7z.001 -y -aos -o%DIR_APP%
  ) 
)
