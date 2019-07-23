getTimestamp() {

	T = A_Now

	FormatTime Y, %T%, yyyy
	FormatTime D, %T%, YDay
	FormatTime H, %T%, H
	FormatTime M, %T%, m
	FormatTime S, %T%, s

	Return (31536000*(Y-1970) + (D+Floor((Y-1972)/4))*86400 + H*3600 + M*60 + S)
}