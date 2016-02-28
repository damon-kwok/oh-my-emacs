@echo off

cd /d %~dp0%
call env.bat

IF EXIST ..\cache\apps (
   echo apps exist!
) ELSE (
  echo apps missing!
  IF EXIST ..\cache\apps-zip (
     7z x "..\cache\apps-zip\apps-2016-02-28--15-05.7z.001" -y -aos -o"..\cache\apps"
  ) ELSE (
     git clone https://github.com/damon-kwok/my-emacs-apps.git ..\cache\apps-zip
     7z x "..\cache\apps-zip\apps-2016-02-28--15-05.7z.001" -y -aos -o"..\cache\apps"
  ) 
)
pause
