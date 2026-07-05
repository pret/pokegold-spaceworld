BattleCommand_Mist:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	bit SUBSTATUS_MIST, [hl]
	jr nz, .already_mist
	set SUBSTATUS_MIST, [hl]
	call LoadMoveAnim
	ld hl, MistText
	jp PrintText

.already_mist
	jp PrintButItFailed

MistText:
	text "<USER>は"
	line "しろい　きりに　つつまれた！"
	prompt
