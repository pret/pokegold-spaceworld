
; Teleport Scripts
	const_def
	const SCRIPT_TRY_TELEPORT         ; 00
	const SCRIPT_DO_TELEPORT          ; 01
	const SCRIPT_FAIL_TELEPORT        ; 02
	const SCRIPT_CHECK_SPAWN_TELEPORT ; 03
	
; Flags
SCRIPT_FINISHED_FLAG      EQU 7

; Masks/Return Values
SCRIPT_SUCCESS  EQU $f
SCRIPT_FAIL     EQU 0
SCRIPT_FINISHED EQU 1 << SCRIPT_FINISHED_FLAG