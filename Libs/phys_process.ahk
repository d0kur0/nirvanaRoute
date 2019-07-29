phys_process(bossKillTime, delayAfterTeleport, delayAfterInsert, delayIteration, botName, attackKey, teleportKey, collectKey, isFastCollect)
{
	; teleport
	lClick(318, 45)
	Sleep, 3000
	lClick(283, 724)
	Sleep, 500
	lClick(60, 713)
	Sleep, 500
	lClick(52, 579)
	Sleep, 500
	lClick(52, 579)

	; insert
	Sleep, %delayAfterTeleport%
	lClick(1317, 457)
	Sleep, 2000
	lClick(1004, 222)
	Sleep, 1500
	lClick(72, 675)
	Sleep, 1000
	lClick(72, 675)
	Sleep, %delayAfterInsert%
	lClick(860, 317)
	Sleep, 1000
	lClick(72, 675)
	Sleep, 1000
	lClick(72, 675)
	Sleep, 500
	lClick(239, 381)
	Sleep, 3000
	lclick(52, 434)
	Sleep, 3000
	lclick(52, 434)
	Sleep, 3000
	lclick(52, 434)
	Sleep, 3000
	lclick(52, 434)
	Sleep, 3000
	lClick(28, 413)
	Sleep, 3000
	lClick(28, 413)
	Sleep, 3000

	keydown("{TAB}")

	Loop, %bossKillTime%
	{
		key = {%attackKey%}
		keydown(key)
		Sleep, 1000
	}

	if (isFastCollect)
	{
		Loop, 3
		{
			key = {%collectKey%}
			keydown(key)
			Sleep, 500
		}
	}
	Else
	{
		Loop, 20
		{
			key = {%collectKey%}
			keydown(key)
			Sleep, 500
		}
	}

	lClick(77, 765)
	Sleep, 200
	lClick(44, 767)
	Sleep, 500
	lClick(212, 786)

	Sleep, 500
	keydown("/")
	keydown(botName)
	Sleep, 200
	keydown("{SPACE}")
	Sleep, 200
	keydown(1)
	Sleep, 200
	keydown(2)
	Sleep, 200
	keydown(3)
	Sleep, 200
	keydown("{ENTER}")
	Sleep, 3000
	lClick(690, 159)
	Sleep, 1000
	lClick(634, 442)

	Sleep, 500
	key = {%teleportKey%}
	keydown(key)
	Sleep, 600
	lClick(801, 359)
	Sleep, %delayIteration%
}