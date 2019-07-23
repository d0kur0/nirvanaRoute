#include Libs\findAndActivate.ahk
#include Libs\helpers.ahk
#include Libs\phys_process.ahk
#include Libs\mag_process.ahk
#include Libs\use_FP.ahk
#include Libs\clear_party.ahk
#include Libs\json.ahk

FPState = 0
mainState = 0

EnvGet, appData, APPDATA
homeDir = %appData%\nirvanaRoute
profilesDB_file = %homeDir%\profiles.json
profileTemplate := {"bossKillTime": 25
	,"delayAfterTeleport": 4
	,"delayAfterInsert": 8
	,"delayIteration": 3
	,"isUseFP": 0
	,"isPhys": 1
	,"isMag": 0
	,"botName": "Челик"
	,"attackKey": "1"
	,"teleportKey": "F1"
	,"collectKey": "F7"
	,"isFastCollect": 1
	,"FPkey": "F8"}

if (!fileExist(homeDir)) {
	FileCreateDir, %homeDir%
}

if (!fileExist(profilesDB_file)) {
	jsonString = JSON.Stringify(profileTemplate);
	FileAppend, %jsonString%, %profilesDB_file%
}

FileRead, profilesDB, profilesDB_file

if (!isObject(profilesDB)) {
	
}

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Relative
SetBatchLines -1

Gui Add, DropDownList, vprofile x8 y16 w120
Gui Add, Button, v_removeProfile gremoveProfile x487 y16 w120 h23, &Удалить выбранный
Gui Add, Button, v_createProfile gcreateProfile x136 y16 w80 h23, &Добавить
Gui Add, Button, v_saveProfile gsaveProfile x220 y16 w80 h23, &Сохранить
Gui Add, GroupBox, x8 y48 w286 h271, Основные настройки
Gui Add, Edit, vbossKillTime x16 y80 w40 h21 +Number, % profileTemplate["bossKillTime"]
Gui Add, Text, x64 y80 w198 h23 +0x200 , Сколько времени бить босса в сек.
Gui Add, Edit, vdelayAfterTeleport x16 y112 w40 h21, % profileTemplate["delayAfterTeleport"]
Gui Add, Text, x64 y112 w218 h23 +0x200 , Пауза после телепорта (прогрузка) в сек.
Gui Add, Edit, vdelayAfterInsert x16 y144 w40 h21, % profileTemplate["delayAfterInsert"]
Gui Add, Text, x64 y144 w217 h23 +0x200 , Пауза после входа в нирвану в сек.
Gui Add, Edit, vdelayIteration x16 y176 w40 h21, % profileTemplate["delayIteration"]
Gui Add, Text, x64 y176 w120 h23 +0x200 , Пауза между заходами в сек.

if (profileTemplate["isUseFP"]) {
	Gui Add, CheckBox, visUseFP x16 y208 w120 h23 +Checked, Использовать ЗЯБ
} else {
	Gui Add, CheckBox, visUseFP x16 y208 w120 h23, Использовать ЗЯБ
}

if (profileTemplate["isPhys"]) {
	
	Gui Add, Radio, visPhys gchangePhys x16 y232 w70 h23 +Checked , Физ нора
	Gui Add, Radio, visMag gchangeMag x96 y232 w120 h23, Маг нора
	
} else {
	
	Gui Add, Radio, visPhys gchangePhys x16 y232 w70 h23, Физ нора
	Gui Add, Radio, visMag gchangeMag x96 y232 w120 h23 +Checked, Маг нора

}

Gui Add, Edit, vbotName x16 y288 w170 h21, Челик
Gui Add, Text, x16 y264 w254 h23 +0x200 , Имя бота, которому писать "123"
Gui Add, GroupBox, x304 y48 w302 h271, Хоткеи
Gui Add, Edit, vattackKey x312 y80 w40 h21, 1
Gui Add, Text, x360 y80 w167 h23 +0x200 , Клавиша атакущего макроса
Gui Add, Edit, vteleportKey x312 y112 w40 h21, F1
Gui Add, Text, x360 y112 w199 h23 +0x200 , Клавиша на которой стоит руна ТП
Gui Add, Edit, vcollectKey x312 y144 w40 h21, F7
Gui Add, Text, x360 y144 w193 h23 +0x200 , Клавиша для сбора лута
Gui Add, CheckBox, visFastCollect x312 y168 w120 h23 +Checked , Быстрый сбор?
Gui Add, Edit, vFPkey x312 y192 w40 h21, F8
Gui Add, Text, x360 y192 w193 h23 +0x200 , Клавиша, на которой стоит зяб
Gui Add, Button, vBtnOk gstartProcess x8 y328 w80 h23, Запустить

Gui Show, w618 h360, NirvanaRoute
Return

disableGui(disableStartButton = true) {
	GuiControl, Disable, profile
	GuiControl, Disable, _removeProfile
	GuiControl, Disable, _createProfile
	GuiControl, Disable, bossKillTime
	GuiControl, Disable, delayAfterTeleport
	GuiControl, Disable, delayIteration
	GuiControl, Disable, delayAfterInsert
	GuiControl, Disable, isUseFP
	GuiControl, Disable, isPhys
	GuiControl, Disable, isMag
	GuiControl, Disable, botName
	GuiControl, Disable, attackKey
	GuiControl, Disable, teleportKey
	GuiControl, Disable, collectKey
	GuiControl, Disable, isFastCollect
	GuiControl, Disable, FPkey
	
	if (disableStartButton) {
		GuiControl, Disable, BtnOk
	}
}

createProfile(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	MsgBox, create
}

removeProfile(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	MsgBox, remove
}

saveProfile(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	MsgBox, save
}

changePhys(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

}

changeMag(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

}

PostClick(x, y, hwnd) {
  lParam := x & 0xFFFF | (y & 0xFFFF) << 16 
  PostMessage, 0x201, 1, %lParam%,, ahk_id %hwnd% WM_LBUTTONDOWN 
  PostMessage, 0x202, 0, %lParam%,, ahk_id %hwnd% WM_LBUTTONUP 
}

startProcess(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	global mainState
	
	; get base config
	GuiControlGet, bossKillTime
	GuiControlGet, delayAfterTeleport
	GuiControlGet, delayAfterInsert
	GuiControlGet, delayIteration
	GuiControlGet, isPhys
	GuiControlGet, isMag
	GuiControlGet, botName
	GuiControlGet, isUseFP
	GuiControlGet, profile

	; get hotkeys config
	GuiControlGet, attackKey
	GuiControlGet, collectKey
	GuiControlGet, teleportKey
	GuiControlGet, FPKey
	GuiControlGet, isFastCollect
	
	if (!profile) {
		MsgBox, Не выбран профиль работы
		Return
	}
	
	if (mainState == 0) {
		GuiControl,, BtnOk, Остановить
		mainState = 1;
	} else {
		Reload
	}
	
	msgBox, %profile%
	
	;ControlSend, , {F8}, ahk_class ElementClient Window
	;ControlGet, chwnd, Hwnd,, Edit1, ahk_class ElementClient Window
	;msgbox, [%chwnd%]
	;PostClick(100, 100, chwnd)
}

startProcessMain(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {

	findAndActivate()

	; todo block interface
		
	while, 1 
	{
		clear_party()
		use_FP(isUseFP, FPKey)

		if (isPhys)
		{
			phys_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
		Else 
		{
			mag_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
	}
}

GuiEscape:
GuiClose:
    ExitApp
