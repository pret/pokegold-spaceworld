BattleCommand_FuryCutter:
	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyFuryCutterCount

.go
	ld a, [wAttackMissed]
	and a
	jr z, .do_fury_cutter
	call ResetFuryCutterCount
	ret

.do_fury_cutter
; BUG: No cap on Fury Cutter counter, unlike final game.
	inc [hl]
	ld a, [hl]
	ld b, a

.check_double
	dec b
	jr z, .return

; Double the damage
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .check_double

; No overflow
	ld a, $ff
	ld [hli], a
	ld [hl], a

.return
	ret

ResetFuryCutterCount:
	push hl

	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .reset
	ld hl, wEnemyFuryCutterCount

.reset
	xor a
	ld [hl], a

	pop hl
	ret
