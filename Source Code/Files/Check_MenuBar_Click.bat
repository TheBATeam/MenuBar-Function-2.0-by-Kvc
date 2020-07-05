@Echo off
SetLocal ENableDelayedExpansion
REM Auto Generated MenuBar Click File...
REM Program is Created by Kvc
Set __Main_Menu=0 
Set __Sub_Menu=0 

IF %~1 EQU 1 (
	Set __Main_Menu=1
	Call List.bat 0 1 f0 "New" "Save" "Open" "Namish" "Exit" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 EQU 2 (
	Set __Main_Menu=2
	Call List.bat 7 1 f0 "TheBATeam" "LocalHost" "Homeless" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 EQU 3 (
	Set __Main_Menu=3
	Call List.bat 14 1 f0 "New Doc" "Clear" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 EQU 4 (
	Set __Main_Menu=4
	Call List.bat 21 1 f0 "The World" "YourSelf" "Nothing" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 EQU 5 (
	Set __Main_Menu=5
	Call List.bat 28 1 f0 "CMD" "Life" "None" 
	Set __Sub_Menu=!Errorlevel!
)
IF %~1 EQU 6 (
	Set __Main_Menu=6
	Call List.bat 36 1 f0 "From Kvc" "From DarkBatcher" "From TSnake" "EGO" "Software" "About Us" 
	Set __Sub_Menu=!Errorlevel!
)

REM Preparing for Returning The User-Input...
REM Using Tunneling here...
ENDLOCAL && Set "%~2=%__Main_Menu%" && Set "%~3=%__Sub_Menu%"
Goto :EOF
REM Don't Even Think of Doing SOmething - Nasty ;)
www.thebateam.org
