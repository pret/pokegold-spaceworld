BattleCommand_Endure:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus1

.got_substatus
	set SUBSTATUS_ENDURE, [hl]
	call LoadMoveAnim
	ld hl, BracedItselfText
	jp PrintText

BracedItselfText:
	text "<USER>は　こらえる"
	line "たいせいに　はいった！"
	prompt
