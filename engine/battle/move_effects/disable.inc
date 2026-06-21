BattleCommand_Disable:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld de, wEnemyDisableCount
	ld hl, wEnemyMonMoves
	ld bc, wLastEnemyCounterMove
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld de, wPlayerDisableCount
	ld hl, wBattleMonMoves
	ld bc, wLastPlayerCounterMove

.got_moves
	ld a, [de]
	and a
	jr nz, .failed

	ld a, [bc]
	and a
	jr z, .failed
	cp MOVE_STRUGGLE
	jr z, .failed

	ld [wNamedObjectIndexBuffer], a
	ld b, a
	ld c, $ff

.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonPP
	jr z, .got_pp
	ld hl, wBattleMonPP

.got_pp
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .failed

	call BattleRandom
	and 7
	inc a
	inc c
	swap c
	add c
	ld [de], a
	call PlayDamageAnim
	ld hl, wDisabledMove
	ldh a, [hBattleTurn]
	and a
	jr nz, .got_disabled_move_pointer
	inc hl

.got_disabled_move_pointer
	ld a, [wNamedObjectIndexBuffer]
	ld [hl], a
	call GetMoveName
	ld hl, MoveDisabledText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

MoveDisabledText:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer1
	text "を　ふうじこめた！"
	prompt
