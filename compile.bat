@echo off

call bin\env.bat

set HOME=%EMACS_CONFIG_HOME%
cd %HOME%
REM emacs -batch -f batch-byte-compile *.el
REM %EMACS_BIN%\emacs.exe -debug-init -q -batch -f batch-byte-compile %ROOT%\config\*.el
REM %EMACS_BIN%\emacs.exe -debug-init -q -l %ROOT%\config\init.el -batch -f batch-byte-compile %ROOT%\config\modules\*.el
%EMACS_BIN%\emacs.exe -batch -f batch-byte-compile %ROOT%\config\*.el
%EMACS_BIN%\emacs.exe -batch -f batch-byte-compile %ROOT%\config\modules\*.el
pause
