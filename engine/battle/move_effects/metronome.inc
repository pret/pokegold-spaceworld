BattleCommand_Metronome:
	call LoadMoveAnim
	ld de, wPlayerMoveStructEffect
	ld hl, wCurPlayerMove
	ldh a, [hBattleTurn]
	and a
	jr z, .GetMove
	ld de, wEnemyMoveStructEffect
	ld hl, wCurEnemyMove

.GetMove
	call BattleRandom
	and a
	jr z, .GetMove

; No invalid moves.
	cp NUM_ATTACKS + 1
	jr nc, .GetMove

; You can't get Metronome from using Metronome.
	cp MOVE_METRONOME
	jr z, .GetMove

	ld [hl], a
	push de
	call IncrementMovePP
	call UpdateMoveData
	pop de
	ld a, [de]
	call DoMove
	jp EndMoveEffect
