#include "libs/consts.au3"
#include "libs/gui.au3"
#include "libs/findClient.au3"

; relative window
Opt("MouseCoordMode", 0)
opt("SendKeyDelay", 50)

FindElementClient();

While 1
; Teleport

MouseClick('left', 337, 44)
Sleep(3000);
MouseClick('left', 282, 715);
Sleep(1000);
MouseClick('left', 77, 713);
Sleep(1000);
MouseClick('left', 49, 576);
Sleep(1000);
MouseClick('left', 49, 576);
Sleep(3000);

; Insert

Send('{D DOWN}');
Sleep(1500);
Send('{D UP}');
Sleep(1000);
MouseClick('left', 744, 59);
Sleep(3000);
MouseClick('left', 57, 674);
Sleep(1000);
MouseClick('left', 57, 674);
Sleep(10000);
MouseClick('left', 709, 237);
Sleep(1000);
MouseClick('left', 57, 674);
Sleep(1000);
MouseClick('left', 57, 674);
Sleep(500);

Send('{D 50}');

Send('{W DOWN}');
Sleep(18500);
Send('{W UP}');

$start = 0;

While 1
	If $start > 5 Then 
		ExitLoop
	EndIf

	Send('{1 5}')
	Sleep(5000);

	$start = $start + 1
WEnd

Send('{F7 5}');
Sleep(1000);
MouseClick('left', 114, 767);
Sleep(500);
MouseClick('left', 250, 786);
Sleep(500);
Send('{1}');
Send('{2}');
Send('{3}');
Send('{ENTER}');
Sleep(3000);
MouseClick('left', 690, 158);
Sleep(1000);
MouseClick('left', 635, 444);
Sleep(2000);
Send('{F1}');
Sleep(500);
MouseClick('left', 801, 359);

Sleep(6000);

Send('{D DOWN}');
Sleep(1880);
Send('{D UP}');

WEnd
