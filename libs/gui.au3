#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include "logger.au3"

Const $wWidth  = 400;
Const $wHeight = 600;

Opt("GUIOnEventMode", 1);
GUICreate("Nirvana Route", $wWidth, $wHeight);
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")
GUISetState(@SW_SHOW);

Global $editInput = GUICtrlCreateEdit("", 15, 15, $wWidth - 30, $wHeight - 30);
;GUICtrlSetState($editInput, $GUI_DISABLE)

Func CLOSEButton ()
   Exit
EndFunc