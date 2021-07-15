@echo off
call:%~1 run
if not exist "C:\Program Files\Java" echo This program cannot run without Java! Please install it! If you have installed it, make sure it is installed at "C:\Program Files\Java"
:open
echo Welcome to the official minecraft vanilla server manipulator
set /p answer=What operation would you like to execute? [E]dit, [C]reate, [D]elete, [B]ackup  or [R]un
if "%answer%"=="E" goto edit
if "%answer%"=="C" goto create
if "%answer%"=="R" call runsets.bat
if "%answer%"=="D" goto del
if "%answer%"=="B" goto bkup
echo Answer!
goto open

:bkup
if not exist %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4% mkdir %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
Robocopy /S /E . ./%date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
cd %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
rmdir %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4% /S /Q
Echo backup finished!
pause
exit

:del
echo This server is about to delete! This CANNOT be undone! If you do not want to delete, close this window now! Otherwise, press any key.
pause
rmdir . /S /Q
exit

:edit
if exist tmp rmdir tmp /s /q
echo During a question, type "exit" and server will revert to previous properties backup.
echo If you are not planning to finish, it is highly not recommended you do this because if you exit, all changes will be reverted.
set /p answer=Continue?(Y/N)
if "%answer%"=="N" goto open
mkdir tmp
echo #Minecraft server properties>./tmp/server.properties	
echo #Wed Jul 14 16:38:34 EDT 2021>>./tmp/server.properties
set /p answer=Broadcast rcon to ops? Default is true (Y/N)
if "%answer%"=="Y" echo broadcast-rcon-to-ops=true>>"./tmp/server.properties"
if "%answer%"=="N" echo broadcast-rcon-to-ops=false>>"./tmp/server.properties"
if "%answer%"=="exit" goto editexit
pause
set /p answer=Enable jmx monitoring? Default is false (Y/N)
if "%answer%"=="Y" echo enable-jmx-monitoring=true >./tmp/server.properties
if "%answer%"=="N" echo enable-jmx-monitoring=false>./tmp/server.properties
if "%answer%"=="exit" goto editexit
pause
exit

:cq

exit


:create
if exist server.jar goto error
curl https://download1475.mediafire.com/y78kh9dj9kig/xld45j4lw2djw83/settings.bat --output settings.bat
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
call runsets.bat

:run

if exist server.jar echo Running server!
if not exist server.jar goto error
if not exist eula.txt curl https://download1075.mediafire.com/r4jvkdrdnyzg/qd545sy6l0dudwj/eula.txt --output eula.txt
java -Xmx%MAX_RAM% -Xms%MIN_RAM% -jar server.jar %gui%
pause
exit

:error
echo The installer has run into an unexpected problem, and will need to quit. We're sorry!
pause
exit
