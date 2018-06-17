
; Script IDs
	const_def
	const SCRIPT_ID_00   ; 00
	const SCRIPT_ID_01   ; 01
	const SCRIPT_ID_02   ; 02
	const SCRIPT_ID_03   ; 03
	const SCRIPT_ID_04   ; 04
	const SCRIPT_ID_05   ; 05
	
; Flags
SCRIPT_FINISHED_F      EQU 7

; Masks/Return Values
SCRIPT_FINISHED_MASK EQU 1 << SCRIPT_FINISHED_F
SCRIPT_SUCCESS  EQU $f
SCRIPT_FAIL     EQU 0

; Some script don't combine the return value with the flag
; Instead, they load this into the wFieldMoveScriptID, and keep
; the return value in a
SCRIPT_FINISHED EQU -1 