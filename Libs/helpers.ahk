getTimestamp() {

	T = A_Now

	FormatTime Y, %T%, yyyy
	FormatTime D, %T%, YDay
	FormatTime H, %T%, H
	FormatTime M, %T%, m
	FormatTime S, %T%, s

	Return (31536000*(Y-1970) + (D+Floor((Y-1972)/4))*86400 + H*3600 + M*60 + S)
}

implode(sep, params*) {
    for index,param in params
        str .= sep . param
    return SubStr(str, StrLen(sep)+1)
}

keydown(key) {
	ControlSend, , %key%, ahk_class ElementClient Window
}

lClick(x, y) {
	ControlClick, x%x% y%y%, ahk_class ElementClient Window, , Left, 1, NA
}

rClick(x, y) {
	ControlClick, x%x% y%y%, ahk_class ElementClient Window, , Right, 1, NA
}