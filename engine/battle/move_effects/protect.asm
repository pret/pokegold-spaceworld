BattleCommand_Protect:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus1

.got_substatus
	set SUBSTATUS_PROTECT, [hl]
	call LoadMoveAnim
	ld hl, ProtectedItselfText
	jp PrintText

ProtectedItselfText:
	text "<USER>は"
	line "まもりの　たいせいに　はいった！"
	prompt
