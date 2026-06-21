BattleCommand_FocusEnergy:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jr nz, .already_pumped
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call LoadMoveAnim
	ld hl, GettingPumpedText
	jp PrintText

.already_pumped
	call BattleCommand_MoveDelay
	jp PrintButItFailed

GettingPumpedText:
	text_exit
	text "<USER>は"
	line "はりきっている！"
	prompt
