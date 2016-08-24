#AutoIt3Wrapper_Change2CUI=y
#include <Date.au3>

If $CmdLine[0] <> 1 Or ($CmdLine[1] <> "left" And $CmdLine[1] <> "right") Then 
	ConsoleWrite("Switched to peer domain when user knocks the vertical screen border twice" & @CRLF)
	ConsoleWrite("Usage: alpha-sigma-switcher left|right" & @CRLF)
	Exit
EndIf

Local $borderX = 0
If $CmdLine[1] = "right" Then
	$borderX = @DeskTopWidth - 1
EndIf

;Sometimes ESC arrives spuriously, use Ctrl+C to terminate
;HotKeySet("{ESC}", "Terminate")

Local $stayToSwitchMs = 1000
Local $pollInterval = 30

Local $inTheCorner
Local $enteredCornerTimestampMs
$inTheCorner = False
$enteredCornerTimestampMs = 0
ConsoleWrite("Starting infinite loop, Ctrl+C to exit" & @CRLF)
While True
	$Pos = MouseGetPos()
	$x = $Pos[0]
	$y = $Pos[1]
	If $x = $borderX And $y = @DeskTopHeight - 1 Then
		If Not $inTheCorner Then
			ConsoleWrite("Entered the corner" & @CRLF)
			$enteredCornerTimestampMs = _Date_Time_GetTickCount()
			$inTheCorner = True
		ElseIf _Date_Time_GetTickCount() - $enteredCornerTimestampMs >= $stayToSwitchMs Then
			ConsoleWrite("Sending CapsLock x 2" & @CRLF)
			; Send() is not appropriate: it sends keystroke to active window, not to keyboard buffer, so we use WSH SendKeys() instead
			RunWait("cscript //b //nologo double-caps-lock.js")
			MouseMove(@DeskTopWidth / 2, @DeskTopHeight / 2)
			$inTheCorner = False
		EndIf
	Else 
		$inTheCorner = False
	EndIf
	Sleep($pollInterval)
WEnd

Func Terminate()
    Exit
EndFunc