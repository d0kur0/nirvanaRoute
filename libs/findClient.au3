Func FindElementClient ()
	While 1
		If Not WinExists($elementClient) Then 
			
			writeLog('Клиент игры не запущен... Повтор проверки через 5 сек.');
			Sleep(5000);
			ContinueLoop;

		Endif;

		writeLog("Окно клиента найдено, ожидание попадания в фокус");

		If WinWaitActive($elementClient) Then 
			writeLog("Окно попало в фокус, идём дальше.");
			ExitLoop;
		EndIf;
	WEnd
EndFunc