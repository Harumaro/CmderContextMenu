SET CMDERPATH=D:\Documents\work\Cmder
SET CMDERPATHREG=%CMDERPATH:\=\\%
SET ADDREGFILE=%CMDERPATH%"\cmder_set_ctx_menu.reg"
SET DELREGFILE=%CMDERPATH%"\cmder_unset_ctx_menu.reg"

type %ADDREGFILE%
echo Windows Registry Editor Version 5.00 > %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder] >> %ADDREGFILE%
echo "Icon"="\"%CMDERPATHREG%\\Cmder.exe\"" >> %ADDREGFILE%
echo @="Open Cmder" >> %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder\command] >> %ADDREGFILE%
echo @="wscript.exe \"%CMDERPATHREG%\\invis.vbs\" \"%CMDERPATHREG%\\Cmder.bat\"" >> %ADDREGFILE%

type %DELREGFILE%
echo Windows Registry Editor Version 5.00 > %DELREGFILE%
echo. >> %DELREGFILE%
echo [-HKEY_CLASSES_ROOT\directory\background\shell\Cmder] >> %DELREGFILE%