@echo off
:sub:
echo scan subfolders?
echo 1. yes
echo 2. no
echo.
set /P sub=enter your choice: 
echo.
IF %sub% EQU 1 goto continue
IF %sub% EQU 2 goto continue
cls
echo invalid value :/
Timeout /T 3 /NOBREAK > NUL
cls
goto sub

:continue:
echo only scan file with a specific extension?
echo 1. yes
echo 2. no
echo.
set /P extchoose=enter your choice: 
IF %extchoose% EQU 1 goto chooseext
IF %extchoose% EQU 2 set choice=& goto continue2
cls
echo invalid value :/
Timeout /T 3 /NOBREAK > NUL
cls
goto continue
exit

:chooseext:
echo.
Set /P ext=scan file with what extension? 
if NOT %ext:~0,1% EQU . set ext=.%ext%
goto continue2
exit

:continue2:
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
for %%F in (*%ext%) do (
    echo checking %%F
    FOR %%I in (%%F) do if %%~zI GEQ %maxsize% echo %%F>>"%pathsize%\size.txt"
)
echo _________________________
echo done!
pause > NUL
exit

:withsub:
for /R %%F in (*%ext%) do (
    echo checking %%~nF%%~xF
    FOR %%I in (%%~nF%%~xF) do if %%~zI GEQ %maxsize% echo %%F>>"%pathsize%\size.txt"
)
echo _________________________
echo done!
pause > NUL
exit