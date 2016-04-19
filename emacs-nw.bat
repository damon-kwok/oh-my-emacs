@echo off

cd /d %~dp0%
call env.bat
call app-fetch.bat

copy /y %HOME%\config\.emacs %HOME%\.emacs
cd %HOME%
%EMACS_BIN%\emacs.exe -nw --debug-init

REM -nw -l %HOME%\config\init.el
REM %EMACS_BIN%\emacs.exe -debug-init -nw -batch -f batch-byte-compile ..\config\*.el -q -l ..\config\init.el
