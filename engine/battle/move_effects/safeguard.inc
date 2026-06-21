BattleCommand_Safeguard:
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount

.ok
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	bit SCREENS_SAFEGUARD, [hl]
	jr nz, .failed
	set SCREENS_SAFEGUARD, [hl]

	ld a, 5
	ld [de], a
	call LoadMoveAnim
	ld hl, .CoveredByVeilText
	jp PrintText

.CoveredByVeilText:
	text "<USER>は"
	line "しんぴのベールに　つつまれた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
