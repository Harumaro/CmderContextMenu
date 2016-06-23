SET CMDERPATH=D:\Documents\work\Cmder
SET FILENAME=%CMDERPATH%"\config\user-startup.cmd"
echo @cd /d %cd% >> %FILENAME%
echo cls >> %FILENAME%
%CMDERPATH%"\Cmder.exe"
