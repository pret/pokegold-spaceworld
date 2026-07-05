BattleCommand_Spikes:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens

.got_screens
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

; Fails if spikes are already down!

	bit SCREENS_SPIKES, [hl]
	jr nz, .failed

; Nothing else stops it from working.

	set SCREENS_SPIKES, [hl]

	call LoadMoveAnim
	ld hl, .SpikesText
	jp PrintText

.SpikesText
	text "<TARGET>の　あしもとに"
	line "まきびしが　ちらばった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
