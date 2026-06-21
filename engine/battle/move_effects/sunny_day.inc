BattleCommand_StartSun:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call LoadMoveAnim
	ld hl, .SunGotBrightText
	jp PrintText

.SunGotBrightText
	text "ひざしが　つよくなった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
