#include Libs\findAndActivate.ahk
#include Libs\phys_process.ahk
#include Libs\mag_process.ahk
#include Libs\use_FP.ahk

FPState = 0

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Relative
SetBatchLines -1

Gui Add, GroupBox, x8 y8 w280 h271, Основные настройки
Gui Add, Edit, vbossKillTime x16 y32 w40 h21 +Number, 25
Gui Add, Edit, vdelayAfterTeleport x16 y64 w40 h21, 4
Gui Add, Edit, vdelayAfterInsert x16 y96 w40 h21, 8
Gui Add, Edit, vdelayIteration x16 y128 w40 h21, 3
Gui Add, Text, x64 y32 w198 h23 +0x200, Сколько времени бить босса в сек.
Gui Add, Text, x64 y64 w218 h23 +0x200, Пауза после телепорта (прогрузка) в сек.
Gui Add, Text, x64 y96 w217 h23 +0x200, Пауза после входа в нирвану в сек.
Gui Add, Text, x64 y128 w120 h23 +0x200, Пауза между заходами в сек.
Gui Add, CheckBox, visUseFP x16 y160 w120 h23, Использовать ЗЯБ
Gui Add, Radio, visPhys gchangePhys x16 y192 w70 h23 +Checked, Физ нора
Gui Add, Radio, visMag gchangeMag x104 y192 w120 h23, Маг нора
Gui Add, GroupBox, x320 y8 w290 h267, Хоткеи
Gui Add, Edit, vattackKey x328 y32 w50 h21, 1
Gui Add, Text, x384 y32 w167 h23 +0x200, Клавиша атакущего макроса
Gui Add, Edit, vteleportKey x328 y64 w50 h21, F1
Gui Add, Text, x384 y64 w199 h23 +0x200, Клавиша на которой стоит руна ТП
Gui Add, Edit, vbotName x16 y248 w170 h21, Челик
Gui Add, Text, x16 y224 w254 h23 +0x200, Имя бота, которому писать "123"
Gui Add, Edit, vcollectKey x328 y96 w50 h21, F7
Gui Add, CheckBox, visFastCollect x328 y120 w120 h23 +Checked, Быстрый сбор?
Gui Add, Text, x384 y96 w193 h23 +0x200, Клавиша для сбора лута
Gui Add, Button, vBtnOk gstartProcess x8 y288 w80 h23, Запустить

Gui Add, Edit, vFPkey x328 y146 w50 h21, F8
Gui Add, Text, x384 y146 w193 h23 +0x200, Клавиша, на которой стоит зяб

Gui Show, w618 h320, NirvanaRoute
Return

changePhys(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

}

changeMag(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

}

startProcess(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

	findAndActivate()

	; get base config
	GuiControlGet, bossKillTime
	GuiControlGet, delayAfterTeleport
	GuiControlGet, delayAfterInsert
	GuiControlGet, delayIteration
	GuiControlGet, isPhys
	GuiControlGet, isMag
	GuiControlGet, botName
	GuiControlGet, isUseFP

	; get hotkeys config
	GuiControlGet, attackKey
	GuiControlGet, collectKey
	GuiControlGet, teleportKey
	GuiControlGet, FPKey
	GuiControlGet, isFastCollect

	; todo block interface

	if (isPhys)
	{
		while, 1 
		{
			use_FP(isUseFP, FPKey)
			phys_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
	}
	Else
	{
		while, 1 
		{
			use_FP(isUseFP, FPKey)
			mag_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
	}

}

GuiEscape:
GuiClose:
    ExitApp
