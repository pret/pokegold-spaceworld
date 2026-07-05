BattleCommand_StartRain:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call LoadMoveAnim
	ld hl, .DownpourText
	jp PrintText

.DownpourText
	text "おおあめに　なった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
