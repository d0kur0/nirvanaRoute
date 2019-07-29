#include Libs\find.ahk
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
	temp := {"default": profileTemplate}
	jsonString := JSON.Stringify(temp)
	FileAppend, %jsonString%, %profilesDB_file%
}

FileRead, profilesDB, %profilesDB_file%
profilesDB := JSON.Parse(profilesDB)

if (!isObject(profilesDB)) {
	temp := {"default": profileTemplate}
	jsonString := JSON.Stringify(temp)
	
	file := FileOpen(profilesDB_file, "w")
	file.Write(jsonString)
	file.Close()
	
	Reload
}

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Relative
SetBatchLines -1

for key, value in profilesDB {
	if (!firstProfile) {
		firstProfile := key
	}
	
	profiles = %profiles%|%key%
}

profiles := trim(profiles, "|")
currentValues := profilesDB[firstProfile]

Gui Add, DropDownList, vprofile gchangeProfile x8 y16 w120 Choose1, % profiles
Gui Add, Button, v_removeProfile gremoveProfile x487 y16 w120 h23, &Удалить выбранный
Gui Add, Button, v_createProfile gcreateProfile x136 y16 w230 h23, &Сохранить настройки как новый профиль
Gui Add, GroupBox, x8 y48 w286 h271, Основные настройки
Gui Add, Edit, vbossKillTime giChange x16 y80 w40 h21 +Number, % currentValues["bossKillTime"]
Gui Add, Text, x64 y80 w198 h23 +0x200 , Сколько времени бить босса в сек.
Gui Add, Edit, vdelayAfterTeleport giChange x16 y112 w40 h21, % currentValues["delayAfterTeleport"]
Gui Add, Text, x64 y112 w218 h23 +0x200 , Пауза после телепорта (прогрузка) в сек.
Gui Add, Edit, vdelayAfterInsert giChange x16 y144 w40 h21, % currentValues["delayAfterInsert"]
Gui Add, Text, x64 y144 w217 h23 +0x200 , Пауза после входа в нирвану в сек.
Gui Add, Edit, vdelayIteration giChange x16 y176 w40 h21, % currentValues["delayIteration"]
Gui Add, Text, x64 y176 w120 h23 +0x200 , Пауза между заходами в сек.

if (currentValues["isUseFP"]) {
	Gui Add, CheckBox, visUseFP giChange x16 y208 w120 h23 +Checked, Использовать ЗЯБ
} else {
	Gui Add, CheckBox, visUseFP giChange x16 y208 w120 h23, Использовать ЗЯБ
}

if (currentValues["isPhys"]) {
	
	Gui Add, Radio, visPhys giChange x16 y232 w70 h23 +Checked , Физ нора
	Gui Add, Radio, visMag giChange x96 y232 w120 h23, Маг нора
	
} else {
	
	Gui Add, Radio, visPhys giChange x16 y232 w70 h23, Физ нора
	Gui Add, Radio, visMag giChange x96 y232 w120 h23 +Checked, Маг нора

}

Gui Add, Edit, vbotName giChange x16 y288 w170 h21,% currentValues["botName"]
Gui Add, Text, x16 y264 w254 h23 +0x200 , Имя бота, которому писать "123"
Gui Add, GroupBox, x304 y48 w302 h271, Хоткеи
Gui Add, Edit, vattackKey giChange x312 y80 w40 h21, % currentValues["attackKey"]
Gui Add, Text, x360 y80 w167 h23 +0x200 , Клавиша атакущего макроса
Gui Add, Edit, vteleportKey giChange x312 y112 w40 h21, % currentValues["teleportKey"]
Gui Add, Text, x360 y112 w199 h23 +0x200 , Клавиша на которой стоит руна ТП
Gui Add, Edit, vcollectKey giChange x312 y144 w40 h21, % currentValues["collectKey"]
Gui Add, Text, x360 y144 w193 h23 +0x200 , Клавиша для сбора лута

if (currentValues["isFastCollect"]) {
	Gui Add, CheckBox, visFastCollect giChange x312 y168 w120 h23 +Checked , Быстрый сбор?
} else {
	Gui Add, CheckBox, visFastCollect giChange x312 y168 w120 h23, Быстрый сбор?
}

