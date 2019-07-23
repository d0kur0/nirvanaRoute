use_FP(isUseFP, FPKey)
{
	global FPState

	if (isUseFP)
	{
		if (FPState + 3600 < getTimestamp() - 360)
		{
			FPState := getTimestamp()
			use_FP_process(FPKey)
		}
	}
}

use_FP_process(FPKey) {
	Send, {%FPKey%}
	Sleep, 5000
}