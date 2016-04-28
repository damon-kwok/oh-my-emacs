@echo off

cd /d %~dp0%
call env.bat
bash app-fetch

rem set HOME=%CD%\home
rem set EMACS_HOME=%APP_HOME%\emacs-bin-w64-25.0.92-O2
rem set EMACS_HOME=%APP_HOME%\emacs-25-20160331T094545Z-bin-i686-mingw32
rem set EMACS_BIN=%EMACS_HOME%\bin

copy /y %HOME%\emacs-config\.emacs %HOME%\.emacs
cd %HOME%
start %EMACS_BIN%\runemacs.exe --debug-init
