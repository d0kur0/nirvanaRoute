Func writeLog ($message)
   $message = GUICtrlRead($editInput) & $message & @CRLF;
   GUICtrlSetData($editInput, $message);
EndFunc