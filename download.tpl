cd /d %~dp0%
call env.bat

set ZIP_HOME=%APP_HOME%-zip

if exist %APP_HOME% (
   echo apps exist!
) else(
  echo apps missing!
  if exist %ZIP_HOME% (
     git fetch
     7z x %ZIP_HOME%p\apps-ttttt.7z.001 -y -aos -o%APP_HOME%
  ) else (
     git clone https://github.com/damon-kwok/my-emacs-apps.git %ZIP_HOME%
     7z x %ZIP_HOME%p\apps-ttttt.7z.001 -y -aos -o%APP_HOME%
  ) 
)