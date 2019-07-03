coords := {}
; Координаты камня грёз
coords.stone_x := 318
coords.stone_y := 45
; Координаты полосы скрола в камне
coords.stoneScroll_x := 283
coords.stoneScroll_y := 724
; Координаты Зала Перерождения в камне
coords.hallOfRebirth_x := 60
coords.hallOfRebirth_y := 713
; Координаты первого варианта ответа в диалоге
coords.firstAnswer_x := 52,
coords.firstAnswer_y := 579


IfWinNotExist, ahk_class ElementClient Window
	MsgBox, Error, window not found 

WinWait, ahk_class ElementClient Window
WinActivate, ahk_class ElementClient Window

CoordMode, Mouse, Relative

While true
{
; teleport
MouseClick, left, coords.stone_x, coords.stone_y
Sleep, 3000
MouseClick, left, coords.stoneScroll_x, coords.stoneScroll_y
Sleep, 500
MouseClick, left, coords.hallOfRebirth_x, coords.hallOfRebirth_y
Sleep, 500
MouseClick, left, coords.firstAnswer_x, coords.firstAnswer_y
Sleep, 500
MouseClick, left, coords.firstAnswer_x, coords.firstAnswer_y

; insert
Sleep, 4000
MouseClick, left, 1317, 457
Sleep, 2000
MouseClick, left, 1004, 222
Sleep, 1500
MouseClick, left, 72, 675
Sleep, 1000
MouseClick, left, 72, 675
Sleep, 8000
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
;MouseClick, left, 28, 413
;Sleep, 3000
;MouseClick, left, 28, 413
;Sleep, 3000

Send, {TAB}

Loop, 25
{
	Send, {1}
	Sleep, 1000
}

Loop, 3
{
	Send, {F7}
	Sleep, 500
}

MouseClick, left, 77, 765
Sleep, 200
MouseClick, left, 44, 767
Sleep, 500
MouseClick, left, 212, 786

Sleep, 500
Send, {/}
Send, {Ч}
Sleep, 200
Send, {е}
Sleep, 200
Send, {л}
Sleep, 200
Send, {и}
Sleep, 200
Send, {к}
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
Send, {F1}
Sleep, 500
MouseClick, left, 801, 359
Sleep, 3000
}