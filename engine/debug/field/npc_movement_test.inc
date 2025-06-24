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
	ld de, SFX_SAFARI_ZONE_PA
	call PlaySFX
	scf
	ret

.MovementData:
	turn_head UP
	step_sleep 6
	slow_step UP
	slow_step RIGHT
	slow_jump_step RIGHT
	slow_step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	slow_jump_step LEFT
	step LEFT
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

.not_here
	ld de, SFX_COLLISION
	call PlaySFX
	ld hl, .NotHereText
	call FieldDebug_ShowTextboxAndExit
	xor a
	ret

.NotHereText:
	text "ここではだめです！"
	done

