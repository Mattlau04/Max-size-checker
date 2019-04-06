@echo off
:sub:
echo scan subfolders?
echo 1. yes
echo 2. no
echo.
set /P sub=enter your choice: 
IF %sub% EQU 1 goto continue
IF %sub% EQU 2 goto continue
cls
echo invalid value :/
Timeout /T 3 /NOBREAK > NUL
cls
goto sub

:continue:
echo.
set /P path=path to the folder to scan: 
echo.
set /P pathsize=path to the folder where size.txt will be created: 
echo.
set /P maxsize=maximum size of the files (in bytes): 
cd %pathsize%
del size.txt
cd %path%
cls
IF %sub% EQU 1 goto :withsub:
IF %sub% EQU 2 goto :withoutsub:
echo you shouldn't be reading this :/
pause
exit
:withoutsub:
for %%F in (*.txt) do (
    echo checking %%F
    FOR %%I in (%%F) do if %%~zI GEQ %maxsize% echo %%F>>"%pathsize%\size.txt"
)
echo _________________________
echo done!
pause > NUL
exit

:withsub:
for /R %%F in (*.txt) do (
    echo checking %%~nF%%~xF
    FOR %%I in (%%~nF%%~xF) do if %%~zI GEQ %maxsize% echo %%F>>"%pathsize%\size.txt"
)
echo _________________________
echo done!
pause > NUL
exit