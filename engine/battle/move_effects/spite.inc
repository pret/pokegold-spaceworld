BattleCommand_Spite:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	ld de, wOTPartyMon1PP
	ld a, [wLastEnemyCounterMove]
	jr z, .got_moves
	ld hl, wBattleMonMoves
	ld de, wPartyMon1PP
	ld a, [wLastPlayerCounterMove]

.got_moves
	and a
	jr z, .failed
	cp MOVE_STRUGGLE
	jr z, .failed
	ld b, a
	ld c, -1

.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld [wNamedObjectIndexBuffer], a
	dec hl
	ld b, 0
	push bc
	ld c, wBattleMonPP - wBattleMonMoves
	add hl, bc
	pop bc
	ld a, [hl]
	and PP_MASK
	jr z, .failed
	push bc
	push de
	call GetMoveName
	pop de

	call BattleRandom
	and %11
	inc a
	inc a
	ld b, a
	ld a, [hl]
	and PP_MASK
	cp b
	jr nc, .deplete_pp
	ld b, a

.deplete_pp
; BUG: If the target is transformed, then the move in the same slot in the monster's
; original moveset will have its PP overwritten to match the new value.
; This was fixed in the final game.
	ld a, b
	ld [wTextDecimalByte], a
	ld a, [hl]
	sub b
	ld [hl], a
	ld h, d
	ld l, e
	pop bc
	add hl, bc
	ld [hl], a
	call LoadMoveAnim
	ld hl, SpiteEffectText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

SpiteEffectText:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer1
	text "を　@"
	deciram wTextDecimalByte, 1, 1
	text "けずった！"
	prompt
