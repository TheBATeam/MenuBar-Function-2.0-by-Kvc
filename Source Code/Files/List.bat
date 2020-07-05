@Echo off

Set _Ver=2.0

:: The function is quite awesome and can make your batch programs amazing in just a single line of Code
:: our goal is to make things easy and simple for the programmers out there...
:: If you like our work, Don't forget to give it a thumbs up at www.thebateam.org
:: you'll find more amazing stuff like this at the blog. :)

:: The following Function is created by kvc...don't modify it...if you don't know what are you doing...
:: it takes following arguments...
:: it is the ver.2.0 of List function... and it contains diffrnet types of List printing options... #kvc

:: [%1 = X-ordinate]
:: [%2 = Y-co_ordinate]
:: [%3 = the colour Code for the List,e.g. fc,08,70,07 etc...don't define it if you want default colour...or type '-' (minus) for no color change...]

rem #kvc

rem :: Visit www.thebateam.org for more extensions / plug-ins like this.... :]
rem #TheBATeam

If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.%_Ver%&&goto :eof)


If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)
If /i "%~4" == "" (goto :help)


:List
Setlocal Enabledelayedexpansion
Set _List_Count=1
Set _List_Width=1
Set _Final=
Set _Return_code=0

set x_val=%~1
set y_val=%~2
set color=%~3
if /i "!color!" == "-" (set color=07) Else (set "color=%~3")

Set /a y_val_old=!y_val! + 1

REM TO Get All List Items...
:List_Loop
REM List Items loop...
Set "Item_!_List_Count!=%~4"

REM Checking for Max. Width of List...
Call Getlen "%~4"
Set _Temp_width=!ErrorLevel!
IF !_Temp_width! GTR !_List_Width! (Set _List_Width=!_Temp_width!)

Set Item_!_List_Count!_Width=%_Temp_width%

REM Preparing for next Item...
Shift /4
IF /I "%~4" == "" (Goto :Next)
Set /A _List_Count+=1
Goto :List_Loop

:Next
REM Some necessary variables...
Set /A _List_Width=!_List_Width!+4
Set /A _List_Height=!_List_Count!+2
Set /A _Max_Width=!x_val! + !_List_Width! - 2
Set /A _Max_Height=!y_val_old! + !_List_Count! - 1
Set _Box=
Set _List_Space=

REM Checking for the Outer Bounds of CMD Console...
Call GetDim _Rows _Columns
Set /A _Rows-=2
Set /A _Columns-=1

IF %_Max_Width% GTR %_Columns% (
	Set /A _List_Width-=4
	Set /A x_val-=%_List_Width%
	Goto :Next
	)
IF %_Max_Height% GTR %_Rows% (
	Set /A y_val-=%_List_Height%
	Set /a y_val_old=!y_val! + 1
	Goto :Next
	)

REM Setting Up-Close Button...
Set _Special_X=%_Max_Width%
Set _Special_Y=%y_val%
Set "_Special_Area= %_Special_X% %_Special_Y% %_Special_X% %_Special_Y%"
Set _Final=/c 0x%Color:~0,1%C /g %_Special_X% %_Special_Y% /d "X" /c 0x%color%

REM Outer Layout of List...
Call Box %x_val% %y_val% %_List_Height% %_List_Width% - - %Color% 1

REM Printing List Items...
Set /A x_val+=2
Set y_val=!y_val_old!

For /l %%A In (1,1,!_List_Count!) DO (
	set "_final=!_final! /g !x_val! !y_val! /d "!Item_%%A!" "
	set /a y_val+=1
)

REM Final Output...
batbox.exe %_final% /c 0x07

REM Resetting variables...
Set y_val=!y_val_old!
Set /a x_val-=1
Set _Invert_color=%color:~1,1%%Color:~0,1%
Set _Hover=

REM Calculating for getting User Input...
REM Creating clicked area...
For /l %%A In (1,1,!_List_Count!) DO (
	Set "_Box=!_Box!!x_val! !y_val! !_Max_Width! !y_val! "
	Set /A y_val+=1
	Set "_Hover=!_Invert_color!!_Hover! "
	)

REM Setting for Anywhere else click on screen... (void area)
Set _Box=%_Box:~0,-1% %_Special_Area%
Set _Hover=%_Hover% C%Color:~1,1%

REM For The Extra Close Option, 'X' - Special Element!
Set /A _List_Count+=1

:User_Input
REM Enabling Mouse Interaction with Cmd... Using 'GetInput.exe'
Set _Result=
GetInput /M %_Box% /H %_Hover%
Set _Result=%Errorlevel%

IF %_Result% == 27 (Set _Return_code=0 && Goto :End)
IF %_Result% == %_List_Count% (Set _Return_code=0 && Goto :End)

If %_Result% GTR %_List_Count% (Goto :User_Input)

Set _Return_code=%_Result%

:End
Exit /b !_Return_code!


:help
Echo.
Echo. This function helps in Adding a little GUI effect into your batch program...
echo. It Prints simple List on the cmd console at specified X Y co-ordinate...
Echo. After printing, it stops For User 'mouse' input... ANd returns the Item No.
Echo. Which is clicked by User... 
Echo. 
Echo. IF 'X' is clicked, or Pressed ESC From Keyboard... then it will return 0 in 
Echo. the 'Errorlevel' Variable.
echo.
echo. Syntax: call List [X] [Y] [color ^| - ] [Items 1] [Items 2] ...
echo. Syntax: call List [help ^| /^? ^| -h ^| -help]
echo. Syntax: call List ver
echo.
echo. Where:-
echo. X		= X-ordinate of top-left corner of List
echo. Y		= Y-co_ordinate of top-left corner of List
echo. ver		= Version of List function
Echo. Items #	= The Items to display in the List... They maybe Enclosed within "".
echo.
echo. This version %_Ver% of List function contains much more GUI Capabilities.
echo. As it uses batbox.exe and calls it only once at the end of calculation...
Echo. For the most efficient output. This ver. uses GetInput By Aacini too. For the
Echo. Advanced Output on the console.
Echo.
echo. Visit www.thebateam.org for more...
echo. #TheBATeam
goto :eof
