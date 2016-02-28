@echo off

cd /d %~dp0%
call env.bat
call download.bat

set HOME=%EMACS_CONFIG_HOME%
copy /y %ROOT%\config\templates\.emacs %HOME%\.emacs

cd %HOME%

%EMACS_BIN%\emacs.exe -debug-init -nw -l %ROOT%\config\init.el
REM %EMACS_BIN%\emacs.exe -debug-init -nw -batch -f batch-byte-compile ..\config\*.el -q -l ..\config\init.el
