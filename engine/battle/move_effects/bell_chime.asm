BattleCommand_BellChime:
	ld hl, wBattleMonStatus
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus1

.got_status
	ld a, [hli]
	or [hl]
	jr z, .failed
	xor a
	ld [hld], a
	ld [hl], a
	ld a, [de]
	res SUBSTATUS_NIGHTMARE, a
	ld [de], a
	call LoadMoveAnim
	ld hl, BellChimedText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintNoChangesText

BellChimedText:
	text "<USER>の"
	line "ステータスいじょうが　なおった！"
	prompt
