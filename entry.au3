#include "libs/consts.au3"
#include "libs/gui.au3"
#include "libs/findClient.au3"

FindElementClient();

; Initial
; Телепортация из угла к камню
writeLog('Использую руну и телепортируюсь в ЮГД');
Send('{F1}');
MouseClick($MOUSE_CLICK_LEFT, 891, 383);

writeLog("Ждём прогрузку");
Sleep(2000);

writeLog("Открываем камень грёз");
MouseClick($MOUSE_CLICK_LEFT, 1039, 320);

writeLog("Ждём пока персонаж подойдёт к камню");
Sleep(5000);

writeLog("Скролю список данжей в камне до Зала Перерождения");
MouseClick($MOUSE_CLICK_LEFT, 373, 758);

WriteLog("телепортируюсь в Зал Перерождения");
MouseClick($MOUSE_CLICK_LEFT, 161, 735);
MouseClick($MOUSE_CLICK_LEFT, 141, 599);
MouseClick($MOUSE_CLICK_LEFT, 141, 599);

While 1
   Sleep(100);
WEnd