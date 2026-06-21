BattleCommand_Mimic:
	call BattleCommand_MoveDelay
	ld a, [wAttackMissed]
	and a
	jr nz, .fail

	ld hl, wBattleMonMoves
	ld de, wLastEnemyCounterMove
	ldh a, [hBattleTurn]
	and a
	jr z, .player_turn
	ld hl, wEnemyMonMoves
	ld de, wLastPlayerCounterMove

.player_turn
; BUG: No checks for Struggle, so it can be mimicked.
	call CheckHiddenOpponent
	jr nz, .fail
	ld a, [de]
	and a
	jr z, .fail

.find_mimic
	ld a, [hli]
	cp MOVE_MIMIC
	jr nz, .find_mimic
	dec hl
	ld a, [de]
	ld [hl], a
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call LoadMoveAnim
	ld hl, MimicLearnedMoveText
	jp PrintText

.fail
	jp PrintButItFailed

MimicLearnedMoveText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "を　おぼえた！"
	prompt
