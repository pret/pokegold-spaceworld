; Cut HP in half and put a curse on the opponent.
BattleCommand_NailDown:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus1

.got_substatus
	call CheckHiddenOpponent
	jr nz, .failed
	bit SUBSTATUS_CURSE, [hl]
	jr nz, .failed
	set SUBSTATUS_CURSE, [hl]
	call LoadMoveAnim

	callfar GetQuarterMaxHP
	callfar SubtractHPFromUser

	ld hl, .PutACurseText
	jp PrintText

.PutACurseText
	text "<USER>は"
	line "じぶんに　くぎを　うった"

	para "<TARGET>は"
	line "のろいを　かけられた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
