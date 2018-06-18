init_script_table: MACRO
script_id = 0	
ENDM

add_script: MACRO
	dw \1
\1ScriptID = script_id
script_id = script_id + 1
ENDM

set_script: MACRO
	ld a, \1ScriptID
	ld [wFieldMoveScriptID], a
ENDM