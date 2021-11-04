@echo off
WHERE hyperfine
IF %ERRORLEVEL% NEQ 0 goto dep
call:%~1 run
if not exist "C:\Program Files\Java" echo This program cannot run without Java! Please install it! If you have installed it, make sure it is installed at "C:\Program Files\Java"
cls
:open
echo Welcome to the official minecraft vanilla server manipulator
set /p answer=What operation would you like to execute? [E]dit, [C]reate, [D]elete, [B]ackup  or [R]un
if "%answer%"=="E" goto edit
if "%answer%"=="C" goto cq
if "%answer%"=="O" goto run
if "%answer%"=="D" goto del
if "%answer%"=="B" goto bkup
echo Answer!
goto open

:dep
echo Installing some dependencies please wait.
cls
echo Please press 1 and enter
curl https://static.rust-lang.org/rustup/dist/i686-pc-windows-msvc/rustup-init.exe --output rustup-init.exe
rustup-init.exe
cargo install hyperfine
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
echo If you do not know what a question means, it is best to leave as default.
echo If you are fine with the defaults, then there is no need to be here. Good luck, server creator.....
echo If you are not planning to finish, it is highly not recommended you do this because if you exit, all changes will be reverted.
echo And if you have made a mistake, type exit on the next question.
set /p answer=Continue?(Y/N)
if "%answer%"=="N" goto open
mkdir tmp
echo #Minecraft server properties>./tmp/server.properties
echo #Wed Jul 14 16:38:34 EDT 2021>>./tmp/server.properties
goto etap

:etap
set /p answer=Broadcast rcon to ops? Default is true
if "%answer%"=="exit" goto editexit
echo broadcast-rcon-to-ops=%answer%>>./tmp/server.properties
set /p answer=Set view distance. default is 10
if "%answer%"=="exit" goto editexit
echo view-distance=%answer%>>./tmp/server.properties
set /p answer=Enable jmx monitoring? Default is false
if "%answer%"=="exit" goto editexit
echo enable-jmx-monitoring=%answer%>>./tmp/server.properties
set /p answer=Set server ip. Default is nothing(just press space and enter)
if "%answer%"=="exit" goto editexit
echo server-ip=%answer%>>./tmp/server.properties
rem ses break
set /p answer=Resource pack prompt? Default is nothing(just press space and enter)
if "%answer%"=="exit" goto editexit
echo resource-pack-prompt=%answer%>>./tmp/server.properties
set /p answer=RCON port. default is 25575
if "%answer%"=="exit" goto editexit
echo rcon.port=%answer%>>./tmp/server.properties
set /p answer=Default gamemode	default is survival
if "%answer%"=="exit" goto editexit
echo gamemode=%answer%>>./tmp/server.properties
set /p answer=Set server port. Default is 25565
if "%answer%"=="exit" goto editexit
echo server-port=%answer%>>./tmp/server.properties
rem ses break
set /p answer=Allow nether? default is true
if "%answer%"=="exit" goto editexit
echo allow-nether=%answer%>>./tmp/server.properties
set /p answer=Enable command blocks? default is false
if "%answer%"=="exit" goto editexit
echo enable-command-block=%answer%>>./tmp/server.properties
set /p answer=Enable RCON? default is false
if "%answer%"=="exit" goto editexit
echo enable-rcon=%answer%>>./tmp/server.properties
set /p answer=Sync chunk writes? default is true
if "%answer%"=="exit" goto editexit
echo sync-chunk-writes=%answer%>>./tmp/server.properties
rem ses break
set /p answer=Enable query? default is false
if "%answer%"=="exit" goto editexit
echo enable-query=%answer%>>./tmp/server.properties
set /p answer=OP permission level? default is 4
if "%answer%"=="exit" goto editexit
echo op-permission-level=%answer%>>./tmp/server.properties
set /p answer=prevent proxy connections? default is false
if "%answer%"=="exit" goto editexit
echo prevent-proxy-connections=%answer%>>./tmp/server.properties
set /p answer=Resource pack? default is nothing(just press space and enter)
if "%answer%"=="exit" goto editexit
echo resource-pack=%answer%>>./tmp/server.properties
rem ses break
set /p answer=entity broadcast range percentage? default is 100
if "%answer%"=="exit" goto editexit
echo entity-broadcast-range-percentage=%answer%>>./tmp/server.properties
set /p answer=Level name? Default is world
if "%answer%"=="exit" goto editexit
echo level-name=%answer%>>./tmp/server.properties
set /p answer=RCON password? default is nothing
if "%answer%"=="exit" goto editexit
echo rcon.password=%answer%>>./tmp/server.properties
set /p answer=player idle timeout? default is 0
if "%answer%"=="exit" goto editexit
echo player-idle-timeout=%answer%>>./tmp/server.properties
rem ses break
set /p answer=Motd? default is A Minecraft Server
if "%answer%"=="exit" goto editexit
echo motd=%answer%>>./tmp/server.properties
set /p answer=Query port? default is 25565
if "%answer%"=="exit" goto editexit
echo query.port=%answer%>>./tmp/server.properties
set /p answer=force gamemode? default is false
if "%answer%"=="exit" goto editexit
echo force-gamemode=%answer%>>./tmp/server.properties
set /p answer=rate limit? default is 0
if "%answer%"=="exit" goto editexit
echo rate-limit=%answer%>>./tmp/server.properties
echo Displaying changes.
cls
pause
type "tmp/server.properties"
goto savet

:savet
set/p answer=Save changes? (Y/N)
if "%answer%"=="Y" goto save
if "%answer%"=="N" goto editexit
echo PLease type Y or N!
goto savet

:save
if not exist ./tmp/server.properties goto error
robocopy ./tmp/ .
echo Save finished!
rmdir tmp /s /q
goto open

:editexit
echo Reverting to backup!
if exist tmp echo Backup load succesful
if not exist tmp echo Backup folder not found, but was still loaded
rmdir tmp /s /q
goto open

:cq

if exist server.jar goto error
cls
title Server Creation
echo Welcome to Server Creation
set /p answer=Modded server?(Y/N)?
if "%answer%"=="Y" set software=curse && goto version
if "%answer%"=="N" set software=mc
echo Your computer is about to be benchmarked. Your computer may slow down.
:sys
hyperfine help -i
set /p benchmarkanswer=Type the number you see next to System:
set /p answer=Is %benchmarkanswer% correct?(Y/N)
if %answer% EQU "N" goto sys
if %benchmarkanswer% gtr 5 set software=paper
if %benchmarkanswer% lss 5 set software=mcmain
:version
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
if %software% EQU curse (
    if %version%  EQU "latest" (
        curl https://maven.minecraftforge.net/net/minecraftforge/forge/1.17.1-37.0.104/forge-1.17.1-37.0.104-installer.jar --output server.jar
	cls
	echo Click Install Server and set the directory to this directory
    )
)
pause
call settings.bat

:run
call settings.bat
find "false" eula.txt && (
	echo You need to accept the eula. Change "false" to "true" && eula.txt && goto run)
if exist server.jar echo Running server!
if exist run.bat run.bat
if not exist server.jar goto error
java -Xmx%MAX_RAM% -Xms%MIN_RAM% -jar server.jar %gui%
pause
goto open

:error
echo The installer has run into an unexpected problem, and will need to quit. We're sorry!
pause
exit