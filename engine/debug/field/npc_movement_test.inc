FieldDebug_NPCMovementTest:
	call .NPCMovementTest
	jr c, .exit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.exit
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret

.NPCMovementTest:
	ld a, [wMapGroup]
	cp GROUP_SILENT_HILL_HOUSE
	jr nz, .not_here
	ld a, [wMapId]
	cp MAP_SILENT_HILL_HOUSE
	jr nz, .not_here
	ld a, 2
	ld hl, .MovementData
	call LoadMovementDataPointer
	ld de, SFX_22
	call PlaySFX
	scf
	ret

.MovementData:
	db FACE_UP
	db MOVEMENT_2F
	db SLOW_STEP_UP
	db SLOW_STEP_RIGHT
	db SLOW_JUMP_RIGHT
	db SLOW_STEP_RIGHT
	db STEP_DOWN
	db STEP_DOWN
	db STEP_DOWN
	db STEP_DOWN
	db STEP_LEFT
	db SLOW_JUMP_LEFT
	db STEP_LEFT
	db SLOW_STEP_UP
	db SLOW_STEP_UP
	db SLOW_STEP_UP
	db MOVEMENT_32

.not_here
	ld de, SFX_1E
	call PlaySFX
	ld hl, .NotHereText
	call FieldDebug_ShowTextboxAndExit
	xor a
	ret

.NotHereText:
	text "ここではだめです！"
	done

