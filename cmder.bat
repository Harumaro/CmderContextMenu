SET CMDERPATH=
SET FILENAME=%CMDERPATH%\config\user-startup.cmd
SET OLDNAME=%CMDERPATH%\config\user-startup.old
move /y %FILENAME% %OLDNAME%
echo @cd /d %cd% >> %FILENAME%
echo cls >> %FILENAME%
%CMDERPATH%"\Cmder.exe"
timeout /t 3 /nobreak > NUL
move /y %OLDNAME% %FILENAME%
