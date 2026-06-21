BattleCommand_Counter:
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemyMove
	ld de, wEnemyMoveStructPower
	jr z, .got_enemy_move
	ld hl, wCurPlayerMove
	ld de, wPlayerMoveStructPower

.got_enemy_move
	ld a, 1
	ld [wAttackMissed], a
	ld a, [hl]
	cp MOVE_COUNTER
	ret z

	ld a, [de]
	and a
	ret z

	inc de
	ld a, [de]
	cp SPECIAL_TYPES
	ret nc

	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z

	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, .capped
	ld a, $ff
	ld [hli], a
	ld [hl], a

.capped
	xor a
	ld [wAttackMissed], a
	ret
