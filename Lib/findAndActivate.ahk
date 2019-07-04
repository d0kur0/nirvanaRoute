findAndActivate ()
{
	IfWinNotExist, ahk_class ElementClient Window
		MsgBox, Error, window not found 

	WinWait, ahk_class ElementClient Window
	WinActivate, ahk_class ElementClient Window
}