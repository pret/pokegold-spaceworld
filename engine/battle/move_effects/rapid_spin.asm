BattleCommand_EscapeTrappingMove:
	ld hl, wEnemySubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus3

.got_substatus
	bit SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret z
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ld hl, ReleasedByText
	call PrintText
	ret

ReleasedByText:
	text "<USER>は　<TARGET>の"
	line "こうげきから　かいほうされた！"
	prompt
