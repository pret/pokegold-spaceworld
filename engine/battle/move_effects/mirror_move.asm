BattleCommand_MirrorMove:
	ldh a, [hBattleTurn]
	and a
	ld a, [wLastEnemyCounterMove]
	ld hl, wCurPlayerMove
	ld de, wPlayerMoveStruct
	jr z, .got_moves
	ld a, [wLastPlayerCounterMove]
	ld de, wEnemyMoveStruct
	ld hl, wCurEnemyMove

.got_moves
	cp MOVE_MIRROR_MOVE
	jr z, .failed
	and a
	jr nz, .used

.failed
	ld hl, MirrorMoveFailedText
	call PrintText
	jp EndMoveEffect

.used
	ld [hl], a
	ld [wNumSetBits], a
	dec a
	ld hl, Moves
	ld bc, 7 ; Size of move struct
	call AddNTimes
; Copy to user's move struct buffer
	ld a, BANK(Moves)
	call FarCopyBytes

	call IncrementMovePP
	call GetMoveName
	call CopyStringToStringBuffer2
	call BattleCommand_MoveDelay
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, .do_move
	ld a, [wEnemyMoveStructEffect]

.do_move
	call DoMove
	jp EndMoveEffect

MirrorMoveFailedText:
	text "しかし　オウムがえしは"
	next "しっぱいにおわった！"
	prompt
