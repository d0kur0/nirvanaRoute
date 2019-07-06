phys_process(bossKillTime, delayAfterTeleport, delayAfterInsert, delayIteration, botName, attackKey, teleportKey, collectKey, isFastCollect)
{
	; teleport
	MouseClick, left, 318, 45
	Sleep, 3000
	MouseClick, left, 283, 724
	Sleep, 500
	MouseClick, left, 60, 713
	Sleep, 500
	MouseClick, left, 52, 579
	Sleep, 500
	MouseClick, left, 52, 579

	; insert
	Sleep, %delayAfterTeleport%
	MouseClick, left, 1317, 457
	Sleep, 2000
	MouseClick, left, 1004, 222
	Sleep, 1500
	MouseClick, left, 72, 675
	Sleep, 1000
	MouseClick, left, 72, 675
	Sleep, %delayAfterInsert%
	MouseClick, left, 860, 317
	Sleep, 1000
	MouseClick, left, 72, 675
	Sleep, 1000
	MouseClick, left, 72, 675
	Sleep, 500
	MouseClick, left, 239, 381
	Sleep, 3000
	MouseClick, left, 52, 434
	Sleep, 3000
	MouseClick, left, 52, 434
	Sleep, 3000
	MouseClick, left, 52, 434
	Sleep, 3000
	MouseClick, left, 52, 434
	Sleep, 3000
	MouseClick, left, 28, 413
	Sleep, 3000
	MouseClick, left, 28, 413
	Sleep, 3000

	Send, {TAB}

	Loop, %bossKillTime%
	{
		Send, {%attackKey%}
		Sleep, 1000
	}

	if (isFastCollect)
	{
		Loop, 3
		{
			Send, {%collectKey%}
			Sleep, 500
		}
	}
	Else
	{
		Loop, 20
		{
			Send, {%collectKey%}
			Sleep, 500
		}
	}

	MouseClick, left, 77, 765
	Sleep, 200
	MouseClick, left, 44, 767
	Sleep, 500
	MouseClick, left, 212, 786

	Sleep, 500
	Send, {/}
	Send, %botName%
	Sleep, 200
	Send, {SPACE}
	Sleep, 200
	Send, {1}
	Sleep, 200
	Send, {2}
	Sleep, 200
	Send, {3}
	Sleep, 200
	Send, {ENTER}
	Sleep, 3000
	MouseClick, left, 690, 159
	Sleep, 1000
	MouseClick, left, 634, 442

	Sleep, 500
	Send, {%teleportKey%}
	Sleep, 500
	MouseClick, left, 801, 359
	Sleep, %delayIteration%
}