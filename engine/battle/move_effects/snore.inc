BattleCommand_Snore:
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wBattleMonStatus

.got_status
	ld a, [hl]
	and SLP
	ret nz
	inc a
	ld [wAttackMissed], a
	ret
