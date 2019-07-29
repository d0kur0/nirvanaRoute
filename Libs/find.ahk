find()
{
	IfWinNotExist, ahk_class ElementClient Window
		MsgBox, Error, window not found 
}