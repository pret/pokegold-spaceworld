BattleCommand_SleepTalk:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves + 1
	ld de, wCurPlayerMove
	ld bc, wPlayerMoveStruct
	ld a, [wBattleMonStatus]
	jr z, .go
	ld hl, wEnemyMonMoves + 1
	ld de, wCurEnemyMove
	ld bc, wEnemyMoveStruct
	ld a, [wEnemyMonStatus]

.go
	and SLP
	jr z, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, [hl]
	and a
	jr z, .failed
	dec hl

.sample_move
; BUG: Disabled moves can be chosen and used with no problem.
; The final game would add checks to prevent this.

; Additionally, final game excludes charge moves because they prevent the user from
; finishing the move until they wake up, trapping the user in a temporary loop.
	push hl
	call BattleRandom
	maskbits NUM_MOVES
	push bc
	ld c, a
	ld b, 0
	add hl, bc
	pop bc

	ld a, [hl]
	pop hl
	and a
	jr z, .sample_move
; Make sure Sleep Talk doesn't try to run itself
	push de
	ld d, a
	ld a, [bc]
	cp d
	ld a, d
	pop de
	jr z, .sample_move

	ld [de], a
	call LoadMoveAnim
	push bc
	call UpdateMoveData
	pop bc
	inc bc
	ld a, [bc]
	call DoMove
	jp EndMoveEffect

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText
