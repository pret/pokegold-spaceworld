MACRO init_script_table
DEF script_id = 0
ENDM

MACRO add_script
	dw \1
DEF \1ScriptID = script_id
DEF script_id = script_id + 1
ENDM

MACRO set_script
	ld a, \1ScriptID
	ld [wFieldMoveScriptID], a
ENDM
