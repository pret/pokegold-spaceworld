BattleCommand_Encore:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemySubStatus5
	ld de, wEnemyEncoreCount
	ld a, [wLastEnemyCounterMove]
	jr z, .ok
	ld hl, wPlayerSubStatus5
	ld de, wPlayerEncoreCount
	ld a, [wLastPlayerCounterMove]

.ok
; Struggle, Mirror Move, and Encore itself can be encored, unlike the final game.
	and a
	jr z, .failed

	bit SUBSTATUS_ENCORED, [hl]
	jr nz, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	set SUBSTATUS_ENCORED, [hl]
	call BattleRandom
	and 3
	inc a
	inc a
	inc a
	ld [de], a
	call LoadMoveAnim
	ld hl, GotAnEncoreText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

GotAnEncoreText:
	text "<TARGET>は"
	line "アンコールを　うけた！"
	prompt