Gui Add, Edit, vFPkey giChange x312 y192 w40 h21, % currentValues["FPKey"]
Gui Add, Text, x360 y192 w193 h23 +0x200 , Клавиша, на которой стоит зяб
Gui Add, Button, vBtnOk gstartProcess x8 y328 w80 h23, Запустить

Gui Show, w618 h360, NirvanaRoute
Return

setProfile(profile) {
	Global profilesDB
	values := profilesDB[profile]
	
	GuiControl,, bossKillTime, % values["bossKillTime"]
	GuiControl,, delayAfterTeleport, % values["delayAfterTeleport"]
	GuiControl,, delayAfterInsert, % values["delayAfterInsert"]
	GuiControl,, delayIteration, % values["delayIteration"]
	GuiControl,, isPhys, % values["isPhys"]
	GuiControl,, isMag, % values["isMag"]
	GuiControl,, botName, % values["botName"]
	GuiControl,, isUseFP, % values["isUseFP"]
	
	GuiControl,, attackKey, % values["attackKey"]
	GuiControl,, collectKey, % values["collectKey"]
	GuiControl,, teleportKey, % values["teleportKey"]
	GuiControl,, FPKey, % values["FPKey"]
	GuiControl,, isFastCollect, % values["isFastCollect"]
}

changeProfile(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	GuiControlGet, profile
	setProfile(profile)
}

iChange(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	Global profilesDB
	Global profilesDB_file
	
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
	
	currentValues := {"bossKillTime": bossKillTime
	,"delayAfterTeleport": delayAfterTeleport
	,"delayAfterInsert": delayAfterInsert
	,"delayIteration": delayIteration
	,"isUseFP": isUseFP
	,"isPhys": isPhys
	,"isMag": isMag
	,"botName": botName
	,"attackKey": attackKey
	,"teleportKey": teleportKey
	,"collectKey": collectKey
	,"isFastCollect": isFastCollect
	,"FPkey": isFastCollect}
	
	profilesDB[profile] := currentValues
	jsonString := Json.Stringify(profilesDB)
	
	file := FileOpen(profilesDB_file, "w")
	file.Write(jsonString)
	file.Close()
}

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
	Global profilesDB
	Global profilesDB_file
	
	inputBox, profileName, Сохранение, Имя профиля
	
	if (!profileName) {
		Return
	}
	
	if (!RegExMatch(profileName, "i)[A-z\_]")) {
		msgBox, Имя профиля может быть только из латинских букв и символа _
		Return
	}
	
	if (profilesDB.hasKey(profileName)) {
		MsgBox, Профиль с таким именем уже существует
		Return
	}
	
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
	
	currentValues := {"bossKillTime": bossKillTime
	,"delayAfterTeleport": delayAfterTeleport
	,"delayAfterInsert": delayAfterInsert
	,"delayIteration": delayIteration
	,"isUseFP": isUseFP
	,"isPhys": isPhys
	,"isMag": isMag
	,"botName": botName
	,"attackKey": attackKey
	,"teleportKey": teleportKey
	,"collectKey": collectKey
	,"isFastCollect": isFastCollect
	,"FPkey": isFastCollect}
	
	profilesDB.insert(profileName, currentValues)
	jsonString := Json.Stringify(profilesDB)
	
	file := FileOpen(profilesDB_file, "w")
	file.Write(jsonString)
	file.Close()
	
	GuiControl,, profile, % profileName
}

removeProfile(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
	Global profilesDB
	Global profilesDB_file
	
	GuiControlGet, profile
	
	profilesDB.remove(profile)
	jsonString := Json.Stringify(profilesDB)
	
	file := FileOpen(profilesDB_file, "w")
	file.Write(jsonString)
	file.Close()
	
	Reload
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
	
	while 1 
	{
		find()
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

startProcessMain() {
	
	find()
	
	;while, 1 
	;{
		clear_party()
		use_FP(isUseFP, FPKey)

		if (isPhys)
		{
			;phys_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
		Else 
		{
			;mag_process(bossKillTime, delayAfterTeleport*1000, delayAfterInsert*1000, delayIteration*1000, botName, attackKey, teleportKey, collectKey, isFastCollect)
		}
	;}
}

GuiEscape:
GuiClose:
    ExitApp
