Unreferenced_RageEffect:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus4
.ok
	set SUBSTATUS_RAGE, [hl]
	ret
