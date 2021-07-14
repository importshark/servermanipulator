@echo off
if not exist "C:\Program Files\Java" echo This program cannot run without Java! Please install it! If you have installed it, make sure it is installed at "C:\Program Files\Java"
:open
echo Welcome to the official minecraft vanilla server manipulator
set /p answer=What operation would you like to execute? [E]dit, [C]reate, [D]elete, [B]ackup  or [R]un
if "%answer%"=="E" goto edit
if "%answer%"=="C" goto create
if "%answer%"=="R" goto run
if "%answer%"=="D" goto del
if "%answer%"=="B" goto bkup
echo Answer!
goto open

:bkup
if not exist %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4% mkdir %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
Robocopy /S /E . ./%date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
pause
exit

:del
echo This server is about to delete! This CANNOT be undone! If you do not want to delete, close this window now! Otherwise, press any key.
pause
rmdir . /S /Q
exit

:edit
echo Edit server tool loaded.
echo %.%
pause
exit

:cq

exit


:create
if exist server.jar goto error
echo Server will create, but you must answer some questions.
set /p answer=Override automatic optimization for low end devices? (Y/N)?
if "%answer%"=="Y" set software=mcmain
if "%answer%"=="N" set software=paper
set /p answer=What version? Type version or latest
if "%answer%"=="latest" set version="latest"
echo Server creating!
echo %software%
echo %version%
pause
if %software% EQU mcmain (
    if %version%  EQU "latest" (
        curl https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar --output server.jar
    )
)
if %software% EQU paper (
    if %version%  EQU "latest" (
        curl https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/100/downloads/paper-1.17.1-100.jar --output server.jar
    )
)
pause
goto run

exit

:error
echo The installer has run into an unexpected problem, and will need to quit. We're sorry!
pause
exit

:run
if exist server.jar echo Running server!
if not exist server.jar goto error
if not exist eula.txt java -Xmx1024M -Xms1024M -jar server.jar
>nul find "false" eula.txt && (
  curl https://download1075.mediafire.com/dcscrezdt3rg/uhxrh3zhv12oza8/eula.txt --output eula.txt
) || (
  echo Server test complete.
)
java -Xmx1024M -Xms1024M -jar server.jar

pause
exit
