@Echo off
Setlocal enabledelayedexpansion

Cd Files

:Top
cls
call MenuBar File f0 _Box _Hover

:mouse
REM Enabling Mouse Interaction with Cmd... Using 'GetInput'
GetInput /M %_BOx% /H 70

Call Check_MenuBar_Click.bat %Errorlevel% _Menu_Option _Sub_menu_option

Title %_Menu_Option%x%_Sub_menu_option%
Goto :Top
pause>nul