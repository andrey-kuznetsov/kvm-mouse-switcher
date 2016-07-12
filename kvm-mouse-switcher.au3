#AutoIt3Wrapper_Change2CUI=y
#include <Date.au3>

if $CmdLine[0] <> 1 Or ($CmdLine[1] <> "left" And $CmdLine[1] <> "right") Then 
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

Local $bumpGapMillis = 1000
Local $pollInterval = 30

Local $onBorder
Local $formerNonBorderMillis
Local $latterNonBorderMillis
resetState()
ConsoleWrite("Starting infinite loop, Ctrl+C to exit" & @CRLF)
While True
	$Pos = MouseGetPos()
	$x = $Pos[0]
	$y = $Pos[1]
	If $x = $borderX Then
		$onBorder = True
	Else 
		If $onBorder Then
			ConsoleWrite("Left the border" & @CRLF)
			$latterNonBorderMillis = _Date_Time_GetTickCount()
			If $latterNonBorderMillis - $formerNonBorderMillis < $bumpGapMillis Then
				ConsoleWrite("Sending CapsLock x 2" & @CRLF)
				; Send() is not appropriate: it sends keystroke to active window, not to keyboard buffer, so we use WSH SendKeys() instead
				RunWait("cscript //b //nologo double-caps-lock.js")
				$onBorder = False
				$formerNonBorderMillis = 0
				$latterNonBorderMillis = 0
			EndIf
			$formerNonBorderMillis = $latterNonBorderMillis
		EndIf
		$onBorder = False
	EndIf
	Sleep($pollInterval)
WEnd

Func resetState()
	$onBorder = False
	$formerNonBorderMillis = 0
	$latterNonBorderMillis = 0
EndFunc

Func Terminate()
    Exit
EndFunc