BattleCommand_DestinyBond:
	ld hl, wPlayerSubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus5

.got_substatus
	set SUBSTATUS_DESTINY_BOND, [hl]
	call LoadMoveAnim
	ld hl, DestinyBondEffectText
	jp PrintText

DestinyBondEffectText:
	text "<USER>は　あいてを"
	line "みちずれに　しようとしている"
	prompt
