; Dummied out in the final game in favor of a dedicated turn switch command.
; See BattleCommand_Unused5D in pokegold.
BattleCommand_Swagger:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	call LoadMoveAnim
	ld hl, wEnemyMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move_struct
	ld hl, wPlayerMoveStruct

.got_move_struct:
; Flip turn to handle increasing stats of opposite side
	push af
	xor 1
	ldh [hBattleTurn], a

; Back up old move animation and effect
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl

; Set effect to EFFECT_ATTACK_UP_2
	ld a, EFFECT_ATTACK_UP_2
	ld [hld], a

; Zero out the move animation
	xor a
	ld [hl], a
	call BattleCommand_StatUp

; Return the variables to what they once were
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	pop af
	ldh [hBattleTurn], a
	ret

.failed
	call BattleCommand_MoveDelay
	call PrintButItFailed
	jp EndMoveEffect
