BattleCommand_StartSandstorm:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens

.got_screens
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	bit SCREENS_SANDSTORM, [hl]
	jr nz, .failed

	set SCREENS_SANDSTORM, [hl]
	call LoadMoveAnim
	ld hl, .SandstormBrewedText
	jp PrintText

.SandstormBrewedText:
	text "<TARGET>は"
	line "すなあらしに　まきこまれた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
