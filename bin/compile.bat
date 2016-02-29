@echo off

call env.bat

set HOME=%EMACS_CONFIG_HOME%
cd %HOME%
REM emacs -batch -f batch-byte-compile *.el
%EMACS_BIN%\emacs.exe -debug-init -q -batch -f batch-byte-compile ..\config\*.el
%EMACS_BIN%\emacs.exe -debug-init -q -l ..\config\init.el -batch -f batch-byte-compile ..\config\modules\*.el
pause
