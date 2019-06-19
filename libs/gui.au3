#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include "logger.au3"

Const $wWidth  = 400;
Const $wHeight = 250;

Global $fExit

$hWndGUI = GUICreate('NirvanaRoute', $wWidth, $wHeight, -1, -1, $WS_POPUP, BitOR($WS_EX_TRANSPARENT, $WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))

$aTaskbar = WinGetPos("[CLASS:Shell_TrayWnd]", "")
$aWin = WinGetPos($hWndGUI)

WinMove($hWndGUI, "", @DesktopWidth - $aWin[2] - 4, @DesktopHeight - $aWin[3] - $aTaskbar[3] - 4)

GUICtrlSetFont(-1, 20, 400, 0, "MS Sans Serif")
WinSetTrans($hWndGUI, '', 210); прозрачность 0 - 255
GUISetState(@SW_SHOWNOACTIVATE)
HotKeySet('{Esc}', '_Exit')

Global $editInput = GUICtrlCreateLabel("", 15, 15, $wWidth - 30, $wHeight - 30, -1, -1);

Func _Exit()
    Exit
EndFunc
