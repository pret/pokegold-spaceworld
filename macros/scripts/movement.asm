; MovementPointers indexes (see engine/overworld/movement.asm)
	const_def 0, 4

; Directional movements

	const movement_turn_head ; $00
MACRO turn_head
	db movement_turn_head | \1
ENDM

	const movement_slow_step ; $04
MACRO slow_step
	db movement_slow_step | \1
ENDM

	const movement_step ; $08
MACRO step
	db movement_step | \1
ENDM

	const movement_big_step ; $0c
MACRO big_step
	db movement_big_step | \1
ENDM

	const movement_quick_step ; $10
MACRO quick_step
	db movement_quick_step | \1
ENDM

	const movement_slow_jump_step ; $14
MACRO slow_jump_step
	db movement_slow_jump_step | \1
ENDM

	const movement_jump_step ; $18
MACRO jump_step
	db movement_jump_step | \1
ENDM

	const movement_fast_jump_step ; $1c
MACRO fast_jump_step
	db movement_fast_jump_step | \1
ENDM

	const movement_quick_jump_step ; $20
MACRO quick_jump_step
	db movement_fast_quick_step | \1
ENDM

DEF const_inc = 1

; Control
	const movement_remove_sliding ; $24
MACRO remove_sliding
	db movement_remove_sliding
ENDM

	const movement_set_sliding ; $25
MACRO set_sliding
	db movement_set_sliding
ENDM

	const movement_remove_fixed_facing ; $26
MACRO remove_fixed_facing
	db movement_remove_fixed_facing
ENDM

	const movement_fix_facing ; $27
MACRO fix_facing
	db movement_fix_facing
ENDM

	const movement_show_object ; $28
MACRO show_object
	db movement_show_object
ENDM

	const movement_hide_object ; $29
MACRO hide_object
	db movement_hide_object
ENDM

; Sleep

	const movement_step_sleep ; $2a
MACRO step_sleep
	if \1 <= 8
		db movement_step_sleep + \1 - 1
	else
		db movement_step_sleep + 8, \1
	endc
ENDM

	const_skip 7 ; all step_sleep values

	const movement_step_end ; $32
MACRO step_end
	db movement_step_end
ENDM

	const movement_remove_object ; $33
MACRO remove_object
	db movement_remove_object
ENDM

	const movement_step_loop ; $34
MACRO step_loop
	db movement_step_loop
ENDM

	const movement_step_stop ; $35
MACRO step_stop
	db movement_step_stop
ENDM

	const movement_teleport_from ; $36
MACRO teleport_from
	db movement_teleport_from
ENDM

	const movement_teleport_to ; $37
MACRO teleport_to
	db movement_teleport_to
ENDM

DEF NUM_MOVEMENT_CMDS EQU const_value